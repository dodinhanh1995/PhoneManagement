<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcNews.ascx.cs" Inherits="PhoneManagement.UserControls.Home.UcNews" %>
<%@ OutputCache Duration="600" VaryByParam="none" %>
<div class="panel panel-info margin_top10">
    <div class="panel-heading">
        <h1 class="size-x-large margin_top10"><span class="glyphicon glyphicon-globe"></span> Tin công nghệ</h1>
    </div>
    <div class="panel-body">

        <!-- item -->
        <asp:Repeater ID="rptNewsTitle" runat="server" EnableViewState="false">
            <ItemTemplate>
                <div class="box_news col-md-12">
                    <header class="col-md-9 pull-left">
                        <a href='<%# Eval("urlTitle", "tin-tuc-{0}") %>' title='<%# Eval("title") %>'><%# Eval("title") %></a>
                        <p class="text-muted small margin_top5">
                            <span class="glyphicon glyphicon-time"></span> <%# Convert.ToDateTime(Eval("dateCreated")).ToShortDateString() %>
                        </p>
                    </header>

                    <footer class="col-md-3 pull-left">
                        <a href='<%# Eval("urlTitle", "tin-tuc-{0}") %>' title="<%# Eval("title") %>">
                            <img src='<%# Eval("picture", "public/upload/news/{0}") %>' alt="<%# Eval("picture") %>" width="80" height="65" />
                        </a>
                    </footer>
                </div>
                <div class="clear5">
                    <hr />
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <!-- end item -->
    </div>
    <!-- end panel body -->
</div>
<!-- end panel -->
