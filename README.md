
## messages
|column|Type|Null|Key|
|:-|:-|:-|:-|
|id|integer|No|Primary|
|body|text|||
|image|string|||
|group_id|reference|No|ForeignKey|
|user_id|reference|No|ForeignKey|

### relation
##### belongs_to:user
##### belongs_to:group

## users
|column|Type|Null|Key|
|:-|:-|:-|:-|
|id|integer|No|Primarykey|
|name|string|No||
|email|string|No||
|password|string|No||
|group_id|reference|No|ForeignKey|

### relation
##### has_many:messages
##### belongs_to:group
##### has_many:groups

## groups
|column|Type|Null|Key|
|:-|:-|:-|:-|
|id|integer|No|Primarykey|
|name|string|No|||

### relation
##### has_many:users
##### belongs_to:user
