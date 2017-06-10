<%@ Page Title="DashBoard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PhoneManagement.Admin.Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%--<!-- Page Content -->
    <div id="home">
    --%>
    <h3><i class="fa fa-dashboard"></i>&nbsp;Thống kê chung</h3>
    <hr />
    <asp:Panel ID="pnlUpdatedProfile" Visible="false" EnableViewState="false" runat="server">
        <p class="text-center alert alert-success">
            <asp:Label ID="lblUpdateProfile" runat="server"></asp:Label>
        </p>
    </asp:Panel>

    <!-- item -->
    <asp:UpdatePanel ID="UpdatePanelDashboard" runat="server">
        <ContentTemplate>
            <div class="col-lg-12">
                <div class="col-md-6">
                    <div class="pull-left">
                        <span class="label label-default" style="font-size: 16px">From</span>
                        <asp:TextBox CssClass="text-center" ID="txtFromDate" Width="200px" runat="server" AutoPostBack="True" OnTextChanged="txtFromDate_TextChanged"></asp:TextBox>
                    </div>
                    <asp:ImageButton EnableViewState="false" ID="ibtnFromDate" runat="server" ImageUrl="~/public/upload/logo/calendar.png" Width="30" />
                    <ajaxToolkit:CalendarExtender ID="CalFromDate" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFromDate" PopupButtonID="ibtnFromDate" />

                </div>
                <div class="col-md-6">
                    <asp:ImageButton EnableViewState="false" CssClass="pull-right" ID="ibtnToDate" runat="server" ImageUrl="~/public/upload/logo/calendar.png" Width="30" />
                    <ajaxToolkit:CalendarExtender ID="CalToDate" runat="server" Format="dd/MM/yyyy" TargetControlID="txtToDate" PopupButtonID="ibtnToDate" />
                    <div class="pull-right">
                        <span class="label label-default" style="font-size: 16px">To</span>
                        <asp:TextBox CssClass="text-center" ID="txtToDate" Width="200px" runat="server" AutoPostBack="True" OnTextChanged="txtToDate_TextChanged"></asp:TextBox>
                    </div>

                </div>
            </div>


            <div class="col-lg-3 bg-warning">
                <h4><i class="fa fa-shopping-cart"></i></h4>
                <p class="text-right">
                    <asp:Label Font-Size="X-Large" ID="lblOrderToDay" runat="server"></asp:Label>
                </p>
                <p class="text-right">Đơn Đặt Hàng</p>
            </div>
            <!-- ./item -->

            <!-- item -->
            <div class="col-lg-3 bg-info">
                <h4><i class="fa fa-dollar"></i></h4>
                <p class="text-right">
                    <asp:Label Font-Size="X-Large" ID="lblServedCustomer" runat="server"></asp:Label>
                </p>
                <p class="text-right">Phục Vụ Khách Hàng</p>
            </div>
            <!-- ./item -->

            <!-- item -->
            <div class="col-lg-3 bg-primary">
                <h4><i class="fa fa-money"></i></h4>
                <p class="text-right">
                    <asp:Label Font-Size="X-Large" ID="lblOrderTotalSales" runat="server"></asp:Label>
                </p>
                <p class="text-right">Doanh Thu Hệ Thống</p>
            </div>
            <!-- ./item -->

            <!-- item -->
            <div class="col-lg-3 bg-success">
                <h4><i class="fa fa-mobile"></i></h4>
                <p class="text-right">
                    <asp:Label Font-Size="X-Large" ID="lblOrderTotalProduct" runat="server"></asp:Label>
                </p>
                <p class="text-right">Tổng Sản Phẩm Đã Bán</p>
            </div>
            <!-- ./item -->

            <div class="clearfix"></div>

            <!-- Order -->
            <div class="col-lg-6">
                <h3>Đơn Hàng Nổi Bật</h3>
                <asp:GridView ID="gvTopOrderValued" AutoGenerateColumns="false" runat="server"
                    CssClass="table table-bordered table-condensed table-hover">
                    <Columns>
                        <asp:TemplateField HeaderText="Mã đơn hàng">
                            <ItemTemplate><%# Eval("orderID") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Khách hàng">
                            <ItemTemplate><%# Convert.ToByte(Eval("gender")) == 1? "anh " : "chị "%><%# Eval("customerName") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số lượng">
                            <ItemTemplate><%# Eval("amount") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tổng tiền">
                            <ItemTemplate><%# Eval("totalPrice","{0:0,0<sup>đ</sup>}") %></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <!-- ./Order -->

            <!-- Product -->
            <div class="col-lg-6">
                <h3>Sản Phẩm Bán Chạy</h3>
                <asp:GridView ID="gvTopProductBestSelling" AutoGenerateColumns="false" runat="server"
                    CssClass="table table-bordered table-condensed table-hover">
                    <Columns>
                        <asp:TemplateField HeaderText="Mã sản phẩm">
                            <ItemTemplate><%# Eval("productID") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <ItemTemplate><%# Eval("productName") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá">
                            <ItemTemplate><%# Eval("price","{0:0,0<sup>đ</sup>}") %></ItemTemplate>
                            <%--<HeaderStyle Width="400" />--%>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số lượng đã bán">
                            <ItemTemplate><%# Eval("Amount") %> sản phẩm</ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <!-- ./Product -->

            <!-- Customer -->
            <div class="col-lg-12">
                <h3>Khách Hàng Nổi Bật</h3>
                <asp:GridView ID="gvTopCustomerOutstanding" AutoGenerateColumns="false" runat="server"
                    CssClass="table table-bordered table-condensed table-hover">
                    <Columns>
                        <asp:TemplateField HeaderText="Mã khách hàng">
                            <ItemTemplate><%# Eval("customerID") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Khách hàng">
                            <ItemTemplate><%# Convert.ToByte(Eval("gender")) == 1? "anh " : "chị "%><%# Eval("customerName") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate><%# Eval("email") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số điện thoại">
                            <ItemTemplate><%# Eval("telephone") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tổng sản phẩm đã mua">
                            <ItemTemplate><%# Eval("TotalQuantity") %> sản phẩm</ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tổng tiền đã thanh toán">
                            <ItemTemplate><%# Eval("TotalPrice","{0:0,0<sup>đ</sup>}") %></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <!-- /Customer -->

            <!-- Order Pending -->
            <div class="col-lg-12">
                <h3>Đơn Hàng Đang Chờ Xử Lý</h3>
                <asp:Label ID="lblNotifyOrderPending" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
                <asp:GridView ID="gvOrderPending" PageSize="5" AutoGenerateColumns="false" runat="server"
                    CssClass="table table-bordered table-condensed table-hover" AllowPaging="True" OnPageIndexChanging="gvOrderPending_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate><a href="OrdersAdmin.aspx"><%# Eval("orderID") %></a></ItemTemplate>
                            <HeaderStyle Width="20" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Khách hàng">
                            <ItemTemplate>
                                <%# Convert.ToByte(Eval("gender")) == 1? "anh " : "chị "%><%# Eval("customerName") %>
                            </ItemTemplate>
                            <HeaderStyle Width="180" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Địa chỉ nhận hàng">
                            <ItemTemplate><%# Eval("shipAddress") %></ItemTemplate>
                            <HeaderStyle Width="400" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tổng hóa đơn">
                            <ItemTemplate><%# Eval("TotalPrice", "{0: 0,0<sup>đ</sup>}") %></ItemTemplate>
                            <HeaderStyle Width="60" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate><%# Convert.ToInt32(Eval("status")) == 0 ? "Đang chờ xử lý" : "Đã thanh toán" %></ItemTemplate>
                            <HeaderStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ngày tạo">
                            <ItemTemplate><%# Convert.ToString(Eval("dateCreated"), new System.Globalization.CultureInfo("en-US")) %></ItemTemplate>
                            <HeaderStyle />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="pagination-ys" />
                </asp:GridView>
            </div>
            <!-- /Order Pending -->
        </ContentTemplate>
    </asp:UpdatePanel>




    <%--            </div>--%>
    <!-- ./col-lg-12 -->
</asp:Content>
