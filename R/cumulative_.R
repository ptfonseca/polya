
#' @export

sapply_bf_multinomial <- function(
  samples,
  categories,
  null_par = 1 / length(categories),
  hyper_par = rep(1, length(categories)),
  haldane = FALSE,
  in_favour = "H0") {

  sapply(
    X = samples,
    FUN = bf_multinomial,
    categories = categories,
    null_par = null_par,
    hyper_par = hyper_par,
    haldane =  haldane,
    in_favour = in_favour
  )
}

#' @export

sapply_fbf_multinomial <- function(
  samples,
  categories,
  null_par = 1 / length(categories),
  hyper_par = rep(1, length(categories)),
  haldane = FALSE,
  frac = 0.1,
  m = length(categories),
  robust = "no",
  in_favour = "H0") {

  sapply(
    X = samples,
    FUN = fbf_multinomial,
    categories = categories,
    null_par = null_par,
    hyper_par = hyper_par,
    haldane = haldane,
    frac = frac,
    m = m,
    robust = robust,
    in_favour = in_favour)

}

#' @export

sapply_pbf_multinomial <- function(
  samples,
  categories,
  null_par = 1 / length(categories),
  hyper_par = rep(1, length(categories)),
  in_favour = "H0") {

  sapply(
    X = samples,
    FUN = pbf_multinomial,
    categories = categories,
    null_par = null_par,
    hyper_par = hyper_par,
    in_favour = in_favour)
}

#' @export

sapply_ibf_multinomial <- function(
  samples,
  categories,
  null_par = 1 / length(categories),
  haldane = FALSE,
  hyper_par = rep(1, length(categories)),
  type = "arithmetic",
  method = "mts",
  k = 2,
  in_favour = "H0") {

  sapply(
    X = samples,
    FUN = ibf,
    categories = categories,
    null_par = null_par,
    haldane =  haldane,
    hyper_par = hyper_par,
    type = type,
    method = method,
    k = k,
    in_favour = in_favour)
}
