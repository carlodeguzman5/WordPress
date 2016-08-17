using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Domains_Template : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnHidden_Click(object sender, EventArgs e)
    {
        Session["domain"] = null;
        Session["email"] = null;
        Session["username"] = null;
        Response.Redirect("/WordPress/Login.aspx");
    }
}
