using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

public partial class Accounts_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void SessionButton_Click(object sender, EventArgs e)
    {
        com.wordpress.www.AccountsService AccountService = new com.wordpress.www.AccountsService();
        com.wordpress.www.DomainsService DomainsService = new com.wordpress.www.DomainsService();

        String[] data = AccountService.Login(emailText.Text, passwordText.Text).Split('|');

        string domainName = DomainsService.GetDomain(emailText.Text);
        Session["domain"] = domainName;
        Session["email"] = emailText.Text;
        Session["username"] = data[1];

        if (!domainName.Equals(""))
        {
            Response.Redirect("~/Domains/" + domainName);
        }
    }
}