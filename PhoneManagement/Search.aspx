<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="PhoneManagement.Search" %>

<%@ Register Src="~/UserControls/Templates/UcLogoOfBrand.ascx" TagPrefix="uc1" TagName="UcLogoOfBrand" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="margin_top10"></div>
    <section class="container telephone_page">
        <!-- Banner Telephone Page -->
        <div class="row">
            <div class="phone_banner">
                <asp:Repeater ID="rptAdvertiseTop" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <img src='<%# Eval("picture", "public/upload/advertisements/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' width="300" height="120" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </ItemTemplate>
                </asp:Repeater>

            </div>


            <div class="clear10"></div>
            <!-- Menu Filter -->
            <nav class="navbar navbar-inverse margin_top10">
                <div class="col-md-10">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="./"><span class="fa fa-home" title="AnhDo Mobile"></span> <b> Trang chủ</b></a>
                        </li>
                        <li>
                            <a>
                                <asp:Label ID="lblKey" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label></asp:Label>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="col-md-2 pull-right">
                    <h6 class="lead text-right">
                        <asp:Label ID="lblTotalRecords" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="White"></asp:Label></h6>
                </div>
            </nav>
            <!-- End Menu Filter -->


            <uc1:UcLogoOfBrand runat="server" ID="UcLogoOfBrand" />


            <!-- item -->
            <asp:Repeater ID="rptProductBox" runat="server" EnableViewState="false">
                <ItemTemplate>
                    <div class="col-md-2 text-center sub-box-product">
                        <a href='<%# Eval("name_url", "dien-thoai-{0}") %>' title=''<%# Eval("name") %>'>
                            <img src='<%# Eval("picture", "public/upload/products/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' />
                        </a>
                        <hr />
                        <strong>
                            <p class="text-left"><%# Eval("name") %></p>
                        </strong>

                        <div>
                            <p class="text-left price-discount">
                                <%# Convert.ToInt32(Eval("discount")) > 0 ? "<del>" + Eval("price", "{0: 0,0}") + "</del><sup>đ</sup>" : "" %>
                            </p>
                            <span class="price pull-left">
                                <b><%# Eval("priceMain", "{0: 0,0}") %><sup>đ</sup></b>
                            </span>
                            <a href='<%# Eval("id", "AddToCart.aspx?id={0}") %>' class="btn btn-xs btn-warning pull-right">
                            <span class="fa fa-cart-plus">
                                <b>Đặt mua</b>
                            </span>
                            </a>
                        </div>
                        <div class="icon-discount">
                            <%# Convert.ToInt32(Eval("discount")) > 0 ? "<p class='btn btn-success btn-xs pull-right'>-" + Eval("discount") + "%</p>" : "" %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <!-- end item -->
        </div>
        <!-- end row -->
    </section>
    <!-- End Telephone Page -->
    <h3></h3>


</asp:Content>
