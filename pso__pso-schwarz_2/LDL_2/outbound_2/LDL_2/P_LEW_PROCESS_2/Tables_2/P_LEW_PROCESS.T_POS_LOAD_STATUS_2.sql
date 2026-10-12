CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_pos_load_status_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
global_loc_id STRING(20) COLLATE 'und:ci' NOT NULL,
receipt_dt DATE NOT NULL,
receipts_transfered_tmsp DATETIME,
cntlr_transfered_tmsp DATETIME,
source_deleted_tmsp DATETIME,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (loc_sid, receipt_dt) NOT ENFORCED
);