CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_wh_master_supplier_contact_purpose_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Länderkennung DWH'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse Kennung'),
sup_contact_purpose_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key for the contact_1 purpose from WAWI t_244_contact_type.'),
sup_contact_purpose_descr STRING(100) NOT NULL
OPTIONS(description='international description of the contact_1 purpose from WAWI t_244_contact_type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (sup_contact_purpose_descr, sup_contact_purpose_id) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. temporary cache table for load into t_supplier_contact_hist_1');