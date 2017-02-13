/**
 * Created by Nozomi on 2/13/2017.
 */
var uploader = null;
var upload = {
    _showWarn: function (msg) {
        $("#EjectTitle").html(msg);
        $('#eject-mask').fadeIn(100);
        $('#prompt').slideDown(100);
    },

    _uploadFile: function () {
        if (uploader == null) {
            this._initUpdate();
        }
    },

    _initUpdate: function () {
        var _this = this;
        var FILE_TYPES = ['rar', 'doc', 'docx', 'txt', 'pdf', 'jpg', 'png', 'gif'];
        uploader = WebUploader.create({
            swf: _base + "/webuploader/Uploader.swf",
            server: _base + '/written/uploadFile',
            auto: true,
            pick: {id: "#uploadFileButton", multiple: false},
            accept: {
                title: 'fileTypes',
                extensions: 'rar,doc,docx,txt,pdf,jpg,png,gif'
            },
            resize: false,
            fileNumLimit: 10,
            fileSizeLimit: 100 * 1024 * 1024    // 100 M
        });


        uploader.on("filesQueued", function (files) {
            var allCount = $("#fileList ul").length + 1
            if (allCount > 10) {
                _this._showWarn("文件数量超出");
                return false;
            }
        });

        uploader.on("beforeFileQueued", function (file) {
            var allSize = file.size;

            $("#fileList ul li").each(function () {
                allSize += $(this).attr("size");
            });

            if (file.size == 0) {
                _this._showWarn("文件空");
                return false;
            }

            if (file.size > 20 * 1024 * 1024) {
                _this._showWarn("文件大小");
                return false;
            }

            if (allSize > 100 * 1024 * 1024) {
                _this._showWarn("文件大小");
                return false;
            }

            if ($.inArray(file.ext.toLowerCase(), FILE_TYPES) < 0) {
                _this._showWarn("文件格式");
                return false;
            }

        });

        uploader.on("fileQueued", function (file) {
            $("#fileList").css("display", "block");
            $("#uploadFileText").css("display", "block");
            $("#selectFile").css("display", "none");
            $("#fileListShow").append('<ul><a href="javascript:"><li id="' + file.id + '"><p><i class="icon iconfont">&#xe601;</i></p><p class="word-large">' + file.name + '</p><p class="right"><input type="button" class="btn btn-red btn-mini" value="删除"></p></li></a></ul>')
        });

        uploader.on('uploadSuccess', function (file, responseData) {
            if (responseData.statusCode == "1") {
                var fileData = responseData.data;
                //文件上传成功
                if (fileData) {
                    $("#" + file.id).attr("fileId", fileData);
                    return;
                }
            }//上传失败
            else {
                _this._showWarn("上传失败");
                //删除文件
                $("#" + file.id).parent('ul').remove();
                var file = uploader.getFile(file.id);
                uploader.removeFile(file);
                return;
            }
        });

        //  验证大小
        uploader.on("error", function (type) {
            if (type == "F_DUPLICATE") {
                _this._showWarn("验证大小");
            } else if (type == "Q_EXCEED_SIZE_LIMIT") {
                //_this._showWarn($.i18n.prop('order.upload.error.fileSize'));
            } else if (type == "Q_EXCEED_NUM_LIMIT") {
                //_this._showWarn($.i18n.prop('order.upload.error.fileNum'));
            } else if (type == "Q_TYPE_DENIED") {
                //_this._showWarn($.i18n.prop('order.upload.error.type'));
            }
        });

        uploader.on('uploadError', function (file, reason) {
            _this._showWarn("uploadError");
            //删除文件
            $("#" + file.id).parent('ul').remove();
            var file = uploader.getFile(file.id);
            uploader.removeFile(file);
        });

        uploader.on('uploadComplete', function (file) {
            $('#' + file.id).find('.progress').fadeOut();
        });
    }
};