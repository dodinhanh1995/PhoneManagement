<%@ Page Title="Điện thoại Anh Đỗ, smart phone, apple, samsung chính hãng | AnhDo Mobile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PhoneManagement.Default" %>

<%@ Register Src="~/UserControls/Home/UcProducts.ascx" TagPrefix="uc1" TagName="UcProducts" %>
<%@ Register Src="~/UserControls/Templates/UcLogoOfBrand.ascx" TagPrefix="uc1" TagName="UcLogoOfBrand" %>
<%@ Register Src="~/UserControls/Home/UcNews.ascx" TagPrefix="uc1" TagName="UcNews" %>
<%@ Register Src="~/UserControls/Templates/UcAdvertisements.ascx" TagPrefix="uc1" TagName="UcAdvertisements" %>
<%@ Register Src="~/UserControls/Home/UcBannerRight.ascx" TagPrefix="uc1" TagName="UcBannerRight" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Page Content -->
    <section class="container" id="content">
        <div class="row">

            <uc1:UcLogoOfBrand runat="server" ID="UcLogoOfBrand" />

            <uc1:UcAdvertisements runat="server" ID="UcAdvertisements" />

            <!-- Products Content Column -->
            <uc1:UcProducts runat="server" ID="UcProducts" />
            <!-- end col-lg-8-->

            <!-- Tech News Column -->
            <div class="col-lg-4" id="tech_news">

                <uc1:UcNews runat="server" ID="UcNews" />
                <!-- end panel -->


                <!-- banner right -->
                <uc1:UcBannerRight runat="server" id="UcBannerRight" />



            </div>
            <!-- end Tech News Column -->
        </div>
        <!-- end row -->
    </section>
    <h5></h5>
    <!-- end Page Content -->





</asp:Content>
