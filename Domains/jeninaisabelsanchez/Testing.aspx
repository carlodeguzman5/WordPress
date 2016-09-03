<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" %>

<script runat="server">

    protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(e.CommandArgument.ToString());
    }
    
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
    <div id="fb-root"></div>
    <script>        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=1659501234363339";
            fjs.parentNode.insertBefore(js, fjs);
        } (document, 'script', 'facebook-jssdk'));</script>
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
                  <li class="mdl-menu__item upload">Upload Header Image</li>
                </ul>
                    
                <div class="mdl-card__media mdl-color-text--grey-50" style="height: 200px;">
                    <h2 class="blogTitle" style="text-shadow: 1px 1px 2px #000000;">
                    </h2>
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
                        <span>
                            <button id="LikeButton" type="button" onclick="return false;" class="mdl-button mdl-js-button mdl-button--icon like-button">
                                <i class="material-icons like-icon">favorite</i>
                            </button>
                            <span class="visuallyhidden">favorites</span>
                        </span>

                        <button id="ReblogButton" type="button" onclick="return false;" class="mdl-button mdl-js-button mdl-button--icon reblog-button">
                            <i class="material-icons reblog-icon">repeat</i>
                        </button>
                        <span class="visuallyhidden">repeat</span>

                    </div>
                    <div>
                    <div class="fb-share-button" onclick="fbshareCurrentPage()" data-layout="button" data-size="large" data-mobile-iframe="false"><a class="fb-xfbml-parse-ignore" >Share</a></div>
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
                                            <div>   
                                                <button class="mdl-button mdl-js-button mdl-button--icon" type="button" onclick="deleteConfirm(<%#Eval("commentId")%>)" style="visibility:<%# Eval("username").ToString().Equals(Session["username"].ToString()) ? "visible" : "hidden" %>" >
                                                  <i class="material-icons">clear</i>
                                                </button>
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
                ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" SelectCommand="SELECT c.blogId, c.username, commentContent, timestamp, picture, commentId FROM dbo.[Comments] as c JOIN dbo.[Accounts] ON c.username = dbo.[Accounts].username 
                WHERE blogId = @blogId ORDER BY timestamp DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox3" Name="blogId" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

    <div class="mdl-dialog deleteDialogPrompt" style="width: 50%; position:fixed; z-index:101; top:20%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;"">
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

    <div class="mdl-dialog editDialogWindow" style="width: 70%; position:fixed; z-index:101; top:10%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;">
        
        <h4 class="mdl-dialog__title">Edit Blog Entry</h4>
        <div class="mdl-dialog__content">
            <textarea id="editBlogContent"></textarea>
        </div>
        <div class="mdl-dialog__actions">
            <button type="button" class="mdl-button editDialogSave">Save Changes</button>
            <button type="button" class="mdl-button editDialogClose">I Changed My Mind</button>
        </div>
        
    </div>

    <div class="mdl-dialog uploadDialogWindow" style="width: 50%; position:fixed; z-index:101; top:20%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;">
        
        <h4 class="mdl-dialog__title">Upload Header Image</h4>
        <div class="mdl-dialog__content">
            
            <input type="file" class="upload" id="f_UploadImage" />
            <img id="myUploadedImg" alt="Photo" style="width:180px;" />

        </div>
        <div class="mdl-dialog__actions">
            <button type="button" class="mdl-button uploadDialogSave">Save Changes</button>
            <button type="button" class="mdl-button uploadDialogClose">I Changed My Mind</button>
        </div>
        
    </div>

    <div class="mdl-dialog commentDeleteDialog" style="width: 50%; position:fixed; z-index:101; top:20%; background-color:White; visibility: hidden; margin-left: auto; margin-right: auto; left: 0; right: 0;">
        
        <h4 class="mdl-dialog__title">Are you sure you want to delete this comment?</h4>
        <div class="mdl-dialog__content"> 

        </div>
        <div class="mdl-dialog__actions">
            <button type="button" class="mdl-button commentDeleteYes">Yes</button>
            <button type="button" class="mdl-button commentDeleteDialogClose">Nevermind</button>
        </div>
        
    </div>

    

    <script type="text/javascript">
        var emailSession = '<%= Session["email"] %>'
        var domainSession = '<%= Session["domain"] %>'
        var usernameSession = '<%= Session["username"] %>'

        function reblog() {
            if (emailSession == "") {
                alert("Please Login to Like posts");
            }
            else {
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com/WordPress/Services/ReblogsService.asmx/Reblog",
                    data: "{\"domainId\":\"" + domainSession + "\",\"blogId\":\"" + $('.TextBox3').val() + "\"}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "Reblogged") {
                            $('.reblog-icon').css("color", "blue");
                        }
                        else {
                            $('.reblog-icon').css("color", "black");
                        }
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
            }


        }

        function like() {
            var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"username\":\"" + usernameSession + "\"}";
            if (emailSession == "") {
                alert("Please Login to Like posts");
            }
            else {
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com/WordPress/Services/LikesService.asmx/CreateLike",
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
                    url: "http://www.wordpress.com/WordPress/Services/CommentsService.asmx/CreateComment",
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

        var commentPointer;
        function deleteConfirm(commentId) {
            $('.commentDeleteDialog').css("visibility", "visible");
            commentPointer = commentId;

        }

        $('.commentDeleteYes').on("click", function () {
            deleteComment(commentPointer);
            $('.commentDeleteDialog').css("visibility", "hidden");
        });

        $('.commentDeleteDialogClose').on("click", function () {
            commentPointer = null;
            $('.commentDeleteDialog').css("visibility", "hidden");
        });


        function deleteComment(commentId) {
            $.ajax({
                cache: false,
                type: 'POST',
                url: 'http://www.wordpress.com/WordPress/Services/CommentsService.asmx/DeleteComment',
                data: "{\"commentId\":\"" + commentId + "\"}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    __doPostBack('<%=UpdatePanel2.ClientID %>', '');
                },
                error: function (response) {
                    alert("Database Error: Delete Comment");
                }
            });


        }

        function GetBlogData() {

            var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"username\":\"" + '<%=Session["username"]%>' + "\",\"email\":\"" + emailSession + "\"}";
            $.ajax({
                cache: false,
                type: "POST",
                url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/GetBlogContentsForPage",
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
                        $('.mdl-card__media').css("background-image", "url('http://www.wordpress.com/WordPress/Assets/BlogHeaders/" + datatable["image"] + "')");
                        $('.mdl-card__media').css("background-size", "cover");

                        var date = new Date(parseInt(datatable["dateCreated"].replace(/\//g, "").replace(/Date\(/g, "").replace(/\)/g, "")));
                        $('.dateCreated').html(new Date());

                        if (datatable["isLiked"] == "1") {
                            $('.like-icon').css("color", "Red");
                        }

                        if (datatable["isReblogged"] == "1") {
                            $('.reblog-icon').css("color", "Blue");
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

                        if (datatable["canReblog"] == "0" || datatable['domainId'] == '<%=Session["domain"]%>') {
                            $('.reblog-button').attr("disabled", "disabled");
                        }
                        else {
                            $('.reblog-button').attr("onclick", "reblog(); return false;");
                        }

                    }
                },
                failure: function (response) {
                    alert("Database Error");
                }
            });
        }


        var _URL = window.URL || window.webkitURL;
        $("#f_UploadImage").on('change', function () {

            var file, img;
            if ((file = this.files[0])) {
                img = new Image();
                img.onload = function () {
                    sendFile(file);
                };
                img.onerror = function () {
                    alert("Not a valid file:" + file.type);
                };
                img.src = _URL.createObjectURL(file);
            }
        });

        function sendFile(file) {

            var formData = new FormData();
            formData.append('file', $('#f_UploadImage')[0].files[0]);
            $.ajax({
                type: 'post',
                url: 'http://www.wordpress.com/WordPress/fileUploader.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error') {
                        var my_path = "http://www.wordpress.com/WordPress/Assets/Temp/" + status;
                        $("#myUploadedImg").attr("src", my_path);
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    alert("Whoops something went wrong!");
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
                url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/GetBlogId",
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
                    url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/GetBlogContent",
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

            $('.upload').on("click", function () {
                $('.uploadDialogWindow').css("visibility", "visible");
            });


            $('.dialogDelete').on("click", function () {
                var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"domainId\":\"" + domain + "\",\"blogTitle\":\"" + newTitle + "\"}";

                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/DeleteBlog",
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

            $('.uploadDialogClose').on("click", function () {
                $('.uploadDialogWindow').css("visibility", "hidden");
                editor.setContent("");
            });


            $('.uploadDialogSave').on("click", function () {
                var imagePath = $('#myUploadedImg').prop("src");
                var array = imagePath.split('/');

                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/UploadBlogHeader",
                    data: "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"imageName\":\"" + array[array.length - 1] + "\"}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        location.reload();
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });

                $('.uploadDialogWindow').css("visibility", "hidden");


            });

            function fbshareCurrentPage() {
                window.open("https://www.facebook.com/sharer/sharer.php?u=" + escape(window.location.href) + "&t=" + document.title, '',
                'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');
                return false;
            }

            $('.editDialogSave').on("click", function () {

                var data = "{\"blogId\":\"" + $(".TextBox3").val() + "\",\"blogContentText\":\"" + editor.getContent({ format: 'text' }) + "\",\"blogContentHtml\":\"" + editor.getContent().replace(/"/g, "'") + "\"}"
                console.log(data);
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "http://www.wordpress.com/WordPress/Services/BlogsService.asmx/EditBlogContent",
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
                url: "http://www.wordpress.com/WordPress/Services/DomainsService.asmx/GetStyles",
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

