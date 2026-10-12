/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_payment_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_payment_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Waehrung, die grundsaetzlich fuer das Land_1 gilt (z.B. AT=>EUR)'),
curr_sid_alt BIGNUMERIC(38,0)
OPTIONS(description='Alternativ-Waehrung, mit der gezahlt wurde (z.B. AT erlaubt auch CHF)'),
turnover_relevant_fg BIGNUMERIC(38,0) NOT NULL,
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_payment.orig_receipt_nr_ejr'),
receipt_dt DATE NOT NULL OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_payment.dat_formdate'),
receipt_tmsp DATETIME NOT NULL
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_payment.dat_formdate + time_receipt_ejr'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_payment.timezone_cd'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_payment.pos_terminal_id'),
receiptline_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer auf Bon; WAWI-DWH: t_ejr_payment.orig_receipt_serial_nr_ejr'),
transaction_type_cd STRING(20) OPTIONS(description='WAWI-DWH: t_ejr_payment.transactiontype_id'),
transaction_begin_tmsp DATETIME
OPTIONS(description='Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_payment.timestamp_begin_ejr'),
transaction_end_tmsp DATETIME
OPTIONS(description='Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_payment.timestamp_end_ejr'),
cashier_id BIGNUMERIC(38,0) OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_payment.checker_id'),
payment_method_id BIGNUMERIC(38,0) OPTIONS(description='; WAWI-DWH: t_ejr_payment.tendertype_id'),
payment_method_cd STRING(20) OPTIONS(description='SAP Code'),
tendertype_ejr_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='; WAWI-DWH: t_ejr_payment.tendertype_cd_ejr'),
payment_fg BIGNUMERIC(38,0) OPTIONS(description='; WAWI-DWH: t_ejr_payment.cnt_payment_ejr'),
curr_cd STRING(20),
payment_val NUMERIC(18,5)
OPTIONS(description='Wert des Kaufs in Landes-/Storewaehrung; WAWI-DWH: t_ejr_payment.val_retail_payment_ejr'),
curr_cd_alt STRING(20) OPTIONS(description='; WAWI-DWH: t_ejr_payment.currency_iso_cd'),
payment_alt_val NUMERIC(18,5)
OPTIONS(description='Wert des Kaufs in alternativ erlaubter Waehrung, mit der auch gezahlt wurde; WAWI-DWH: t_ejr_payment.val_foreign_curr_ejr'),
diff_rounding_val NUMERIC(18,5) OPTIONS(description='; WAWI-DWH: t_ejr_payment.val_diff_rounding_ejr'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, receipt_id, receipt_dt, register_id, receiptline_nr, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. ;             SAP CAR: ;             ELWIS: -             WAWI: t_ejr_payment & t_ejr_payment_ntr');