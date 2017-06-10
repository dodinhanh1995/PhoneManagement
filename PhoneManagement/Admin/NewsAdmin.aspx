<%@ Page Title="Quản lý tin tức" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="NewsAdmin.aspx.cs" Inherits="PhoneManagement.Admin.NewsAdmin" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <h2><i class="fa fa-file-text"></i> Quản lý tin tức</h2>
    <hr />
    <asp:PlaceHolder runat="server" ID="notifyMessage" Visible="false" EnableViewState="false" >
        <p class="text-center alert alert-success"><%: NotifyMessage %></p>
    </asp:PlaceHolder>


    <asp:MultiView ID="mulvNews" runat="server" ActiveViewIndex="0">
        <asp:View ID="viewNewsList" runat="server">
            <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-primary btn-sm" OnClick="btnAddNew_Click"><i class="fa fa-plus" aria-hidden="true"></i> Thêm mới</asp:LinkButton>
            <asp:GridView ID="gvNewsList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover margin_top10"
                OnPageIndexChanging="gvNewsList_PageIndexChanging" OnRowDeleting="gvNewsList_RowDeleting" OnSorting="gvNewsList_Sorting" PageSize="6" OnRowUpdating="gvNewsList_RowUpdating">
                <Columns>
                    <asp:TemplateField HeaderText="ID" SortExpression="id">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tiêu đề">
                        <ItemTemplate>
                            <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("title") %>'></asp:Label>
                            <asp:HiddenField ID="hdfContent" runat="server" Value='<%# Eval("content") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Số lượt xem" SortExpression="view">
                        <ItemTemplate>
                            <span><%# Eval("view") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Hình ảnh">
                        <ItemTemplate>
                            <asp:Image ID="imgPicture" runat="server" ImageUrl='<%# Eval("picture", "~/public/upload/news/{0}") %>' Width="80px"></asp:Image>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ngày viết bài" SortExpression="dateCreated">
                        <ItemTemplate>
                            <span><%# Eval("dateCreated", "{0:dd/MM/yyyy}") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Chức năng">
                        <ItemTemplate>
                            <asp:LinkButton EnableViewState="false" ID="btnEdit" runat="server" CommandName="Update" CssClass="btn btn-default btn-sm"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa</asp:LinkButton>
                            <asp:LinkButton EnableViewState="false" ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Bạn có chắc là muốn xóa không?')" CommandName="Delete"><i class="fa fa-trash" aria-hidden="true"></i> Xóa</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pagination-ys" />
            </asp:GridView>
        </asp:View>


        <asp:View ID="viewNewsForm" runat="server">
            <asp:LinkButton runat="server" CssClass="btn btn-default btn-sm" ID="btnBack" OnClick="btnBack_Click"><i class="fa fa-arrow-left" aria-hidden="true"></i> Quay lại</asp:LinkButton>
            <div class="form-group">
                <label class="control-label col-sm-3">Tiêu đề *</label>
                <div class="col-sm-7">
                    <asp:HiddenField ID="hdfID" runat="server" />
                    <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfValidTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Vui lòng nhập tên tiêu đề!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-3">Nội dung *</label>
                <div class="col-sm-7">
                    <asp:TextBox ID="txtContent" CssClass="form-control ckeditor" TextMode="MultiLine" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfValidContent" runat="server" Enabled="false" ControlToValidate="txtContent" ErrorMessage="Vui lòng nhập tên nội dung!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-3">Hình ảnh tiêu đề *</label>
                <div class="col-sm-7">
                    <asp:Image ID="imgPicture" runat="server" Visible="false" Width="100px" Height="60px" />
                    <asp:FileUpload ID="fuPicture" CssClass="form-control" runat="server"></asp:FileUpload>
                    <asp:RequiredFieldValidator ID="rfValidPicture" runat="server" ControlToValidate="fuPicture" ErrorMessage="Vui lòng chọn hình ảnh tiêu đề!" ValidationGroup="groupAddNew" Display="Dynamic" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <asp:Button ID="btnAdd" EnableViewState="false" CssClass="btn btn-primary" runat="server" Text="Thêm mới" ValidationGroup="groupAddNew" OnClick="btnAdd_Click" />
                    <asp:Button ID="btnUpdate" EnableViewState="false" CssClass="btn btn-primary" runat="server" Text="Cập nhật" ValidationGroup="groupAddNew" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnCancel" EnableViewState="false" runat="server" CssClass="btn btn-danger" Text="Hủy bỏ" OnClick="btnCancel_Click" />
                </div>
            </div>
        </asp:View>
    </asp:MultiView>



</asp:Content>
