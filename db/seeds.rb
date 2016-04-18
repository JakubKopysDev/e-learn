environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end

def seed_video(file_name)
  File.open(File.join(Rails.root, "/app/assets/videos/seed/#{file_name}"))
end

User.create!(username: "Kubson", email: "jakub.kopys@tlen.pl", password: "Kubson14567", admin: true )
User.create!(username: "Foobar", email: "test@tlen.pl", password: "foobarfoobar")
Guide.create!(video: seed_video('samplevideo2.flv'), thumbnail: seed_image('test300'), user_id: 2, title:  "Example Guide", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac ante nunc. Etiam in ipsum non nulla aliquam efficitur. Proin luctus consectetur aliquet. Donec porttitor elit sed turpis consectetur tincidunt dignissim at arcu. Praesent eget sollicitudin nunc. Sed risus arcu, interdum eu sapien vel, sodales lacinia risus. Morbi consequat faucibus malesuada. Donec commodo interdum finibus. Mauris neque eros, rhoncus tincidunt ligula nec, luctus ultrices sem. Nullam ut laoreet erat. Fusce aliquet orci nec metus tincidunt, nec feugiat augue iaculis. Sed elit mi, blandit ac auctor et, tincidunt dapibus dolor. Suspendisse at feugiat orci. " )

5.times do |n|
  title = "Title-#{n+1}"
  description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac ante nunc. Etiam in ipsum non nulla aliquam efficitur. Proin luctus consectetur aliquet. Donec porttitor elit sed turpis consectetur tincidunt dignissim at arcu. Praesent eget sollicitudin nunc. Sed risus arcu, interdum eu sapien vel, sodales lacinia risus. Morbi consequat faucibus malesuada. Donec commodo interdum finibus. Mauris neque eros, rhoncus tincidunt ligula nec, luctus ultrices sem. Nullam ut laoreet erat. Fusce aliquet orci nec metus tincidunt, nec feugiat augue iaculis. Sed elit mi, blandit ac auctor et, tincidunt dapibus dolor. Suspendisse at feugiat orci. "
  thumbnail = seed_image('test300')
  video = seed_video('samplevideo.mp4')
  Guide.create!(title: title, description: description, user_id: 1, thumbnail: thumbnail, video: video)
end
