using System.Collections;
using System.Reflection;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using System.Text.Json;

public class ConnectionStrings
{
    public string Local { get; set; } = "";
    public string Production { get; set; } = "";
}

public class Appsettings
{
    public ConnectionStrings ConnectionStrings { get; set; }

    public Appsettings()
    {
        this.ConnectionStrings = new ConnectionStrings();
    }
}

public class Program
{
    static void Main(string[] args)
    {
        var appSettings = GetAppSettings();

        if (args?.Length > 0)
        {
            if (args.Contains("Development"))
            {
                RunMigrations(appSettings.ConnectionStrings.Local);
            }
            else if (args.Contains("Production"))
            {
                RunMigrations(appSettings.ConnectionStrings.Production);
            }
        }
    }

    private static Appsettings GetAppSettings()
    {
        var di = new DirectoryInfo("./");

        var files = di.GetFiles();

        foreach (var file in files)
        {
            if (file.Name == "appsettings.json")
            {
                using (StreamReader r = new StreamReader(file.FullName))
                {
                    var json = r.ReadToEnd();
                    var appsettings = JsonSerializer.Deserialize<Appsettings>(json);

                    return appsettings;
                }
            }
        }

        return new Appsettings();
    }
    
    private static void RunMigrations(string connectionString)
    {
        var sqlConnectionString = connectionString;
            
        var di = new DirectoryInfo("./Migrations");

        var rgFiles = di.GetFiles("*.sql");
        var conn = new Microsoft.Data.SqlClient.SqlConnection(sqlConnectionString);

        Server server = new Server(new ServerConnection(conn));

        foreach (FileInfo fi in rgFiles)
        {
            var script = fi.OpenText().ReadToEnd();
            server.ConnectionContext.ExecuteNonQuery(script);
        }
    }

}