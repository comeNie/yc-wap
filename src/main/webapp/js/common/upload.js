/**
 * Created by Nozomi on 2/13/2017.
 */
var uploader = null;
var upload = {
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
            pick: {id: "#selectFile", multiple: false},
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
                _this._showWarn($.i18n.prop('order.upload.error.fileNum'));
                return false;
            }
        });

        uploader.on("beforeFileQueued", function (file) {
            var allSize = file.size;

            $("#fileList ul li").each(function () {
                allSize += $(this).attr("size");
            });

            if (file.size == 0) {
                _this._showWarn($.i18n.prop('order.upload.error.empty'));
                return false;
            }

            if (file.size > 20 * 1024 * 1024) {
                _this._showWarn($.i18n.prop('order.upload.error.fileSizeSingle'));
                return false;
            }

            if (allSize > 100 * 1024 * 1024) {
                _this._showWarn($.i18n.prop('order.upload.error.fileSize'));
                return false;
            }

            if ($.inArray(file.ext.toLowerCase(), FILE_TYPES) < 0) {
                _this._showWarn($.i18n.prop('order.upload.error.type'));
                return false;
            }

        });

        uploader.on("fileQueued", function (file) {
            $("#fileList ul").css('"border-bottom","none"');
            $("#fileList").append('<ul style="border-bottom: medium none;"><li class="word" size="' + file.size + '" id="' + file.id + '">' + file.name + '</li><li><p class="ash-bj"><span style="width:0%;"></span></p><p name="percent">0%</p></li><li class="right"><i class="icon iconfont" >&#xe618;</i></li></ul>');
        });

        uploader.on("uploadProgress", function (file, percentage) {

            var fileId = $("#" + file.id),
                percent = fileId.find(".progress .progress-bar");
            if (!percent.length) {//避免重复创建
                percent = $('<div class="progress progress-striped active"><div class="progress-bar" role="progressbar" style="width: 0%"></div></div>')
                    .appendTo(fileId).find('.progress-bar');
            }
            fileId.next().find('span').css('width', percentage * 100 + "%");
            fileId.next().find('p[name="percent"]').text(parseInt(percentage * 100) + "%");
            percent.css('width', percentage * 100 + '%');

        });

        uploader.on('uploadSuccess', function (file, responseData) {
            if (responseData.statusCode == "1") {
                var fileData = responseData.data;
                // console.log(fileData);
                //文件上传成功
                if (fileData) {
                    $("#" + file.id).attr("fileId", fileData);
                    return;
                }
            }//上传失败
            else {
                _this._showFail($.i18n.prop('order.upload.error.upload'));
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
                _this._showWarn($.i18n.prop('order.upload.error.repeat'));
            } else if (type == "Q_EXCEED_SIZE_LIMIT") {
                //_this._showWarn($.i18n.prop('order.upload.error.fileSize'));
            } else if (type == "Q_EXCEED_NUM_LIMIT") {
                //_this._showWarn($.i18n.prop('order.upload.error.fileNum'));
            } else if (type == "Q_TYPE_DENIED") {
                //_this._showWarn($.i18n.prop('order.upload.error.type'));
            }

        });

        uploader.on('uploadError', function (file, reason) {
            _this._showFail($.i18n.prop('order.upload.error.upload'));

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