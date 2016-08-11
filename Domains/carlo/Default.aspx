﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Domains_Template" ValidateRequest = "false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/tinymce/4.3.13/tinymce.min.js"></script>

<script type="text/javascript" language="javascript">
    tinymce.init({
        selector: "#newBlogEditor",
        plugins: "image, paste, emoticons, textcolor, wordcount",
        toolbar: "forecolor backcolor | styleselect | undo redo | removeformat | bold italic underline |  aligncenter alignjustify  | bullist numlist outdent indent | link | print | fontselect fontsizeselect",
        max_height: 700,
        min_height: 400
    });
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <body>
         <asp:HiddenField ID="HiddenField1" runat="server" />
         
        <div class="blog__posts mdl-grid">

          <asp:ListView ID="ListView1" runat="server" DataKeyNames="blogId" 
            DataSourceID="SqlDataSource1" EnableModelValidation="True">
            <EmptyDataTemplate>
                <div class="mdl-card mdl-cell mdl-cell--12-col">
                    <div class="mdl-card__media mdl-color-text--grey-50" style="vertical-align: middle;">
                        <h3>It's quiet here. Care to add a story?</h3>
                    </div>
                </div>
            </EmptyDataTemplate>
            <ItemTemplate>
                <div class="mdl-card mdl-cell mdl-cell--12-col">
                    <div class="mdl-card__media mdl-color-text--grey-50">
                        <h3><a href= "<%# Eval("blogTitle").ToString().Replace(" ", "_") + ".aspx" %>"> <%# Eval("blogTitle") %></a></h3>
                    </div>
                    <div class="mdl-color-text--grey-600 mdl-card__supporting-text">
                        <%# Eval("blogContent") %>
                    </div>

                    <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
                      <img src=" <%# "../../Assets/ProfilePictures/" + Eval("picture")  %>"  class="minilogo">
                      <div>
                        <strong><%# Eval("username") %></strong>
                        <span><%# Eval("dateCreated") %></span>
                      </div>
                    </div>

                    <span>
                        <button class="mdl-button mdl-js-button mdl-button--icon" <%# Eval("canLike").ToString().Equals("1") ? "" : "disabled" %>>
                          <i class="material-icons">favorite_border</i>
                        </button>
                        <button class="mdl-button mdl-js-button mdl-button--icon" <%# Eval("canReblog").ToString().Equals("1") ? "" : "disabled" %>>
                          <i class="material-icons">repeat</i>
                        </button>
                    </span>
                </div>
            </ItemTemplate>
            <LayoutTemplate>
                <div class="blog__posts mdl-grid" ID="itemPlaceholderContainer" runat="server" style="">
                    <div runat="server" id="itemPlaceholder" />
                </div>
            </LayoutTemplate>
            </asp:ListView>

            <a ID="show-dialog" href="#" class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
              <i class="material-icons">add</i>
            </a>

        </div>

        <div class="mdl-dialog addNewBlogDialog" style="width: 50%; position:absolute; z-index:101; top:20%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;">
            <h4 class="mdl-dialog__title">New Blog Entry</h4>
            <div class="mdl-dialog__content">
            <asp:Label ID="Label1" runat="server" Text="Title: "></asp:Label>
            <asp:TextBox CssClass="TitleText" ID="TitleText" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="You'll need a Title" Text="*" ControlToValidate="TitleText" 
                    Display="Dynamic" ValidationGroup="Blog"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ErrorMessage="There are invalid characters in your Title" ControlToValidate="TitleText" 
                    ValidationExpression="[a-z0-9A-Z'!? ]+" 
                    ValidationGroup="Blog"></asp:RegularExpressionValidator>
                    <p></p>
                <textarea id="newBlogEditor"></textarea>
                <asp:CheckBox ID="LikeCheck" runat="server" Checked="False" 
                    Text="Enable Liking"></asp:CheckBox>
                <asp:CheckBox ID="commentCheck" runat="server" Checked="False" 
                    Text="Disable Comments"></asp:CheckBox>
                <asp:CheckBox ID="reblogCheck" runat="server" Checked="False" 
                    Text="Disable Reblogging"></asp:CheckBox>

            </div>
            <div class="mdl-dialog__actions">
                <asp:Button ID="Button1" CssClass="mdl-button save" runat="server" Text="Save" OnClientClick="return false;"
                    UseSubmitBehavior="False" ValidationGroup="Blog"></asp:Button>
                <button type="button" class="mdl-button close">Discard</button>
                <button type="button" class="mdl-button draft">Save as Draft</button>
            </div>
        </div>


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" SelectCommand="SELECT blogId, blogTitle, b.domainId, b.username, blogContent, htmlBlogContent, canLike, canComment, canReblog, dateCreated, datemodified, picture FROM dbo.[Blogs] as b, dbo.[Accounts] as a WHERE a.username = b.username AND b.domainId = @domainId">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField1" Name="domainId" 
                    PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
    </body>
    



    <script type="text/javascript">
        var loc = window.location.pathname;
        var arr = loc.split('/');
        var dir = arr[arr.length - 2];

        var session = '<%= Session["domain"]%>'

        if (session != dir) {
            $('#show-dialog').hide();
        }

        $(document).ready(function () {
            var dialog = $('.addNewBlogDialog');

            dialog.css("visibility", "hidden")

            $('#show-dialog').on("click", function () {
                dialog.css("visibility", "visible");
            });

            $('.close').on('click', function () {
                dialog.css("visibility", "hidden");
            });

            $('.draft').on('click', function () {
                dialog.css("visibility", "hidden");
            });

            $('.save').on('click', function () {
                var contentText = tinyMCE.activeEditor.getContent({ format: 'text' }); //.replace(/'/g, "\\'");
                var contentHtml = tinyMCE.activeEditor.getContent(); //.replace(/'/g, "\\'");

                var LikeCheck;
                var CommentCheck;
                var ReblogCheck;

                if ($('#CommentCheck').is(':checked') == "true") {
                    CommentCheck = 0;
                }
                else {
                    CommentCheck = 1;
                }
                if ($('#LikeCheck').is(':checked') == "true") {
                    LikeCheck = 1;
                }
                else {
                    LikeCheck = 0;
                }
                if ($('#ReblogCheck').is(':checked') == "true") {
                    ReblogCheck = 0;
                }
                else {
                    ReblogCheck = 1;
                }

                var data = "{\"blogTitle\":\"" + $('.TitleText').val() + "\", \"domainId\":\"" + dir + "\",\"username\":\"" + dir + "\",\"blogContent\":\"" + contentText + "\"," +
                "\"canLike\":\"" + LikeCheck + "\",\"canComment\":\"" + CommentCheck + "\",\"canReblog\":\"" + ReblogCheck + "\",\"htmlBlogContent\":\"" + contentHtml + "\"}";

                if (typeof (Page_ClientValidate) == 'function') {
                    Page_ClientValidate();
                }


                if (Page_IsValid) {
                    alert(data);
                    $.ajax({
                        cache: false,
                        type: "POST",
                        url: "http://www.wordpress.com:1234/WordPress/Services/BlogsService.asmx/CreateBlog",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == "Success") {
                                location.replace($('.TitleText').val().replace(/ /g, "_") + ".aspx");
                            }
                        },
                        failure: function (response) {
                            //alert(response.ds);
                        }
                    });
                }
            });
        });
        
    </script>
</asp:Content>

