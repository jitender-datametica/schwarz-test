/* --------------------------------------------------------------------------------
   DDL for table: t_item_movement_record_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_movement_record_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_movement_record_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelbelegjahr; SAP-Retail: mkpf.mjahr; SAP-BW: t_bw_2lis_03_bf.mjahr; ELWIS: t_s_itm_mov_record.itm_mov_record_yr'),
item_movement_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Artikelbeleg; SAP-Retail: mkpf.mblnr; SAP-BW: t_bw_2lis_03_bf.mblnr; ELWIS: t_s_itm_mov_record.itm_mov_record_id'),
doc_dt DATE
OPTIONS(description='Belegdatum im Beleg; SAP-Retail: mkpf.bldat; SAP-BW: t_bw_2lis_03_bf.bldat; ELWIS: t_s_itm_mov_record.record_dat'),
event_type_cd STRING(20)
OPTIONS(description='Vorgangsart; SAP-Retail: mkpf.vgart; SAP-BW: t_bw_2lis_03_bf.vgart; ELWIS: t_s_itm_mov_record.event_type_cd'),
acct_rec_entry_tmsp DATETIME
OPTIONS(description='Tag_2 und Uhrzeit der Erfassung des Buchhaltungsbelegs; SAP-Retail: mkpf.cpudt + cputm; SAP-BW: t_bw_2lis_03_bf. ; ELWIS: -'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Buchungsdatum; SAP-Retail: mkpf.budat; SAP-BW: t_bw_2lis_03_bf.budat; ELWIS: t_s_itm_mov_record.booking_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, item_movement_record_year, item_movement_record_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. IMVR; Belegkopf Artikelbeleg;             SAP-Retail: mkpf;             SAP-BW:  t_bw_2lis_03_bf;             ELWIS: t_s_itm_mov_record;');