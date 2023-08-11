using System;

Stack<int> stk = new();
stk.Push(1);
Console.WriteLine(stk.Pop());

public class Stack<T>
{
	private class Node
	{
		public T Item {get; set;}
		public Node(T x, Node d)
		{
			Item = x;
			down = d;
		}

		public Node? down;
	}
	
	private Node? top;

	public Stack() => top = null;
	public Stack(T x) => top = new(x, null);

	public void Push(T x)
	{
		Node? new_top = new(x, top);
		top = new_top;
		new_top = null;
	}

	public T Pop()
	{
		if (top == null)
			throw new Exception("InvaildOperation while popping a empty stack");
		Node? new_top = top;
		top = new_top.down;
		new_top.down = null;

		return new_top.Item;
	}
}


