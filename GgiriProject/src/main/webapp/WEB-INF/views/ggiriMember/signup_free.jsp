<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signupFree</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<script>

function count_check(obj){
	var chkBox = document.getElementsByName("skill");
	var chkCnt = 0;
	for(var i = 0; i < chkBox.length ; i++){
		if(chkBox[i].checked){
			chkCnt++;
		}
	}
	if(chkCnt > 10){
		alert("보유 기술은 10개까지 선택할 수 있습니다.");
		obj.checked = false;
		return false;
	}
}

$(function(){
	
	$("#id").blur(function(){
		if($("#id").val() == "") { 
			$(".successIdChk").text("아이디를 입력해주세요.");
			$(".successIdChk").css("color", "red");
			$("#idDoubleChk").val("false");
			return;
		}
	});
	
	$("#id").keyup(function(){
		var contextPath = "${pageContext.request.contextPath}";
		var id = $("#id").val();
		if(id == "" || id.length < 2) {
			$(".successIdChk").text("아이디는 2자 이상 8자 이하로 설정해주세요");
			$(".successIdChk").css("color", "red");
			$("#idDoubleChk").val("false");
		} else {
			$.ajax({
				url : contextPath + '/ggiriMember/IdCheck?id=' + id,
				type : 'post',
				cache : false,
				success : function(data) {
					if(data == 0){
						$(".successIdChk").text("사용가능한 아이디 입니다.");
						$(".successIdChk").css("color", "blue");
						$("#idDoubleChk").val("true");
					} else {
						$(".successIdChk").text("사용중인 아이디 입니다.");
						$(".successIdChk").css("color", "red");
						$("#idDoubleChk").val("false");
					}
				},
				error : function(){
					console.log("실패");
				}
			});
		}
		
	});
	
	$("#pwd").blur(function(){
		if($("#pwd").val() == "") { 
			$(".successPwd").text("비밀번호를 입력해주세요.");
			$(".successPwd").css("color", "red");
			return;
		} else {
			$(".successPwd").text("");
			return;
		}
	});
	
	$("#pwdchk").blur(function(){
		if($("#pwdchk").val() == "") { 
			$(".successPwdChk").text("비밀번호를 확인해주세요.");
			$(".successPwdChk").css("color", "red");
			$("#pwdChkResult").val("false");
			return;
		}
	});
	
	$("#pwdchk").keyup(function(){
		if($("#pwdchk").val() == "" && $("#pwd").val() == ""){
			$(".successPwdChk").text("");
			$("#pwdChkResult").val("false");
		}
		else if($("#pwdchk").val() == $("#pwd").val()){
			$(".successPwdChk").text("비밀번호가 일치합니다.");
			$(".successPwdChk").css("color", "blue");
			$("#pwdChkResult").val("true");
		} else {
			$(".successPwdChk").text("비밀번호가 일치하지 않습니다.");
			$(".successPwdChk").css("color", "red");
			$("#pwdChkResult").val("false");
		}
	});
	
	$("#birth").blur(function(){
		var birth = $("#birth").val();
		if(birth.length < 8) { 
			$(".successBirthChk").text("생년월일은 8자로 입력해주세요.");
			$(".successBirthChk").css("color", "red");
			$("#birthChkResult").val("false");
			return;
		} else {
			$(".successBirthChk").text("");
			$("#birthChkResult").val("true");
			return;
		}
	});
	
	$("#addr3").blur(function(){
		if($("#addr1").val() != "" && $("#addr2").val() != "" && $("#addr3").val() != ""){
			$(".successAddrChk").text("");
			$("#addrChk").val("true");
		} else {
			$(".successAddrChk").text("주소는 필수 입력사항 입니다.");
			$(".successAddrChk").css("color", "red");
			$("#addrChk").val("false");
		}
	});
	
	$("#email").blur(function(){
		if($("#email").val() == "") { 
			$(".successEmail").text("이메일을 입력해주세요.");
			$(".successEmail").css("color", "red");
			return;
		}
	});
	
	var code = "";
	$("#emailChk").click(function(){
		var contextPath = "${pageContext.request.contextPath}";
		var email = $("#email1").val() + $("#email2").val();
		
		if(email == ""){
			alert("이메일을 입력 후 인증번호를 보내주세요.");
			$("#email1").focus();
			return;
		}
		
		$.ajax({
			type : "GET",
			url : contextPath + "/ggiriMember/mailCheck?email=" + email,
			cache : false,
			success : function(data) {
				if(data == "error" || data == ""){
					alert("이메일 주소가 올바르지 않습니다.");
					$("#email1").attr("autofocus", true);
					$(".successEmailChk").text("유효한 이메일 주소를 입력하세요.");
					$(".successEmailChk").css("color", "red");
				} else {
					alert("인증번호가 발송되었습니다.");
					$("#userEmail2").css("display", "inline-block");
					$(".successEmailChk").text("인증번호 확인 후 입력");
					$(".successEmailChk").css("color", "green");
					code = data;
				}
			}
		});
	});
	
	$("#userEmail2").keyup(function(){
		if($("#userEmail2").val() == "") { 
			$(".successEmailChk").text("이메일 인증을 확인해주세요.");
			$(".successEmailChk").css("color", "red");
			$("#emailDoubleChk").val("false");
			return;
		}
		if($("#userEmail2").val() == code){
			$(".successEmailChk").text("인증번호가 일치합니다.");
			$(".successEmailChk").css("color", "blue");
			$("#emailDoubleChk").val("true");
		} else {
			$(".successEmailChk").text("인증번호가 일치하지 않습니다.");
			$(".successEmailChk").css("color", "red");
			$("#emailDoubleChk").val("false");
		}
	});
	
	
	
	<%--
	var code2 = "";
	$("#telChk").click(function(){
		var contextPath = "${pageContext.request.contextPath}";
		var userTel = $("#tel_1").val() + $("#tel_2").val() + $("#tel_3").val();
		if($("#tel_1").val() == "" || $("#tel_2").val() == "" || $("#tel_3").val() == ""){
			alert("휴대폰 번호를 확인해주세요.");
			$("#tel_2").focus();
			return;
		}
		
		if($("#userTelChk").val() == "") {
			$(".successTelChk").text("");
			$("#telDoubleChk").val("false");
		}
		
		$.ajax({
			type : "GET",
			url : contextPath + "/member/userTelChk?userTel=" + userTel,
			cache : false,
			success : function(data){
				if(data == "error"){
					alert("휴대폰 번호가 올바르지 않습니다.");
					$(".successTelChk").text("유효한 번호를 입력해주세요.");
					$(".successTelChk").css("color", "red");
					$("#tel_2").attr("autofocus", true);
				} else {
					alert("휴대폰 인증번호가 발송되었습니다.");
					$("#userTelChk").css("display", "inline-block");
					$(".successTelChk").text("발송된 인증번호를 입력해주세요.");
					$(".successTelChk").css("color", "green");
					code2 = data;
				}
			}
		});
	});
	--%>
	<%--
	$("#userTelChk").blur(function(){
		if($("#userTelChk").val() == "") { 
			$(".successTelChk").text("");
			$("#telDoubleChk").val("false");
			return;
		}
		
		if($("#userTelChk").val() == code2){
			$(".successTelChk").text("인증번호가 일치합니다.");
			$(".successTelChk").css("color", "blue");
			$("#telDoubleChk").val("true");
		} else {
			$(".successTelChk").text("인증번호가 일치하지 않습니다.");
			$(".successTelChk").css("color", "red");
			$("#telDoubleChk").val("false");
		}
	});
	--%>
	
	$("#button1").click(function(){
		var rv = true;
		var tel = $("#tel_1").val() + $("#tel_2").val() + $("#tel_3").val();
		var addr = $("#addr1").val() + $("#addr2").val() + $("#addr3").val();
		var email = $("#email1").val() + $("#email2").val();
		
		
		if($("#idDoubleChk").val() != "true"){
			alert("아이디를 확인해주세요.");
			$("#id").focus();
			return rv = false;
		}
		
		if($("#pwdChkResult").val() != "true"){
			alert("비밀번호를 확인해주세요.");
			$("#pwd").focus();
			return rv = false;
		}
		
		if($("#birthChkResult").val() != "true"){
			alert("생년월일을 확인해주세요.");
			$("#birth").focus();
			return rv = false;
		}
		
		if($("#emailDoubleChk").val() != "true"){
			alert("이메일 인증을 확인해주세요.");
			$("#userEmail").focus();
			return rv = false;
		}
		
		<%--
		if($("#telDoubleChk").val() != "true"){
			alert("휴대폰 인증을 확인해주세요.");
			$("#userTelChk").focus();
			return rv = false;;
		}	
		--%>
		
		if($("#tel_1").val() == "" || $("#tel_2").val() == "" || $("#tel_3").val() == ""){
			alert("휴대폰 번호를 확인해주세요.");
			$("#tel_2").focus();
			return rv = false;
		}
		
		if($("#userTelChk").val() == "") {
			$(".successTelChk").text("");
			$("#telDoubleChk").val("false");
		}
		
		if($("#addrChk").val() != "true"){
			alert("주소를 확인해주세요.");
			return rv = false;
		}
		
		
		
		alert($("#id").val() + "님 환영합니다.");
		return rv;
	});
});

