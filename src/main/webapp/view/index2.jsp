<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    span { width: 150px; color: red;}
    input{border:1px solid red;}
    table{width: 80%; margin: 0 auto;}
    table,th,td {border: 1px solid gray; text-align: center;}
    h2{text-align: center;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		function getList() {
			$.ajax({
				url:"${pageContext.request.contextPath}/MyController01",
				dataType:"xml",
				method:"post",
				success: function(data) {
					// console.log(data);
					var tbody = "";
					$(data).find("member").each(function() {
						tbody += "<tr>";
						tbody += "<td>"+$(this).find("m_idx").text()+"</td>";
						tbody += "<td>"+$(this).find("m_id").text()+"</td>";
						tbody += "<td>"+$(this).find("m_pw").text()+"</td>";
						tbody += "<td>"+$(this).find("m_name").text()+"</td>";
						tbody += "<td>"+$(this).find("m_addr").text()+"</td>";
						tbody += "<td>"+$(this).find("m_reg").text()+"</td>";
						tbody += "<td><input type='button' value='삭제' id='del' name="+$(this).find("m_idx").text()+"></td>";
						tbody += "</tr>";
					});
					$("#tbody").append(tbody);
				},
				error: function() {
					alert("실패");
				}
			});
		}
		
		// data -> 서버주소에 갈 때 같이 넘어가는 파라미터 값
		$("#m_id").keyup(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/MyController06",
				dataType : "text",
				method : "post",
				data : "m_id="+$("#m_id").val(),
				success : function(data) {
					// $("span").text(data);
					if(data == "1"){
						$("#btn").removeAttr("disabled");
						$("span").text("사용가능");
					}else if(data == "0"){
						$("#btn").attr("disabled", "disabled");
						$("span").text("사용불가");
					}					
				},
				error : function() {
					alert("실패");
				}
			});
		});
		
		// 가입하기
		// data가 여러개일 때는 직렬화(serialize())를 해야 함
		// serialize() -> 직렬화, form 태그 안에 있는 요소만 가능
		$("#btn").click(function() {
			var param = $("#myform").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/MyController07",
				dataType : "text",
				method : "get",
				data : param,
				success : function(data) {
					// $("span").text(data);
					if(data == 0){
						alert("가입 실패");
					}else if(data == 1){
						alert("가입 성공");
						$("#tbody").empty();
					}					
				},
				error : function() {
					alert("실패");
				}
			});
		});
		
		//삭제 : 동적으로 생성된 요소는 click이 아닌 on을 사용
		$("table").on("click","#del", function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/MyController08",
				dataType : "text",
				method : "get",
				data : "m_idx="+$(this).atttr("name"),
				success : function(data) {
					// $("span").text(data);
					if(data == 0){
						alert("삭제 실패");
					}else if(data == 1){
						alert("삭제 성공");
						$("#tbody").empty();
						getList();
					}					
				},
				error : function() {
					alert("실패");
				}
			});
		});
		
		getList();
	});
</script>
</head>
<body>
	<h2> 회원 정보 입력하기 </h2>
    <form name="myform" method="post" id="myform" >
        <table>
            <thead>
                <tr>
                    <th>아이디</th><th>패스워드</th><th>이름</th><th>주소</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <input type="text" size="14" name="m_id" id="m_id" /><br><span>중복여부</span>
                    </td>
                    <td> <input type="password" size="8" name="m_pw" /></td>
                    <td> <input type="text" size="14" name="m_name" /></td>
                    <td> <input type="text" size="25" name="m_addr" /></td>
                </tr>
            </tbody>
            <tfoot>
                <tr><td colspan="7" align="center"><button id="btn" disabled>가입하기</button></td></tr>
            </tfoot>
        </table>
    </form>
    <br /> <br /> <br />
    <h2> 회원 정보 보기 </h2>
    <div>
        <table id="list">
            <thead>
                <tr>
                    <th>번호</th><th>아이디</th><th>패스워드</th><th>이름</th><th>주소</th><th>날짜</th><th>삭제</th>
                </tr>
            </thead>
            <tbody id="tbody"></tbody>
        </table>
    </div>
</body>
</html>