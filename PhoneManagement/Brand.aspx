<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Brand.aspx.cs" Inherits="PhoneManagement.Brand" %>
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
                            <a href="./" title="AnhDo Mobile"><span class="fa fa-home"></span><b> Trang chủ</b></a></li>
                        <li class="dropdown">
                            <a href="#" data-toggle="dropdown"><span class="caret"></span> Mức giá</a>
                            <ul class="dropdown-menu">
                                <li>
                                    <asp:HyperLink ID="hplLessThan3m" ToolTip="Dưới 3 triệu" runat="server">Dưới 3 triệu</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="hpl3mTo6m" ToolTip="Dưới 6 triệu" runat="server">Từ 3 - 6 triệu</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="hpl6mTo10m" ToolTip="Từ 6 đến 10 triệu" runat="server">Từ 6 - 10 triệu</asp:HyperLink></li>
                                <li>
                                <li>
                                    <asp:HyperLink ID="hpl10mTo15m" ToolTip="Từ 10 đến 15 triệu" runat="server">Từ 10 - 15 triệu</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="hplGreaterThan15m" ToolTip="Trên 15 triệu" runat="server">Trên 15 triệu</asp:HyperLink></li>
                            </ul>
                        </li>

                        <li class="dropdown">
                            <a href="#" data-toggle="dropdown"><span class="caret"></span> Sắp xếp</a>
                            <ul class="dropdown-menu">
                                <li>
                                    <asp:HyperLink ID="hplASC" ToolTip="Giá tăng dần" runat="server">Giá tăng dần</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="hplDESC" ToolTip="Giá giảm dần" runat="server">Giá giảm dần</asp:HyperLink></li>
                            </ul>
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
                        <a href='<%# Eval("name_url", "dien-thoai-{0}") %>'>
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
                            <%# Convert.ToInt32(Eval("quantity")) > 0 ?
                                writeText(Convert.ToInt32(Eval("id")), Convert.ToInt32(Eval("priceMain")))
                                : "<h5 class=\"text-warning\"><i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i>&nbsp;<b>Tạm thời hết hàng</b></h5>" 
                            %>
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
    <p></p>

</asp:Content>
