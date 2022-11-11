@echo off
SET folder_exist=ebunker
SET pubkey_exist=ebunker-public-key.gpg

if not exist %folder_exist% (
echo "����ebunker�ļ��в����ڣ��봴��ebunker�ļ��У�������keystore�ļ��������ı������Ѵ����������ļ�������Ϊebunker"
echo "�ο��ĵ���https://docs.ebunker.io/docs/keystore"
pause
exit
)

if not exist %pubkey_exist% (
echo "���󣺼��ܹ�Կδ�ҵ�������ʼ������ظ��� ebunker-public-key.gpg������"
echo "�������أ������ļ�����Ϊebunker-public-key.gpg"
echo "�ο��ĵ���https://docs.ebunker.io/docs/keystore"
pause
exit
)

set "timestamp=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
echo %timestamp%

powershell Compress-Archive -Path ebunker -DestinationPath ebunker-keystore_%timestamp%.zip
gpg --import ebunker-public-key.gpg
gpg --recipient ebunker --output ebunker-keystore_%timestamp%.gpg --encrypt ebunker-keystore_%timestamp%.zip


echo �ļ������ɣ��ļ��� ebunker-keystore_%timestamp%.gpg ��λ�ã�����
pause
exit
