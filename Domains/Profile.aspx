<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Domains_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <!-- Square card -->
    <style>
        .demo-card-square.mdl-card 
        {
            margin: 0 auto;
            width: 60%;
        }
        .demo-card-square > .mdl-card__title {
          color: #fff;
          background: rgb(255,171,64);
          height: 250px;
        }
        .demo-card-square > .mdl-card__supporting-text
        {
            
        }
    </style>
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="demo-card-square mdl-card mdl-shadow--2dp">
      <div class="mdl-card__title mdl-card--expand" style="background-image: url('http://www.wordpress.com/WordPress/Assets/profile.jpg'); background-size:cover;">
        <h1 class="mdl-card__title-text">Profile</h1>
      </div>
      <div class="mdl-card__supporting-text" >
          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
           <ContentTemplate>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="email" 
              DataSourceID="SqlDataSource1" EnableModelValidation="True">
              <EmptyDataTemplate>
                  <span>An Error has occured.</span>
              </EmptyDataTemplate>
              <ItemTemplate>
                    <table style="padding: 0 32px 0 32px; width: 100%;" >
                        <tr>
                            <td>
                                <p>Profile Picture: </p>
                            </td>
                            <td>
                                <asp:Image ID="Image1" AlternateText="Picture" ImageUrl= '<%# "~/Assets/ProfilePictures/" +  Eval("picture") %>' width="100px" runat="server" />
                                   
                            </td>
                        </tr>
                        <tr>
                            <td>
                             <p>Username: </p>
                            </td>
                            <td>
                                <p><%# Eval("username") %></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p> Email Address: </p>
                            </td>
                            <td>
                                <p><%# Eval("email") %></p>
                            </td>
                        </tr>
                        
                    </table>
                </ItemTemplate>
                <LayoutTemplate>
                    <div ID="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            </ContentTemplate>
          </asp:UpdatePanel>
          

            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Upload" />

          <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
              ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" SelectCommand="SELECT * FROM dbo.[Accounts]
                WHERE email = @email">
              <SelectParameters>
                  <asp:SessionParameter Name="email" SessionField="email" />
              </SelectParameters>
          </asp:SqlDataSource>

      </div>
      <div class="mdl-card__actions mdl-card--border">
        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">
          Save
        </a>
      </div>
    </div>
    <script type="text/javascript">
        $.ajax({
            cache: false,
            type: "POST",
            url: "http://www.wordpress.com/WordPress/Services/AccountsService.asmx/GetImagePath",
            data: "{\"email\":\"" + '<%=Session["email"] %>' + "\"}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $('#image').attr("src", response.d);
            },
            failure: function (response) {
                //alert(response.ds);
            }
        });


        $.ajax({
            cache: false,
            type: "POST",
            url: "http://www.wordpress.com/WordPress/Services/DomainsService.asmx/GetStyles",
            data: "{\"domainId\":\"" + '<%=Session["domain"]%>' + "\"}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var datatable = JSON.parse(response.d)[0];

                $('.mdl-card__title').css("background-color", datatable["primaryColor"]);
                $('.mdl-card__title').css("color", datatable["secondaryColor"]);
                $('body').css("background-image", "url('../Assets/BackgroundImages/" + datatable["bgImage"] + "')");


            },
            failure: function (response) {
                //alert(response.ds);
            }
        });

    </script>


</asp:Content>

