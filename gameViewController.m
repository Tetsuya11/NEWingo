//
//  gameViewController.m
//  ingo
//
//  Created by 一野哲也 on015/08/03.
//  Copyright (c) 2015年 TetsuyaIchino. All rights reserved.
//

#import "gameViewController.h"
#import "AppDelegate.h"

@interface gameViewController (){
    
     AppDelegate *_appDelegate;
    
    //Plist dictionary
    NSDictionary *_dic;
    
    // 質問本文用
    NSMutableArray *_questionAry;

    
    NSString *_keyStr;

    NSMutableArray *_selectAry;
    
    NSArray *_questionAnswer;
    
    NSMutableArray *_answerOnly;
    
    NSString *_answer;
    
    // 質問の総数用 (表示)
    int _allQuestionNum;
    
    // 質問の総数用 (処理)
    int _countAllQuestion;
    
    // 回答した回数を保持するためのカウント
    int _countAnswer;
    
    // 正解：不正解のカウント
    int _correctCount;
    int _incorrectCount;
    
    // 今回は固定で0を入れているが、ランダムな数字に変えればランダムで質問を出し削除が可能。
    int _selectCount;

    int _totalCorrectNumber;
    int _incorrectCountNumber;
    
}

@end

@implementation gameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];//初期化
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"quiz" ofType:@"plist"];
    _dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // 可変配列の初期化と配列データの代入
    _questionAry = [[NSMutableArray alloc] init];//まずは問題を入れる為のMutableを初期化
    _selectAry = [[NSMutableArray alloc]init];//選択のmutable
    _answerOnly =[[NSMutableArray alloc]init];//正解判定用
    
    /////////////////////////正解判定用の変数を作
    //ランダム係数
    //Plistのクリーン化
    
       // _dict (plist)から問題を取り出して配列に追加
    NSArray *dictKeyAry = [_dic allKeys];
    
    
    for (int i = 0; i < dictKeyAry.count; i++) {//問題数分だけ回す
        _keyStr = dictKeyAry[i];//0,1,2,3,4,
        NSString *questiontitleStr = _dic[_keyStr][@"問題"]; // 問題部分の取得1~5
        NSLog(@"======================================");
        
        [_questionAry addObject:questiontitleStr];//問題をquestionAryに入れる
        
        /////////////選択・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        [_selectAry addObject:_dic[_keyStr][@"選択"]];//ここのmutableはArrayで良いのか？　各問題の選択が入っている？
        //認識として、すべての「選択1~4」が_selectAryの中に入っていて[i]のindex番号が変わるから
        //Array((問題1の選択1~4)(問題2の選択1~4)・・・)的な
        
        _questionAnswer =_dic[_keyStr][@"選択"][@"選択1"];//各問題の「選択１」が取れてる
        
        [_answerOnly addObject:_questionAnswer];
        
        NSLog(@"選択したボタンが正解かどうかさせたい = %@", _questionAnswer);
    }
    //////////////////////////////////・・・・・・・・・・・・・・・・・・・・
    //_keyStrには問題１〜５までが入っている　また_selectAryには問題1~5の選択欄のArray
    
    for (int i = 0; i < 4; i++) {
        //NSLog(@"回答ボタン用のanswerDict %@",_answerDict);
    }
    
    // クイズの数を表示用の変数に渡す
    _countAllQuestion = (int)_questionAry.count - 1;//ここは問題数に応じて左上の合計出題数を表示
    
    // 表示用
    _allQuestionNum = _countAllQuestion + 1;
    NSLog(@"質問の合計数 = %i", _allQuestionNum);
    // 全質問の合計値表示
    self.totalNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_allQuestionNum];
    
    _countAnswer = 1;
    // 回答数の初期値表示
    self.counterLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_countAnswer];
    
    /* 乱数 */
    int t[_countAllQuestion];
    int x = 0;
    
    for(int i = 0; i < _countAllQuestion; i++){
        t[i] = arc4random() % _countAllQuestion;
        x = t[i];
        // NSLog(@"xの値 %i",x);
        for( i = 0; i < _countAllQuestion; i++)
            if(t[i] ==x)
                break;
 }
    NSLog(@"ランダムな値 = %i",x);
    
    _selectCount = x;//ランダム
    _correctCount = 0;
    _incorrectCount = 0;
    

    // 質問表示 あくまでもviewdidなので開いた最初の問題　index番号0の質問を出す⇨ボタンを押した時の処理にも記載
    self.questionLabel.text = _questionAry[_selectCount];//_selectカウントはx
    
    //    // ボタンのタイトル設定　　　indexは0なので0番目の質問と選択欄がまず初めに出る。
    [self.answerAButton setTitle:_selectAry[_selectCount][@"選択1"] forState:UIControlStateNormal];
    [self.answerBButton setTitle:_selectAry[_selectCount][@"選択2"] forState:UIControlStateNormal];
    [self.answerCButton setTitle:_selectAry[_selectCount][@"選択3"] forState:UIControlStateNormal];
    [self.answerDButton setTitle:_selectAry[_selectCount][@"選択4"] forState:UIControlStateNormal];
    
    _answer = _selectAry[_selectCount][@"選択1"];//下で作るとRemoveで消えていた為、Remove前にこの処理のグローバルを作る
    NSLog(@"★★★★★★★★★★★★★★★★★★★★★★★★★★");
    NSLog(@"_answer = %@",_answer);
    
    // 表示した質問が要らなくなるので削除
    [_questionAry removeObject:_questionAry[_selectCount]];//index番号0の質問を削除
    
    // 回答も必要なくなるので削除
    [_selectAry removeObject:_selectAry[_selectCount]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)tapABtn:(id)sender {
    
    // senderからボタンの情報を呼び出す
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.currentTitle;
    
    // ボタンのタイトルを引数にしてselectAnswerメソッドを呼び出す
    [self selectAnswer:title];
}

