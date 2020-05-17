
# Testing Multinomial and Binomial point null hypotheses
# ------------------------------------------

test.null.binomial <- function(
  x,
  null.par,
  sucess,
  hyper.par = c(1, 1),
  pi_null = 0.5,
  transf = "level",
  bf_round = 2,
  probs_round = 3){

  x <- as.vector(x[!is.na(x)])
  bf <- unname(bfactor_binomial(x, null.par, sucess, hyper.par[1], hyper.par[2], transf))

  results <- data.frame(
    "sample" = deparse(substitute(x)),
    "BF" = bf,
    "Evidence" = bfactor_interpret(bf),
    "P(H0|X)" = bfactor_to_prob(bf)
  )

 if(isTRUE(log.10)){names(results) <- gsub("BF(X)", "log10(BF(x))", names(results))}

  results
}

# rbind(
#   test.null.binomial(ifelse(austria_bl1==1, 1, 0), null.par = theta_benford(1)[1], sucess = 1),
#   test.null.binomial(austria_bl1==0, null.par = theta_benford(2)[1])
# )
#
# rbind(
#   test.null.binomial(austria_bl1==1, null.par = theta_benford(1)[1]),
#   test.null.binomial(austria_bl1==0, null.par = theta_benford(2)[1])
# )
#

test.null.multinomial <- function(
  data,
  null.par,
  pi_null = 0.5,
  model = "multinomial",
  hyper.par = if(model == "multinomial") {rep.int(1, length(null.par))} else {c(1, 1)},
  log.10 = TRUE,
  bf.round = 2,
  probs.round = 3){

  bf <- bayes.factor(data = data, null.par = null.par, model = model, hyper.par = hyper.par)

  # data <- as.vector(data[!is.na(data)])

  if(model == "multinomial"){
    p_value <- chisq.test(table(data), p = null.par)$p.value
  } else if (model == "binomial"){
    n <- length(data)
    obs_prop <- as.numeric(rev(table(data))[1])/n
    z_stat <- (abs(obs_prop-null.par)-(1/(2*n)))/sqrt((null.par*(1-null.par))/n)
    p_value <- 2* (1-pnorm(abs(z_stat), 0, 1))
  }

  results <- data.frame(
    "sample" = deparse(substitute(data)),
    "BayesFactor" = if(isTRUE(log.10)){round(log10(bf), bf.round)} else {round(bf, bf.round)},
    "Evidence" = ifelse(bf < 1, "Negative",
      ifelse(bf < 3.2, "Weak",
        ifelse(bf < 10, "Substantial",
          ifelse(bf < 100, "Strong", "Decisive")))),
    "P(H0|X)" = round(((1 + ((1 - pi_null) / pi_null) * (1 / bf)))^(-1), probs.round),
    "LB.P(H0|X)" = round(pcal(p_value), probs.round)
  )

  if(isTRUE(log.10)){names(results) <- gsub("BayesFactor(X)", "log10(BayesFactor(x))", names(results))}

  results
}

test_chisq_multinomial <- function(x, null.par, categories){

  x <- x[!is.na(x)]
  categories <- factor(categories, levels = categories , ordered = TRUE)
  counts <- table(x[!is.na(x)])[levels(categories)]

  tst <- chisq.test(counts,  p = null.par)

  data.frame(
    "X-squared" = tst$statistic,
    "df" = tst$parameter,
    "p_value" = tst$p.value,
    row.names = NULL
  )
}

# Testing many binomial point null hypotheses
# ------------------------------------------
test.binomial.hypotheses <- function( # Function to compute Binomial-Beta model results (BL1 or BL2)
  data,
  null.par,
  sucess = unique(data),
  pi_null = .5,
  a = 1,
  b = 1,
  log10 = TRUE,
  bf.round = 2,
  probs.round = 3){

  data <- data[!is.na(data)]
  x <- as.numeric(table(data))
  n <- length(data)

  # if(length(pi_null == 1) && length(null.par) > 1){
  #   pi_null <- rep.int(pi_null, length(null.par))
  # }

    obs_prop <- as.numeric(table(data)[1])/n
    z_stats <- (abs(obs_prop-null.par)-(1/(2*n)))/sqrt((null.par*(1-null.par))/n)
    p_values <- 2 * (1-pnorm(abs(z_stats), 0, 1))

    digits <- 1:9

    bf <- mapply(FUN = bfactor_binomial, null.par = null.par, sucess = sucess,  a = a, b = b,
      MoreArgs = list(data = data))
    pp <- mapply(FUN = bfactor_to_prob, pi_null = pi_null, bf = bf)

  result <- data.frame(
    "Digit" = digits,
    "BayesFactors" = round(if(log10 == FALSE){bf} else{log10(bf)}, bf.round),
    "Evidence" = ifelse(bf < 1, "Negative",
      ifelse(bf < 3.2, "Weak",
        ifelse(bf < 10, "Substantial",
          ifelse(bf < 100, "Strong",
            "Decisive")))
    ),
    "PostProb.H0" = round(pp, probs.round),
    "P.value" = p_values
  )

  if(log10 == TRUE){names(result) <- gsub("BayesFactors", "log10(BayesFactors)", names(result))}
  return(result)

  }


# test.binomial.hypotheses(Austria.bl1, theta_benford(1))
