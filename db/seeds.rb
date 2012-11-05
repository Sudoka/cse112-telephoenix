# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p1= Phone.create(name: 'Iphone 5', brand: 'Apple')
p2= Phone.create(name: 'Iphone 4', brand: 'Apple')
p3= Phone.create(name: 'Iphone 4s', brand: 'Apple')
p4= Phone.create(name: 'Galaxy SIII', brand: 'Samsung')
p5= Phone.create(name: 'Rumor Touch', brand: 'LG')
p6= Phone.create(name: 'Triumph', brand: 'Motorola')
p7= Phone.create(name: 'Array', brand: 'Samsung')

Tag.create(phone: p1, key: 'Smartphone', value: 'Yes')
Tag.create(phone: p1, key: 'Camera', value: 'Front and Back')
Tag.create(phone: p1, key: 'Keyboard', value: 'Virtual')
Tag.create(phone: p2, key: 'Smartphone', value: 'Yes')
Tag.create(phone: p4, key: 'Android', value: '4.0')
Tag.create(phone: p7, key: 'Smartphone', value: 'no')
Tag.create(phone: p7, key: 'Keyboard', value: 'Physical Sliding')
