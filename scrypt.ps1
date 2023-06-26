# this file should be saved in UTF8 with BOM

$Usage = "用法: scrypt 待加密目录 文档编号 密码"
$Err1 = "错误: 第一个参数非有效目录"
if ($args.count -lt 3) {
	write-host $Usage
	exit
}
if (-Not (Test-Path $args[0])) {
	write-host $Err1`n$Usage
	exit
}
staticrypt $args[0] `
--template-instructions "编号VD$($args[1])" `
-p $args[2] `
-t ./volwave_template.html `
--short -r `
--template-title "Volwave加密文档" `
--template-remember "记住密码" `
--template-error "密码错误" `
--template-button "解密查看"

write-host "【加密完成】文档编号VD$($args[1])"
