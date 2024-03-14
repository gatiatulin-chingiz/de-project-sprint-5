Привет, ревьер!
Направляю работу на проверку...
У меня получился какой-то Франкенштейн... аж стыдно...
Очень сбивает с толку ООП, не привык к нему
Особенно когда где-то валятся коннекторы read/write и непонятно, что с этим делать...
Надеюсь на экспертное мнение...


CDM
	cdm.couriers_salary:
		id — идентификатор записи
		courier_id — ID курьера, которому перечисляем.
		courier_name — Ф. И. О. курьера.
		settlement_year — год отчёта.
		settlement_month — месяц отчёта, где 1 — январь и 12 — декабрь.
		orders_count — количество заказов за период (месяц).
		orders_total_sum — общая стоимость заказов.
		rate_avg — средний рейтинг курьера по оценкам пользователей.
		order_processing_fee — сумма, удержанная компанией за обработку заказов, которая высчитывается как orders_total_sum * 0.25.
		courier_order_sum — сумма, которую необходимо перечислить курьеру за доставленные им/ей заказы. За каждый доставленный заказ курьер должен получить некоторую сумму в зависимости от рейтинга (см. ниже).
		courier_tips_sum — сумма, которую пользователи оставили курьеру в качестве чаевых.
		courier_reward_sum — сумма, которую необходимо перечислить курьеру. Вычисляется как courier_order_sum + courier_tips_sum * 0.95 (5% — комиссия за обработку платежа).


DDS
Для cdm.couriers_salary данные берем из DDS:
	id — инкрементально
	courier_id — в dds не хватает таблицы с курьерами
	courier_name — в dds не хватает таблицы с курьерами
	settlement_year — информация есть в dds.timestamps
	settlement_month — информация есть в dds.timestamps
	orders_count — информация есть в dds.orders
	orders_total_sum — информация есть в fct_product_sales
	rate_avg — в dds не хватает таблицы с курьерами
	order_processing_fee — расчетно
	courier_order_sum — - расчетно
	courier_tips_sum — в dds не хватает таблицы с курьерами
	courier_reward_sum — расчетно


STG
В STG делаем 2 таблицы:
	sgt.couriers:
		_id — ID курьера в БД;
		name — имя курьера.
	stg.deliveries:
		order_id
		order_ts
		- delivery_id -  не нужно
		courier_id
		- address - не нужно
		- delivery_ts - не нужно
		rate
		tip_sum