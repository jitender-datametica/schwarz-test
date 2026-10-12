/* --------------------------------------------------------------------------------
   DDL for table: t_item_missing_progress
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_missing_progress (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_missing_id NUMERIC(20,0) NOT NULL
OPTIONS(description='SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_no; ELWIS: t_s_itm_missing_hist.itm_missing_nr; SAP-EWM: t_z_ds_mis_items.zz_mi_no'),
item_missing_progress_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='?; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_pos; ELWIS: t_s_itm_missing_hist.itm_missing_pos; SAP-EWM: Ordnungsnummer uber (client_id, item_missing_id, wh_id)'),
missing_activity_cd STRING(20)
OPTIONS(description='Fehlartikelaktivitaet; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_act; ELWIS: t_s_itm_missing_hist.itm_missing_activity; SAP-EWM: NULL'),
missing_state_cd STRING(20)
OPTIONS(description='Fehlartikelstatus; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_stat; ELWIS: t_s_itm_missing_hist.itm_missing_state; SAP-EWM: t_z_ds_mis_items.zz_mi_status'),
missing_state_prev_cd STRING(20)
OPTIONS(description='vorheriger Fehlartikelstatus; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_sta1; ELWIS: t_s_itm_missing_hist.itm_missing_state_old; SAP-EWM: t_z_ds_mis_items.zz_mi_status (preceding 1)'),
missing_reason_cd STRING(20)
OPTIONS(description='Fehlartikelgrund; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmisreas; ELWIS: t_s_itm_missing_hist.itm_missing_reason_cd; SAP-EWM: t_z_ds_mis_items.mi_reason'),
missing_reason_prev_cd STRING(20)
OPTIONS(description='Fehlartikelgrund; SAP-BW: t_odp_itm_missing_hist._slash_bic_slash_zmmi_reas; ELWIS: t_s_itm_missing_hist.itm_missing_reason_cd_old; SAP-EWM: t_z_ds_mis_items.mi_reason (preceding 1)'),
creation_dttm DATETIME
OPTIONS(description='Erfassungszeitpunkt; SAP-BW: t_odp_itm_missing_hist.crea_dat + crea_time; ELWIS: t_s_itm_missing_hist.created_dat + created_time; SAP-EWM: t_z_ds_mis_items.zzerdat + zzerzet'),
change_dttm DATETIME
OPTIONS(description='Aenderungszeitpunkt; SAP-BW: t_odp_itm_missing_hist.ch_at + ch_on; ELWIS: t_s_itm_missing_hist.changed_dat + changed_time; SAP-EWM: t_z_ds_mis_items.zzaedat + zzaezet'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Erfassungsdatum; SAP-BW: t_odp_itm_missing_hist.erdat; ELWIS: t_s_itm_missing_hist.created_dat; SAP-EWM: t_z_ds_mis_items.zzaedat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, item_missing_id, item_missing_progress_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 9920 $. IMIP; Fehlartikel Bearbeitungshistorie;              SAP-Retail: ? zlex023_mis_acth ?;              SAP-BW: t_odp_itm_missing_hist;             ELWIS: t_s_itm_missing_hist;             SAP-EWM: t_z_ds_mis_items');