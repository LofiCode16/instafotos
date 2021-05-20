# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

images = [
    'https://www.hola.com/imagenes/estar-bien/20210217184541/gatos-gestos-lenguaje-significado/0-922-380/gatos-gestos-m.jpg',
    'https://www.ecestaticos.com/image/clipping/79776773aab795837282c7d4947abaf7/por-que-nos-parece-que-los-perros-sonrien-una-historia-de-30-000-anos.jpg',
    'https://t1.ea.ltmcdn.com/es/images/9/1/3/tipos_de_erizos_de_tierra_20319_orig.jpg'
]

3.times do |i|
    User.create(
        name: "user#{i+1}",
        email: "user#{i+1}@mail.com",
        password: '123456'
    )
end

20.times do |i|
    Post.create(
        image_url: images.sample,
        content: "contenido del post #{i+1}",
        user_id: User.all.sample.id
    )
end

