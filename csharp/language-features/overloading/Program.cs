using System;

public class Program
{
	public void Display(string x) => Console.WriteLine(x);
	public void Display(double x) => Console.WriteLine(x);

	public static void Main(string[] args)
	{
		Program x = new();
		x.Display("first");
		x.Display(1.23456);
	}
}
