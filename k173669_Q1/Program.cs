using System;
using System.Reflection;

namespace k173669_Q1
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                /// Change this to full path of where .dll is located
                string path = @"C:\Users\bilal\Downloads\lab03_k173652\k173652_Q1\EntityFramework.dll";
                var assembly = Assembly.LoadFile(path);

                /// Iterate through types
                foreach (var type in assembly.GetTypes())
                {
                    Console.WriteLine($"{type.Name} ({type.GetMethods().Length})");
                    /// Iterate through member methods
                    foreach (var method in type.GetMethods())
                    {
                        Console.WriteLine($"    .{method.Name}");
                    }
                    Console.WriteLine();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
