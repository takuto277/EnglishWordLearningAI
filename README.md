# EnglishWordLearningAI

## 概要
#### AI単語帳アプリ
##### ユーザーが入力した文章を英文に変換させ、それを元に画像生成を行う。選択された画像と文章をセットにして登録し、オリジナルの生成画像付き英単語帳が作成できる。

## アプリ画面 
#### 実機起動

|ホーム/単語一覧画面|英文生成画面|文章選択画面|イメージ選択画面|登録完了画面|単語詳細画面|
|-|-|-|-|-|-|
| ![IMG_2229](https://github.com/takuto277/EnglishWordLearningAI/assets/83527790/333ce1ac-5c5e-4949-9578-53899b792df4) | ![IMG_2231](https://github.com/takuto277/EnglishWordLearningAI/assets/83527790/d39c66d6-9dcb-4bae-9dcd-9da7b6fca7f4) | ![IMG_2226](https://github.com/takuto277/EnglishWordLearningAI/assets/83527790/49d57d12-03c5-4790-a94f-f370a4c9fa21) | ![IMG_2227](https://github.com/takuto277/EnglishWordLearningAI/assets/83527790/f36c2d55-3588-4dc3-88d2-35d0f754d59c) | ![IMG_2228](https://github.com/takuto277/EnglishWordLearningAI/assets/83527790/e978bc91-e19f-427a-bb94-2fd851c539d8) | ![IMG_2230](https://github.com/takuto277/EnglishWordLearningAI/assets/83527790/d1cd1783-44e6-4742-a5f3-3d94e80a38da) |


## 参考資料
### サーバー制作
- 開発言語
  -  Python
- 使用環境
  - AWS, Lambda, API Gateway, Bedrock, S3
- 画像生成
  -  [参考サイト]([https://www.fsi.co.jp/blog/8843/](https://aws.amazon.com/jp/builders-flash/202402/bedrock-image-generation/?awsf.filter-name=*all))
- 例文生成
  - [参考サイト](https://qiita.com/miso_taku/items/0b495b75d669556621b5)

### システム設計
- 開発言語
  -  SwiftUI

![ER図](./Images/ER図.png)
