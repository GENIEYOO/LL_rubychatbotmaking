require 'msgmaker'
require 'parser'

class KakaoController < ApplicationController
  @@keyboard=MsgMaker::Keyboard.new
  @@message = MsgMaker::Message.new
  
  def keyboard
    render json: @@keyboard.getBtnKey(["영화", "고양이", "아무말"])
  end

  def message
    basic_keyboard = @@keyboard.getBtnKey(["영화", "고양이", "아무말"])

    user_msg=params[:content]
    
    if user_msg == "고양이"
      parse=Parser::Animal.new
      message = @@message.getPicMessage("나만 고양이없어", parse.cat)
    
    elsif user_msg =="영화"
      parse=Parser::Movie.new
      message=@@message.getMessage(parse.naver + ["좋아요", "별로" ].sample)
    
    else
      message=@@message.getMessage("없는 명령어 입니다.")
      
    end

    result = {
      message: message,
      keyboard: basic_keyboard
    }
    
    render json: result
  end
  
  
  
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
