using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Summary description for DomainsService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class DomainsService : System.Web.Services.WebService {

    public DomainsService () {

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
    public string GetDomain(string email) {
        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Accounts] WHERE email = '" + email + "'");
        if (dt.Rows.Count == 1) {
            return dt.Rows[0]["domainId"].ToString();
        }
        return "";
    }
    
}
