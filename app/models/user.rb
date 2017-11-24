class User < ActiveRecord::Base
    def plus
        self.chat_room += 1
        #유저 데이터에 채팅룸을 더한다.
    end
end
