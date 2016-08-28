# pluto

Steps taken are:

```
mix phoenix.new pluto --no-brunch --no-html

mix phoenix.gen.json Ticket tickets subject:string description:string
mix phoenix.gen.json Upload uploads s3_url:string type:string type_id:integer
mix phoenix.gen.json Comment comments value:string ticket_id:references:tickets
```