function daumPost(){
    new daum.Postcode({
        oncomplete: function(data) {
			var addr="";
			// R : 도로명, J : 지번
			if(data.userSelectedType=='R'){
				addr = data.roadAddress
			}
			else{
				addr = data.jibunAddress
			}
			$("#addr1").val(data.zonecode)
			$("#addr2").val(addr)
			$("#addr3").focus()
        }
    }).open();
}

</script>
<style type="text/css">
table {
	margin: 0 auto;
	width: 600px;
}

table th,td {
	border-bottom: 2px solid gray;
	padding: 60px 0 60px 0;
}

table td {
	padding: 5px 0 7px 8px;
	text-align: left;
}

.point {
	font-size: 13px;
}

.sendNum {
	color : black;
	font-size: 13px;
	border: 1px solid black;
	background: gray;
}

ul {
	list-style: none;
}

#button1 {
	margin-left: 200px;
	width: 600px;
	height: 50px;
	border-radius: 9999px;
	font-size: 24px;
	background: orange;
}

#emailChk {
	background: orange;
	border-radius: 9999px;
	cursor: pointer;
	padding: 5px;
}

</style>
</head>
<body>
	<c:import url="../default/header.jsp"/>
	<div class="wrap">
		<h1 style="padding-left: 400px;">회원 가입</h1>
		<form id="signup_free" action="register" method="post">
			<table>
				<tr>
					<th> 이름 </th>
					<td>
						<input type="text" name="name" id="name" placeholder="이름" maxlength="10" autocomplete="none">
					</td>
				</tr>
				<tr>
					<th> 아이디 </th>
					<td>
						<input type="text" name="id" id="id" placeholder="아이디" maxlength="10" autocomplete="none"><br>
						<span class="point">※ 2 ~ 10 글자 입력가능 </span><br>
						<span class="point successIdChk"></span>
						<input type="hidden" id="idDoubleChk">
					</td>
				</tr>
				<tr>
					<th> 비밀번호 </th>
					<td>
						<input type="password" name="pwd" id="pwd" placeholder="비밀번호"><br>
						<span class="point successPwd"></span>
						<span class="point">※ 대소문자, 숫자, 특수문자 필수</span><br>
					</td>
				</tr>
				<tr>
					<th> 비밀번호 확인 </th>
					<td>
						<input type="password" id="pwdchk" placeholder="비밀번호 확인"><br>
						<span class="point successPwdChk"></span><br>
						<input type="hidden" id="pwdChkResult" value="false">
					</td>
				</tr>
				<tr>
					<th> 생년월일 </th>
					<td>
						<input type="text" name="birth" id="birth" maxlength="8" placeholder="ex)19901231"><br>
						<span class="point successBirthChk"></span><br>
						<input type="hidden" id="birthChkResult" value="false">
					</td>
				</tr>
				<tr>
					<th> 성별 </th>
					<td>
						<ul>
							<li>
								<label for="man"> 남자 </label>
								<input type="radio" class="hidden" name="gender" id="man" value="M" checked>
								<label for="woman"> 여자 </label>
								<input type="radio" class="hidden" name="gender" id="woman" value="F">
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<th> E-mail </th>
					<td>
						<input type="text" name="email" id="email1" placeholder="E-mail 입력"> @ 
						<select id="email2">
							<option value=""> 도메인 선택 </option>
							<option value="@naver.com"> Naver </option>
							<option value="@google.com"> Google </option>
							<option value="@gmail.com"> Gmail </option>
						</select> &nbsp;
						<span id="emailChk" class="sendNum"> 인증번호 </span><br>
						<span class="point successEmail"></span><br>
						
					</td>
				</tr>
				<tr>
					<th>이메인 인증확인</th>
					<td>
						<input type="text" id="userEmail2" autocomplete="none"><br>
						<span class="point successEmailChk">※ 이메일 입력 후 인증번호 클릭 </span>
						<input type="hidden" id="emailDoubleChk">
					</td>
				</tr>
				<tr>
					<th> Tel </th>
					<td>
						<select name="tel" id="tel_1">
							<option> 010 </option>
							<option> 018 </option>
							<option> 019 </option>
						</select> - 
						<input type="text" id="tel_2" size="4" maxlength="4"> - 
						<input type="text" id="tel_3" size="4" maxlength="4">
					</td>
				</tr>
				<!-- 
				<tr>
					<th> 핸드폰 인증확인 </th>
					<td>
						<input type="text" name="userTelChk" id="userTelChk"><br>
						<span class="point successTelChk">※ 핸드폰 번호 입력 후 인증번호 클릭 </span>
						<input type="hidden" id="telDoubleChk">
					</td>
				</tr>
				 -->
				<tr>
					<th> 주소 </th>
					<td>
						<input type="text" id="addr1" name="addr" placeholder="우편번호" readonly>
						<input type="button" class="btn btn-info" value="우편번호 찾기" onclick="daumPost()"><br>
						<input type="text" id="addr2" placeholder="주소" readonly><br>
						<input type="text" id="addr3" placeholder="상세주소" ><br>
						<span class="point successAddrChk"></span><br>
						<input type="hidden" id="addrChk" value="false">
					</td>
				</tr>
				<tr>
					<th> 구인직종 </th>
					<td>
						<ul>
							<li>
								<label for="occupation_01"> 개발자 </label>
								<input type="radio" class="hidden" name="job" id="occupation_01" value="developer" checked>
								<label for="occupation_02"> 퍼블리셔 </label>
								<input type="radio" class="hidden" name="job" id="occupation_02" value="publisher">
								<label for="occupation_03"> 디자이너 </label>
								<input type="radio" class="hidden" name="job" id="occupation_03" value="designer">
								<label for="occupation_04"> 기획자 </label>
								<input type="radio" class="hidden" name="job" id="occupation_04" value="planner">
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<th> 활용가능 기술 </th>
					<td>
						<ul>
							<li>
								<label for="available_0">Front-End</label>
								<input type="checkbox" class="hidden" name="skill" id="available_0" value="frontEnd" onclick="count_check(this)">
								<label for="available_1">Back-End</label>
								<input type="checkbox" class="hidden" name="skill" id="available_1" value="backEnd" onclick="count_check(this)">
								<label for="available_2">Java</label>
								<input type="checkbox" class="hidden" name="skill" id="available_2" value="java" onclick="count_check(this)">
								<label for="available_3">Spring</label>
								<input type="checkbox" class="hidden" name="skill" id="available_3" value="spring" onclick="count_check(this)">
								<label for="available_4">Maven</label>
								<input type="checkbox" class="hidden" name="skill" id="available_4" value="maven" onclick="count_check(this)">
								<label for="available_5">Jenkins</label>
								<input type="checkbox" class="hidden" name="skill" id="available_5" value="jenkins" onclick="count_check(this)">
								<label for="available_6">WebView</label>
								<input type="checkbox" class="hidden" name="skill" id="available_6" value="webView" onclick="count_check(this)">
								<label for="available_7">node.js</label>
								<input type="checkbox" class="hidden" name="skill" id="available_7" value="node.js" onclick="count_check(this)">
								<label for="available_8">React.js</label>
								<input type="checkbox" class="hidden" name="skill" id="available_8" value="react.js" onclick="count_check(this)">
								<label for="available_9">react-native</label>
								<input type="checkbox" class="hidden" name="skill" id="available_9" value="react-native" onclick="count_check(this)">
								<label for="available_10">Vue.js</label>
								<input type="checkbox" class="hidden" name="skill" id="available_10" value="Vue.js" onclick="count_check(this)"><br>
								<label for="available_11">JavaScript</label>
								<input type="checkbox" class="hidden" name="skill" id="available_11" value="javaScript" onclick="count_check(this)">
								<label for="available_12">Oracle</label>
								<input type="checkbox" class="hidden" name="skill" id="available_12" value="oracle" onclick="count_check(this)">
								<label for="available_13">MSSQL</label>
								<input type="checkbox" class="hidden" name="skill" id="available_13" value="msSql" onclick="count_check(this)">
								<label for="available_14">MySQL</label>
								<input type="checkbox" class="hidden" name="skill" id="available_14" value="mySql" onclick="count_check(this)">
								<label for="available_15">MariaDB</label>
								<input type="checkbox" class="hidden" name="skill" id="available_15" value="mariaDB" onclick="count_check(this)"><br>
								<label for="available_16">MongoDB</label>
								<input type="checkbox" class="hidden" name="skill" id="available_16" value="mongoDB" onclick="count_check(this)">
								<label for="available_17">Android</label>
								<input type="checkbox" class="hidden" name="skill" id="available_17" value="android" onclick="count_check(this)">
								<label for="available_18">loT</label>
								<input type="checkbox" class="hidden" name="skill" id="available_18" value="lot" onclick="count_check(this)">
								<label for="available_19">PHP</label>
								<input type="checkbox" class="hidden" name="skill" id="available_19" value="php" onclick="count_check(this)">
								<label for="available_20">jQuery</label>
								<input type="checkbox" class="hidden" name="skill" id="available_20" value="jquery" onclick="count_check(this)">
								<label for="available_21">Aduino</label>
								<input type="checkbox" class="hidden" name="skill" id="available_21" value="aduino" onclick="count_check(this)"><br>
								<label for="available_22">Hybrid</label>
								<input type="checkbox" class="hidden" name="skill" id="available_22" value="hybrid" onclick="count_check(this)">
								<label for="available_23">UNIX</label>
								<input type="checkbox" class="hidden" name="skill" id="available_23" value="unix" onclick="count_check(this)">
								<label for="available_24">C#</label>
								<input type="checkbox" class="hidden" name="skill" id="available_24" value="c#" onclick="count_check(this)">
								<label for="available_25">C</label>
								<input type="checkbox" class="hidden" name="skill" id="available_25" value="c" onclick="count_check(this)">
								<label for="available_26">C++</label>
								<input type="checkbox" class="hidden" name="skill" id="available_26" value="c++" onclick="count_check(this)">
								<label for="available_27">Qt</label>
								<input type="checkbox" class="hidden" name="skill" id="available_27" value="qt" onclick="count_check(this)">
								<label for="available_28">Server</label>
								<input type="checkbox" class="hidden" name="skill" id="available_28" value="server" onclick="count_check(this)"><br>
								<label for="available_29">Miplatform</label>
								<input type="checkbox" class="hidden" name="skill" id="available_29" value="miplatform" onclick="count_check(this)">
								<label for="available_30">Thymeleaf</label>
								<input type="checkbox" class="hidden" name="skill" id="available_30" value="thymeleaf" onclick="count_check(this)">
								<label for="available_31">flutter</label>
								<input type="checkbox" class="hidden" name="skill" id="available_31" value="flutter" onclick="count_check(this)">
								<label for="available_32">ios</label>
								<input type="checkbox" class="hidden" name="skill" id="available_32" value="ios" onclick="count_check(this)">
							</li>
						</ul>
					</td>
				</tr>
			</table><br>
			<input type="submit" id="button1" value="회원가입">
		</form>
	</div>
	<c:import url="../default/footer.jsp"/>
</body>
</html>