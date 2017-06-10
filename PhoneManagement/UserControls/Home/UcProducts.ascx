<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcProducts.ascx.cs" Inherits="PhoneManagement.UserControls.Home.UcProducts" EnableViewState="false" %>
<%@ OutputCache Duration="180" VaryByParam="none" %>


<!-- Products Content Column -->
<div class="col-lg-8 inner_content">
    <!-- Title -->
    <h1>
        <a href="thuong-hieu-apple" title="ios">
            <img src="public/upload/logo/ios.png" alt="ios" width="40" title="ios" /><b  class="size-x-large">iOS</b>
        </a>
    </h1>
    <!-- item -->
    <asp:Repeater ID="rptIosProductBox" runat="server">
        <ItemTemplate>
            <div class="col-md-4 text-center box_product">
            
                <a href='<%# Eval("name_url", "dien-thoai-{0}") %>' title='<%# Eval("name") %>'>
                    <img src='<%# Eval("picture", "public/upload/products/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' />
                </a>
                <hr />
                <strong>
                    <p class="text-left name"><%# Eval("name") %></p>
                </strong>

                <div>
                    <p class="text-left price-discount">
                        <%# Convert.ToInt32(Eval("discount")) > 0 ? "<del>" + Eval("price", "{0: 0,0}") + "</del><sup>đ</sup>" : "" %>
                    </p>
                    <span class="price pull-left">
                        <b><%# Eval("priceMain", "{0: 0,0}") %><sup>đ</sup></b>
                    </span>
                    <a href='<%# Eval("id", "AddToCart.aspx?id={0}") %>' title="Đặt mua" class="btn btn-xs btn-warning pull-right">
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


    <asp:Image ID="imgHomeMiddle" CssClass="margin_top10" runat="server" Width="100%" />

    <!-- Android Products-->
    <!-- Title -->
    <h1>
        <a href="thuong-hieu-samsung" title="android">
            <img src="public/upload/logo/android.png" alt="android" title="android" width="40" /><b  class="size-x-large">Android</b>
        </a>
    </h1>
    <!-- item -->
    <asp:Repeater ID="rptAdroidProductBox" runat="server">
        <ItemTemplate>
            <div class="col-md-4 text-center box_product">
                <a href='<%# Eval("name_url", "dien-thoai-{0}") %>' title=''<%# Eval("name") %>'>
                    <img src='<%# Eval("picture", "public/upload/products/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' />
                </a>
                <hr />
                <strong>
                    <p class="text-left name"><%# Eval("name") %></p>
                </strong>
                <div>
                    <p class="text-left price-discount">
                        <%# Convert.ToInt32(Eval("discount")) > 0 ? "<del>" + Eval("price", "{0: 0,0}") + "</del><sup>đ</sup>" : "" %>
                    </p>
                    <span class="price pull-left">
                        <b><%# Eval("priceMain", "{0: 0,0}") %><sup>đ</sup></b>
                    </span>
                    <a href='<%# Eval("id", "AddToCart.aspx?id={0}") %>' title="Đặt mua" class="btn btn-xs btn-warning pull-right">
                        <span class="fa fa-cart-plus">
                            <b>Đặt mua</b>
                        </span>
                    </a>
                    <div class="icon-discount">
                        <%# Convert.ToInt32(Eval("discount")) > 0 ? "<p class='btn btn-success btn-xs pull-right'>-" + Eval("discount") + "%</p>" : "" %>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <!-- end item -->





</div>
<!-- end col-lg-8-->
