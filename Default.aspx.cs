﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["domain"] != null) {
            Response.Redirect("~/Domains/" + Session["domain"].ToString() + "/");
        }
    }
    protected void ButtonRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Register.aspx");
    }

    protected void LoginLinkButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Login.aspx");
    }
}