<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='${request.contextPath}/static/lib/fullcalendar.min.css' rel='stylesheet' />
<link href='${request.contextPath}/static/lib/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='${request.contextPath}/static/lib/moment.min.js'></script>
<script src='${request.contextPath}/static/lib/jquery.min.js'></script>
<script src='${request.contextPath}/static/lib/fullcalendar.min.js'></script>
<script src='${request.contextPath}/static/lib/zh-cn.js'></script>
    <link href='${request.contextPath}/static/lib/rhui.css' rel='stylesheet' type="text/css" />  
    <script src='${request.contextPath}/static/lib/rhui-all.js'></script>  
<script>

	$(document).ready(function() {
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay,listWeek'
			},
			defaultView: 'agendaWeek',
			defaultDate: new Date(),
			navLinks: true, // can click day/week names to navigate views
			editable: true,
			selectable: true,  
			selectHelper: true,
			unselectAuto: true, 
			eventLimit: true, // allow "more" link when too many events
			events: {
				url:"/meetings"
			},
			/*  
                    添加日程事件  
                    start: 被选中区域的开始时间  
                    end: 被选中区域的结束时间  
                    jsEvent: jascript对象  
                    view: 当前视图对象  
                */  
                select: function(start, end, jsEvent, view){  
                    //添加日程事件  
                    var $win = $('#addCalendarWin');  
                    $win.find('input[name="start"]').val(start.format('YYYY-MM-DD HH:mm'));  
                    $win.find('input[name="end"]').val(end.format('YYYY-MM-DD HH:mm'));  
                    $win.rhui('window').show();  
                },  
                  
                /*  
                    修改日程事件  
                    当点击日历中的某一日程时，触发此事件  
                    data: 日程信息  
                    jsEvent: jascript对象  
                    view: 当前视图对象  
                */  
                eventClick: function(data, jsEvent, view){  
                    //修改日程事件  
                    var $win = $('#editCalendarWin');  
                    $win.find('input[name="id"]').val(data.id);  
                    $win.find('input[name="title"]').val(data.title);  
                    $win.find('textarea[name="content"]').val(data.content);  
                    $win.find('input[name="start"]').val(data.start.format('YYYY-MM-DD HH:mm'));  
                    $win.find('input[name="end"]').val(data.end.format('YYYY-MM-DD HH:mm'));  
                    $win.rhui('window').show();  
                }  
		});
		//初始化新建日程窗口  
            (function(){  
                var $win = $('#addCalendarWin');  
                  
                //初始化日期控件  
                //$win.find('input[name="start"]').datetimepicker({format: 'Y-m-d H:i'});  
                //$win.find('input[name="end"]').datetimepicker({format: 'Y-m-d H:i'});  
                  
                $win.rhui('window', {  
                    title: '新建日程',  
                    width: 400,  
                    height: 265,  
                    buttons: [{  
                        text: '确定',  
                        cls: 'rhui-btn-primary',  
                        click: function(toolbar, win){
                        	var title =  $win.find('input[name="title"]').val(); 
                        	var content =  $win.find('textarea[name="content"]').val(); 
                        	var start =  $win.find('input[name="start"]').val();                         	
                        	var end =  $win.find('input[name="end"]').val(); 
                        	 
				              var params = {title: title,
				              	content:content,
				                  start: start,
				                  end: end
				              };
                        	 $.ajax({
				                  url:"/meetings/save",
				                  type:"post",
				                  data: params,
				                    dataType: 'json',
				                    success: function(res){                    
				                        if(res == 1){
				                           alert("添加成功！");	
				                        }else{
				                            alert("添加失败！");	
				                        }
				                        $('#calendar').fullCalendar('refetchEvents');
				                        win.hide();  
				                    }
				              });                      
                            
                        }  
                    },{  
                        text: '取消',  
                        click: function(toolbar, win){  
                            win.hide();  
                        }  
                    }]  
                }).hide();                
            })();  
            
            function saveMeeting(params){
            $.ajax({
                  url:"/meetings/save",
                  type:"post",
                  data:params,
                    dataType: 'json',
                    success: function(res){                    
                        if(res == 1){
                           alert("添加成功！");
                           return true;

                        }else{
                            alert("添加失败！");
                           return false;

                        }
                        $('#calendar').fullCalendar('refetchEvents');
                    }
              });
            }
              
            //初始化修改日程窗口  
            (function(){  
                var $win = $('#editCalendarWin');  
                  
                //初始化日期控件  
                //$win.find('input[name="start"]').datetimepicker({format: 'Y-m-d H:i'});  
                //$win.find('input[name="end"]').datetimepicker({format: 'Y-m-d H:i'});  
                  
                $win.rhui('window', {  
                    title: '修改日程',  
                    width: 400,  
                    height: 265,  
                    buttons: [{  
                        text: '确定',  
                        cls: 'rhui-btn-primary',  
                        click: function(toolbar, win){  
                        	var id = $win.find('input[name="id"]').val(); 
                           var title =  $win.find('input[name="title"]').val(); 
                        	var content =  $win.find('textarea[name="content"]').val(); 
                        	var start =  $win.find('input[name="start"]').val();                         	
                        	var end =  $win.find('input[name="end"]').val(); 
                        	 
				              var params = {id: id,
				              title: title,
				              	content:content,
				                  start: start,
				                  end: end
				              };
				              
				              $.ajax({
				                  url:"/meetings/save",
				                  type:"post",
				                  data: params,
				                    dataType: 'json',
				                    success: function(res){                    
				                        if(res == 1){
				                           alert("修改成功！");	                          
				
				                        }else{
				                            alert("修改失败！");			                          
				
				                        }
				                        $('#calendar').fullCalendar('refetchEvents');
				                        win.hide();  
				                    }
				              });
                        	/*if(saveMeeting(params)){ 
                        		alert("修改成功！");
                        		$win.hide();  
                        	}else{
                        		alert("操作有误，修改失败！");
                        	}    */     
                        }  
                    },{  
                        text: '删除',  
                        cls: 'rhui-btn-danger',  
                        click: function(toolbar, win){ 
                        var id = $win.find('input[name="id"]').val();  
                         $.ajax({
		                  url:"/meetings/delete/"+id,
		                  type:"get",
		                    success: function(res){
		                        if(res== 1){
		                            alert('日程已删除');  
		                        }else{
		                            alert('日程删除失败');  
		
		                        }
		                        $('#calendar').fullCalendar('refetchEvents');
		                        win.hide();  
		                    }
		              });
                           
                        }  
                    },{  
                        text: '取消',  
                        click: function(toolbar, win){  
                            win.hide();  
                        }  
                    }]  
                }).hide();  
            })();  
	});

