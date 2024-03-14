drop table if exists stg.deliverysystem_couriers;
create table stg.deliverysystem_couriers(
id serial primary key,
object_id varchar not null,
object_value text not null,
constraint courier_unique_key unique(object_id));