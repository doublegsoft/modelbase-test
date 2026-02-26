Modelbase数据对象模式
===================

## {entity} + [entity] + [value] 

单个实体对象，和多个关联的实体对象，以及多个作为关联关系的值域对象

```modelbase

@entity
@persistence(name='tn_exp_smpl')
@name(label='基础', singular='simple', plural='simples')
simple<
  @persistence(name='smplid')
  @name(label='标识')
  id!!: long,

  @persistence(name='smplnm')
  @name(label='名称')
  name+!: string(200),
  
  @conjunction(name='simple_another')
  @name(label='另外的', singular='another')
  anothers: &another(id)[]
>

@entity
@persistence(name='tn_exp_ano')
@name(label='另一个', singular='another', plural='anothers')
another<
  @persistence(name='anoid')
  @name(label='标识')
  id!!: long,

  @persistence(name='anonm')
  @name(label='名称')
  name+!: string(200)
>

@value
@persistence(name='tv_exp_smplano')
@name(label='基础和另一个的关联', singular='simple_another', plural='simple_anothers')
simple_another<
  @persistence(name='smplid')
  @name(label='基础')
  simple!!: &simple(id),
  
  @persistence(name='anoid')
  @name(label='另一个')
  another!!: &another(id),
  
  @persistence(name='rol')
  @name(label='名称')
  role!: enum[GD:好,BT:很好,BS:最好]
>

another_<
  @name(label='关系程度')
  role!: enum[GD:好,BT:很好,BS:最好]
>
```

## {entity} + [entity] + [conjunction]  

单个实体对象，和多个关联的实体对象，以及多个关联对象

```modelbase

@entity
@persistence(name='tn_exp_smpl')
@name(label='基础', singular='simple', plural='simples')
simple<
  @persistence(name='smplid')
  @name(label='标识')
  id!!: long,

  @persistence(name='smplnm')
  @name(label='名称')
  name+!: string(200),
  
  @conjunction(name='simple_tag')
  @name(label='标签', singular='tag')
  tags: &tag(id)[]
>

@entity
@persistence(name='tn_exp_tg')
@name(label='标签', singular='another', plural='anothers')
tag<
  @persistence(name='tgid')
  @name(label='标识')
  id!!: long,

  @persistence(name='tgnm')
  @name(label='名称')
  name+!: string(200)
>

@conjunction
@persistence(name='tx_exp_smpltg')
@name(label='基础和标签的关联', singular='simple_tag', plural='simple_tags')
simple_tag<
  @persistence(name='smplid')
  @name(label='基础')
  simple!!: &simple(id),

  @persistence(name='tgid')
  @name(label='标签')
  tag!!: &tag(id)
>

```

## {entity} + {entity} + {value}  

单个实体对象，和单个关联的实体对象，以及作为关联关系的值域对象

```modelbase

@entity
@persistence(name='tn_exp_smpl')
@name(label='基础', singular='simple', plural='simples')
simple<
  @persistence(name='smplid')
  @name(label='标识')
  id!!: long,

  @persistence(name='smplnm')
  @name(label='名称')
  name+!: string(200)
>

@entity
@persistence(name='tn_exp_ano')
@name(label='另一个', singular='another', plural='anothers')
another<
  @persistence(name='anoid')
  @name(label='标识')
  id!!: long,

  @persistence(name='anonm')
  @name(label='名称')
  name+!: string(200)
>

@value
@persistence(name='tv_exp_smplano')
@name(label='基础和另一个的关联', singular='simple_another', plural='simple_anothers')
simple_another<
  @persistence(name='smplid')
  @name(label='基础')
  simple!!: &simple(id),
  
  @persistence(name='anoid')
  @name(label='另一个')
  another!!: &another(id),
  
  @persistence(name='rol')
  @name(label='名称')
  role!: enum[GD:好,BT:很好,BS:最好]
>

another_<
  @name(label='关系程度')
  role!: enum[GD:好,BT:很好,BS:最好]
>
```

```json

{
...
"queryHandlers":[{
  "query":{
    ...
  },
  "handler":"||another/save",
  "sourceField":"simpleId",
  "targetField":"anotherId",
  "queryHandlers":[{
    "handler":"||simple_another/save",
    "sourceFields":["simpleId","anotherId"],
    "targetFields":["simpleId","anohterId"],
    "query": {
      "role":"BS"
    }
  }] 
}]
}
```

## {entity} + {entity} + {conjunction}  

单个实体对象，和单个关联的实体对象，以及单个关联对象

## {entity} + {value} 

单个实体对象和单个值域对象

## {entity} 

单个实体对象保存

## {value} 

单个值域对象保存

## {conjunction} 

单个链接对象保存
