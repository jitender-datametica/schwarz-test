CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_receiving_count_status_1 (
rcv_cnt_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='status_1 identifier of the counting and processing of the location_item_incoming row'),
rcv_cnt_status_descr STRING(100) NOT NULL
OPTIONS(description='description of the status_1 identifier of the counting and processing of the location_item_incoming row'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (rcv_cnt_status_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains possible status_1 identifiers of the counting and processing of the location_item_incoming row          Source: static, WAWI field C174_ITEMSTATUS');