drop table if exists stg.deliverysystem_deliveries;
create table stg.deliverysystem_deliveries(
id serial primary key,
object_id varchar not null,
object_value text not null,
constraint delivery_unique_key unique(object_id));