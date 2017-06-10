<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UcFooter.ascx.cs" Inherits="PhoneManagement.UserControls.Templates.UcFooter" EnableViewState="false" %>
<%@ OutputCache Duration="84200" VaryByParam="none" %>

<div class="container-fluid" id="footer">
    <div class="container text-center">
        <div class="row">
            <div class="col-md-2 top pull-left">
                <span class="glyphicon glyphicon-search margin_top20"></span> <strong>Tìm kiếm nhiều:</strong>
            </div>
            <div class="col-md-10 pull-left">
                <ul class="searched">
                    <asp:Repeater ID="rptTopViewProduct" runat="server">
                        <ItemTemplate>
                            <li>
                                <a href='<%# Eval("name_url", "dien-thoai-{0}") %>' title='<%# Eval("name") %>'>
                                    <%# Eval("name") %>
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
    <div class="row">
        <hr class="margin_top0" />
    </div>

    <footer>
        <div class="container" id="copy_right">
            <div class="row">
                <div class="col-md-5 pull-left">

                    <img src="public/upload/logo/logo.png" alt="AnhDo Mobile Logo" title="AnhDo Mobile" width="180" />
                    
                    <div class="clear10"></div>
                    <address>
                        <b>CTY TNHH TM &#38; DVKT ANHDO</b>
                        <p>GPĐKKD số 01234.56789 do Sở KHĐT Hà Nội cấp ngày 01/01/2001.</p>
                    </address>
                    <p class="text">
                        AnhDo Mobile được biết đến là cửa hàng điện thoại có tiếng tại Hà Nội. Với sự chuyên nghiệp và uy tín, cửa hàng đã trở thành địa chỉ quen thuộc không chỉ trên thị trường Hà Nội mà còn phục vụ rất nhiều khách hàng - đại lý trên toàn quốc.
                    </p>
                </div>

                <div class="col-md-3 pull-left">
                    <ul>
                        <li><a href="gioi-thieu-cong-ty" title="Giới thiệu công ty">Giới thiệu công ty</a></li>
                        <li><a href="lien-he" title="Liên hệ">Liên hệ</a></li>
                        <li><a href="#" title="Tuyển dụng">Tuyển dụng</a></li>
                        <li><a href="he-thong-sieu-thi" title="Hệ thống siêu thị">Hệ thống siêu thị</a></li>
                        <hr class="margin_top15" />
                        <li>Gọi mua hàng <b>1900.5995</b> (7:30 - 22:00)</li>
                        <li>Gọi khiếu nại <b>1900.5990</b> (8:00 - 21:00)</li>
                    </ul>
                </div>

                <div class="col-md-4 text-center pull-left">
                    <p>Phương thức thanh toán</p>
                    <img src="public/upload/logo/pay.png"  title="phương thức thanh toán" alt="phương thức thanh toán">
                </div>
            </div>
        </div>
        <!-- Button Back To Top -->
        <a href="#" title="back to top" id="back-to-top"></a>
    </footer>
</div>


<!-- jQuery -->
<script src="public/js/jquery-3.1.1.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="public/js/bootstrap.min.js"></script>

<script src="public/js/client_side.js"></script>



