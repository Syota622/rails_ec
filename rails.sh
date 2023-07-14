# railsコマンドなど実行したコマンドをメモとして記録しておく
docker-compose run --rm web rails generate model Order cart:references
docker-compose run --rm web rails generate model OrderItem order:references product:references quantity:integer
docker-compose run --rm web rails generate model Address order:references first_name:string last_name:string user_name:string email_name:string address1:string address2:string country:string prefectures:string post_code:string
docker-compose run --rm web rails generate model Payment order:references card_name:string name_cart:string credit_number:string expiration:string cvv:string

docker-compose run --rm web rails db:migrate