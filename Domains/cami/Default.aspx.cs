using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Diagnostics;

public partial class Domains_Template : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] path = Server.MapPath("").Split('\\');
        HiddenField1.Value = path[path.Length - 1];

        if (Session["domain"] != null) { 
            
        }

    }
    protected void btnHidden_Click(object sender, EventArgs e)
    {
        Debug.WriteLine("WOOH");
        Session["domain"] = null;
        Session["email"] = null;
        Session["username"] = null;
        Response.Redirect("/WordPress/Login.aspx");
    }
}