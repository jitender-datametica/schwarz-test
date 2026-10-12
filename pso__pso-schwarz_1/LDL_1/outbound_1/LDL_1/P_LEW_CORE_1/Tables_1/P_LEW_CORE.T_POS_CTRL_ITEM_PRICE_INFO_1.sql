/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_item_price_info_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_item_price_info_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1; '),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1; FK auf ITEM_1;'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Waehrung fuer die Preisangabe; FK auf CURRENCY'),
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_price_info.orig_receipt_nr_ejr'),
receipt_dt DATE OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_price_info.dat_formdate'),
receipt_tmsp DATETIME NOT NULL
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_price_info.dat_formdate + time_receipt_ejr'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_price_info.pos_terminal_id'),
cashier_id BIGNUMERIC(38,0) OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_price_info.checker_id'),
authority_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Autorisierung - Code; WAWI-DWH: t_ejr_price_info.authority_id'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_price_info.timezone_cd'),
transaction_begin_tmsp DATETIME
OPTIONS(description='Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_price_info.timestamp_begin_ejr'),
transaction_end_tmsp DATETIME
OPTIONS(description='Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_price_info.timestamp_end_ejr'),
transaction_type_cd STRING(20) OPTIONS(description='; WAWI-DWH: t_ejr_price_info.transactiontype_id'),
curr_cd STRING(20) OPTIONS(description='Waehrung fuer die Preisangabe'),
retail_price_val NUMERIC(18,5)
OPTIONS(description='Verkaufspreis des Artikels; WAWI-DWH: t_ejr_price_info.price_retail_ejr'),
item_takeover_fg BIGNUMERIC(38,0)
OPTIONS(description='Uebernahme des Artikels nach Aufruf (0=nein, 1=ja, der Artikel_1 wurde gekauft); WAWI-DWH: t_ejr_price_info.item_takeover_fg'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, item_sid, receipt_id, register_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. ;             SAP CAR: ;             ELWIS: -             WAWI: t_ejr_price_info');