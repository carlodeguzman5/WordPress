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

    protected void ListView1_OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (String.Equals(e.CommandName, "Like"))
        {

            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            string blogId = ListView1.DataKeys[dataItem.DisplayIndex].Value.ToString();

            com.wordpress.www.LikesService LikesService = new com.wordpress.www.LikesService();
            if (Session["email"] != null)
            {
                LikesService.CreateLike(blogId, Session["email"].ToString());
                //UpdatePanel1.Update();   
            }
            //else, return error message.
        }
    }
}