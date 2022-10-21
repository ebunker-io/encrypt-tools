$folder_exist=(Test-Path ebunker)
$pubkey_exist=(Test-Path ebunker-public-key.gpg)


if("$folder_exist" -eq "$False")
{
echo "错误：ebunker文件夹不存在，请创建ebunker文件夹，并放入keystore文件和密码文本。如已创建，请检查文件夹名称为ebunker"
echo "参考文档：https://docs.ebunker.io/docs/keystore"
pause
exit

}

if("$pubkey_exist" -eq "$False")
{
echo "错误：加密公钥未找到，请从邮件中下载附件 ebunker-public-key.gpg到桌面"
echo "如已下载，请检查文件名称为ebunker-public-key.gpg"
echo "参考文档：https://docs.ebunker.io/docs/keystore"
pause
exit

}

$timestamp=Get-Date -Format 'yyyyMMddHHmmss'
powershell Compress-Archive -Path ebunker -DestinationPath "ebunker-keystore_$timestamp.zip"
gpg --import ebunker-public-key.gpg
gpg --recipient ebunker --output "ebunker-keystore_$timestamp.gpg" --encrypt "ebunker-keystore_$timestamp.zip"

echo "文件已生成，文件名 ebunker-keystore_$timestamp.gpg ，位置：桌面"
echo "按任意键退出"
pause

exit