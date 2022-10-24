@echo off
SET folder_exist=ebunker
SET pubkey_exist=ebunker-public-key.gpg

if not exist %folder_exist% (
echo "错误：ebunker文件夹不存在，请创建ebunker文件夹，并放入keystore文件和密码文本。如已创建，请检查文件夹名称为ebunker"
echo "参考文档：https://docs.ebunker.io/docs/keystore"
pause
exit
)

if not exist %pubkey_exist% (
echo "错误：加密公钥未找到，请从邮件中下载附件 ebunker-public-key.gpg到桌面"
echo "如已下载，请检查文件名称为ebunker-public-key.gpg"
echo "参考文档：https://docs.ebunker.io/docs/keystore"
pause
exit
)

set "timestamp=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
echo %timestamp%

powershell Compress-Archive -Path ebunker -DestinationPath ebunker-keystore_%timestamp%.zip
gpg --import ebunker-public-key.gpg
gpg --recipient ebunker --output ebunker-keystore_%timestamp%.gpg --encrypt ebunker-keystore_%timestamp%.zip


echo 文件已生成，文件名 ebunker-keystore_%timestamp%.gpg ，位置：桌面
pause
exit
