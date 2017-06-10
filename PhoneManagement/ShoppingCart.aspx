<%@ Page Title="Giỏ hàng | AnhDo Mobile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="PhoneManagement.ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container" id="shopping_cart">
        <p class="margin_top10"></p>
        <div class="row">
            <div class="col-lg-3"></div>
            <div class="col-lg-6 bg_white">

                <asp:Panel ID="pnlTitle" runat="server" EnableViewState="false">
                    <!-- Title of Shopping Cart -->
                    <div class="col-lg-12 title bg_white margin_top10">
                        <ul>
                            <li>Đặt hàng nhanh
                        <img src="public/upload/details/right.png" alt="right" width="25"></li>
                            <li>Thanh toán và giao hàng
                        <img src="public/upload/details/right.png" alt="right" width="25"></li>
                        </ul>
                    </div>
                    <div class="clearfix">
                        <hr />
                    </div>
                </asp:Panel>

                <asp:MultiView ID="mulViewShoppingCart" runat="server" ActiveViewIndex="0">
                    <asp:View ID="viewEmpty" runat="server">
                        <div class="clearfix"></div>
                        <h4 class="margin_top20">Không có sản phẩm nào trong giỏ hàng.</h4>
                        <a class="btn btn-danger" href="./">Quay về trang chủ</a>
                        <h4></h4>
                    </asp:View>


                    <asp:View ID="viewCart" runat="server">
                        <asp:UpdatePanel ID="UpdatePanelCart" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="table table-strip table-condensed" DataKeyNames="ID" ShowFooter="True" OnRowCommand="gvCart_RowCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <a href="./" title="Mua thêm sản phẩm khác"><i class="fa fa-arrow-left"></i>Mua thêm sản phẩm khác.</a>
                                                <hr />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div class="pull-left">
                                                    <asp:Image ID="imgPicture" CssClass="pull-left" runat="server" ImageUrl='<%# Eval("Picture", "~/public/upload/products/{0}") %>' AlternateText='<%# Eval("Name") %>' ToolTip='<%# Eval("Name") %>' Width="50px" Height="70px" />
                                                </div>
                                                <div class="pull-left margin_left10 margin_top10">
                                                    <a href='<%# Eval("NameUrl", "dien-thoai-{0}")%>'>
                                                        <asp:Label ID="lblName" ToolTip='<%# Eval("Name") %>' runat="server" Text='<%# Eval("Name") %>' CssClass="text-info" Font-Bold="True"></asp:Label></a>
                                                    <p>
                                                        <asp:Label ID="lblPrice" CssClass="text-danger" runat="server" Text='<%# Eval("Price", "{0: 0,0<sup>đ</sup>}") %>' Font-Bold="True"></asp:Label>
                                                    </p>
                                                    <asp:LinkButton EnableViewState="false" ID="lbtnRemove" runat="server" CssClass="label label-danger" CommandName="Remove"><i class="fa fa-times-circle"></i> Xóa</asp:LinkButton>
                                                </div>
                                                <div class="clearfix">
                                                    <hr />
                                                </div>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <strong style="font-size: 16px">Tổng tiền:</strong>
                                            </FooterTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <a title="Giỏ hàng của bạn  ">Giỏ hàng của bạn</a>
                                                <hr />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <b>
                                                    <asp:Label ID="lblTotalPrice" CssClass="text-danger" runat="server" Text='<%# Eval("TotalPrice", "{0: 0,0<sup>đ</sup>}") %>' Font-Size="Medium"></asp:Label></b><br />

                                                <div class="list-group list-group-horizontal" style="margin-top: 12.5px;">
                                                    <asp:LinkButton ID="lbtnMinus" CssClass="list-group-item" CommandName="Minus" CommandArgument='<%# Eval("Quantity") %>' runat="server"><i class="fa fa-minus"></i></asp:LinkButton>
                                                    <asp:TextBox ID="txtQuantity" CssClass="list-group-item" runat="server" ReadOnly="true" Text='<%# Eval("Quantity") %>' Width="50"></asp:TextBox>
                                                    <asp:LinkButton ID="lbtnPlus" CssClass="list-group-item" CommandName="Plus" CommandArgument='<%# Eval("Quantity") %>' runat="server"><i class="fa fa-plus"></i></asp:LinkButton>
                                                </div>
                                                <hr />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" CssClass="price">
                                                    <asp:Label ID="Label2" runat="server"><%# TotalCart() %></asp:Label><sup>đ</sup></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <!-- End Cart -->
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <asp:LinkButton ID="btnPay" CssClass="btn btn-success btn-sm" runat="server" OnClick="btnPay_Click">Thanh toán giỏ hàng</asp:LinkButton>
                        <div class="clearfix margin_top10"></div>
                    </asp:View>

                    <asp:View ID="viewCheckout" runat="server">
                        <asp:LinkButton ID="btnBack" OnClick="btnBack_Click" runat="server" CssClass="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i> Quay lại giỏ hàng</asp:LinkButton>
                        <div class="clearfix">
                            <hr />
                        </div>

                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <asp:RadioButtonList ID="radGender" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="1" Text=" Anh"></asp:ListItem>
                                        <asp:ListItem Value="0" Text=" Chị"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <p class="clearfix"></p>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtFullName" CssClass="form-control" runat="server" placeholder="Họ và tên."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Vui lòng nhập họ và tên!" ValidationGroup="Pay" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtTelephone" CssClass="form-control" runat="server" placeholder="Số điện thoại."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfTelephone" runat="server" ControlToValidate="txtTelephone" ErrorMessage="Vui lòng nhập số điện thoại!" ValidationGroup="Pay" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập số điện thoại hợp lệ!" ControlToValidate="txtTelephone" Display="Dynamic" Font-Bold="True" ForeColor="Red" ValidationExpression="^0[\d]{9,11}"></asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12 margin_top10">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Địa chỉ Email (không bắt buộc)."></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail" ValidationGroup="Pay" ErrorMessage="Vui lòng nhập địa chỉ Email hợp lệ!" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12 margin_top10">
                                    <asp:TextBox ID="txtNote" CssClass="form-control" runat="server" placeholder="Yêu cầu khác (không bắt buộc)."></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12 margin_top10">
                                    <asp:TextBox ID="txtShipAddress" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" placeholder="Địa chỉ nơi nhận hàng."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfAddress" runat="server" ControlToValidate="txtShipAddress" ErrorMessage="Vui lòng nhập địa chỉ nơi nhận hàng!" ValidationGroup="Pay" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-4 col-sm-8 margin_top10">
                                    <asp:LinkButton ID="lbtnPayWhenReceived" ValidationGroup="Pay" EnableViewState="false" CssClass="btn btn-warning" runat="server" OnClick="lbtnPayWhenReceived_Click">
                            <b>THANH TOÁN KHI NHẬN HÀNG</b><p class="small">Không nhận hàng nếu không vừa ý.</p>
                                    </asp:LinkButton>
                                </div>
                            </div>

                        </div>
                        <br />
                    </asp:View>


                    <asp:View ID="viewFinish" runat="server">
                        <div class="bg_white">
                            <p class="margin_top10"></p>
                            <img src="public/upload/details/order_successful.png" width="100%" />
                            <p class="margin_top20">Cảm ơn <b><%: Gender %> <%: CustomerName %></b> đã cho chúng tôi cơ hội được phục vụ. Trong vòng 5 phút, nhân viên của AnhDo sẽ gọi điện xác nhận đợn đặt hàng của <%: Gender %>.</p>

                            <p class="well well-sm margin_top20">THÔNG TIN ĐẶT HÀNG</p>
                            <ul>
                                <li><b>Thanh toán khi nhận hàng</b></li>
                                <li>Tổng tiền:
                            <b class="price">
                                <asp:Label ID="lblTotalCartFinish" runat="server"></asp:Label><sup>đ</sup></b></li>
                            </ul>
                            <p>Khi cần hỗ trợ vui lòng gọi <a class="text-primary">1900.5995</a> (7h30 - 22h)</p>

                            <p class="well well-sm margin_top10">SẢN PHẨM ĐÃ MUA</p>


                            <asp:GridView ID="gvCartFinish" runat="server" AutoGenerateColumns="False" CssClass="table table-strip table-condensed">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="pull-left">
                                                <img class="pull-left" src='<%# Eval("Picture", "public/upload/products/{0}") %>' alt='<%# Eval("Name") %>' title='<%# Eval("Name") %>' width="50" height="70" />
                                            </div>
                                            <div class="pull-left margin_left10 margin_top10">
                                                <strong><span class="text-info"><%# Eval("Name") %></span></strong>
                                                <p class="text-danger"><%# Eval("Price","{0: 0,0<sup>đ</sup>}") %></p>
                                            </div>
                                            <div class="clearfix">
                                                <hr />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <h6></h6>
                                            <b class="text-danger"><%# Eval("TotalPrice", "{0: 0,0<sup>đ</sup>}") %></b>
                                            <div>
                                                <span>Số lượng: <%# Eval("Quantity") %></span>
                                            </div>
                                            <p class="clearfix" style="margin-top: 23px;">
                                                <hr />
                                            </p>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </asp:View>


                </asp:MultiView>
            </div>
            
        </div>
        <!-- end row -->
        <p class="margin_top10"></p>
    </div>

</asp:Content>
