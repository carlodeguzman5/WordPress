<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Domains_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <!-- Square card -->
    <style>
        .demo-card-square.mdl-card 
        {
            margin: 200px auto;
            width: 60%;
        }
        .demo-card-square > .mdl-card__title {
          color: #fff;
          background: rgb(255,171,64);
        }
        .demo-card-square > .mdl-card__supporting-text
        {
            
        }
    </style>

    <div class="demo-card-square mdl-card mdl-shadow--2dp">
      <div class="mdl-card__title mdl-card--expand">
        <h2 class="mdl-card__title-text">Profile</h2>
      </div>
      <div class="mdl-card__supporting-text">
          <asp:ListView ID="ListView1" runat="server" DataKeyNames="email" 
              DataSourceID="SqlDataSource1" EnableModelValidation="True">
              <EditItemTemplate>
                  <span style="">email:
                  <asp:Label ID="emailLabel1" runat="server" Text='<%# Eval("email") %>' />
                  <br />
                  username:
                  <asp:TextBox ID="usernameTextBox" runat="server" 
                      Text='<%# Bind("username") %>' />
                  <br />
                  password:
                  <asp:TextBox ID="passwordTextBox" runat="server" 
                      Text='<%# Bind("password") %>' />
                  <br />
                  domainId:
                  <asp:TextBox ID="domainIdTextBox" runat="server" 
                      Text='<%# Bind("domainId") %>' />
                  <br />
                  picture:
                  <asp:TextBox ID="pictureTextBox" runat="server" Text='<%# Bind("picture") %>' />
                  <br />
                  <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                      Text="Update" />
                  <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                      Text="Cancel" />
                  <br /><br /></span>
              </EditItemTemplate>
              <EmptyDataTemplate>
                  <span>No data was returned.</span>
              </EmptyDataTemplate>
              <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                             Username: 
                            </td>
                            <td>
                                 <asp:TextBox ID="TextBox1" ReadOnly="true" runat="server" Text='<%# Eval("username") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Email Address: 
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox2" ReadOnly="true" runat="server" Text='<%# Eval("email") %>'></asp:TextBox> 
                            </td>
                        </tr>
                        <tr>
                            <td>
                                
                            </td>
                            <td>
                                <asp:Image ID="Image1" AlternateText="Picture" ImageUrl= '<%# "~/Assets/ProfilePictures/" +  Eval("picture") %>' width="100px" runat="server" />
                                   
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

            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
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
          View Updates
        </a>
      </div>
    </div>
    <script type="text/javascript">
        $.ajax({
            cache: false,
            type: "POST",
            url: "http://www.wordpress.com:1234/WordPress/Services/AccountsService.asmx/GetImagePath",
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
    </script>


</asp:Content>

