# PowerShell Profile Manager

このリポジトリは、PowerShell プロファイルを管理し、簡単にセットアップできるようにするためのものです。

## 前提条件

- PowerShell 5.1 以上
- [psake](https://github.com/psake/psake) モジュール
- [git](https://git-scm.com/)

## インストール

1. このリポジトリをクローンします。
```powershell
git clone https://github.com/pomu0326/ps-profile.git [クローン先のディレクトリ]
```
`[クローン先のディレクトリ]`はリポジトリをクローンしたいローカルのディレクトリに置き換えてください。

2. クローンしたディレクトリに移動します。
```powershell
cd [クローン先のディレクトリ]
```

3. psakeを使用してプロファイルをインストールします。
```powershell
Invoke-psake ps-profile.build.ps1 Install
```

## 使用方法

プロファイルがインストールされた後、新しい PowerShell セッションを開始すると、カスタムプロファイルが自動的にロードされます。

## カスタマイズ

プロファイルをカスタマイズするには、クローンしたリポジトリ内のプロファイルスクリプトを編集してください。新しい PowerShell セッションを開始すると、カスタマイズが反映されます。

カスタマイズを反映させるのに、インストールスクリプトの再実行は不要です。HardLinkでプロファイルをリンクさせているため、クローンしたリポジトリ内の修正が直接反映されます。

## ライセンス

このプロジェクトは MIT License のもとでライセンスされています。