using System;

void FunctionWithLotsOfArguments(int a, int b, int c, int d)
{
	Console.Write($"a = {a}\nb = {b}\nc = {c}\nd = {d}\n");
}

FunctionWithLotsOfArguments(b : 1, a : 2, d : 3, c : 4);
