
## messages
|column|Type|Null|Key|other|
|:--|:--|:--|:--|:--|
|id|integer|No|PrimaryKey||
|body|text||||
|image|string||||
|group_id|reference|No|ForeignKey||
|user_id|reference|No|ForeignKey|||

relation
belongs_to:user
belongs_to:group

## users
|column|Type|Null|Key|other|
|:--|:--|:--|:--|:--|
|id|integer|No|Primarykey||
|name|string|No||index|
|email|string|No|||
|password|string|No|||
|group_id|reference|No|ForeignKey|||

relation
has_many:messages
has_many:groups, through: :user_groups
has_many:user_groups

## groups
|column|Type|Null|Key|other|
|:--|:--|:--|:--|:--|
|id|integer|No|Primarykey||
|name|string|No||||

relation
has_many:messages
has_many:users, through: :user_groups
has_many:user_groups

## user_groups
|column|Type|Null|Key|other|
|:--|:--|:--|:--|:--|
|user_id|reference|No|ForeignKey||
|group_id|reference|No|ForeignKey|||

relation
belongs_to:user
belongs_to:group
