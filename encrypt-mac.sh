#/bin/bash

echo "keystore文件加密程序开始运行......"
time=$(date +%Y%m%d%H%M%S)
echo "1. 记录当前时间：${time}"
cd ~/Desktop/

echo "2. 检查ebunker文件夹......"
if [ ! -d "./ebunker" ]; then
    echo "错误：ebunker文件夹不存在，请创建ebunker文件夹，并放入keystore文件和密码文本。如已创建，请检查文件夹名称为ebunker"
    echo "参考文档：https://docs.ebunker.io/docs/keystore"
    exit 1
fi

echo "3. 检查加密公钥......"
if [ ! -f "./ebunker-public-key.gpg" ]; then
    echo "错误：加密公钥未找到，请从邮件中下载附件 ebunker-public-key.gpg到桌面"
    echo "如已下载，请检查文件名称为ebunker-public-key.gpg"
    echo "参考文档：https://docs.ebunker.io/docs/keystore"
    exit 1
fi
echo "4. 压缩ebunker文件......"
tar czf ebunker-keystore_${time}.tar.gz ebunker
echo "5. 导入加密公钥......"
gpg --import ebunker-public-key.gpg
echo "6. 加密keystore......"
gpg --recipient ebunker --output ebunker-keystore_${time}.gpg --encrypt ebunker-keystore_${time}.tar.gz
rm ebunker-keystore_${time}.tar.gz
echo "恭喜！！您的keystore加密完成，文件为: ebunker-keystore_${time}.gpg"
echo "恭喜！！请将文件ebunker-keystore_${time}.gpg回复到eBunker邮箱，参考文档：https://docs.ebunker.io/docs/keystore"
