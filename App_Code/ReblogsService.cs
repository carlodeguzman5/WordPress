using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for ReblogsService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ReblogsService : System.Web.Services.WebService {

    public ReblogsService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    private DataTable ExecuteSelectQuery(string Query)
    {
        string constr = ConfigurationManager.ConnectionStrings["WordPressConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(Query))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        //dt.TableName = "Customers";
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }

    [WebMethod]
    public string Reblog(string domainId, string blogId) {

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WordPressConnectionString"].ConnectionString);
        conn.Open();

        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Reblogs] WHERE domainId = '" + domainId + "' AND blogId = '" + blogId + "'");

        if (dt.Rows.Count >= 1)
        {

            SqlCommand cmd = new SqlCommand("DELETE FROM dbo.[Reblogs] " +
            " WHERE domainId = @domainId AND blogId = @blogId", conn);

            cmd.Parameters.AddWithValue("@domainId", domainId);
            cmd.Parameters.AddWithValue("@blogId", blogId);

            cmd.ExecuteNonQuery();
            conn.Close();
            return "Removed Reblog";
        }
        else {
            SqlCommand cmd = new SqlCommand("INSERT INTO dbo.[Reblogs] " +
                " VALUES (@domainId, @blogId)", conn);

            cmd.Parameters.AddWithValue("@domainId", domainId);
            cmd.Parameters.AddWithValue("@blogId", blogId);

            cmd.ExecuteNonQuery();
            conn.Close();
            return "Reblogged";
        }
    }
    
}
