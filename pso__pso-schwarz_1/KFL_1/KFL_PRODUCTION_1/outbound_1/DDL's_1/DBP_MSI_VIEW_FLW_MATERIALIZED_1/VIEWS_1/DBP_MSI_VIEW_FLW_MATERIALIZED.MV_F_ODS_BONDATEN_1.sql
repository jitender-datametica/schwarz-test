CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_ods_bondaten_1 (mandant_id, wup_id, bon_dat,
arthiertyp_id, wg_id, anzahl_scanned, anzahl_keyed, anzahl_bons) AS SELECT *
FROM kfl_production_dbp_msi_view_flw.mv_f_ods_bondaten_1;