﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" AutoEventWireup="true" CodeFile="Customize.aspx.cs" Inherits="Domains_Customize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../Scripts/jscolor/jscolor.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
   <!-- Square card -->
    <style>
        .demo-card-square.mdl-card 
        {
            margin: 100px auto;
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
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div class="demo-card-square mdl-card mdl-shadow--2dp">
      <div class="mdl-card__title mdl-card--expand">
        <h2 class="mdl-card__title-text">Customize Profile</h2>
      </div>
      <div class="mdl-card__supporting-text">
          
            <table>
                <tr>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                        <asp:Button ID="Button1" runat="server" Text="Upload" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Primary Color: <input id="primary-color" class="jscolor" value="">
                        <button id="primaryColorButton" type="button" onclick="setPrimaryColor()" >
                            Set Color
                        </button>
                    </td>
                </tr>
            </table>

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


        $.ajax({
            cache: false,
            type: "POST",
            url: "http://www.wordpress.com:1234/WordPress/Services/DomainsService.asmx/GetStyles",
            data: "{\"domainId\":\"" + '<%=Session["domain"]%>' + "\"}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var datatable = JSON.parse(response.d)[0];

                $('.mdl-card__media').css("background-color", datatable["primaryColor"]);
                $('.mdl-card_media').css("color", datatable["secondaryColor"]);
                $('body').css("background-image", "url('../Assets/BackgroundImages/" + datatable["bgImage"] + "')");

                $('#primary-color').val( datatable["primaryColor"] );

            },
            failure: function (response) {
                //alert(response.ds);
            }
        });

        function setPrimaryColor() {
            var primaryColor = $('#primary-color').val();

            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com:1234/WordPress/Services/DomainsService.asmx/setPrimaryColor",
                data: "{\"color\":\"#" + primaryColor +"\",\"domainId\":\"" + '<%=Session["domain"]%>' + "\"}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                   
                },
                failure: function (response) {
                    alert("Database Error: Set Primary Color");
                }
            });


        }

    </script>

</asp:Content>

