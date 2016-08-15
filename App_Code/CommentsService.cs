using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for CommentsService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class CommentsService : System.Web.Services.WebService {

    public CommentsService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    private void ExecuteInsertQuery(string Query)
    {
        string constr = ConfigurationManager.ConnectionStrings["WordPressConnectionString"].ConnectionString;
        SqlConnection sqlConnection1 = new SqlConnection(constr);

        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;
        cmd.CommandText = Query;
        cmd.Connection = sqlConnection1;

        sqlConnection1.Open();
        cmd.ExecuteNonQuery();
        sqlConnection1.Close();
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
    public string CreateComment(string blogId, string username, string commentContent) {
        //ExecuteInsertQuery("INSERT INTO dbo.[Comments] VALUES ('" + blogId + "','" + username + "','" + commentContent.Replace("'", "''") + "','" + DateTime.Now + "')");

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WordPressConnectionString"].ConnectionString);
        conn.Open();

        SqlCommand cmd = new SqlCommand("INSERT INTO dbo.[Comments] VALUES (@blogId, @username, @commentContent, @timestamp)", conn);
        cmd.Parameters.AddWithValue("@blogId", blogId);
        cmd.Parameters.AddWithValue("@username", username);
        cmd.Parameters.AddWithValue("@commentContent", commentContent);
        cmd.Parameters.AddWithValue("@timestamp", DateTime.Now);
        cmd.ExecuteNonQuery();

        conn.Close();

        return "Success";
    }
}
