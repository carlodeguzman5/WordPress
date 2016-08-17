<%@ Page Title="" Language="C#" MasterPageFile="Template.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Domains_Template" ValidateRequest = "false"%>

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
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:HiddenField ID="HiddenField1" runat="server" />
         
        <div class="blog__posts mdl-grid">

            <div class="mdl-card something-else mdl-cell mdl-cell--8-col mdl-cell--4-col-desktop">
                <button type="button" class="mdl-button mdl-js-ripple-effect mdl-js-button mdl-button--fab mdl-color--accent">
                  <i class="material-icons mdl-color-text--white" role="presentation">add</i>
                  <span class="visuallyhidden">add</span>
                </button>
                <div class="mdl-card__media mdl-color--white mdl-color-text--grey-600">
                  <img alt="Profile Picture" class="picture" src="" />
                </div>
                <div class="mdl-card__supporting-text meta meta--fill mdl-color-text--grey-600">
                  <div>
                    <strong class="username"></strong>
                  </div>
                  <ul class="mdl-menu mdl-js-menu mdl-menu--bottom-right mdl-js-ripple-effect" for="menubtn">
                    <li class="mdl-menu__item">About</li>
                    <li class="mdl-menu__item">Message</li>
                    <li class="mdl-menu__item">Favorite</li>
                    <li class="mdl-menu__item">Search</li>
                  </ul>
                  <button id="menubtn" type="button" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                    <i class="material-icons" role="presentation">more_vert</i>
                    <span class="visuallyhidden">show menu</span>
                  </button>
                </div>
            </div>
            
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="blogId" 
                    DataSourceID="SqlDataSource1" EnableModelValidation="True" 
                    onitemcommand="ListView1_OnItemCommand" EnableViewState="False">
                    <EmptyDataTemplate>
                        <div class="mdl-card mdl-cell mdl-cell--12-col">
                            <div class="mdl-card__media mdl-color-text--grey-50" style="vertical-align: middle;">
                                <h3>It's quiet here. Care to add a story?</h3>
                            </div>
                        </div>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="mdl-card mdl-cell mdl-cell--12-col">
                            <div class="mdl-card__media mdl-color-text--grey-50" style="background-color: <%# Eval("primaryColor") %> ; background-image: url('http://www.wordpress.com/WordPress/Assets/BlogHeaders/<%#Eval("image")%>')">
                                <h3 style="text-shadow: 1px 1px 2px #000000;"><a href= "<%# Eval("blogTitle").ToString().Replace(" ", "_") + ".aspx" %>"> <%# Eval("blogTitle") %></a></h3>
                            </div>
                            <div class="mdl-color-text--grey-600 mdl-card__supporting-text">
                                <%# Eval("blogContent") %>
                            </div>

                            <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
                              <img alt="DP" src=" <%# "http://www.wordpress.com/WordPress/Assets/ProfilePictures/" + Eval("picture")  %>"  class="minilogo">
                              <div>
                                <strong><%# Eval("username") %></strong>
                                <span><%# Eval("dateCreated") %></span>
                              </div>
                            </div>

                            <span>
                                <asp:LinkButton ID="LinkButton1" runat="server" class="mdl-button mdl-js-button mdl-button--icon" CommandName="Like" CommandArgument="22">
                                    <i class="material-icons like-icon" style="color:<%# Eval("isLiked").ToString().Equals("1") ? "Red" : "Black" %>">favorite</i>
                                </asp:LinkButton>
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
                </ContentTemplate>
            </asp:UpdatePanel>

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
        ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" SelectCommand="SELECT blogId, blogTitle, b.domainId, b.username, blogContent, htmlBlogContent, canLike, canComment, canReblog, dateCreated, datemodified, picture, primaryColor, secondaryColor, image,
                CASE WHEN EXISTS(SELECT * FROM dbo.[Likes] as l WHERE l.email = @email AND l.blogId = b.blogId)
                    THEN '1' 
                    ELSE '0'
	                END AS isLiked
                FROM dbo.[Blogs] AS b, dbo.[Accounts] AS a, dbo.[Domains] as d 
                WHERE a.username = b.username 
                AND d.domainId = b.domainId
                AND b.domainId = @domainId">
            <SelectParameters>
                <asp:SessionParameter Name="email" SessionField="email" DefaultValue=" " />
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

        function Like(blogId) {
            alert(blogId);
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
                        url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/CreateBlog",
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



            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com/WordPress/Services/AccountsService.asmx/GetProfileInformation",
                data: "{\"domainId\":\"" + dir + "\"}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var datatable = JSON.parse(response.d)[0];

                    $('.picture').prop("src", "../../Assets/ProfilePictures/" + datatable["picture"]);
                    $('.username').html(datatable["username"]);


                },
                failure: function (response) {
                    //alert(response.ds);
                }
            });


            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com/WordPress/Services/DomainsService.asmx/GetStyles",
                data: "{\"domainId\":\"" + dir + "\"}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var datatable = JSON.parse(response.d)[0];

                    $('body').css("background-image", "url('http://www.wordpress.com/WordPress/Assets/BackgroundImages/" + datatable["bgImage"] + "'");

                },
                failure: function (response) {
                    //alert(response.ds);
                }
            });


        });
        //__doPostBack('<%=UpdatePanel1.ClientID%>', '')
    </script>
</asp:Content>

