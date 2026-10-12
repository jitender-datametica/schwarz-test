CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_aktion_non_std_weights_1 AS SELECT mandant_id,
 werbe_typ_id,
 kjwo,
 dat_quelle,
 dat_ziel,
 dat_von_orig,
 dat_bis_orig,
 gewichtung_prz
FROM kfl_production_dbp_msi_data.ts_wbs_aktion_non_std_weights_1 AS V01;