using System;

PrintInts(1,2,3,4,5);

void PrintInts(params int[] arguments)
{
	foreach (var x in arguments)
	{
		Console.Write(x + " ");
	}
	Console.WriteLine();
}
