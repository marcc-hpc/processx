
context("waiting on processes")

test_that("no deadlock when no stdout + wait", {

  skip("failure would freeze")

  p <- process$new("seq", c("1", "100000"))
  p$wait()
})

test_that("wait with timeout", {

  p <- process$new("sleep", "3")
  expect_true(p$is_alive())

  t1 <- proc.time()
  p$wait(timeout = 100)
  t2 <- proc.time()

  expect_true(p$is_alive())
  expect_true((t2 - t1)["elapsed"] >   50/1000)
  expect_true((t2 - t1)["elapsed"] < 3000/1000)

  p$kill()
  expect_false(p$is_alive())
})