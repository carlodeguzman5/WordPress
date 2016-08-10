using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Summary description for LikesService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class LikesService : System.Web.Services.WebService {

    public LikesService () {

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

    [WebMethod]
    public string GetLikeCount(string blogId) {

        DataTable dt = ExecuteSelectQuery("SELECT COUNT(*) FROM dbo.[Likes] WHERE blogId = '" + blogId + "'");
        return dt.Rows[0]["Column1"].ToString();
    }

    [WebMethod]
    public string CreateLike(string blogId, string email)
    {
        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Likes] WHERE blogId = '" + blogId + "' AND email = '" + email + "'");
        if (dt.Rows.Count > 0) {

            ExecuteInsertQuery("DELETE FROM dbo.[Likes] WHERE blogId = '" + blogId + "' AND email = '" + email + "'");
            return "Unliked";
        }
        ExecuteInsertQuery("INSERT INTO dbo.[Likes] VALUES('" + blogId + "','" + email + "')");
        return "Liked";
    }
    
}