- (IBAction)tapBBtn:(id)sender {
    
    // senderからボタンの情報を呼び出す
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.currentTitle;
    
    // ボタンのタイトルを引数にしてselectAnswerメソッドを呼び出す
    [self selectAnswer:title];
}

- (IBAction)tapCBtn:(id)sender {
    
    // senderからボタンの情報を呼び出す
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.currentTitle;
    
    // ボタンのタイトルを引数にしてselectAnswerメソッドを呼び出す
    [self selectAnswer:title];
}

- (IBAction)tapDBtn:(id)sender {
    
    // senderからボタンの情報を呼び出す
    UIButton *btn = (UIButton *)sender;
    NSString *title = btn.currentTitle;
    
    // ボタンのタイトルを引数にしてselectAnswerメソッドを呼び出す
    [self selectAnswer:title];
}

//ボタンのタイトルはcurentで引数として渡しているのでNSString型
- (void)selectAnswer:(NSString *)btnTitle {//voidでは戻り値なし、intでは整数、string型もある　return
    // 回答された際にカウントする
    _countAnswer++;
    if ([_answer isEqualToString:btnTitle]) {
        NSLog(@"正解");
        _correctCount++;
        self.correctAnswerLabel.text = [NSString stringWithFormat:@"%d",_correctCount];
    }else{
        NSLog(@"不正解");
        _incorrectCount++;
        self.incorrectAnswerLabel.text = [NSString stringWithFormat:@"%d",_incorrectCount];
        
        
    }
    NSLog(@"合計正解数=%i@",_correctCount);

    //プロパティには.でアクセス
    _appDelegate._totalCorrectNumber = _correctCount;
    _appDelegate._incorrectCountNumber = _incorrectCount;
    

    // 選択したボタンのタイトルを利用して正解かどうかなどの処理を書く
    // 引数のbtnTitleには、このメソッドを呼び出した時に引数で渡したボタンのtitleを使ったり
    NSLog(@"選択されたボタンのタイトル = %@", btnTitle);
    NSLog(@"★★★★★★★★★★★★★★★★★★★★★★★★★★");
    
    
    // クイズが続く場合は質問用配列などの中身を確認
    NSLog(@"=======================");
    
    for (int i = 0; i < _questionAry.count; i++) {
        NSLog(@"残りクイズ = %@", _questionAry[i]);
    }
    NSLog(@"_countAnswer=%i",_countAnswer);
     NSLog(@"_allQuestionNum=%i",_allQuestionNum);
    
    
    if (_countAnswer == _allQuestionNum + 1) {
        
        
        // もし質問の総数+1と回答の総数が一致すればクイズを終了
        NSLog(@"クイズ終了");
        
        // ここに各々の初期化処理を書く
        // 画面を戻したり変数を戻したり
        
        // 今回は簡易でボタンを隠す
        game2ViewController *game2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GM2"];
        [self presentViewController:game2ViewController animated:YES completion:nil];

    } else {
        // 画面をリロードする
        
        _countAllQuestion = (int)_questionAry.count;//-1                         ここは問題数に応じて左上の合計出題数を表示
        NSLog(@"質問の合計数==== = %i", _countAllQuestion);
        
        /* 乱数 */
        int t[_countAllQuestion];
        int x = 0;
        
        if (x != 0) {
            for(int i = 0; i < _countAllQuestion; i++){
                t[i] = arc4random() % _countAllQuestion;
                x = t[i];
                NSLog(@"xの値 %i",x);
                for( i = 0; i < _countAllQuestion; i++)
                    if(t[i] ==x)
                        break;
            }
        }


        _selectCount = x;
        
        // 実際には次の値をラベルやボタンに表示させている
        self.counterLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_countAnswer];
        self.questionLabel.text = _questionAry[_selectCount];
        
        [self.answerAButton setTitle:_selectAry[_selectCount][@"選択1"] forState:UIControlStateNormal];
        [self.answerBButton setTitle:_selectAry[_selectCount][@"選択2"] forState:UIControlStateNormal];
        [self.answerCButton setTitle:_selectAry[_selectCount][@"選択3"] forState:UIControlStateNormal];
        [self.answerDButton setTitle:_selectAry[_selectCount][@"選択4"] forState:UIControlStateNormal];
        // 表示して要らなくなった質問を削除
        
        
        _answer = _selectAry[_selectCount][@"選択1"];
        NSLog(@"_answer =============== %@",_answer);
        
        
        [_questionAry removeObject:_questionAry[_selectCount]];
        [_selectAry removeObject:_selectAry[_selectCount]];
        
    }

}
@end
