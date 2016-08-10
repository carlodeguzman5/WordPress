<%@ Page Title="" Language="C#" MasterPageFile="~/Domains/Template.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/tinymce/4.3.13/tinymce.min.js"></script>

    <script type="text/javascript" language="javascript">
        tinymce.init({
            selector: "#editBlogContent",
            plugins: "image"
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

        

        <script type="text/javascript">

            var loc = window.location.pathname;
            var arr = loc.split('/');
            var domain = arr[arr.length - 2];
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
                    //alert(response.d);
                    $('.TextBox3').val(response.d);
                },
                failure: function (response) {
                    //alert(response.ds);
                }
            });
            

        </script>

            <div class="blog__posts mdl-grid">
                <div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col">
                <asp:Button id="demo-menu-lower-left"
                        class="mdl-button mdl-js-button mdl-button--icon blog-menu" OnClientClick="return false;">
                  <i class="material-icons">more_vert</i>
                </asp:Button>

                <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                    for="demo-menu-lower-left">
                  <li class="mdl-menu__item edit">Edit</li>
                  <li class="mdl-menu__item delete">Delete</li>
                </ul>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:ListView ID="ListView1" runat="server" DataKeyNames="blogId" 
                            DataSourceID="SqlDataSource1" EnableModelValidation="True" 
                            EnableViewState="False">
                        
                            <ItemTemplate>
                            <div class="mdl-card__media mdl-color-text--grey-50">
                         
                                <h3>
                                    <%# Eval("blogTitle") %>
                                </h3>
                            </div>
                            <div class="mdl-color-text--grey-700 mdl-card__supporting-text meta">
                              <div class="minilogo"></div>
                              <div>
                                <strong><%# Eval("username") %></strong>
                                <span><%# Eval("dateCreated") %></span>
                              </div>
                              <div class="section-spacer"></div>
                              <div class="meta__favorites">
                                <%# Eval("likeCount") %>
                                <button id="like-button" class="mdl-button mdl-js-button" onclick="like()" <%# Eval("canLike").ToString().Equals("1") ? "" : "disabled" %>>
                                    <i class="material-icons" >favorite</i>
                                </button>
                                <span class="visuallyhidden">favorites</span>
                              </div>
                              <div>
                                <i class="material-icons" role="presentation">share</i>
                                <span class="visuallyhidden">share</span>
                              </div>
                            </div>
                        
                            <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
                                <p> <%# Eval("htmlBlogContent") %> </p>
                            </div>

                        
                            <div class="mdl-color-text--primary-contrast mdl-card__supporting-text comments">
                                <div class="form">
                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                            <textarea rows=2 class="mdl-textfield__input comment"  <%# Eval("canComment").ToString().Equals("1") ? "" : "disabled" %>  ></textarea>
                                            <label for="comment" class="mdl-textfield__label"> <%# Eval("canComment").ToString().Equals("1") ? "Join the Discussion" : "Comments have been disabled by the author."%></label>
                                    </div>
                                    <button onclick="comment()" id="comment-button" type="button" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon comment-button">
                                        <i class="material-icons" role="presentation">check</i><span class="visuallyhidden">add comment</span>
                                    </button>
                                </div>
                            </div>

                        </ItemTemplate>
                            <EmptyDataTemplate>
                            <div class="blog__posts mdl-grid">
                                <div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col">
                                    <div ID="itemPlaceholderContainer" runat="server" style="">
                                <span runat="server" id="itemPlaceholder" />
                                    </div>
                                </div>
                            </div>
                            </EmptyDataTemplate>
                            <LayoutTemplate>    
                                <div ID="itemPlaceholderContainer" runat="server">
                                    <span runat="server" id="itemPlaceholder" />
                                </div>
                            </LayoutTemplate>
                        </asp:ListView>

                    
                        <div class="mdl-color-text--primary-contrast mdl-card__supporting-text comments"

                            <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSource2" 
                                EnableModelValidation="True" EnableViewState="False">
                                <EditItemTemplate>
                                    <span style="">blogId:
                                    <asp:TextBox ID="blogIdTextBox" runat="server" Text='<%# Bind("blogId") %>' />
                                    <br />
                                    username:
                                    <asp:TextBox ID="usernameTextBox" runat="server" 
                                        Text='<%# Bind("username") %>' />
                                    <br />
                                    commentContent:
                                    <asp:TextBox ID="commentContentTextBox" runat="server" 
                                        Text='<%# Bind("commentContent") %>' />
                                    <br />
                                    timestamp:
                                    <asp:TextBox ID="timestampTextBox" runat="server" 
                                        Text='<%# Bind("timestamp") %>' />
                                    <br />
                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                        Text="Update" />
                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                        Text="Cancel" />
                                    <br /><br /></span>
                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <span>No comments yet. Care to share your thoughts?</span>
                                </EmptyDataTemplate>
                                <InsertItemTemplate>
                                    <span style="">blogId:
                                    <asp:TextBox ID="blogIdTextBox" runat="server" Text='<%# Bind("blogId") %>' />
                                    <br />username:
                                    <asp:TextBox ID="usernameTextBox" runat="server" 
                                        Text='<%# Bind("username") %>' />
                                    <br />commentContent:
                                    <asp:TextBox ID="commentContentTextBox" runat="server" 
                                        Text='<%# Bind("commentContent") %>' />
                                    <br />timestamp:
                                    <asp:TextBox ID="timestampTextBox" runat="server" 
                                        Text='<%# Bind("timestamp") %>' />
                                    <br />
                                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                                        Text="Insert" />
                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                        Text="Clear" />
                                    <br /><br /></span>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                   <div class="comment mdl-color-text--grey-700">
                                        <header class="comment__header">
                                            <img src=" <%# "../../Assets/ProfilePictures/" + Eval("picture")  %>"  class="comment__avatar">
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

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WordPressConnectionString %>" 
            SelectCommand="SELECT dbo.[Blogs].blogId, blogTitle, domainId, username, blogContent, htmlBlogContent, canLike, canComment, canReblog, dateCreated, dateModified, COUNT(dbo.[Likes].blogId) as likeCount
                FROM dbo.[Blogs]
                left join dbo.[Likes]
                on (dbo.[Blogs].blogId = dbo.[Likes].blogId)
                WHERE domainId = @domainId AND blogTitle = @blogTitle
                group by dbo.[Blogs].blogId, blogTitle, domainId, username, blogContent, htmlBlogContent, canLike, canComment, canReblog, dateCreated, dateModified">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="domainId" 
                    PropertyName="Text" Type="String" DefaultValue="" />
                <asp:ControlParameter ControlID="TextBox2" Name="blogTitle" 
                    PropertyName="Text" Type="String" DefaultValue="" />
            </SelectParameters>
        </asp:SqlDataSource>


    <dialog class="mdl-dialog deleteDialogPrompt" style="width: 50%; margin:0 auto;">
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
    </dialog>

    <div class=" editDialogWindow" style="width: 50%; position:absolute; left: 50%; z-index:101; top:40%; visibility: hidden; ">
        <div class="mdl-dialog" style="position: relative; left: -50%; background-color:White;">
            <h4 class="mdl-dialog__title">Edit Blog Entry</h4>
            <div class="mdl-dialog__content">
              <textarea id="editBlogContent"></textarea>
            </div>
            <div class="mdl-dialog__actions">
              <button type="button" class="mdl-button editDialogSave">Save Changes</button>
              <button type="button" class="mdl-button editDialogClose">I Changed My Mind</button>
            </div>
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
                            $('#like-button').css("color", "red");
                        }
                        else {
                            $('#like-button').css("color", "black");
                        }
                        __doPostBack('<%=UpdateButton.ClientID %>')
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
            }
        }

        function comment() {

            var username = '<%= Session["username"]%>'
            var data = "{\"blogId\":\"" + $('.TextBox3').val() + "\",\"username\":\"" + username + "\" ,\"commentContent\": \"" + $('.comment').val() + "\"}";

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
                        __doPostBack('<%=UpdateButton.ClientID %>')
                    },
                    failure: function (response) {
                        alert("Database Error");
                    }
                });
            }
        }

        $(document).ready(function () {
            var deleteDialog = document.querySelector('.deleteDialogPrompt');
            var editDialog = document.querySelector('.editDialogWindow');
            var domain = arr[arr.length - 2];
            var editor = tinymce.EditorManager.get('editBlogContent');
            var domainSession = '<%= Session["domain"]%>'


            $('.edit').on("click", function () {
                //editDialog.showModal();
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
                deleteDialog.showModal();
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
                deleteDialog.close();
            });

            $('.editDialogClose').on("click", function () {
                //editDialog.close();
                $('.editDialogWindow').css("visibility","hidden");
            });

            $('.editDialogSave').on("click", function () {

                var data = "{\"blogId\":\"" + $(".TextBox3").val() + "\",\"blogContentText\":\"" + editor.getContent({ format: 'text' }) + "\",\"blogContentHtml\":\"" + editor.getContent() + "\"}"
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

            __doPostBack('<%=UpdatePanel1.ClientID %>')
        });
    </script>
</body>
</asp:Content>

