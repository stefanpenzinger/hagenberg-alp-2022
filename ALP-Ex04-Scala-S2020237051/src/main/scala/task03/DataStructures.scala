package task03

object DataStructures {
  def main(args: Array[String]): Unit = {
    val myList = List(1.9, 2.9, 3.4, 3.5)
    println(drop(myList, 3))
    println(tail(myList))
    println(setHead(myList, 5))
    println(dropWhile(myList, intCompare))
    println(init(myList))
  }

  def intCompare(x: Double): Boolean = {
    x > 2.9
  }

  def tail[A](xs: List[A]): List[A] = {
    if (xs == null) {
      return List[A]()
    }

    @annotation.tailrec
    def loop(n: Int): List[A] =
      if (n >= xs.length) {
        xs.slice(1, xs.length)
      }
      else {
        xs.updated(n - 1, xs(n))
        loop(n + 1)
      }

    loop(1)
  }

  def drop[A](l: List[A], n: Int): List[A] = {
    if (l == null) {
      return List[A]()
    }

    @annotation.tailrec
    def loop(n: Int, list: List[A]): List[A] =
      if (n <= 0) {
        list
      } else if (list.isEmpty) {
        list
      }
      else {
        loop(n - 1, list.tail)
      }

    loop(n, l)
  }


  def setHead[A](xs: List[A], h: A): List[A] = {
    if (xs == null) {
      return List[A](h)
    }

    xs.updated(0, h)
  }

  def dropWhile[A](l: List[A], f: A => Boolean): List[A] = {
    if (l == null) {
      return List[A]()
    }

    @annotation.tailrec
    def loop(list: List[A]): List[A] =
      if (list.nonEmpty && f(list.head)) {
        loop(list.tail)
      }
      else list

    loop(l)
  }

  // Why can’t this function be implemented in constant time like tail?
  // Because the array is first copied in order to loop it
  def init[A](l: List[A]): List[A] = {
    if (l == null) {
      return List[A]()
    }

    @annotation.tailrec
    def loop(n: Int, list: List[A]): List[A] =
      if (list.isEmpty) {
        l
      } else if (n == list.length) {
        l.slice(0, n - 1)
      } else {
        loop(n + 1, list)
      }

    loop(0, l)
  }
}
