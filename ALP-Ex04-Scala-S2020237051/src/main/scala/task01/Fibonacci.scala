package task01

object Fibonacci {
  def main(args: Array[String]): Unit = {
    println(fibTailRecursive(90000))
  }

  /**
   * Non tail recursive fibonacci implementation
   *
   * @param n Integer number
   * @return The nth fibonacci number
   */
  def fib(n: Int): BigInt = {
    if (n <= 1) {
      return n
    }

    fib(n - 1) + fib(n - 2)
  }

  /**
   * Tail recursive fibonacci implementation
   *
   * @param n Integer number
   * @return The nth fibonacci number
   */
  def fibTailRecursive(n: Int): BigInt = {
    @scala.annotation.tailrec
    def fibFcn(n: Int, acc1: BigInt, acc2: BigInt): BigInt = n match {
      case 0 => acc1
      case 1 => acc2
      case _ => fibFcn(n - 1, acc2, acc1 + acc2)
    }

    fibFcn(n, 0, 1)
  }
}
