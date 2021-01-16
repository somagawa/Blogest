# ばしょログ

![画像１](./README_image_1.jpg)

## サイト概要
ばしょログは共有したいスポットを記事として投稿することができます。また遊ぶ場所を探したり、旅行の計画を立てる時に、他の投稿者の記事を参考にすることもできます。

http://basyolog.net
- テストユーザー (記事投稿、コメント、いいね、フォロー意外はログイン必要なし)<br>
 ログインID : test@test<br>
 パスワード : password

### サイトテーマ
気軽に楽しかった場所や有意義だった場所を発信したり、スポットを検索できます。

### ターゲットユーザ
・楽しかった場所、思い出を共有したい人
・スポットを探している人

### 主な利用シーン
旅行の計画時、友人と遊びに行く場所を探す時、デートスポットを探す時


## 使用技術

- HTML/CSS
- Javascript
- Ruby 2.5.7
- Ruby on Rails 5.2.4.2
- Rspec 3.9
- MySQL 5.7
- AWS(EC2、RDS) Amazon Linux AMI 2018.03
- Docker 19.03.12
- docker-compose 1.27.2
- CircleCI


## 工夫した点

- 一部、<b>非同期通信</b>を使用し、ユーザーのストレスを軽減しました（いいね、フォロー、コメント）
- <b>GoogleMapAPI</b>による地図表示で直感的な場所の特定を可能にしました
- <b>Rspec(Capybara)</b>を使用し、効率的なバグの検知を行いました
- <b>Docker</b>を使用し、簡単かつスピーディーな環境構築を可能にしました


## 主な機能
- キーワード、住所、ジャンルによるシームレスな検索
- ランキング機能
- 記事投稿機能
- 記事編集機能
- いいね機能
- フォロー機能
- 地図表示機能
- レスポンシブ対応


## 設計書
- ER図
https://drive.google.com/file/d/1PFTfvio3heCFniQRhC3ytIgJVDEz4yqT/view?usp=sharing
- ワイヤーフレーム
https://drive.google.com/file/d/16q3BsKG0lzQQkr5v94KDQt7YNNv3FxU-/view?usp=sharing
- アプリケーション詳細設計書
https://drive.google.com/file/d/19lJfUPFqqljeZGzq6GQ5J3LVD_Jb8wcM/view?usp=sharing


## 機能一覧
https://docs.google.com/spreadsheets/d/1dqCoy5gZYkliHLtHzWoDS5huSI74oz52TerJzSpxaDg/edit?usp=sharing


