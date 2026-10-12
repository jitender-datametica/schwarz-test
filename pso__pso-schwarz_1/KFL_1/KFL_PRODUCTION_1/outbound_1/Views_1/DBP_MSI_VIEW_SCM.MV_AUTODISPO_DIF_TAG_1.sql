CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_autodispo_dif_tag_1 AS SELECT mandant_id,
 kunde_id AS wup_id,
 0 AS nb_id,
 art_id,
 dat,
 dat_ausfuehrung,
 dif_typ_id,
 dif_status_id,
 dif_wert,
 dif_kommentar,
 sap_returncode
FROM kfl_production_dbp_view.v_autodispo_dif_tag_1 AS V01;