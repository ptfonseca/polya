
library(digit.analysis)

context("Bayes factors - Bin vs Multinom match")

testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_binomial(
      x = austria.bl1,
      null.par = theta_benford(1)[1],
      sucess = 1,
      a = 1,
      b = 1,
      transf = "log10"
    ),
    2
  ),
    round(
      bfactor_multinomial(
        x = ifelse(austria.bl1 == 1, "aa", "bb"),
        null.par = c(theta_benford(1)[1], 1 - theta_benford(1)[1]),
        alpha = 1,
        transf = "log10"
      ),
      2
    ))
})

testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_binomial(
      x = austria.bl1,
      null.par = theta_benford(1)[1],
      sucess = 1,
      a = 1,
      b = 1,
      transf = "log10"
    ),
    2
  ),
    c("log10(BF)" = 0.07))
})

testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_multinomial(
      x = ifelse(austria.bl1 == 1, "bb", "aa"),
      null.par = c(theta_benford(1)[1], 1 - theta_benford(1)[1]),
      categories = c("bb", "aa"),
      alpha = 1,
      transf = "log10"
    ),
    2
  ),
    c("log10(BF)" = 0.07))
})


testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_multinomial(
      x = ifelse(austria.bl1==1, "bb", "aa"),
      null.par = c(1-theta_benford(1)[1], theta_benford(1)[1]),
      categories = c("aa", "bb"),
      alpha = 1,
      transf = "log10"),
    2
  ),
    c("log10(BF)" = 0.07))
})

testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_multinomial(
      x = ifelse(austria.bl1==1, "bb", "aa"),
      null.par = c(theta_benford(1)[1], 1-theta_benford(1)[1]),
      categories = c("bb", "aa"),
      alpha = 1,
      transf = "log10"),
    2
  ),
    c("log10(BF)" = 0.07))
})

testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_multinomial(
      x = ifelse(austria.bl1==1, "aa", "bb"),
      null.par = c(theta_benford(1)[1], 1-theta_benford(1)[1]),
      categories = c("aa", "bb"),
      alpha = 1,
      transf = "log10") ,
    2
  ),
    c("log10(BF)" = 0.07))
})

testthat::test_that("Austria log10(BF), unif prior", {
  expect_equal(round(
    bfactor_multinomial(
      x = ifelse(austria.bl1==1, "bb", "aa"),
      null.par = c(theta_benford(1)[1], 1-theta_benford(1)[1]),
      categories = c("bb", "aa"),
      alpha = 1,
      transf = "log10") %>% round(2)
    ,
    2
  ),
    c("log10(BF)" = 0.07))
})






