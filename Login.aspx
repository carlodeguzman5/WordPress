<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Accounts_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style3
        {
            width: 140px;
        }
         .demo-card-square.mdl-card 
        {
            margin: 200px auto;
            width: 100%;
        }
        .demo-card-square > .mdl-card__title {
          color: #fff;
          background: rgb(255,171,64);
        }
        .demo-card-square > .mdl-card__supporting-text
        {
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="demo-card-square mdl-card mdl-shadow--2dp">
      <div class="mdl-card__title mdl-card--expand">
        <h2 class="mdl-card__title-text">Login</h2>
      </div>
      <div class="mdl-card__supporting-text">
        <table class="mdl-textfield--full-width">
            <tr>
                <td class="display-1">
                    <asp:Label ID="Label1" runat="server" Text="Email: "></asp:Label>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="emailText" CssClass="emailText" runat="server" ValidationGroup="Login"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="emailText" ErrorMessage="Email is Required" 
                        ValidationGroup="Login" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="emailText" 
                        ErrorMessage="Please enter a valid email address." 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        ValidationGroup="Login" Display="Dynamic">Please enter a valid email address.</asp:RegularExpressionValidator>
                    <br />
                    <asp:TextBox ID="passwordText" CssClass="passwordText" runat="server" TextMode="Password" 
                        ValidationGroup="Login"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="passwordText" ErrorMessage="Password is Required" 
                        ValidationGroup="Login" Display="Dynamic">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
            <td>
                &nbsp;</td>
                <td class="display-1" style="text-align:right;">
                   </td>
            
            </tr>
        </table>

      </div>
      <div class="mdl-card__actions mdl-card--border">
        <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent LoginButton" 
            ValidationGroup="Login" UseSubmitBehavior="false" OnClientClick="login(); return false;" />  
      </div>
    </div>

    <div id="demo-toast-example" class="mdl-js-snackbar mdl-snackbar">
        <div class="mdl-snackbar__text"></div>
        <button class="mdl-snackbar__action" type="button"></button>
    </div>

    <asp:Button ID="SessionButton" runat="server" CssClass="SessionButton" 
            UseSubmitBehavior="false" style="visibility:hidden;" onclick="SessionButton_Click" />  

    <script type="text/javascript">
 
        function login() {
            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate();
            }

            if (Page_IsValid) {
                var data = "{\"email\":\"" + $('.emailText').val() + "\",\"password\":\"" + $('.passwordText').val() + "\"}"
                console.log(data);
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com/WordPress/Services/AccountsService.asmx/Login",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d.split('|')[0] == "200") {
                            var emailText = $('.emailText').val();
                            var domainText = getDomainWithEmail(emailText);
                        }
                        else {
                            var data = { message: "Invalid Login Credentials",
                                timeout: 4000
                            };
                            var snackbarContainer = document.querySelector('#demo-toast-example');
                            snackbarContainer.MaterialSnackbar.showSnackbar(data);
                        }
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
        
            }
        
        }


        function getDomainWithEmail(email) {

            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com/WordPress/Services/DomainsService.asmx/GetDomain",
                data: "{\"email\":\"" + email + "\"}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('.SessionButton').click();
                },
                failure: function (response) {
                    alert("Database Error GetDomain");
                }
            });
        }
    
    
    </script>
</asp:Content>

