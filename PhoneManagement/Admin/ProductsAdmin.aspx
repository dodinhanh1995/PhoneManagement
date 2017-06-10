<%@ Page Title="Quản lý sản phẩm" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductsAdmin.aspx.cs" Inherits="PhoneManagement.Products" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">
        <div class="col-md-12">

            <h2><i class="fa fa-mobile"></i>Quản lý sản phẩm</h2>
            <hr />


            <asp:PlaceHolder ID="plhMessage" Visible="false" EnableViewState="false" runat="server">
                <p class="text-center alert alert-success"><%: message %></p>
            </asp:PlaceHolder>

            <asp:MultiView ID="mulvProducts" runat="server" ActiveViewIndex="0">
                <asp:View ID="viewListProducts" runat="server">

                    <asp:Panel ID="pnlSearch" runat="server">
                        <div class="col-lg-2">
                            <asp:LinkButton ID="btnAddNew" EnableViewState="false" runat="server" CssClass="btn btn-primary btn-sm" OnClick="btnAddNew_Click"><i class="fa fa-plus" aria-hidden="true"></i> Thêm mới</asp:LinkButton>
                        </div>
                        <div class="col-lg-5">
                            <asp:TextBox ID="txtSearch" EnableViewState="false" CssClass="form-control" placeholder="Nhập tên sản phẩm hoặc thương hiệu" runat="server" AutoPostBack="True"></asp:TextBox>
                            <br />
                        </div>
                        
                    </asp:Panel>
                    
                    <asp:GridView ID="gvListProducts" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover margin_top10" AllowPaging="True" AllowSorting="True"
                        OnPageIndexChanging="gvListProducts_PageIndexChanging" PageSize="10" DataKeyNames="id"
                        OnRowDeleting="gvListProducts_RowDeleting" OnSorting="gvListProducts_Sorting" OnRowUpdating="gvListProducts_RowUpdating">
                        <Columns>
                            <asp:TemplateField HeaderText="ID" SortExpression="id">
                                <ItemTemplate>
                                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tên sản phẩm" SortExpression="name">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                    <br />
                                    <asp:Image ID="imgPicture" runat="server" ImageUrl='<%# Eval("picture","~/public/upload/products/{0}") %>' Width="50px" />
                                    Lượt xem:<span><%# Eval("view") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Giá" SortExpression="price">
                                <ItemTemplate>
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0: 0,0}") %>'></asp:Label><sup>đ</sup>
                                    <p>
                                        Giảm giá:<asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("discount") %>'></asp:Label>%
                                    </p>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Số lượng" SortExpression="quantity">
                                <ItemTemplate>
                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mã thương hiệu" SortExpression="brandName">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdfDescription" runat="server" Value='<%# Eval("description") %>' />
                                    <asp:HiddenField ID="hdfBrandID" runat="server" Value='<%# Eval("brandID") %>' />
                                    <asp:Label ID="lblBrandID" runat="server" Text='<%# Eval("brandName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Chức năng">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-default btn-sm" CommandName="Update"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')" CommandName="Delete"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle Width="190" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-ys" />
                    </asp:GridView>
                </asp:View>


                <asp:View ID="viewProductForm" runat="server">

                    <asp:LinkButton runat="server" CssClass="btn btn-default btn-sm" ID="btnBack" EnableViewState="false" OnClick="btnBack_Click"><i class="fa fa-arrow-left" aria-hidden="true"></i> Quay lại</asp:LinkButton>
                    <div class="form-group">
                        <label class="control-label col-sm-3">Tên sản phẩm *</label>
                        <div class="col-sm-7">
                            <asp:HiddenField ID="hdfID" runat="server" />
                            <asp:TextBox ID="txtName" CssClass="form-control" runat="server" placeholder="Nhập tên sản phẩm."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfValidName" runat="server" ControlToValidate="txtName" ErrorMessage="Vui lòng nhập tên sản phẩm!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-3">Thương hiệu *</label>
                        <div class="col-sm-7">
                            <asp:DropDownList CssClass="form-control" ID="ddlBrand" runat="server"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-3">Giá sản phẩm *</label>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" placeholder="Nhập giá sản phẩm (VD: 10000000.00 => 10 triệu)"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfValidPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Vui lòng nhập giá sản phẩm!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rValidPrice" runat="server" Display="Dynamic" ErrorMessage="Vui lòng nhập giá sản phẩm hợp lệ!" Font-Bold="True" ForeColor="Red" MaximumValue="100000000" MinimumValue="0" ValidationGroup="groupAddNew" ControlToValidate="txtPrice" Type="Double"></asp:RangeValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-3">Giảm giá (%)</label>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtDiscount" CssClass="form-control" runat="server" placeholder="Nhập số giảm giá (VD: 10.0 => 10%)"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfValidDiscount" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Vui lòng nhập số giảm giá!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rValidDiscount" runat="server" ControlToValidate="txtDiscount" Display="Dynamic" ErrorMessage="Vui lòng nhập số giảm giá  (1 -&gt; 100) hợp lệ!" Font-Bold="True" ForeColor="Red" ValidationGroup="groupAddNew" MaximumValue="100" MinimumValue="0" Type="Double"></asp:RangeValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-3">Số lượng *</label>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtQuantity" CssClass="form-control" runat="server" placeholder="Nhập số lượng sản phẩm. (1 -> 1000)"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfValidQuantity" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Vui lòng nhập số lượng!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rValidQuantity" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Vui lòng nhập số lượng hợp lệ (1 -> 1000)!" Display="Dynamic" Font-Bold="True" ForeColor="Red" ValidationGroup="groupAddNew" MaximumValue="1000" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-3">Thông tin mô tả</label>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtDescription" CssClass="form-control ckeditor" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="control-label col-sm-3">Hình ảnh *</label>
                        <div class="col-sm-7">
                            <asp:Image ID="imgPicture" runat="server" Width="100px" />
                            <asp:FileUpload ID="fuPicture" CssClass="form-control" runat="server"></asp:FileUpload>
                            <asp:RequiredFieldValidator ID="rfValidPicture" runat="server" ControlToValidate="fuPicture" ErrorMessage="Vui lòng chọn hình ảnh sản phẩm!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <asp:Button ID="btnAdd" Visible="false" CssClass="btn btn-primary" runat="server" Text="Thêm mới" ValidationGroup="groupAddNew" OnClick="btnAdd_Click" />
                            <asp:Button ID="btnUpdate" Visible="false" CssClass="btn btn-primary" runat="server" Text="Cập nhật" ValidationGroup="groupAddNew" OnClick="btnUpdate_Click" />
                            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" Text="Hủy bỏ" OnClick="btnCancel_Click" />
                        </div>
                    </div>

                </asp:View>
            </asp:MultiView>

        </div>
    </div>




</asp:Content>
