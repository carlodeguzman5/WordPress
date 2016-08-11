using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Threading;

/// <summary>
/// Summary description for BlogsService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class BlogsService : System.Web.Services.WebService {

    public BlogsService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    private void ExecuteInsertQuery(string Query) {
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
    public String CreateBlog(string blogTitle, string domainId, string username, string blogContent, string canLike, string canComment, string canReblog, string htmlBlogContent) {


        ExecuteInsertQuery("INSERT INTO dbo.[Blogs] (blogTitle,domainId,username,blogContent, htmlBlogContent ,canLike,canComment,canReblog,dateCreated,dateModified) VALUES" +
            "('" + blogTitle.Replace("'", "''") + "', '" + domainId + "', '" + username + "','" + blogContent.Replace("'", "''").Replace("\"", "''") + "','" + htmlBlogContent.Replace("'", "''") + "','" + canLike + "','" + canComment + "','" + canReblog + "','" + DateTime.Now.ToString() + "','" + DateTime.Now.ToString() + "')");

        return CreateBlogPage(blogTitle, domainId);
    }

    [WebMethod]
    public DataTable GetBlog()
    { //string domainId, string blogTitle
        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Blogs] WHERE domainId = '" + "carlo" + "' AND blogTitle = '" + "This is Gospel" + "'");
        dt.TableName = "This is Gospel";
        return dt;
    }

    [WebMethod]
    public string GetBlogId(string domainId, string blogTitle) {
        DataTable dt = ExecuteSelectQuery("SELECT blogId FROM dbo.[Blogs] WHERE domainId = '" + domainId + "' AND blogTitle = '" + blogTitle + "'");

        if (dt.Rows.Count <= 0)
        {
            return "Error";
        }

        return dt.Rows[0]["blogId"].ToString();
       
    }


    private string CreateBlogPage(string blogTitle, string domainId)
    {
        File.Copy(Server.MapPath("~/Domains/BlogTemplate.aspx"), Server.MapPath("~/Domains/" + domainId + "/" + blogTitle.Replace(" ", "_") + ".aspx"));
        //File.Copy(Server.MapPath("~/Domains/BlogTemplate.aspx.cs"), Server.MapPath("~/Domains/" + domainId + "/" + blogTitle.Replace(" ", "_") + ".aspx.cs"));
        return "Success";

    }


    [WebMethod]
    public string IsCommentable(string blogId)
    {
        DataTable dt = ExecuteSelectQuery("SELECT canLike FROM dbo.[Blogs] WHERE blogId = '" + blogId + "'");
        return dt.Rows[0]["canLike"].ToString();
    }

    [WebMethod]
    public string DeleteBlog(string blogId, string domainId, string blogTitle)
    {
        File.Delete(Server.MapPath("~/Domains/" + domainId + "/" + blogTitle.Replace(" ", "_") + ".aspx"));
        ExecuteInsertQuery("DELETE FROM dbo.[Blogs] WHERE blogId = '" + blogId + "'");
        return "Success";
    }

    [WebMethod]
    public string GetBlogContent(string blogId)
    {
        DataTable dt = ExecuteSelectQuery("SELECT htmlBlogContent FROM dbo.[Blogs] WHERE blogId = '" + blogId + "'");
        return dt.Rows[0]["htmlBlogContent"].ToString();
    }

    [WebMethod]
    public string EditBlogContent(string blogId, string blogContentText, string blogContentHtml)
    {
        ExecuteInsertQuery("UPDATE dbo.[Blogs] SET blogContent = '" + blogContentText.Replace("'","''").Replace("\"","''") + "', htmlBlogContent = '" + blogContentHtml.Replace("'", "''") + "' WHERE  blogId = '" + blogId + "'");
        return "Success";
    }
    
}
