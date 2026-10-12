create table if not exists SZD_PRODUCTION.core.t_fact_truck_deliveries_1 (
	supplier_party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the supplier.',
	hauler_party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the hauler.',
	recipient_party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the recipient.',
	dispoweek_dt date not null comment 'the date of the first day of the dispo week.',
	outbound_dt date not null comment 'the date on which the goods were dispatched.',
	arrival_dt date not null comment 'the date when the goods arrived at the recipient.',
	promotion_dt date not null comment 'the promotion date.',
	planned_delivery_dt date not null comment 'the planned delivery date.',
	delivery_dt date not null comment 'the delivery date.',
	delivery_note_nr varchar(50) not null comment 'the business identification number of the delivery note.',
	delivery_date_fixed_fg boolean not null comment 'flag indicating that the delivery date is fixed.',
	total_cnt number(38,0) not null comment 'fact - additive - the total count of delivery trucks.',
	outbound_cnt number(38,0) not null comment 'fact - additive - the count of trucks that has started.',
	arrived_cnt number(38,0) not null comment 'fact - additive - the count of trucks that arrived at the recipient.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was created or last updated.',
	constraint pk_fact_truck_deliveries primary key (supplier_party_sid, hauler_party_sid, recipient_party_sid, dispoweek_dt, outbound_dt, arrival_dt, promotion_dt, planned_delivery_dt, delivery_dt, delivery_date_fixed_fg)
)comment='fact table - analytical - granularity - by week, supplier_1, hauler, recipient - aggregate - contains analytical facts regarding the count of trucks delivering goods to a recipient. - source - lexis'
;