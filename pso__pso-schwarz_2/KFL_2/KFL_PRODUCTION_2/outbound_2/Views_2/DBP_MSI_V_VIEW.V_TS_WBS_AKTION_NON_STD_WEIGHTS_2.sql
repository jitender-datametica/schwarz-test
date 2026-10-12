CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wbs_aktion_non_std_weights_2 AS SELECT mandant_id,
 werbe_typ_id,
 kjwo,
 dat_quelle,
 dat_ziel,
 gewichtung_prz,
 dat_von_orig,
 dat_bis_orig
FROM kfl_production_dbp_msi_data.ts_wbs_aktion_non_std_weights_2;