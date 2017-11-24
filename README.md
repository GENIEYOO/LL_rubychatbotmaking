# 카카오톡 YELLOW ID 자동응답 API활용하기



* 카카오톡 플러스 친구 API활용 github

  * [주소](https://github.com/plusfriend/auto_reply) (+5.1부터 필요!)

  * [참고 깃](https://github.com/och8808/kakao_bot_sample )

    ​

* 카카오 YELLOWID 생성

  [카카오YELLOWID](https://center-pf.kakao.com/)

  ​

* cloud9 kakaobot 생성

  * 카카오 키보드랑 메시지 컨트롤러 생성

    ```
    -rails g controller kakao keyboard message
    ```

  * routes.rb 수정

    ​

  * controller.rb 수정

    - keyboard랑 message가 기본
    - helper에다가 msgmaker와 parser삽입하고 모듈 넣어준다. controller에서 모듈 끌어다 씀.


* 개념

  * 사용자랑 대화하는 것이 아니라 서버랑 대화 - 서버가 켜져 있는지 확인

    API사용시 field명 맞추어 줘야함.



*  postman 활용

  * postman 활용하면 get /post방식 모두 open이 가능하다. 

    JSON에 있는 거 볼 수 있다.

  ​

* module활용 (모듈은 정리)





* mission3. cat api이용 고양이 랜덤 이미지 출력

* mission2.  네이버 영화 크롤링 해서 영화 추천해주기

  - API활용시 API에서 제시된 대로 필드명을 잘 활용해주어야 한다. -포토필드를 활용해야 포토출력 가능

  - http://thecatapi.com/api/images/get?format=xml&results_per_page=1%type=jpg

    type=jpg추가

* 참고 

  http://www.fluenty.co/ko/ : 코드 수 줄이고 사이트내 정보 사용할 수 있음.

  ​

* controller.rb 액션 로직 정리

  *  먼저 들어갈 때 동작 

    

  ```
  def keyboard
      render json: @@keyboard.getBtnKey(["영화", "고양이", "아무말"])
    end
  ```

  * user 메시지 받고 반응

   

  ```
    def message
      basic_keyboard = @@keyboard.getBtnKey(["영화", "고양이", "아무말"])

      user_msg=params[:content]
      
  ```

  ​

  * 고양이 이미지 랜덤출력 뽑아주기

    ```
      if user_msg == "고양이"
          parse=Parser::Animal.new
          message = @@message.getPicMessage("나만 고양이없어", parse.cat)
    ```

    ​

  * 영화 추천

    ```
       elsif user_msg =="영화"
          parse=Parser::Movie.new
          message=@@message.getMessage(parse.naver + ["좋아요", "별로" ].sample)
        else
          message=@@message.getMessage("없는 명령어 입니다.")
          
        end
    ```

    ​

  * 리턴

    ```
      result = {
          message: message,
          keyboard: basic_keyboard
        }
        
        render json: result
      end

    ```

    ​

  * 챗봇 등록한 친구 삭제한 친구수 세기 user.rb에  카운트 메소드 정해주기

  * user.rb/controller.rb

    ```
    class User < ActiveRecord::Base
        def plus
            self.chat_room += 1
            #유저 데이터에 채팅룸을 더한다.
        end
    end

    ```

    ```
     
      def friend_add
        User.create(user_key: params[:user_key], chat_room: 0)
        render nothing: true
      end
        
        
        #새로운 유저 저장


      def friend_del
        user = User.find_by(user_key: params[:user_key])
        user.destroy
        render nothing: true
      end

     
      def chat_room
        user = User.find_by(user_key: params[:user_key])
        user.plus
        user.save
        render nothing: true
      end



    end
    ```

​		

  

​			

​		   

​                 















----------------

에러?20171124

1. arr= ["치킨", "편의점", "떡볶이"."초밥", "20층"] => string 에러 정리 잘해야 잘 보임.



2. hash 앞에 '':'' hash와 Json에 대한 공부 필요!



3. 컴퓨터는 내가 입력한 순서대로 읽는 것 뿐. 코드 하나하나 잘 보고 순서파악하기!



4. chat_room  action 을 추가하고 나서 model에 chat룸을 추가해야 한다. chat_room 액션이 있으면chat_room  컬럼(모델)도 있어야한다.(생각하자.생각하자)

   ​

5. 모델은 건드리지 말아라!



6. paragragh  인덴트 잘 지키기.

    한 줄만 띠고 

    탭수 조정잘하기!!!! 매우 중요. syntax 에러찾는데

   ​

   ​