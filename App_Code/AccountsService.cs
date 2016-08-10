using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;

/// <summary>
/// Summary description for AccountsService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class AccountsService : System.Web.Services.WebService {

    public AccountsService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    private DataTable ExecuteSelectQuery(string Query) {
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

    [WebMethod]
    public string Login(string email, string password) {
        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Accounts] WHERE email = '" + email + "'");
        if (dt.Rows.Count == 1)
        {
            if (dt.Rows[0]["password"].Equals(password))
            {
                return "200|" + dt.Rows[0]["username"];
            }
            else
            {
                return "401";
            }
        }
        else {
            return "401";
        }
    }

    [WebMethod]
    public string Register(string email, string username, string password, string domain) {
        string [] responseMessage = new string[2];
        responseMessage[0] = "";
        responseMessage[1] = "";
        DataTable dt1 = ExecuteSelectQuery("SELECT * FROM dbo.[Accounts] WHERE email = '" + email + "'");
        if (dt1.Rows.Count > 0) {
            responseMessage[1] += "Email is already registered!\n";
            responseMessage[0] = "401";
        }
        dt1 = ExecuteSelectQuery("SELECT * FROM dbo.[Accounts] WHERE username = '" + username + "'");
        if (dt1.Rows.Count > 0) {
            responseMessage[1] += "Username is already registered!\n";
            responseMessage[0] = "401";
        }
        dt1 = ExecuteSelectQuery("SELECT * FROM dbo.[Accounts] WHERE domainId = '" + domain + "'");
        if (dt1.Rows.Count > 0)
        {
            responseMessage[1] += "Domain is already registered!\n";
            responseMessage[0] = "401";
        }

        if (responseMessage[0].Equals(""))
        {
            
            ExecuteInsertQuery("INSERT INTO dbo.[Accounts] (email, username, password, domainId) VALUES('" + email + "','" + username + "','" + password + "','" + domain + "')");
            responseMessage[0] = "200";
            responseMessage[1] = "Your account is ready!";

            CreateDirectory(domain);
        }
        return responseMessage[0] + "|" + responseMessage[1];
      
    }

    [WebMethod]
    public string GetImagePath(string email) {

        DataTable dt = ExecuteSelectQuery("SELECT picture FROM dbo.[Accounts] WHERE email = '" + email + "'");

        

        return dt.Rows[0]["picture"].ToString();
    }

    private void CreateDirectory(string folderName) {
        string directoryPath = Server.MapPath(string.Format("~/Domains/{0}/", folderName));
        if (!Directory.Exists(directoryPath))
        {
            Directory.CreateDirectory(directoryPath);
            File.Copy(Server.MapPath("~/Domains/Default.aspx"), directoryPath + "Default.aspx");
            File.Copy(Server.MapPath("~/Domains/Default.aspx.cs"), directoryPath + "Default.aspx.cs");

        }
        else
        {
            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Directory already exists.');", true);
            //Error
        }
    }
}
