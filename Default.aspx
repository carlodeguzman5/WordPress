<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="mdl-grid">
        <div class="mdl-layout-spacer"></div>
            <div class="" style="text-align:center;">
                <asp:Button CssClass="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" 
                    ID="Button1" runat="server" Text="Get Started" onclick="ButtonRegister_Click" />
                    <br>
                <asp:LinkButton ID="LoginLinkButton" runat="server" 
                    onclick="LoginLinkButton_Click">Already have an Account?</asp:LinkButton>
            </div>
        <div class="mdl-layout-spacer"></div>
    </div>
</asp:Content>

