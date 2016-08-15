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

    private string ConvertDataTabletoString(DataTable dt)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }
        return serializer.Serialize(rows);
    }

    [WebMethod]
    public string GetDomain(string email) {
        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Accounts] WHERE email = '" + email + "'");
        if (dt.Rows.Count == 1) {
            return dt.Rows[0]["domainId"].ToString();
        }
        return "";
    }

    [WebMethod]
    public string GetStyles(string domainId) {
        DataTable dt = ExecuteSelectQuery("SELECT * FROM dbo.[Domains] WHERE domainId = '" + domainId + "'");
        return ConvertDataTabletoString(dt);
    }


    [WebMethod]
    public string setPrimaryColor(string color, string domainId) {
        ExecuteInsertQuery("UPDATE dbo.[Domains] SET primaryColor = '" + color + "' WHERE domainId = '" + domainId + "'");


        return "Success";
    }
    
}
