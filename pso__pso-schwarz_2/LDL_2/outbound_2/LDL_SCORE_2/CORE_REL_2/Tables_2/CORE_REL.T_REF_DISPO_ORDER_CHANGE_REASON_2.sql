--==============================================================
-- Table: t_ref_dispo_order_change_reason_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_dispo_order_change_reason_2
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 08:54:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_dispo_order_change_reason_2 (
dispo_order_change_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code which includes the changes in the order status_2 (e.g. addition order, order quantity increase etc.)'),
dispo_order_change_reason_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the dispo_order_change_reason_cd  written out in group language (German).'),
dispo_order_change_reason_descr_de STRING(100)
OPTIONS(description='A textual description for the dispo_order_change_reason_cd written out in German.'),
dispo_order_change_reason_descr_en STRING(100)
OPTIONS(description='A textual description for thedispo_order_change_reason_cd written out in English.'),
elm_dispo_order_change_reason_id BIGNUMERIC
OPTIONS(description='ELM: elm_corrtypeid, e.g. reason_id = 0 (keine Änderung), 1 = Neue Bestellposition etc . '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (dispo_order_change_reason_cd) NOT ENFORCED
) OPTIONS(description='Reason of the changes in the order status_2 (e.g. addition order, order quantity increase etc.)');