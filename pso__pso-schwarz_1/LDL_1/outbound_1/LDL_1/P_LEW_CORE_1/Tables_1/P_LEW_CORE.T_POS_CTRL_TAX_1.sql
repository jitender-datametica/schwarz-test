/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_tax_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_tax_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1; WAWI-DWH: t_ejr_tax.loc_sid'),
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_tax.orig_receipt_nr_ejr'),
receipt_dt DATE NOT NULL OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_tax.dat_formdate'),
receipt_tmsp DATETIME NOT NULL
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_tax.dat_formdate + time_receipt_ejr'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_tax.pos_terminal_id'),
receiptline_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer auf Bon; WAWI-DWH: t_ejr_tax.orig_receipt_serial_nr_ejr'),
transaction_type_cd STRING(20) OPTIONS(description='; WAWI-DWH: t_ejr_tax.transactiontype_id'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_tax.timezone_cd'),
transaction_begin_tmsp DATETIME
OPTIONS(description='Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_tax.timestamp_begin_ejr'),
transaction_end_tmsp DATETIME OPTIONS(description='Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_tax.timestamp_end_ejr'),
cashier_id BIGNUMERIC(38,0) OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_tax.checker_id'),
total_val NUMERIC(18,5) OPTIONS(description='Steuerpflichtiger Gesamtbetrag; WAWI-DWH: t_ejr_tax.val_vat_base_ejr'),
vat_val NUMERIC(18,5)
OPTIONS(description='Ermittelter Steuerbetrag (Differenz Gesamtbetrag und Betrag ohne Steuer); WAWI-DWH: t_ejr_tax.val_vat_ejr'),
vat_pct_val NUMERIC(18,5) OPTIONS(description='verwendeter Steuersatz; WAWI-DWH: t_ejr_tax.pct_vat_ejr'),
tax_class_cd STRING(20)
OPTIONS(description='; WAWI-DWH: t_ejr_tax.type_vat_ejr; values->vat_sysmbol: (1->A,2->B,3->C,4->D)'),
tax_class_char_cd STRING(20) OPTIONS(description='; WAWI-DWH: t_ejr_tax.vat_symbol'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; WAWI-DWH: t_ejr_tax.dat_formdate'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, receipt_id, receipt_dt, register_id, receiptline_nr, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. ;             SAP CAR: ;             ELWIS: -             WAWI: t_ejr_tax');