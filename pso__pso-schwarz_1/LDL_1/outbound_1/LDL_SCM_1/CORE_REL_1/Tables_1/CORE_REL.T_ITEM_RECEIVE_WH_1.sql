CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_item_receive_wh_1 (
country_iso_cd STRING(3),
dat_formdate DATE,
ian BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
supplier_id_int STRING(100),
position_nr_rcv STRING(100),
package_qty NUMERIC(18,4),
qty_total_rcv NUMERIC(30,5),
dwh_updated_tmsp DATETIME,
dwh_created_tmsp DATETIME
);