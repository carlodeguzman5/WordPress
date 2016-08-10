using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Diagnostics;

public partial class Accounts_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public static bool AppendToHostsFile(string entry)
    {
        try
        {
            using (StreamWriter w = File.AppendText(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.System), @"drivers\etc\hosts")))
            {
                w.WriteLine(entry);
                return true;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            return false;
        }
    }

    protected void SessionButton_Click(object sender, EventArgs e)
    {
        Session["domain"] = domainText.Text;
        Session["email"] = emailText.Text;
        Session["username"] = usernameText.Text;

        Response.Redirect("~/Domains/" + domainText.Text);
    }
}