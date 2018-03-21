
function ajaxCommand(url,option,id) {
	var _interVal , commonAjaxXhr , urlRex=/where=(\d+)/ , ajaxWhere=0 , count=0,
	commonAjax = function(config) {
		config = $.extend({
			type:'post',
			dataType:'json'
		},config);
		commonAjaxXhr = $.ajax(config);
	},
	_exportCommand = function(url) {
		var resultBox = document.getElementById('result');
		if ( 'number' !== typeof ajaxWhere ) return;
		url = url.replace(urlRex,'where=' + ajaxWhere );
		commonAjax({
			url: url,
			type:'get',
			success: function(data) {
				ajaxWhere = data.where;
				if ( data.result.length ) {
					count = 0;
					var commandHtml = data.result.join('');
					document.getElementById(id).innerHTML += commandHtml;
					_exportCommand(url);
				}else{
					count++;
					if(count >= 15 ) return;
					setTimeout(function(){
						_exportCommand(url)
					},1000)
				}
			resultBox.scrollTop = resultBox.scrollHeight;
			}
		});
	};

	commonAjax({
		url: url+'&option='+option,
		type:'get',
		dataType:'text',
		success: function(data) {
			_exportCommand(data);
		}
	})
}


// --------
        function addNew(widgetId, value) {
            var widget = $("#" + widgetId).getKendoDropDownList();
            var dataSource = widget.dataSource;

            if (confirm("Are you sure?")) {
                dataSource.add({
                    UserID: 0,
                    UserName: value
                });

                dataSource.one("sync", function() {
                    widget.select(dataSource.view().length - 1);
                });

                dataSource.sync();
            }
        };

        function users_onClose(e) {
        	window.location.reload()
        }

// --------


$(document).ready(function(){

    var users_dataSource = new kendo.data.DataSource({
        batch: true,
        transport: {
            read:  {
                url: "/jobapp/execuser/name/show",
                dataType: "json"
            },
            create: {
                url: "/jobapp/systemuser/save",
                dataType: "json"
            },
            parameterMap: function(options, operation) {
                if (operation !== "read" && options.models) {
                    return {models: kendo.stringify(options.models)};
                }
            }
        },
        schema: {
            model: {
            	id: "UserID",
                fields: {
                    UserID: { type: "number" },
                    UserName: { type: "string" }
                }
            }
        }
    });


    $("#users_manage").kendoDropDownList({
        filter: "startswith",
        dataTextField: "UserName",
        dataValueField: "UserName",
        dataSource: users_dataSource,
        noDataTemplate: $("#noDataTemplate").html(),
        close: users_onClose
    });

    $("#cmdrun_users").kendoDropDownList({
        filter: "startswith",
        dataTextField: "UserName",
        dataValueField: "UserName",
        dataSource: users_dataSource,
        noDataTemplate: $("#noDataTemplate").html()
    });

    $("#cmdscript_users").kendoDropDownList({
        filter: "startswith",
        dataTextField: "UserName",
        dataValueField: "UserName",
        dataSource: users_dataSource,
        noDataTemplate: $("#noDataTemplate").html()
    });

});