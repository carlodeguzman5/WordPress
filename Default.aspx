<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="mdl-grid">
        <div class="mdl-layout-spacer"></div>
            <div class="" style="text-align:center;">
                <img src="Assets/word-logo-white.png" height="100px" />
                <h3 style="width: 30%; margin: 0 auto; color: #FFFFFF; text-shadow: 1px 1px 2px #000000;">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                </h3>
                <br/>
                <asp:Button CssClass="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" 
                    ID="Button1" runat="server" Text="Get Started" onclick="ButtonRegister_Click" />
                    <br>
                <asp:LinkButton ID="LoginLinkButton" runat="server" 
                    onclick="LoginLinkButton_Click">Already have an Account?</asp:LinkButton>
            </div>
        <div class="mdl-layout-spacer"></div>
    </div>

   
</asp:Content>

