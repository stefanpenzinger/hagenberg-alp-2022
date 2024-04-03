package task02

import com.sun.org.apache.xpath.internal.functions.FuncSubstringBefore

object HigherOrder {
  def main(args: Array[String]): Unit = {
    val intArraySortedAsc = Array[Int](1,2,3,4,5)
    val intArrayNotSortedAsc = Array[Int](1,2,4,3,5)
    val stringArraySortedAsc = Array[String]("apple", "banana", "zeppelin")
    val stringArrayNotSortedAsc = Array[String]("apple", "zeppelin", "banana")

    println(compose((y: Long) => Array(y), (x: String) => x.toLong)("12").mkString("Array(", ", ", ")"))
    println(isSorted(intArraySortedAsc, isSortedAscInt))
    println(isSorted(intArrayNotSortedAsc, isSortedAscInt))w
    println(isSorted(stringArraySortedAsc, isSortedAscString))
    println(isSorted(stringArrayNotSortedAsc, isSortedAscString))
  }

  def isSortedAscInt(actualValue: Int, before: Int): Boolean = {
    actualValue >= before
  }

  def isSortedAscString(actualValue: String, before: String): Boolean = {
    actualValue >= before
  }

  def isSorted[A](as: Array[A], ordered: (A,A) => Boolean): Boolean = {
    @annotation.tailrec
    def loop(n: Int): Boolean =
      if (n >= as.length) true
      else if (!ordered(as(n), as(n - 1))) false
      else loop(n + 1)
    loop(1)
  }

  def compose[A,B,C](f: B => C, g: A => B): A => C = {
    (a: A) => f(g(a))
  }
}

