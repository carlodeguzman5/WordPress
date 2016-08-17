<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Accounts_Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
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

    <div class="demo-card-square mdl-card mdl-shadow--2dp">
      <div class="mdl-card__title mdl-card--expand">
        <h2 class="mdl-card__title-text">Register</h2>
      </div>
      <div class="mdl-card__supporting-text">
        <table class="style1">
    <tr>
        <td dir="rtl">
            <asp:Label ID="Label1" runat="server" Text="Email"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Username"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Your Domain Name"></asp:Label>
            <br />
        </td>
        <td>
            <asp:TextBox ID="emailText" CssClass="emailText" runat="server" Width="200px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="emailText" Display="Dynamic" 
                ErrorMessage="Please enter a valid Email Address" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ValidationGroup="register">Please enter a valid Email Address</asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="emailText" ErrorMessage="Required Field" 
                ValidationGroup="register">*</asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:TextBox ID="usernameText" CssClass="usernameText" runat="server"
                Width="200px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                ControlToValidate="usernameText" Display="Dynamic" 
                ErrorMessage="Only Alphanumeric characters are allowed" 
                ValidationExpression="[a-zA-Z0-9]+" ValidationGroup="register">Only Alphanumeric Characters are Allowed</asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="usernameText" Display="Dynamic" 
                ErrorMessage="Required Field" ValidationGroup="register">*</asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:TextBox ID="passwordText" CssClass="passwordText" runat="server" Width="200px" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="passwordText" Display="Dynamic" 
                ErrorMessage="Required Field" ValidationGroup="register">*</asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:TextBox ID="domainText" CssClass="domainText"  runat="server" Width="200px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                ControlToValidate="domainText" Display="Dynamic" 
                ErrorMessage="Only Alphanumeric Characters are Allowed" 
                ValidationExpression="[a-zA-Z0-9]+" ValidationGroup="register">Only Alphanumeric Characters are Allowed</asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="domainText" Display="Dynamic" 
                ErrorMessage="RequiredFieldValidator" ValidationGroup="register">*</asp:RequiredFieldValidator>
            <br />
        </td>
    </tr>
</table>

      </div>
      
    <asp:Button cssClass="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" 
    ID="RegisterButton" runat="server" Text="Create My Site" 
    ValidationGroup="register" UseSubmitBehavior="False" OnClientClick="register(); return false;"/>
</div>

<div id="demo-toast-example" class="mdl-js-snackbar mdl-snackbar">
  <div class="mdl-snackbar__text"></div>
  <button class="mdl-snackbar__action" type="button"></button>
</div>

<asp:Button ID="SessionButton" runat="server" CssClass="SessionButton" 
        UseSubmitBehavior="false" style="visibility:hidden;" OnClick="SessionButton_Click" /> 

<script type="text/javascript">

    function register() {
        if (typeof (Page_ClientValidate) == 'function') {
            Page_ClientValidate();
        }

        if (Page_IsValid) {
            var data = "{\"email\":\"" + $('.emailText').val() + "\",\"username\":\"" + $('.usernameText').val() + "\",\"password\":\"" + $('.passwordText').val() + "\",\"domain\":\"" + $('.domainText').val() + "\"}"

            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com/WordPress/Services/AccountsService.asmx/Register",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d == "200|Your account is ready!") {
                        $('.SessionButton').click();
                    }
                    else {
                        var data = { message: response.d.split('|')[1],
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



</script>

</asp:Content>


