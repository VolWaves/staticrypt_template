# this file should be saved in UTF8 with BOM

$Version = staticrypt --version
write-host "Using staticrypt version $($Version)"
$Usage = "用法: scrypt 待加密目录 文档编号 [密码]"
$Err1 = "错误: 第一个参数非有效目录"

if ($args.count -lt 2) {
	write-host $Usage
	exit
}

if ($args.count -lt 3) {
	$Password = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_})
	write-host "未设定密码, 使用随机密码加密"
} else {
	$Password = $args[2]
	write-host "使用设定密码加密"
}

if (-Not (Test-Path $args[0])) {
	write-host $Err1`n$Usage
	exit
}
$Dirname = $args[0] | Split-Path -Leaf

staticrypt $args[0] `
--template-instructions "编号VD$($args[1])" `
-p $Password `
-t ./volwave_template.html `
--short -r `
--template-title "Volwave加密文档" `
--template-remember "记住密码" `
--template-error "密码错误" `
--template-button "解密查看"

Remove-Item -path "./encrypted/VD$($args[1])" -recurse
Rename-Item -Path "./encrypted/$($Dirname)" -NewName "VD$($args[1])"
write-host "[Success] 文档编号 VD$($args[1]) 密码[$($Password)]"

