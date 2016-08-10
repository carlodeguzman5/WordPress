<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Domains_Template" ValidateRequest = "false"%>

<%@ Register src="~/RichTextEditor.ascx" tagname="RichTextEditor" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <body>
         <asp:HiddenField ID="HiddenField1" runat="server" />
         
        <div class="blog__posts mdl-grid">

          <asp:ListView ID="ListView1" runat="server" DataKeyNames="blogId" 
            DataSourceID="SqlDataSource1" EnableModelValidation="True">

            <EditItemTemplate>
                <span style="">blogId:
                <asp:Label ID="blogIdLabel1" runat="server" Text='<%# Eval("blogId") %>' />
                <br />
                blogTitle:
                <asp:TextBox ID="blogTitleTextBox" runat="server" 
                    Text='<%# Bind("blogTitle") %>' />
                <br />
                domainId:
                <asp:TextBox ID="domainIdTextBox" runat="server" 
                    Text='<%# Bind("domainId") %>' />
                <br />
                username:
                <asp:TextBox ID="usernameTextBox" runat="server" 
                    Text='<%# Bind("username") %>' />
                <br />
                blogContent:
                <asp:TextBox ID="blogContentTextBox" runat="server" 
                    Text='<%# Bind("blogContent") %>' />
                <br />
                canLike:
                <asp:TextBox ID="canLikeTextBox" runat="server" Text='<%# Bind("canLike") %>' />
                <br />
                canComment:
                <asp:TextBox ID="canCommentTextBox" runat="server" 
                    Text='<%# Bind("canComment") %>' />
                <br />
                canReblog:
                <asp:TextBox ID="canReblogTextBox" runat="server" 
                    Text='<%# Bind("canReblog") %>' />
                <br />
                dateCreated:
                <asp:TextBox ID="dateCreatedTextBox" runat="server" 
                    Text='<%# Bind("dateCreated") %>' />
                <br />
                datemodified:
                <asp:TextBox ID="datemodifiedTextBox" runat="server" 
                    Text='<%# Bind("datemodified") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                    Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                    Text="Cancel" />
                <br /><br /></span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <div class="mdl-card mdl-cell mdl-cell--12-col">
                    <div class="mdl-card__media mdl-color-text--grey-50" style="vertical-align: middle;">
                        <h3>It's quiet here. Care to add a story?</h3>
                    </div>
                </div>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <span style="">blogTitle:
                <asp:TextBox ID="blogTitleTextBox" runat="server" 
                    Text='<%# Bind("blogTitle") %>' />
                <br />domainId:
                <asp:TextBox ID="domainIdTextBox" runat="server" 
                    Text='<%# Bind("domainId") %>' />
                <br />username:
                <asp:TextBox ID="usernameTextBox" runat="server" 
                    Text='<%# Bind("username") %>' />
                <br />blogContent:
                <asp:TextBox ID="blogContentTextBox" runat="server" 
                    Text='<%# Bind("blogContent") %>' />
                <br />canLike:
                <asp:TextBox ID="canLikeTextBox" runat="server" Text='<%# Bind("canLike") %>' />
                <br />canComment:
                <asp:TextBox ID="canCommentTextBox" runat="server" 
                    Text='<%# Bind("canComment") %>' />
                <br />canReblog:
                <asp:TextBox ID="canReblogTextBox" runat="server" 
                    Text='<%# Bind("canReblog") %>' />
                <br />dateCreated:
                <asp:TextBox ID="dateCreatedTextBox" runat="server" 
                    Text='<%# Bind("dateCreated") %>' />
                <br />datemodified:
                <asp:TextBox ID="datemodifiedTextBox" runat="server" 
                    Text='<%# Bind("datemodified") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                    Text="Insert" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                    Text="Clear" />
                <br /><br /></span>
            </InsertItemTemplate>
            <ItemTemplate>
                <div class="mdl-card mdl-cell mdl-cell--12-col">
                    <div class="mdl-card__media mdl-color-text--grey-50">
                        <h3><a href= "<%# Eval("blogTitle").ToString().Replace(" ", "_") + ".aspx" %>"> <%# Eval("blogTitle") %></a></h3>
                    </div>
                    <div class="mdl-color-text--grey-600 mdl-card__supporting-text">
                        <%# Eval("blogContent") %>
                    </div>

                    <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
                      <div class="minilogo"></div>
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
            <SelectedItemTemplate>
                <span style="">blogId:
                <asp:Label ID="blogIdLabel" runat="server" Text='<%# Eval("blogId") %>' />
                <br />
                blogTitle:
                <asp:Label ID="blogTitleLabel" runat="server" Text='<%# Eval("blogTitle") %>' />
                <br />
                domainId:
                <asp:Label ID="domainIdLabel" runat="server" Text='<%# Eval("domainId") %>' />
                <br />
                username:
                <asp:Label ID="usernameLabel" runat="server" Text='<%# Eval("username") %>' />
                <br />
                blogContent:
                <asp:Label ID="blogContentLabel" runat="server" 
                    Text='<%# Eval("blogContent") %>' />
                <br />
                canLike:
                <asp:Label ID="canLikeLabel" runat="server" Text='<%# Eval("canLike") %>' />
                <br />
                canComment:
                <asp:Label ID="canCommentLabel" runat="server" 
                    Text='<%# Eval("canComment") %>' />
                <br />
                canReblog:
                <asp:Label ID="canReblogLabel" runat="server" Text='<%# Eval("canReblog") %>' />
                <br />
                dateCreated:
                <asp:Label ID="dateCreatedLabel" runat="server" 
                    Text='<%# Eval("dateCreated") %>' />
                <br />
                datemodified:
                <asp:Label ID="datemodifiedLabel" runat="server" 
                    Text='<%# Eval("datemodified") %>' />
                <br />
    <br /></span>
            </SelectedItemTemplate>
            </asp:ListView>

            <a ID="show-dialog" href="#" class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
              <i class="material-icons">add</i>
            </a>

        </div>

     

    <dialog class="mdl-dialog">
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
            <uc1:RichTextEditor ID="RichTextEditor1" runat="server" />
            <asp:CheckBox ID="LikeCheck" runat="server" Checked="False" 
                Text="Enable Liking"></asp:CheckBox>
            <asp:CheckBox ID="commentCheck" runat="server" Checked="False" 
                Text="Disable Comments"></asp:CheckBox>
            <asp:CheckBox ID="reblogCheck" runat="server" Checked="False" 
                Text="Disable Reblogging"></asp:CheckBox>

        </div>
        <div class="mdl-dialog__actions">
            <asp:Button ID="Button1" CssClass="mdl-button save" runat="server" Text="Save" OnClientClick=""
                UseSubmitBehavior="False" ValidationGroup="Blog"></asp:Button>
            <button type="button" class="mdl-button close">Discard</button>
            <button type="button" class="mdl-button draft">Save as Draft</button>
        </div>
    </dialog>

    <asp:Button ID="btnHidden" CssClass="btnHidden hidden" runat="server" ClientIDMode="Static" 
             onclick="btnHidden_Click" />

    <script type="text/javascript">
        var loc = window.location.pathname;
        var arr = loc.split('/');
        var dir = arr[arr.length - 2];

        var session = '<%= Session["domain"]%>'

        if (session != dir) {
            $('#show-dialog').hide();
        }




        $(document).ready(function () {
            var dialog = document.querySelector('dialog');
            var showDialogButton = document.querySelector('#show-dialog');


            //$('.mdl-layout-title').val(dir);

            if (!dialog.showModal) {
                dialogPolyfill.registerDialog(dialog);
            }
            showDialogButton.addEventListener('click', function () {
                dialog.showModal();
            });
            dialog.querySelector('.close').addEventListener('click', function () {

                dialog.close();
            });

            dialog.querySelector('.draft').addEventListener('click', function () {
                dialog.close();
            });

            dialog.querySelector('.save').addEventListener('click', function () {
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

                //alert(data);

                if (typeof (Page_ClientValidate) == 'function') {
                    Page_ClientValidate();
                }


                if (Page_IsValid) {
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
    
    <script type="text/javascript" src="https://code.getmdl.io/1.1.3/material.min.js"></script>
    
    </body>
    


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" SelectCommand="SELECT * FROM dbo.[Blogs]
WHERE domainId = @domainId">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="domainId" 
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

