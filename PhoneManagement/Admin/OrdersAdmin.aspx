<%@ Page Title="Quản lý đơn đặt hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrdersAdmin.aspx.cs" Inherits="PhoneManagement.Admin.OrdersAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">
        <div class="row">
            <asp:MultiView ID="mulViewOrders" runat="server" ActiveViewIndex="0">
                <asp:View ID="viewOrdersBrief" runat="server">

                    <h3><i class="fa fa-shopping-basket"></i>Danh sách đơn đặt hàng</h3>
                    <hr />
                    <asp:PlaceHolder ID="plhMessage" Visible="false" EnableViewState="false" runat="server">
                        <p class="text-center alert alert-success">
                            <%: Message %>
                            <asp:Label ID="lblDeletedNotify" runat="server"></asp:Label>
                            <br />
                        </p>
                    </asp:PlaceHolder>

                    <asp:GridView ID="gvOrdersBrief" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" DataKeyNames="id"
                        OnSorting="gvOrdersBrief_Sorting" OnRowDeleting="gvOrdersBrief_RowDeleting"
                        OnSelectedIndexChanging="gvOrdersBrief_SelectedIndexChanging" OnPageIndexChanging="gvOrdersBrief_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="ID" SortExpression="id">
                                <ItemTemplate>
                                    <%# Eval("id") %>
                                </ItemTemplate>
                                <HeaderStyle Width="20px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Họ tên Khách hàng" SortExpression="customerName">
                                <ItemTemplate>
                                    <%# Eval("customerName") %>
                                </ItemTemplate>
                                <HeaderStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Địa chỉ giao hàng">
                                <ItemTemplate>
                                    <%# Eval("shipAddress") %>
                                </ItemTemplate>
                                <HeaderStyle Width="160px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tổng hóa đơn" SortExpression="totalPrice">
                                <ItemTemplate>
                                    <%# Eval("totalPrice", "{0: 0,0<sup>đ</sup>}") %>
                                </ItemTemplate>
                                <HeaderStyle Width="60px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trạng thái" SortExpression="status">
                                <ItemTemplate>
                                    <%# Convert.ToInt32(Eval("status")) == 0 ? "Đang chờ xử lý" : "Đã thanh toán" %>
                                </ItemTemplate>
                                <HeaderStyle Width="60px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ngày tạo" SortExpression="dateCreated">
                                <ItemTemplate>
                                    <%# Eval("dateCreated", "{0:dd/MM/yyyy hh:mm:ss tt}") %>
                                </ItemTemplate>
                                <HeaderStyle Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chức năng">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtnShowDetails" EnableViewState="false" CssClass="btn btn-info btn-sm" runat="server" CommandName="Select"><i class="fa fa-info-circle" aria-hidden="true"></i> Chi tiết</asp:LinkButton>
                                    <asp:LinkButton ID="lbtnDelete" EnableViewState="false" CssClass="btn btn-danger btn-sm" runat="server" CommandName="Delete" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle Width="130px" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-ys" />
                    </asp:GridView>

                </asp:View>


                <asp:View ID="viewOrderDetails" runat="server">
                    <h3><i class="fa fa-info-circle" aria-hidden="true"></i>Chi tiết đơn đặt hàng</h3>
                    <hr />

                    <div class="clearfix">
                        <asp:LinkButton runat="server" CssClass="btn btn-default btn-sm" ID="lbtnBack" EnableViewState="false" OnClick="lbtnBack_Click"><i class="fa fa-arrow-left" aria-hidden="true"></i> Quay lại</asp:LinkButton>
                    </div>

                    <!-- Thông tin khách hàng & thanh toán -->
                    <div class="col-md-5">
                        <h3 class="text-muted"><i class="fa fa-users"></i>Thông tin khách hàng</h3>
                        <asp:DataList CssClass="table table-condensed table-hover" ID="dlCustomerInfo" runat="server">
                            <ItemTemplate>
                                    <tr>
                                        <th style="width: 110px">Họ và tên:</th>
                                        <td><%# Eval("name") %></td>
                                    </tr>
                                    <tr>
                                        <th>Giới tính:</th>
                                        <td><%# Convert.ToInt32(Eval("gender")) == 1 ? "Nam" : "Nữ" %></td>
                                    </tr>
                                    <tr>
                                        <th>Địa chỉ Email:</th>
                                        <td><%# Eval("email") %></td>
                                    </tr>
                                    <tr>
                                        <th>Số điện thoại:</th>
                                        <td><%# Eval("telephone") %></td>
                                    </tr>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanelOrderDetails" runat="server">
                        <ContentTemplate>
                            <div class="col-md-7">
                                <h3 class="text-muted"><i class="fa fa-credit-card" aria-hidden="true"></i>Thông tin thanh toán</h3>
                                <asp:Label ID="lblNotifyPay" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
                                <asp:DataList CssClass="table table-condensed table-hover" ID="dlPayInfo" runat="server" DataKeyField="id" OnEditCommand="dlPayInfo_EditCommand" OnCancelCommand="dlPayInfo_CancelCommand" OnUpdateCommand="dlPayInfo_UpdateCommand" OnItemDataBound="dlPayInfo_ItemDataBound">
                                    <ItemTemplate>
                                        <tr>
                                            <td style="width: 140px">Mã đơn hàng:</td>
                                            <td><%# Eval("id") %></td>
                                        </tr>
                                        <tr>
                                            <td>Tổng hóa đơn:</td>
                                            <td><%# Eval("totalPrice", "{0: 0,0<sup>đ</sup>}") %></td>
                                        </tr>
                                        <tr>
                                            <td>Tổng số lượng:</td>
                                            <td><%# Eval("totalQuantity") %> sản phẩm</td>
                                        </tr>
                                        <tr>
                                            <td>Địa chỉ nhận hàng:</td>
                                            <td><%# Eval("shipAddress") %></td>
                                        </tr>
                                        <tr>
                                            <td>Yêu cầu khác:</td>
                                            <td><%# String.IsNullOrEmpty(Eval("note").ToString()) ? "Không có." : Eval("note") %></td>
                                        </tr>
                                        <tr>
                                            <th>Trạng thái:</th>
                                            <td><%# Convert.ToInt32(Eval("status")) == 0 ? "Đang chờ xử lý" : "Đã thanh toán" %></td>
                                        </tr>
                                        <tr>
                                            <td>Ngày tạo:</td>
                                            <td><%# Eval("dateCreated","{0: dd/MM/yyyy hh:mm:ss tt}") %></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:LinkButton ID="lbtnEdit" EnableViewState="false" runat="server" CssClass="btn btn-default btn-sm" CommandName="Edit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <tr>
                                            <td style="width: 140px">Mã đơn hàng:</td>
                                            <td><%# Eval("id") %></td>
                                        </tr>
                                        <tr>
                                            <td>Tổng hóa đơn:</td>
                                            <td>
                                                <asp:Label ID="lblEditTotalPrice" runat="server" Text='<%# Eval("totalPrice", "{0: 0,0<sup>đ</sup>}") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Tổng số lượng:</td>
                                            <td><%# Eval("totalQuantity") %> sản phẩm</td>
                                        </tr>
                                        <tr>
                                            <td>Địa chỉ nhận hàng:</td>
                                            <td>
                                                <asp:TextBox ID="txtEditShipAddress" TextMode="MultiLine" Columns="60" Rows="4" CssClass="form-control" Text='<%# Eval("shipAddress") %>' runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="EditOrder" ForeColor="#ff0000" Display="Dynamic" runat="server" ErrorMessage="Vui lòng nhập địa chỉ nhận hàng!" Font-Bold="True" ControlToValidate="txtEditShipAddress"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Yêu cầu khác:</td>
                                            <td>
                                                <asp:TextBox ID="txtEditNote" TextMode="MultiLine" Rows="4" Columns="60" CssClass="form-control" runat="server" Text='<%# String.IsNullOrEmpty(Eval("note").ToString()) ? "Không có." : Eval("note") %>'></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Trạng thái:</td>
                                            <td>
                                                <asp:HiddenField ID="hdfStatus" Value='<%# Eval("status") %>' runat="server" />
                                                <asp:DropDownList ID="ddlEditStatus" CssClass="form-control" runat="server">
                                                    <asp:ListItem Value="0" Text="Đang chờ xử lý"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Đã thanh toán"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Ngày tạo:</td>
                                            <td><%# Eval("dateCreated","{0: dd/MM/yyyy hh:mm:ss tt}") %></td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:LinkButton ID="lbtnCancel" EnableViewState="false" runat="server" CssClass="btn btn-warning" CommandName="Cancel">Hủy bỏ</asp:LinkButton>
                                                <asp:LinkButton ID="lbtnUpdate" ValidationGroup="EditOrder" EnableViewState="false" CssClass="btn btn-primary" runat="server" CommandName="Update">Cập nhật</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </EditItemTemplate>
                                </asp:DataList>
                            </div>

                          

                            <!-- Thông tin sản phẩm -->
                            <div class="col-md-12">
                                <h3 class="text-muted margin_top0"><i class="fa fa-mobile" aria-hidden="true"></i>Thông tin sản phẩm</h3>
                                <asp:Label ID="lblNotifyInfoProduct" EnableViewState="false" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label>
                                <asp:GridView ID="gvOrderInfoProduct" AutoGenerateColumns="false" runat="server"
                                    CssClass="table table-bordered table-hover" DataKeyNames="id"
                                    OnRowEditing="gvOrderInfoProduct_RowEditing" OnRowCancelingEdit="gvOrderInfoProduct_RowCancelingEdit"
                                    OnRowDeleting="gvOrderInfoProduct_RowDeleting"
                                    OnRowUpdating="gvOrderInfoProduct_RowUpdating" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvOrderInfoProduct_PageIndexChanging1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Tên sản phẩm">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdfOrderID" runat="server" Value='<%# Eval("orderID") %>' />
                                                <asp:Image CssClass="pull-left" ID="imgPicture" EnableViewState="false" ImageUrl='<%# Eval("picture", "~/public/upload/products/{0}") %>' runat="server" Width="40px" Height="65px" />
                                                <b class="margin_left10 pull-left margin_top5">
                                                    <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                </b>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Giá sản phẩm">
                                            <ItemTemplate>
                                                <%# Eval("price", "{0: 0,0<sup>đ</sup>}") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Giá sản phẩm">
                                            <ItemTemplate>
                                                <%# Eval("discount") %>%
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Số lượng">
                                            <ItemTemplate>
                                                <%# Eval("amount") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEditAmount" CssClass="form-control" placeholder="Nhập số lượng sản phẩm." Text='<%# Eval("amount") %>' runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtEditAmount" Display="Dynamic" Font-Bold="true" ForeColor="#ff0000" ValidationGroup="EditProduct" runat="server" ErrorMessage="Vui lòng nhập số lượng sản phẩm!"></asp:RequiredFieldValidator>
                                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Vui lòng nhập số lượng hợp lệ!" Font-Bold="True" ControlToValidate="txtEditAmount" ForeColor="#ff0000" ValidationGroup="EditProduct" Type="Integer" MinimumValue="1" Display="Dynamic" MaximumValue="1000"></asp:RangeValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Thành tiền">
                                            <ItemTemplate>
                                                <%# Eval("totalPrice", "{0: 0,0<sup>đ</sup>}") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Chức năng">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnEditProduct" runat="server" CssClass="btn btn-default btn-sm" CommandName="Edit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa</asp:LinkButton>
                                                <asp:LinkButton ID="lbtnDeleteProduct" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Delete" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="lbtnCancelProduct" runat="server" CssClass="btn btn-warning btn-sm" CommandName="Cancel">Hủy bỏ</asp:LinkButton>
                                                <asp:LinkButton ID="lbtnUpdateProduct" ValidationGroup="EditProduct" CssClass="btn btn-primary btn-sm" runat="server" CommandName="Update">Cập nhật</asp:LinkButton>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="pagination-ys" />
                                </asp:GridView>

                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:View>

            </asp:MultiView>

        </div>
        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->

</asp:Content>
