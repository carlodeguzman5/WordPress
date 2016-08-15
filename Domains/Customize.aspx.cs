using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Configuration;

public partial class Domains_Customize : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            Boolean fileOK = false;
            String path = Server.MapPath("~/Assets/BackgroundImages/");
            if (FileUpload1.HasFile)
            {
                String fileExtension =
                    System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                String[] allowedExtensions = { ".gif", ".png", ".jpeg", ".jpg" };
                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        fileOK = true;
                    }
                }
            }

            if (fileOK)
            {
                try
                {
                    FileUpload1.PostedFile.SaveAs(path
                        + Session["username"].ToString() + System.IO.Path.GetExtension(FileUpload1.FileName));
                    Label1.Text = "File uploaded!";
                    SaveToDatabase(Session["domain"].ToString() + System.IO.Path.GetExtension(FileUpload1.FileName), Session["domain"].ToString());


                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.StackTrace);
                    Label1.Text = "File could not be uploaded.";
                }
            }
            else
            {
                Label1.Text = "Cannot accept files of this type.";
            }
        }
    }

    private void SaveToDatabase(string path, string domainId)
    {
        ExecuteInsertQuery("UPDATE dbo.[Domains] SET bgImage = '" + path + "' WHERE domainId = '" + domainId + "'");
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
}