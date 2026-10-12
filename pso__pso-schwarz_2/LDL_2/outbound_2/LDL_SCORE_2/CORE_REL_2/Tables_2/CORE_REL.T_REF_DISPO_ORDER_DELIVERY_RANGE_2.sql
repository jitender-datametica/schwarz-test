--==============================================================
-- Table: t_ref_dispo_order_delivery_range_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_dispo_order_delivery_range_2
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 08:57:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_dispo_order_delivery_range_2 (
dispo_order_delivery_range_cd STRING(20) NOT NULL
OPTIONS(description='The code for the delivery range, i.e. whether it is a day based or week based disposition.'),
dispo_order_delivery_range_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the dispo_order_delivery_range_cd written out in group language (German).'),
dispo_order_delivery_range_descr_de STRING(100)
OPTIONS(description='A textual description for the dispo_order_delivery_range_cd written out in German.'),
dispo_order_delivery_range_descr_en STRING(100)
OPTIONS(description='A textual description for the dispo_order_delivery_range_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (dispo_order_delivery_range_cd) NOT ENFORCED
) OPTIONS(description='Describes the delivery range, i.e. whether it is a day based or week based disposition. ');