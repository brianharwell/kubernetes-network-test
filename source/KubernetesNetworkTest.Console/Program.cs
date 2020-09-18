using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace KubernetesNetworkTest.Console
{
  public class Program
  {
    public static async Task Main(string[] args)
    {
      if (args.Length != 1)
      {
        System.Console.WriteLine("ERROR: Destination url must be specified as the only argument");

        Environment.ExitCode = 1;

        return;
      }

      var url = args[0];

      System.Console.WriteLine($"Connecting to '{url}'");

      try
      {
        var httpClient = new HttpClient();
        var httpResponseMessage = await httpClient.GetAsync(url);

        if (!httpResponseMessage.IsSuccessStatusCode)
        {
          System.Console.WriteLine($"ERROR: Connection failed: {(int)httpResponseMessage.StatusCode} ({httpResponseMessage.StatusCode})");

          Environment.ExitCode = 1;

          return;
        }

        System.Console.WriteLine("Connection succeeded");
      }
      catch (Exception exception)
      {
        System.Console.WriteLine(exception);
        throw;
      }
    }
  }
}
