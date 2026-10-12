CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_dispo_order_status (
dispo_order_status_cd STRING(20) NOT NULL
OPTIONS(description='The code for the status of the disposition (e.g. initialized, approved, sent)'),
dispo_order_status_descr STRING(100)
OPTIONS(description='A textual description for the dispo_order_status_cd wirtten out in group language (German).'),
dispo_order_status_descr_de STRING(100)
OPTIONS(description='A textual description for the dispo_order_status_cd wirtten out in German.'),
dispo_order_status_descr_en STRING(100)
OPTIONS(description='A textual description for the dispo_order_status_cd wirtten out in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (dispo_order_status_cd) NOT ENFORCED
) OPTIONS(description='Shows the actual state of an order. Whether its initialized, approved, sent. ');