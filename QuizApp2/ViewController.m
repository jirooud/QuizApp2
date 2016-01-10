//
//  ViewController.m
//  QuizApp2
//
//  Created by bpqd on 2016/01/10.
//  Copyright © 2016年 nakayama. All rights reserved.
//

#import "ViewController.h"
#import "resultViewController.h"
#import <AVFoundation/AVFoundation.h>

NSInteger quizCount;
NSInteger totalQuiz =5;
NSTimer *timer;

@interface ViewController (){
    NSMutableArray *numberAry;
    NSInteger questionNumber;
    NSInteger correctCount;
    BOOL answer;
    BOOL isAnswerButtonsEnable;
}

@property (strong, nonatomic) NSString *sound;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    numberAry = [NSMutableArray array];
    isAnswerButtonsEnable = YES;
    [self sound];
    //配列に発生させたい範囲の乱数を格納する。
    for (int i = 0; i < 10; i++){
        [numberAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self indication];
}

//戻るボタン後の処理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear : animated];
    questionNumber = 0;
    correctCount = 0;
    quizCount = 0;
    numberAry = [NSMutableArray array];
    isAnswerButtonsEnable = YES;
    //配列に発生させたい範囲の乱数を格納する。
    for (int i = 0; i < 10; i++){
        [numberAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self indication];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//最初の問題表示
- (void)indication{
    [self collection];
}

//ボタン再有効
- (void)oneSecond:(NSTimer*)timer{
    isAnswerButtonsEnable = YES;
    [self nextQuiz];
}

//次のクイズと5問終えたらresultViewに移動
- (void)nextQuiz{
    quizCount++;
    if(quizCount < totalQuiz){
        [self collection];
    } else {
        NSLog(@"%d",(int)numberAry.count);
        NSLog(@"%d",(int)questionNumber);
        NSLog(@"%d",(int)correctCount);
        [self performSegueWithIdentifier:@"connect"sender:self];
    }
}

//resultViewに数値を渡す
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"connect"]) {
        ResultViewController *resultViewController = [segue destinationViewController];
        resultViewController.response = correctCount;
    }
}

//テキストに表示する問題集10問
- (void)collection{
    NSLog(@"%d",(int)numberAry.count);
    NSLog(@"%d",(int)questionNumber);
    NSLog(@"%d",(int)correctCount);
    if (numberAry.count != 0){
        //乱数を生成
        int n = arc4random() % numberAry.count;
        //乱数の数値にしたがって配列から文字列を取り出す
        //NSLog(@"%@", numberAry[n]);
        questionNumber = [numberAry[n]integerValue];
        //取り出した文字列を削除
        [numberAry removeObjectAtIndex:n];
    }else{
        NSLog(@"重複のない乱数はありません。");
    }
    switch(questionNumber){
        case 0:
            self.problem.text = @"マダラシロエリハゲワシは高度、約10000mよりも高いところを飛べる。";
            answer=YES; break;
        case 1:
            self.problem.text = @"アメリカのイエローストーン国立公園で動物を観察し、動物記を書いたのは、シートンである";
            answer=YES; break;
        case 2:
            self.problem.text = @"イヌは人が最初に飼いならした動物である。";
            answer=YES; break;
        case 3:
            self.problem.text = @"キリンの首の骨の数は、同じく哺乳類であるヒトの骨の数と同じである。";
            answer=YES; break;
        case 4:
            self.problem.text = @"ペンギンは氷の上でも足が凍らない。";
            answer=YES; break;
        case 5:
            self.problem.text = @"ゲンジボタルが光るのは、成虫だけである。";
            answer=NO; break;
        case 6:
            self.problem.text = @"暗やみの中、コウモリがえさを見つけたり、ものをよけたりするのに使うものは “におい” である。";
            answer=NO; break;
        case 7:
            self.problem.text = @"アフリカゾウの群れのリーダーは、お父さんである。";
            answer=NO; break;
        case 8:
            self.problem.text = @"ベンギンは北半球にもすんでいる。";
            answer=NO; break;
        case 9:
            self.problem.text = @"ラクダのコブの中に入っているのは “水” である。";
            answer=NO; break;
    }
}

//マルボタンとボタン連打防止
- (IBAction)circleButton:(id)sender {
    NSLog(@"マルボタン");
    if (isAnswerButtonsEnable) {
        isAnswerButtonsEnable = NO;
        if (answer ==YES){
            correctCount++;
            self.problem.text = @"正解";
            [self crrectSound:self.sound];
        }else{
            self.problem.text = @"不正解";
            [self blipSound:self.sound];
        }
        [self startTimer];
    }
}

//バツボタンとボタン連打防止
- (IBAction)crossButton:(id)sender {
    NSLog(@"バツボタン");
    if (isAnswerButtonsEnable) {
        isAnswerButtonsEnable = NO;
        if (answer ==NO){
            correctCount++;
            self.problem.text = @"正解";
            [self crrectSound:self.sound];
        }else{
            self.problem.text = @"不正解";
            [self blipSound:self.sound];
        }
        [self startTimer];
    }
}

//正解不正解表示時間
- (void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(oneSecond:)userInfo:nil repeats:NO];
}

- (void)crrectSound:(NSString*)scaleName
{
    //音楽ファイル名を作成
    NSString *soundFileName = [NSString stringWithFormat:@"crrect_answer1"];
    //音楽ファイルのファイルパス(音楽ファイルがデータ上どこにあるか)を作成
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:soundFileName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //エラーを受け取る変数の準備
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error != nil) { //エラーがあった場合
        return;
    }
    [self.player play];
}

- (void)blipSound:(NSString*)scaleName
{
    //音楽ファイル名を作成
    NSString *soundFileName = [NSString stringWithFormat:@"blip01"];
    //音楽ファイルのファイルパス(音楽ファイルがデータ上どこにあるか)を作成
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:soundFileName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //エラーを受け取る変数の準備
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error != nil) { //エラーがあった場合
        return;
    }
    [self.player play];
}

@end
