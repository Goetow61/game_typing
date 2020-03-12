onPageLoad('questions#play', function() {
  var gPhrase = gon.question;
  var gKey = '';              // 入力した文字
  var gMondai = "";           //問題の文字列を格納
  var gMondai_pointer=0;      //問題文の入力位置(何文字目か)
  var gWrong_cnt=0;           //間違ったキータイプの回数
  var gCorrect_cnt=0;         //正しいキータイプの回数
  var gTimeLimit,gTimeStart;  //制限時間用、開始時間用
  var gTid;                   //タイマー用(setinterval)
  var gEle1 = document.getElementById("question");
  var gEle2 = document.getElementById("japanese_translation");
  var gEle3 = document.getElementById("remaining_time");
  var gEle4 = document.getElementById("wrong_cnt");

  // escキー押下でリセット
  document.onkeydown = function(event2) {
    if ( (event2.key===27 || event2.which===27 ) && ( gCorrect_cnt!=0 || gWrong_cnt!=0 ) ) {
      var now = new Date();     // 現在時刻を取得する
      var dt = now.getTime() - gTimeStart;   // 経過時間計算(マイクロ秒で出てくる)
      clearTimeout(gTid);    // タイマー解除
      ShowResult(dt);    // 終了画面
      gTid = gTimeStart = gTimeLimit = undefined;
      gCorrect_cnt = gWrong_cnt = 0;
    }
  }

  document.onkeypress = function(event) {
    // 押したキーによって得られる文字を取得する
    if (event) {
      // スペースを押したらゲームスタート(ブラウザによっては、event.keyが取得できない場合があるみたい)
      // gTimeStart===undefined ゲームスタートしているかどうかを判断する
      if ( (event.key===32 || event.which===32 ) && gTimeStart===undefined) {
        // 引数に制限時間(秒)を入力。未指定時デフォルトは10秒
        TimeInit(400);
        // 
        // 問題文を表示する
        gameSet();
      } else {
        if (event.key) {
          gKey = event.key;
        } else if (event.which) {
          gKey = String.fromCharCode(event.which)
        }
        if ( gTid!=undefined ) { judge(); }
      }
    }
  }

  // ttに制限時間(秒)を入力。未指定時デフォルトは10秒
  function TimeInit(tt=10) {
    gTimeLimit = tt * 1000; // 秒をミリ秒に変換
    var dd = new Date();  // 開始時間取得
    gTimeStart = dd.getTime();   // ミリ秒に変換
    gTid = setInterval(function() { TimeDisplay() }, 1000);   // タイマーセット(1秒)
  }

  function TimeDisplay() {
    var now = new Date();     // 現在時刻を取得する
    var dt = now.getTime() - gTimeStart;   // 経過時間計算(マイクロ秒で出てくる)
    gEle3.innerHTML = "残り" + Math.round( (gTimeLimit - dt) / 1000 ) + "秒";

    // 制限時間が終わったらやる処理
    if(dt > gTimeLimit) {    // ※3
      clearTimeout(gTid);    // タイマー解除
      ShowResult(dt);    // 終了画面
      gTid = gTimeStart = gTimeLimit = undefined;
      gCorrect_cnt = gWrong_cnt = 0;
    }
  }

  //タイピングゲームの問題をセットする関数
  function gameSet() {
    //問題文とカウント数をクリアする
    gMondai="";
    gMondai_pointer=0;
    
    //表示する問題文の作成
    randomNum = Math.floor( Math.random() * gPhrase.length )
    gMondai = gPhrase[randomNum][0];
    japanese_translation = gPhrase[randomNum][1];

    var str1 = '';
    for ( var i = 0 ; i < gMondai.length ; i++ ) {
      str1 += "<span id='word" + i + "'>" + gMondai.substr(i,1) +"</span>";
    }

    //問題枠に表示する
    $('i').remove();
    gEle1.innerHTML = str1;
    gEle2.innerHTML = japanese_translation;

    // 問題が変わる度に表示が消されるのは変なので、最初に一度表示したら終わるまで表示したままにしておく
    if ( gWrong_cnt===0 && gCorrect_cnt===0 ) {
      gEle4.innerHTML = gEle3.innerHTML = "";
    }
    // 結果表示時にdisplay:noneにしているのでdisplay:blockに設定し直す。
    gEle4.parentElement.style.display = "block";
  }

  // タイピング正誤判定
  function judge() {
    //入力されたキーコードと、問題文のキーコードを比較
    if (gKey === gMondai.substr(gMondai_pointer,1) || gKey === gMondai.substr(gMondai_pointer,1).toLowerCase() ) {
      gCorrect_cnt++;

      //入力されたセルの文字色を灰色にする
      var idName = "word"+gMondai_pointer;
      document.getElementById(idName).style.color="#dddddd";

      gMondai_pointer++; //カウント数を＋１にする
      
      //問題文を全部入力できかたどうか確認
      if ( gMondai.length === gMondai_pointer) {
        gameSet();
      }
    } else {
      gWrong_cnt++;
      gEle4.innerHTML = "間違いタイプ回数" + gWrong_cnt + "回";
    }
  }

  //終了したらやること
  function ShowResult(dt) {
    gEle4.innerHTML = gEle3.innerHTML = gEle2.innerHTML = "";
    // 表示すべき語句が無いのでdivブロックを見えなくする(style変えないと語句無しの不自然なブロックが表示されてしまう)
    gEle4.parentElement.style.display = "none" ;
    gEle1.innerHTML = '終了!!';
    var result = {};

    result['correct_cnt'] = gCorrect_cnt;
    result['wrong_cnt'] = gWrong_cnt;
    result['elapsed_time'] = Math.round(dt / 100) / 10;
    result['speed'] = Math.round(gCorrect_cnt / dt * 10000) / 10;
    
    var result_disp = '<table><tr><td>正解キー数</td><td>' + result['correct_cnt'] + ' key</td></tr>';
    result_disp += '<tr><td>間違えたキー数</td><td>' + result['wrong_cnt'] + ' key</td></tr>';
    result_disp += '<tr><td>時間</td><td>' + result['elapsed_time'] + ' s';
    result_disp += '<tr><td>スピード</td><td>' + result['speed'] +' key/s</td></tr>';
    result_disp += '</table>';
    gEle2.innerHTML = result_disp;
    gEle3.innerHTML = 'スペースキーを押したら再スタート';
    
    // https://qiita.com/naberina/items/d3b14521e78e0daccdcd
    // ajaxでrailsに通信しようとするとCSRFエラーが出る為追加
    $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
      var token;
      if (!options.crossDomain) {
      token = $('meta[name="csrf-token"]').attr('content');
        if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
        }
      }
    });
    
    $(function(){
      $.ajax({
        url: 'result',
        type: 'POST',
        data: JSON.stringify(result),
        dataType: 'json',
        processData: false,
        contentType: 'application/json'
      })
      .done(function(){
        console.log("タイピング結果の送信成功");
      })
      .fail(function(){
        console.log("タイピング結果の送信失敗");
      });
    });
  }
});
