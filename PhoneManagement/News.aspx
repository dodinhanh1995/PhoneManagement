<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="PhoneManagement.News" EnableViewState="false" %>
<%@ OutputCache Duration="60" VaryByParam="id" %>
<%@ Register Src="~/UserControls/Home/UcNews.ascx" TagPrefix="uc1" TagName="UcNews" %>
<%@ Register Src="~/UserControls/Home/UcBannerRight.ascx" TagPrefix="uc1" TagName="UcBannerRight" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="bg_white" id="news">
        <div class="container">
            <div class="row">
                <h3></h3>
                <div class="col-lg-8">
                    <div class="row">
                        <asp:ListView ID="lvNewsDetails" runat="server">
                            <ItemTemplate>
                                <h1 title='<%# Eval("title") %>'><%# Eval("title") %></h1>
                                <%# Eval("content") %>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
                <!-- end col-lg-8 -->

                <!-- Tech News Column -->
                <div class="col-lg-4" id="tech_news">
                    <div class="row">

                        <!-- banner right -->
                        <div class="banner_aside">
                            <img src="public/upload/advertisements/iPhone7_7plus-Red.png" alt="iphone 7plus red" title="iphone 7 plus red" width="100%" />
                            <img src="public/upload/advertisements/GalaxyS8ProNew.png" alt="galaxy s8 pro " title="galaxy s8 pro" width="100%" class="margin_top10" />
                        </div>

                        <uc1:UcNews runat="server" ID="UcNews" />
                        <!-- end panel -->

                        <uc1:UcBannerRight runat="server" ID="UcBannerRight" />
                    </div>
                </div>
                <!-- end Tech News Column -->

            </div>
            <!-- end row -->
            <h5></h5>
        </div>
        <!-- end container -->
    </section>


</asp:Content>
