<%@ Page Title="Hệ Thống Siêu Thị | AnhDo Mobile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="PhoneManagement.Branch" %>
<%@ OutputCache Duration="82400" VaryByParam="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="bg_white" id="branch">
        <img src="public/upload/advertisements/MainBranch.jpg" alt="Chi nhánh AnhDo Mobile" title="Chi nhánh AnhDo Mobile" width="100%" />
	<div class="container">
	<div class="row">
		<div class="text-center">
	        <h3 class="">HỆ THỐNG CHI NHÁNH</h3>
	    	<p class="price">Tra cứu thông tin hệ thống các chi nhánh của AnhDo</p>
	    </div>

    	<div class="col-md-4">
          	<select class="form-control">
          	<optgroup label="Chọn địa điểm:">
	            <option>Hà Nội</option>
	            <option>TP.Hồ Chí Minh</option>
	            <option>Lào Cai</option>
	            <option>Hải Phòng</option>
	            <option>Sài Gòn</option>
          	</optgroup>
          	</select>
		<h4><span class="label label-default">TÌM CHI NHÁNH GẦN BẠN NHẤT</span></h4>
          <ul>
            <li><a>Số 33 Lý Quốc Sư, P. Hàng Trống, Q. Hoàn Kiếm, HN</a></li>
            <hr />
            <li><a>Số 57-59 Phố Bạch Mai, P. Cầu Dền, Q. Hai Bà Trưng, HN</a></li>
            <hr />
            <li><a>Số 2, phố Hồ Tùng Mậu,Tổ 21, P. Mai Dịch, Q. Cầu Giấy, HN</a></li>
            <hr />
            <li><a>Số 214-216 Nguyễn Văn Cừ, P. Bồ Đề, Q. Long Biên, HN</a></li>
            <hr />
            <li><a>Số 267 Quang Trung, P. Quang Trung, Q. Hà Đông, HN</a></li>
            <hr />
            <li><a>Số 2 Chùa Bộc, P. Trung Tự, Q. Đống Đa, HN</a></li>
            <hr />
            <li><a>Km10 đường Nguyễn Trãi, P. Văn Quán, Q. Hà Đông, HN</a></li>
            <hr />
          </ul>
        </div>

        <div class="col-md-8 map">
    		<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4430.159529283746!2d105.78461138138782!3d20.98039696629323!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135accdcf7b0bd1%3A0xc1cf5dd00247628a!2zSOG7jWMgdmnhu4duIEPDtG5nIG5naOG7hyBCxrB1IGNow61uaCBWaeG7hW4gdGjDtG5n!5e0!3m2!1svi!2s!4v1476716849826" width="100%" frameborder="0" height="100%" >
    		</iframe>
        </div>
    </div>
    <!-- end row -->
    <h1></h1>
	</div>
	<!-- end container -->
</section>

</asp:Content>
