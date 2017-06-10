<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="PhoneManagement.Details" EnableViewState="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="margin_top10"></div>
    <section class="container" id="detail">
        <div class="row">
            <ul class="breadcrumb bg_white">
                <li>
                    <a href="./" title="AnhDo Mobile"><span class="fa fa-home"></span>Trang chủ</a>
                </li>
                <li>
                    <a href="thuong-hieu-<%: brandNameUrl %>" title="Thương hiệu <%: brandNameUrl %>">
                        <span class="fa fa-mobile"></span><%: brandName %>
                    </a>
                </li>
            </ul>

            <asp:ListView ID="lvProductDetails" runat="server">
                <ItemTemplate>
                    <div class="col-lg-12 bg_white title pull-left">
                        <h1 class="name" style="margin: 0" title='<%# Eval("name") %>'><b><%# Eval("name") %></b></p></h1>
                    </div>

                    <!-- Menu Left -->
                    <div class="col-lg-1 menu_left margin_top10">
                        <ul>
                            <li>
                                <a href='<%# Eval("name_url", "dien-thoai-{0}#specifications") %>'>
                                    <span class="fa fa-cogs"></span>
                                    <br />
                                    Cấu hình
                                </a>
                            </li>

                            <li>
                                <a href='<%# Eval("name_url", "dien-thoai-{0}#comment") %>'>
                                    <span class="fa fa-comment"></span>
                                    <br />
                                    Bình luận
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Information Product-->
                    <div class="col-lg-8 bg_white" id="detail_info">
                        <!-- The picture product -->
                        <div class="col-md-4 text-center">

                            <img src='<%# Eval("picture", "public/upload/products/{0}") %>' title='<%# Eval("name") %>' alt='<%# Eval("name") %>' width="180" />

                        </div>

                        <!-- Infomation Details -->
                        <div class="col-md-8 information">

                            <span class="price">
                                <h3><%# CalculationPrice() %><sup>đ</sup></h3>
                            </span>

                            <ul class="brief">
                                <li>Sản phẩm gồm: <span class="text-info">Sạc, Hộp, Tai nghe, Sách hướng dẫn, Cáp USB.</span></li>
                                <span class="fa fa-gift"></span>Tặng Dock sạc hoặc gậy chụp ảnh remote.
					                <li>Chính hãng: <strong>Bảo hành chính hãng 12 tháng.</strong></li>
                                <li><strong>1 đổi 1 trong 1 tháng</strong> nếu sản phẩm lỗi.</li>
                                <li>Giao hàng tận nơi miễn phí trong <strong>30 phút.</strong></li>
                            </ul>
                            <div class="clearfix"></div>
                            <% if (CheckQuantity())
                               { %>
                            <div id="btn_buy" class="text-left">
                                <ul>
                                    <li>
                                        <a href='<%# Eval("id", "AddToCart.aspx?id={0}") %>' title="Đặt mua"><b>Đặt mua</b><p class="small">Xem hàng, không thích không mua</p>
                                        </a></li>
                                </ul>
                            </div>
                            <%
                               }
                               else
                               {
                            %>
                            <h4 class="text-warning">
                                <i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;
                                    Sản phẩm tạm thời hết hàng.
                            </h4>
                            <% } %>
                        </div>

                        <div class="clearfix">
                            <hr />
                        </div>

                        <!-- specifications detail -->
                        <div class="col-md-12" id="specifications">
                            <%# Eval("description") %>
                        </div>
                        
                </ItemTemplate>
            </asp:ListView>
            <!-- The comment -->
            <div class="col-md-12" id="comment">
                <p class="margin_top30"></p>
                <!-- Comments Form -->
                <div class="well">
                    <h4>Viết bình luận ...<span class="glyphicon glyphicon-pencil"></span></h4>
                    <div class="form-group">
                        <textarea class="form-control" placeholder="Nhập nội dung..." id="txtComment"></textarea>
                    </div>
                    <a class="btn btn-primary">Gửi</a>
                </div>
                <hr />

                <% for (int i = 0; i < 3; i++)
                   { %>
                <!-- Posted Comments -->
                <div class="media">
                    <a class="pull-left" href="#">
                        <img class="media-object" src="public/upload/members/none.png" width="60px" />
                    </a>
                    <div class="media-body">
                        <h4 class="media-heading"><b>Name</b></h4>
                        <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla.</p>
                        <small>
                            <span class="glyphicon glyphicon-time"></span>August 25, 2016 at 9:30 PM
                        </small>
                    </div>
                </div>
                <!-- End Posted Comments -->
                <%} %>
            </div>
            <!-- End The Comment -->
        </div>
        <!-- end col-lg-9 Information Product-->

        <!-- Suggestion Product -->
        <div class="col-lg-3 menu_right margin_top10">
            <div class="panel panel-primary">
                <div class="panel-heading"><strong>Bạn chưa hài lòng? thử tìm:</strong></div>
                <div class="panel-body">
                    <ul>
                        <asp:Repeater ID="rptProductSuggestion" runat="server">
                            <ItemTemplate>
                                <li>
                                    <a href='<%# Eval("name_url", "dien-thoai-{0}") %>' title='<%# Eval("name") %>'>
                                        <h2 class="size-15 margin_top0"><%# Eval("name") %></h2>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <!-- end row -->

    </section>
    <h5></h5>


</asp:Content>
