CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_supplier_item_2 (
client_id BIGNUMERIC(38) NOT NULL,
country_cd STRING(160) NOT NULL,
supplier_id BIGNUMERIC(38) NOT NULL,
supplier_id_int STRING(100),
orig_supplier_nr STRING(20),
orig_item_nr NUMERIC(18),
orig_item_nr_int NUMERIC(9),
dwh_updated_tmsp DATETIME OPTIONS(description='ERSTELLUNGSZEITPUNKT DES DATENSATZES IM DWH.'),
dwh_created_tmsp DATETIME OPTIONS(description='ZEITSTEMPEL DER LETZTEN AKTUALISIERUNG DES DATENSATZES IM DWH.')
);