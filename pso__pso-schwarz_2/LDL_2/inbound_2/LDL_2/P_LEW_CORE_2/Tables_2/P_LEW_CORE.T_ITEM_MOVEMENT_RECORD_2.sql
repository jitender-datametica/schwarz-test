/* --------------------------------------------------------------------------------
   DDL for table: t_item_movement_record_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_MOVEMENT_RECORD_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_movement_record_year           NUMBER(38,0)     NOT NULL COMMENT 'Artikelbelegjahr; SAP-Retail: mkpf.mjahr; SAP-BW: t_bw_2lis_03_bf.mjahr; ELWIS: t_s_itm_mov_record.itm_mov_record_yr',
   item_movement_record_id             NUMBER(20,0)     NOT NULL COMMENT 'Artikelbeleg; SAP-Retail: mkpf.mblnr; SAP-BW: t_bw_2lis_03_bf.mblnr; ELWIS: t_s_itm_mov_record.itm_mov_record_id',
   doc_dt                              DATE             COMMENT 'Belegdatum im Beleg; SAP-Retail: mkpf.bldat; SAP-BW: t_bw_2lis_03_bf.bldat; ELWIS: t_s_itm_mov_record.record_dat',
   event_type_cd                       VARCHAR(20)      COMMENT 'Vorgangsart; SAP-Retail: mkpf.vgart; SAP-BW: t_bw_2lis_03_bf.vgart; ELWIS: t_s_itm_mov_record.event_type_cd',
   acct_rec_entry_tmsp                 TIMESTAMP_NTZ(9) COMMENT 'Tag_2 und Uhrzeit der Erfassung des Buchhaltungsbelegs; SAP-Retail: mkpf.cpudt + cputm; SAP-BW: t_bw_2lis_03_bf. ; ELWIS: -',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Buchungsdatum; SAP-Retail: mkpf.budat; SAP-BW: t_bw_2lis_03_bf.budat; ELWIS: t_s_itm_mov_record.booking_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_MOVEMENT_RECORD PRIMARY KEY (client_id, item_movement_record_year, item_movement_record_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IMVR; Belegkopf Artikelbeleg;
             SAP-Retail: mkpf;
             SAP-BW:  t_bw_2lis_03_bf;
             ELWIS: t_s_itm_mov_record;';

