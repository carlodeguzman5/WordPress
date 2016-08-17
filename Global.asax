<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">
    void Application_Start(object sender, EventArgs e) 
    {
        RegisterRoutes(RouteTable.Routes);
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        
    }

    public static void RegisterRoutes(RouteCollection routes)
    {
        routes.Add("HomePage", new Route
        (
           "carlo",
           new CustomRouteHandler("~/WordPress/")
        ));

        routes.Add("BikeSaleRoute", new Route
        (
           "carlo",
           new CustomRouteHandler("~/WordPress/Domains/carlo/Default.aspx")
        ));
        
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
