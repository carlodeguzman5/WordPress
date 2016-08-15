<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/tinymce/4.3.13/tinymce.min.js"></script>

    <script type="text/javascript" language="javascript">
        tinymce.init({
            selector: "#editBlogContent",
            plugins: "image, paste, emoticons, textcolor, wordcount",
            toolbar: "forecolor backcolor | styleselect | undo redo | removeformat | bold italic underline |  aligncenter alignjustify  | bullist numlist outdent indent | link | print | fontselect fontsizeselect",
            max_height: 700,
            min_height: 400
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<body>
            <div class="demo-back">
              <a class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" href="./" title="go back" role="button">
                <i class="material-icons" role="presentation">arrow_back</i>
              </a>
               
            </div>

            <asp:TextBox ID="TextBox1" cssClass="TextBox1" Text="" runat="server" style="visibility:hidden;"></asp:TextBox>
            <asp:TextBox ID="TextBox2" cssClass="TextBox2" text="" runat="server" style="visibility:hidden;"></asp:TextBox>
            <asp:TextBox ID="TextBox3" cssClass="TextBox3" text="" runat="server" style="visibility:hidden;"></asp:TextBox>


            <div class="blog__posts mdl-grid">
                <div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col">
                <button id="blogMenu" type="button"
                        class="mdl-button mdl-js-button mdl-button--icon blog-menu" >
                  <i class="material-icons">more_vert</i>
                </button>

                <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect" for="blogMenu">
                  <li class="mdl-menu__item edit">Edit</li>
                  <li class="mdl-menu__item delete">Delete</li>
                </ul>
                    
                <div class="mdl-card__media mdl-color-text--grey-50">
                    <h3 class="blogTitle">
                    </h3>
                </div>
                <div class="mdl-color-text--grey-700 mdl-card__supporting-text meta">
                    <img class="picture minilogo" src="">
                    <div>
                    <strong class="username"></strong>
                    <span class="dateCreated"></span>
                    </div>
                    <div class="section-spacer"></div>
                    <div class="meta__favorites">
                        <div class="likeCount"> </div>
                        <asp:LinkButton ID="LikeButton" runat="server" OnClientClick="return false;" class="mdl-button mdl-js-button like-button">
                            <i class="material-icons like-icon">favorite</i>
                        </asp:LinkButton>
                        <span class="visuallyhidden">favorites</span>
                    </div>
                    <div>
                    <i class="material-icons" role="presentation">share</i>
                    <span class="visuallyhidden">share</span>
                    </div>
                </div>
                        
                <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
                    <p class="htmlBlogContent"></p>
                </div>

                        
                <div class="mdl-color-text--primary-contrast mdl-card__supporting-text comments">
                    <div class="form">
                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                <textarea rows=2 class="mdl-textfield__input comment-field"></textarea>
                                <label for="comment" class="mdl-textfield__label comment-label"></label>
                        </div>
                        <button onclick="comment()" id="comment-button" type="button" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon comment-button">
                            <i class="material-icons" role="presentation">check</i><span class="visuallyhidden">add comment</span>
                        </button>
                    </div>
                </div>

                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" EnableViewState="False">
                    <ContentTemplate>
                        <div class="mdl-color-text--primary-contrast mdl-card__supporting-text comments">
                            <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSource2" 
                                EnableModelValidation="True" EnableViewState="False">
                                <EmptyDataTemplate>
                                    <span>No comments yet. Care to share your thoughts?</span>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <div class="comment mdl-color-text--grey-700">
                                        <header class="comment__header">
                                            <img alt="DP" src=" <%# "../../Assets/ProfilePictures/" + Eval("picture")  %>"  class="comment__avatar">
                                            <div class="comment__author">
                                            <strong><%# Eval("username") %></strong>
                                            <span><%# Eval("timestamp") %></span>
                                            </div>
                                        </header>
                                        <div class="comment__text">
                                            <%# Eval("commentContent") %>
                                        </div>
                                        <br />
                                        <br />
                                    </div>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div ID="itemPlaceholderContainer" runat="server" style="">
                                        <span runat="server" id="itemPlaceholder" />
                                    </div>
                                    <div style="">
                                    </div>
                                </LayoutTemplate>
                            </asp:ListView>
                        </div>
                    </ContentTemplate>

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="UpdateButton" EventName="Click" />
                    </Triggers>
               
                </asp:UpdatePanel>
                <asp:Button ID="UpdateButton" runat="server" style="display:none;" />
            </div>
        </div>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" SelectCommand="SELECT c.blogId, c.username, commentContent, timestamp, picture FROM dbo.[Comments] as c JOIN dbo.[Accounts] ON c.username = dbo.[Accounts].username 
                WHERE blogId = @blogId ORDER BY timestamp DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox3" Name="blogId" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

    <div class="mdl-dialog deleteDialogPrompt" style="width: 50%; position:absolute; z-index:101; top:20%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;"">
        <h4 class="mdl-dialog__title">Delete Blog Entry?</h4>
        <div class="mdl-dialog__content">
          <p>
            You will not be able to recover this blog.
            Are you sure you want to delete this?
          </p>
        </div>
        <div class="mdl-dialog__actions">
          <button type="button" class="mdl-button dialogDelete">Delete</button>
          <button type="button" class="mdl-button deleteDialogClose">I Changed My Mind</button>
        </div>
    </div>

    <div class="mdl-dialog editDialogWindow" style="width: 50%; position:absolute; z-index:101; top:20%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;">
        
        <h4 class="mdl-dialog__title">Edit Blog Entry</h4>
        <div class="mdl-dialog__content">
            <textarea id="editBlogContent"></textarea>
        </div>
        <div class="mdl-dialog__actions">
            <button type="button" class="mdl-button editDialogSave">Save Changes</button>
            <button type="button" class="mdl-button editDialogClose">I Changed My Mind</button>
        </div>
        
    </div>

    <script type="text/javascript">
        var emailSession = '<%= Session["email"] %>'

        function like() {
            var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"email\":\"" + emailSession + "\"}";
            if (emailSession == "") {
                alert("Please Login to Like posts");
            }
            else {
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com:1234/WordPress/Services/LikesService.asmx/CreateLike",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "Liked") {
                            $('.like-icon').css("color", "red");
                            $('.likeCount').html(parseInt($('.likeCount').html()) + 1);
                        }
                        else {
                            $('.like-icon').css("color", "black");
                            $('.likeCount').html(parseInt($('.likeCount').html()) - 1);
                        }
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
            }
        }

        function comment() {

            var username = '<%= Session["username"]%>'
            var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"username\":\"" + username + "\" ,\"commentContent\": \"" + $('.comment-field').val() + "\"}";

            if (username == "") {
                alert("Please log in to post a comment");
            }
            else {
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com:1234/WordPress/Services/CommentsService.asmx/CreateComment",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $('.comment-field').val("");
                        __doPostBack('<%=UpdateButton.ClientID %>')
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
            }
        }

        function GetBlogData() {

            var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"email\":\"" + '<%=Session["email"]%>' + "\"}";
            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com:1234/WordPress/Services/BlogsService.asmx/GetBlogContentsForPage",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var datatable = JSON.parse(response.d)[0];

                    if (datatable != null) {
                        $('.blogTitle').html(datatable["blogTitle"]);
                        $('.htmlBlogContent').html(datatable["htmlBlogContent"]);
                        $('.likeCount').html(datatable["likeCount"]);
                        $('.picture').prop("src", "../../Assets/ProfilePictures/" + datatable["picture"]);
                        $('.username').html(datatable["username"]);
                        $('.mdl-card__media').css("background-color", datatable["primaryColor"]);

                        var date = new Date(parseInt(datatable["dateCreated"].replace(/\//g, "").replace(/Date\(/g, "").replace(/\)/g, "")));
                        $('.dateCreated').html(new Date());

                        if (datatable["isLiked"] == "1") {
                            $('.like-icon').css("color", "Red");
                        }

                        if (datatable["canComment"] == "0") {
                            $('.comment-field').attr("disabled", "disabled");
                            $('.comment-label').html("Comments have been disabled.");

                        }
                        else if (datatable["canComment"] == "1") {
                            $('.comment-label').html("Join the discussion!");
                        }

                        if (datatable["canLike"] == "0") {
                            $('.like-button').attr("disabled", "disabled");
                        }
                        else {
                            $('.like-button').attr("onclick", "like(); return false;");
                        }

                    }
                },
                failure: function (response) {
                    alert("Database Error");
                }
            });
        }

        $(document).ready(function () {

            var deleteDialog = document.querySelector('.deleteDialogPrompt');
            var editDialog = document.querySelector('.editDialogWindow');

            var loc = window.location.pathname;
            var arr = loc.split('/');
            var domain = arr[arr.length - 2];
            var editor = tinymce.EditorManager.get('editBlogContent');
            var domainSession = '<%= Session["domain"]%>'

            var title = arr[arr.length - 1];
            var newTitle = title.replace(/.aspx/, "").replace(/_/g, " ")

            $('.TextBox1').val(domain);
            $('.TextBox2').val(newTitle);

            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com:1234/WordPress/Services/BlogsService.asmx/GetBlogId",
                data: "{'domainId':'" + domain + "', 'blogTitle':'" + newTitle + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('.TextBox3').val(response.d);
                    GetBlogData();
                    __doPostBack('<%=UpdatePanel2.ClientID%>', '')
                },
                failure: function (response) {
                    alert("Database Error");
                }
            });





            $('.edit').on("click", function () {
                $('.editDialogWindow').css("visibility", "visible");

                var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\"}";

                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com:1234/WordPress/Services/BlogsService.asmx/GetBlogContent",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        editor.setContent(response.d);
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });



            });

            $('.delete').on("click", function () {
                $('.deleteDialogPrompt').css("visibility", "visible");
            });

            $('.dialogDelete').on("click", function () {
                var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"domainId\":\"" + domain + "\",\"blogTitle\":\"" + newTitle + "\"}";

                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com:1234/WordPress/Services/BlogsService.asmx/DeleteBlog",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        window.location = "/WordPress/Domains/" + domain;
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
            });

            $('.deleteDialogClose').on("click", function () {
                $('.deleteDialogPrompt').css("visibility", "hidden");
            });

            $('.editDialogClose').on("click", function () {
                $('.editDialogWindow').css("visibility", "hidden");
                editor.setContent("");
            });

            $('.editDialogSave').on("click", function () {

                var data = "{\"blogId\":\"" + $(".TextBox3").val() + "\",\"blogContentText\":\"" + editor.getContent({ format: 'text' }) + "\",\"blogContentHtml\":\"" + editor.getContent().replace(/"/g, "'") + "\"}"
                console.log(data);
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com:1234/WordPress/Services/BlogsService.asmx/EditBlogContent",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        location.reload();
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });

                editDialog.close();
            });

            if (domainSession != domain) {
                $(".blog-menu").hide();
            }




            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com:1234/WordPress/Services/DomainsService.asmx/GetStyles",
                data: "{\"domainId\":\"" + domain + "\"}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var datatable = JSON.parse(response.d)[0];

                    $('body').css("background-image", "url('../../Assets/BackgroundImages/" + datatable["bgImage"] + "')");
                },
                failure: function (response) {
                    alert("Database Error: Set BG Image")
                }
            });


        });
        
    </script>
</body>
</asp:Content>