</script>
<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>
</head>
<body>

	<div id='calendar'></div>
	
	 <!-- 新建日程窗口 -->  
    <div class="rhui-window" id="addCalendarWin" style="display:none;">  
        <div class="rhui-panel-body">  
            <table style="margin-left:25px;">  
                <tr>  
                    <td class="field-label">日程标题：</td>  
                    <td><input class="rhui-field" name="title" type="text" /></td>  
                </tr>  
                <tr>  
                    <td class="field-label">日程内容：</td>  
                    <td><textarea class="rhui-field" name="content" style="height:62px;"></textarea></td>  
                </tr>  
                <tr>  
                    <td class="field-label">开始时间：</td>  
                    <td><input class="rhui-field" name="start" type="text"/></td>  
                </tr>  
                <tr>  
                    <td class="field-label">结束时间：</td>  
                    <td><input class="rhui-field" name="end" type="text"/></td>  
                </tr>  
            </table>  
        </div>  
    </div>  
    <!-- end 新建日程窗口 -->  
      
    <!-- 修改日程窗口 -->  
    <div class="rhui-window" id="editCalendarWin" style="display:none;">  
        <div class="rhui-panel-body">  
            <!-- 日程id -->  
            <input type="hidden" name="id" />  
            <table style="margin-left:25px;">  
                <tr>  
                    <td class="field-label">日程标题：</td>  
                    <td><input class="rhui-field" name="title" type="text" /></td>  
                </tr>  
                <tr>  
                    <td class="field-label">日程内容：</td>  
                    <td><textarea class="rhui-field" name="content" style="height:62px;"></textarea></td>  
                </tr>  
                <tr>  
                    <td class="field-label">开始时间：</td>  
                    <td><input class="rhui-field" name="start" type="text"/></td>  
                </tr>  
                <tr>  
                    <td class="field-label">结束时间：</td>  
                    <td><input class="rhui-field" name="end" type="text"/></td>  
                </tr>  
            </table>  
        </div>  
    </div>  
    <!-- end 修改日程窗口 -->     
</body>
</html>
