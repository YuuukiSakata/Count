//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //クイズを格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer:Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //正解を表示するラベル
    @IBOutlet var answerLabel: UILabel!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons1: UIButton!
    @IBOutlet var choiceButtons2: UIButton!
    @IBOutlet var choiceButtons3: UIButton!
    
    
    //画像を表示するためのImageView!
    @IBOutlet var quizImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tmpArray = [AnyObject]()
        
        tmpArray.append(["一度交代でフィールドを出ると原則もどれないのは？","アメフト","ラグビー","どちらでもない",2])
        tmpArray.append(["ヘルメット、ショルダーなど防具を付けるのは？","アメフト","ラグビー","どちらでもない",1])
        tmpArray.append(["高校の大会で花園と呼ばれるのは？","アメフト","ラグビー","どちらでもない",2])
        tmpArray.append(["11人でプレーするのは？","アメフト","ラグビー","どちらでもない",1])
        tmpArray.append(["五郎丸選手は？","アメフト","ラグビー","どちらでもない",2])
        tmpArray.append(["タッチダウンをするのは？","アメフト","ラグビー","どちらでもない",1])
        tmpArray.append(["ボールを前に投げることができるのは？","アメフト","ラグビー","どちらでもない",1])
        tmpArray.append(["監督が試合中選手に指示を送ることができないのは？","アメフト","ラグビー","どちらでもない",2])
        tmpArray.append(["肩より上にタックルすることが禁じられている","アメフト","ラグビー","どちらでもない",2])
        tmpArray.append(["中国語で書くと美式足球なのは？","アメフト","ラグビー","どちらでもない",1])
        tmpArray.append(["試合の時間が4クウォーターに分かれているのは？","アメフト","ラグビー","どちらでもない",1])
        tmpArray.append(["攻守が明確に分かれている","アメフト","ラグビー","どちらでもない",1])
        

        
        // 問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random_uniform(UInt32(tmpArray.count)))
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButtons1.setTitle(quizArray[0][1] as? String, forState: .Normal)
        choiceButtons2.setTitle(quizArray[0][2] as? String, forState: .Normal)
        choiceButtons3.setTitle(quizArray[0][3] as? String, forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            
            //正解数を増やす
            correctAnswer++
            
            answerLabel.backgroundColor = UIColor.redColor()
            answerLabel.text = "正解"
        }else  {
            answerLabel.backgroundColor = UIColor.blueColor()
            answerLabel.text = "不正解"
        }
        
        quizArray.removeAtIndex(0)
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destinationViewController as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


