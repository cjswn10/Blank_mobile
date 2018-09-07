$(function() {

$("#searchid").hide();
	
	$("#id").keyup(function() {

		$("#searchid").empty();
		$.ajax({
			url:"mainSearchId.do",
			data:{"id":this.value},
			success:function(data)
			{

				var arr = eval("("+data+")")
				$.each(arr,function(i,v){
					var id = $("<span></span>").html(v.id);
					var br = $("<br>");
					$("#searchid").append(id,br);
					
					$("#searchid").click(function(){
						$(this).hide();
					})
					
					$(id).click(function() {
						$("#id").val(v.id);
						$("#searchid").hide();	
						$.ajax({
							url:"listFavorite2.do",
							data:{"mno":v.mno},
							success:function(data)
							{
								location.href="othersDiary.do?id="+v.id+"&fmno="+v.mno+"";
								var arr = eval("("+data+")");		
								$.each(arr,function(i,a){
									if(a.mno == mno )
									{
										location.href="othersDiary.do?id="+v.id+"&fno="+a.fno+"&fmno="+v.mno+"";
									}				
								})
							}
						})//ajax
					})
          

					$("#btnMove").one("click",function(){
							$.ajax({
								url:"checkId2.do",
								data:{"id":$("#id").val()},
								success:function(data)
								{
									if($.trim(data) == 0){
					                    location.href="#";
					                    return;
					                }
					                else{
					                	
					                	$("#searchid").empty();
					                	$("#id").val(v.id)
					                	$.ajax({
											url:"listFavorite2.do",
											data:{"mno":v.mno},
											success:function(data)
											{
												location.href="othersDiary.do?id="+v.id+"&fmno="+v.mno+"";
												var arr = eval("("+data+")");		
												$.each(arr,function(i,a){
													if(a.mno == $("#mno").val() )
													{
														location.href="othersDiary.do?id="+v.id+"&fno="+a.fno+"&fmno="+v.mno+"";
													}				
												})
											}

										})//ajax
									
					                	}
					                }
								})//ajax

					          })
						
							});
						}
					})
				if(this.value != "")
				{
					$("#searchid").show();	
				}
				else
				{
					$("#searchid").hide();
				}
		})		
});