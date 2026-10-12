/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_register_transaction_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_register_transaction_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1; '),
receipt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_cntr_transact..orig_receipt_nr_ejr'),
receipt_dt DATE NOT NULL OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_cntr_transact..dat_formdate'),
receipt_tmsp DATETIME NOT NULL
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_cntr_transact..dat_formdate + time_receipt_ejr'),
register_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_cntr_transact..pos_terminal_id'),
cashier_id BIGNUMERIC(38,0) OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_cntr_transact..checker_id'),
authority_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Autorisierung - Code; WAWI-DWH: t_ejr_cntr_transact.authority_id'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_cntr_transact..timezone_cd'),
transaction_begin_tmsp DATETIME
OPTIONS(description='Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_cntr_transact..timestamp_begin_ejr'),
transaction_end_tmsp DATETIME
OPTIONS(description='Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_cntr_transact..timestamp_end_ejr'),
transaction_type_cd STRING(20) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_cntr_transact..transactiontype_id'),
transaction_type_detail_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='; WAWI-DWH: t_ejr_cntr_transact.trans_detail_type_id'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, receipt_id, receipt_dt, register_id, transaction_type_cd, transaction_type_detail_id,
 dwh_cal_dt) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. ;             SAP CAR: ;             ELWIS: -             WAWI: t_ejr_cntr_transact');