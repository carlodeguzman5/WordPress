function dbInsert() {
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