using System;

public class Program
{
	public int DataMember{get; init;} = 42;

	public Program(int x) => DataMember = x;
	public static void Main(string[] args)
	{
		Program x = new(1);
		Console.WriteLine(x.DataMember);
	}
}
