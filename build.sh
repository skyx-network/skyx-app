#!/bin/bash
# 检查是否传入了参数
if [ -z "$1" ]
then
    echo "No platform specified. Please specify 'ios' or 'android'."
    exit
fi

# 根据传入的参数执行相应的构建命令
case $1 in
    ios)
        # 运行 Flutter build ipa
        flutter build ipa

        # 打印构建完成信息
        echo "iOS build completed. Check the output in the 'build/ios/ipa' directory."
        ;;
    android)
        # 运行 Flutter build apk
        flutter build appbundle

        # 打印构建完成信息
        echo "Android build completed. Check the output in the 'build/app/outputs/flutter-apk' directory."
        ;;
    *)
        echo "Invalid platform specified. Please specify 'ios' or 'android'."
        exit
        ;;
esac
