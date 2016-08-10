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
}