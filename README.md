# プラズマシミュレータの使い方

## ポータルサイトへのログイン

必要なもの：IDとPWが書かれたはがき，スマホアプリ「Duo Mobile」

ポータルサイト：https://portal.ps.iferc-csc.jp/

各種情報

最初は 講習会資料/2025年度利用者講習会/ドキュメント/プラズマシミュレータ利用者講習会 のスライドがわかりやすいかも

利用の手引き/プラズマシミュレータシステム利用の手引き が詳しめ（手引きの7.6章にPython仮想環境が，7.7章にPython+GPUが記載されている）

Webフロントエンドサービス/お問い合わせ・相談先/よくあるお問い合わせや各情報はこちら にある，Plasma Simulator WikiにPython,Jupyter Labなどの情報もある（別途Wikiのためのアカウント登録が必要）

## スーパーコンピュータの使い方

Open OnDemandを使用する方法と，SSH接続を行う方法の2つの方法を紹介する

### Open OnDemandを使用する場合

必要なもの：特になし（グループIDはLINEWORKSのグループのノートに記載）

Webフロントサービス/Open OnDemandから，Jupyter LabやPlasma Simulator Shell Access（いわゆるターミナル）を使用できる

注意点としては，Jupyter Labは計算ノードを使用すること，Jupyter Labで使用できるディレクトリが/home/[userID]/以下になっていること（手引きによるとプログラムなどのデータの置き場は/data/[userID]/が推奨されている）

おすすめの使い方：ローカル（自分のPC等）で作成したipynbファイルをGitHubやscpコマンド，Jupyter LabのUpload機能を使用してプラズマシミュレータにコピーした後，Jupyter Labを起動してファイルを選択して計算ノード上で実行する

### SSH接続を行う方法

必要なもの：SSH接続環境（WindowsならUbuntuなどのWSLやSSH接続系のフリーソフト，Macはターミナル等），スマホアプリ「Google Authenticator」

流れ：SSHの秘密鍵と公開鍵を作成し，ポータルサイトの接続情報/公開鍵登録システムからスパコンに公開鍵を登録する

ポータルサイトの接続情報/SSH秘密鍵・公開鍵の作成方法，接続の手引きを適宜参照

SSHの簡単な説明はCS53プログラミングWiki/ツール一覧/SSH(Secure SHell)にも書いてあります（Wikiは[こちら](https://t-shmizu.notion.site/CS53-Wiki-a0b90fbf7b46480fb78564808a11882f?source=copy_link)）

秘密鍵と公開鍵を作成できたら，公開鍵登録システムに公開鍵を登録する

初回接続時に，OTP認証用のQRコードが表示されるので，「Google Authenticator」でQRコードを読み取り，OTPを設定する（設定後，QRコードとその下の数字列を厳重に保管してくださいとのこと 保管したらYを入力してEnter）

2回目以降の接続時は「Google Authenticator」のOTPが必要

#### VSCodeのRemoteSSHを用いる場合

CS53プログラミングWiki/ツール一覧/VSCode/Remote WSL/SSHを適宜参照

事前に.ssh/configを作成する必要あり

MacのVSCodeでは拡張機能を入れれば素直に使用できるはず

Windowsでは，例えばUbuntuで作成した~/.ssh/をC:\Users\\[username]\\.sshにコピーする必要がある．

```bash
cp -r ~/.ssh/ /mnt/c/Users/[username]/
```

### Python + GPU環境構築

利用の手引き/プラズマシミュレータシステム利用の手引き 第7.6.4 pyenvによる仮想環境の作成 をまねる（3.11.14の仮想環境 myenv_3.11.14を作成したとする）

利用の手引き/プラズマシミュレータシステム利用の手引き 第7.7.1 PyTorch をまねる（コピペの際，改行に注意）

ジョブスクリプトtest_PS.shを作成

SSH接続で接続した先はフロントシステム部であり，GPUが搭載されている計算ノードでプログラムを実行させるためには，上記のOpen OnDemandからJupyter Labを開くか，下記のターミナルからジョブを投げる必要がある

### ジョブの投げ方

利用の手引き/プラズマシミュレータシステム利用の手引きの第8章を適宜参照

ジョブスクリプト（test_PS.sh）を作成したのち，ジョブ投入コマンドを実行する

ジョブの投入コマンド

```bash
qsub test_PS.sh
```

ジョブの状態確認コマンド

```bash
qstat
```

ジョブの削除コマンド

```bash
qdel [jobID]
```

ジョブが終了すると，[jobName].o[jobID]という出力ファイルが生成される

### Jupyter LabでPython仮想環境を使用する

Webフロントエンドサービス/お問い合わせ・相談先/よくあるお問い合わせや各情報はこちら にある，Plasma Simulator Wiki/Jupyter Lab で matplotlib等のPythonパッケージを使う　を参照した

1. Jupyter Labを開く

2. Othersのターミナルを開く

3. 仮想環境をアクティベート

```bash
pyenv activate myenv_3.11.14
```

4. Jupyterに仮想環境を登録

```bash
python -m ipykernel install --user --name=myenv_3.11.14
```

5. ターミナルを削除 しばらく待つとLauncherにmyenv_3.11.14が出現

6. test.ipynbをホームディレクトリ配下にコピーして開き，右上の実行環境をmyenv_3.11.14にする

7. 実行する