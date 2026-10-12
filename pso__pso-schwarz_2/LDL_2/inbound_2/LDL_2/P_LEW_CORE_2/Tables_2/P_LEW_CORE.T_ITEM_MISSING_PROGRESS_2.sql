/* --------------------------------------------------------------------------------
   DDL for table: t_item_missing_progress_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_MISSING_PROGRESS_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_missing_id                     NUMBER(20,0)     NOT NULL COMMENT 'SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_no; ELWIS: t_s_itm_missing_hist.itm_missing_nr; SAP-EWM: t_z_ds_mis_items.zz_mi_no',
   item_missing_progress_id            NUMBER(38,0)     NOT NULL COMMENT '?; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_pos; ELWIS: t_s_itm_missing_hist.itm_missing_pos; SAP-EWM: Ordnungsnummer uber (client_id, item_missing_id, wh_id)',
   missing_activity_cd                 VARCHAR(20)      COMMENT 'Fehlartikelaktivitaet; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_act; ELWIS: t_s_itm_missing_hist.itm_missing_activity; SAP-EWM: NULL',
   missing_state_cd                    VARCHAR(20)      COMMENT 'Fehlartikelstatus; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_stat; ELWIS: t_s_itm_missing_hist.itm_missing_state; SAP-EWM: t_z_ds_mis_items.zz_mi_status',
   missing_state_prev_cd               VARCHAR(20)      COMMENT 'vorheriger Fehlartikelstatus; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_sta1; ELWIS: t_s_itm_missing_hist.itm_missing_state_old; SAP-EWM: t_z_ds_mis_items.zz_mi_status (preceding 1)',
   missing_reason_cd                   VARCHAR(20)      COMMENT 'Fehlartikelgrund; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmisreas; ELWIS: t_s_itm_missing_hist.itm_missing_reason_cd; SAP-EWM: t_z_ds_mis_items.mi_reason',
   missing_reason_prev_cd              VARCHAR(20)      COMMENT 'Fehlartikelgrund; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_reas; ELWIS: t_s_itm_missing_hist.itm_missing_reason_cd_old; SAP-EWM: t_z_ds_mis_items.mi_reason (preceding 1)',
   creation_dttm                       TIMESTAMP_NTZ(9) COMMENT 'Erfassungszeitpunkt; SAP-BW: t_odp_itm_missing_hist.crea_dat + crea_time; ELWIS: t_s_itm_missing_hist.created_dat + created_time; SAP-EWM: t_z_ds_mis_items.zzerdat + zzerzet',
   change_dttm                         TIMESTAMP_NTZ(9) COMMENT 'Aenderungszeitpunkt; SAP-BW: t_odp_itm_missing_hist.ch_at + ch_on; ELWIS: t_s_itm_missing_hist.changed_dat + changed_time; SAP-EWM: t_z_ds_mis_items.zzaedat + zzaezet',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Erfassungsdatum; SAP-BW: t_odp_itm_missing_hist.erdat; ELWIS: t_s_itm_missing_hist.created_dat; SAP-EWM: t_z_ds_mis_items.zzaedat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_MISSING_PROGRESS PRIMARY KEY (client_id, item_missing_id, item_missing_progress_id) NOT ENFORCED 
)  COMMENT = '$Revision: 9920 $. IMIP; Fehlartikel Bearbeitungshistorie; 
             SAP-Retail: ? zlex023_mis_acth ?; 
             SAP-BW: t_odp_itm_missing_hist;
             ELWIS: t_s_itm_missing_hist;
             SAP-EWM: t_z_ds_mis_items';

