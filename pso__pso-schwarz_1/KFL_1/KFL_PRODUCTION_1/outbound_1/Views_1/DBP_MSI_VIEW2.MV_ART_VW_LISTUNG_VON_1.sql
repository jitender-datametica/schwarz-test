CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_vw_listung_von_1 (art_id, mandant_id, dat_von, dat_erst_listung
) AS SELECT art_id,
 mandant_id,
 dat_von,
 dat_erst_listung
FROM kfl_production_dbp_view.v_art_vw_listung_von_1
WHERE mandant_id = 1;