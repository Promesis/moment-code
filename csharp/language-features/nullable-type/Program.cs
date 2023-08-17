using System;


SomeReferenceType? 
    some_variable = new(),
    some_null_variable = null;

if (some_variable != null)
    some_variable.SomeAttribute = 0;

int x = some_variable?.SomeAttribute ?? -1;
int y = some_null_variable?.SomeAttribute ?? -1;

Console.WriteLine($"x = some_variable?.SomeAttribute ?? -1= {x}");
Console.WriteLine($"y = some_null_variable?.SomeAttribute ?? -1 = {y}");

public class SomeReferenceType
{
    public int SomeAttribute {get; set;}
}
