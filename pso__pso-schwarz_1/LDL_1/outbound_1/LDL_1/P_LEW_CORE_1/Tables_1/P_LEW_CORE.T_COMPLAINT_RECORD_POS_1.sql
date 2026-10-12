/* --------------------------------------------------------------------------------
   DDL for table: t_complaint_record_pos_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_complaint_record_pos_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
complaint_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Reklamationsnummer; SAP-Retail: zlex_rekla_pos.rklnr; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklnr'),
complaint_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Reklamationspositionsnummer; SAP-Retail; zlex_rekla_pos.rklpo; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklpo'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Reklamationsartikel; FK auf ITEM_1; SAP-Retail: zlex_rekla_pos.matnr; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.matnr'),
loc_sid_send BIGNUMERIC(38,0)
OPTIONS(description='Sendender Betrieb; FK auf LOCATION_1; SAP-Retail: zlex_rekla_pos.werks_src; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.werks_src'),
loc_sid_receive BIGNUMERIC(38,0)
OPTIONS(description='Empfangender Betrieb; FK auf LOCATION_1; SAP-Retail: zlex_rekla_pos.werks_dst; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.werks_dst'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Reklamationsmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: zlex_rekla_pos.meins; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.meins'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Waehrung; FK auf CURRENCY; SAP-Retail: zlex_rekla_pos.waers; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.waers'),
complaint_reason_mark STRING(20)
OPTIONS(description='Reklamationsgrund Code; SAP-Retail: zlex_rekla_pos.rklgr; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklgr; ELWIS: cmpnt_reason_cd'),
complaint_reason_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Reklamationsgrund Beschreibung; 0010=Minderlieferung, 0020=Mehrlieferung, 0030=Fuhrenbruch, ...'),
complaint_area_mark STRING(20)
OPTIONS(description='Reklamationsbereich Code; SAP-Retail: zlex_rekla_pos.rklber; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklber'),
complaint_area_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Reklamationsbereich Beschreibung; 1=Standard, 2=O+G, 3=NVE, 4=Retoure, ...'),
uom_cd STRING(20)
OPTIONS(description='Reklamationsmengeneinheit; SAP-Retail: zlex_rekla_pos.meins; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.meins'),
complaint_qty NUMERIC(18,5)
OPTIONS(description='Reklamationsmenge; SAP-Retail: zlex_rekla_pos.menge; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.menge'),
curr_cd STRING(20)
OPTIONS(description='Waehrungscode; SAP-Retail: zlex_rekla_pos.waers; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.waers'),
complaint_val NUMERIC(18,5)
OPTIONS(description='Wert der Reklamation; SAP-Retail: zlex_rekla_pos.rkval; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklval; ELWIS: cmpnt_val'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Erfassungsdatum; SAP-Retail: zlex_rekla_pos.zzerdat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, complaint_record_id, complaint_record_pos_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. CMPL; Reklamationen;             SAP-Retail: zlex_rekla_pos;             SAP-BW: t_bw_z_ds_zlex_bw_reklamatione;             ELWIS: t_s_cmpnt_record_pos');