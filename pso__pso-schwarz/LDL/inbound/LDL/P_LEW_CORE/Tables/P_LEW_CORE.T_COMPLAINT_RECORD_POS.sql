/* --------------------------------------------------------------------------------
   DDL for table: t_complaint_record_pos
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COMPLAINT_RECORD_POS CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   complaint_record_id                 NUMBER(20,0)     NOT NULL COMMENT 'Reklamationsnummer; SAP-Retail: zlex_rekla_pos.rklnr; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklnr',
   complaint_record_pos_id             NUMBER(38,0)     NOT NULL COMMENT 'Reklamationspositionsnummer; SAP-Retail; zlex_rekla_pos.rklpo; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklpo',
   item_sid                            NUMBER(38,0)     COMMENT 'Reklamationsartikel; FK auf ITEM; SAP-Retail: zlex_rekla_pos.matnr; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.matnr',
   loc_sid_send                        NUMBER(38,0)     COMMENT 'Sendender Betrieb; FK auf LOCATION; SAP-Retail: zlex_rekla_pos.werks_src; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.werks_src',
   loc_sid_receive                     NUMBER(38,0)     COMMENT 'Empfangender Betrieb; FK auf LOCATION; SAP-Retail: zlex_rekla_pos.werks_dst; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.werks_dst',
   uom_sid                             NUMBER(38,0)     COMMENT 'Reklamationsmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: zlex_rekla_pos.meins; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.meins',
   curr_sid                            NUMBER(38,0)     COMMENT 'Waehrung; FK auf CURRENCY; SAP-Retail: zlex_rekla_pos.waers; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.waers',
   complaint_reason_mark               VARCHAR(20)      COMMENT 'Reklamationsgrund Code; SAP-Retail: zlex_rekla_pos.rklgr; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklgr; ELWIS: cmpnt_reason_cd',
   complaint_reason_label              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Reklamationsgrund Beschreibung; 0010=Minderlieferung, 0020=Mehrlieferung, 0030=Fuhrenbruch, ...',
   complaint_area_mark                 VARCHAR(20)      COMMENT 'Reklamationsbereich Code; SAP-Retail: zlex_rekla_pos.rklber; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklber',
   complaint_area_label                VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Reklamationsbereich Beschreibung; 1=Standard, 2=O+G, 3=NVE, 4=Retoure, ...',
   uom_cd                              VARCHAR(20)      COMMENT 'Reklamationsmengeneinheit; SAP-Retail: zlex_rekla_pos.meins; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.meins',
   complaint_qty                       NUMBER(18,5)     COMMENT 'Reklamationsmenge; SAP-Retail: zlex_rekla_pos.menge; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.menge',
   curr_cd                             VARCHAR(20)      COMMENT 'Waehrungscode; SAP-Retail: zlex_rekla_pos.waers; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.waers',
   complaint_val                       NUMBER(18,5)     COMMENT 'Wert der Reklamation; SAP-Retail: zlex_rekla_pos.rkval; SAP-BW: t_bw_z_ds_zlex_bw_reklamatione.rklval; ELWIS: cmpnt_val',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Erfassungsdatum; SAP-Retail: zlex_rekla_pos.zzerdat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_COMPLAINT_RECORD_POS PRIMARY KEY (client_id, complaint_record_id, complaint_record_pos_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CMPL; Reklamationen;
             SAP-Retail: zlex_rekla_pos;
             SAP-BW: t_bw_z_ds_zlex_bw_reklamatione;
             ELWIS: t_s_cmpnt_record_pos';

