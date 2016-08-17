using System;
using System.Web;

public class CustomRouteHandler : System.Web.Routing.IRouteHandler
{

    public CustomRouteHandler(string virtualPath)
    {
        this.VirtualPath = virtualPath;
    }

    public string VirtualPath { get; private set; }

    public IHttpHandler GetHttpHandler(System.Web.Routing.RequestContext
          requestContext)
    {
        var page = System.Web.Compilation.BuildManager.CreateInstanceFromVirtualPath
             (VirtualPath, typeof(System.Web.UI.Page)) as IHttpHandler;
        return page;
    }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}