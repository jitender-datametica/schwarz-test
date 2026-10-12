-- 08.08.2023 snik: SPEC0202038 AKTION
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aktion (aktion_id,
mandant_id, bewart_id, aktionsart_id, werbe_kat_id, dat_von, dat_bis, kjwo_von) AS SELECT aktion_id,
 mandant_id,
 bewart_id,
 aktionsart_id,
 werbe_kat_id,
 dat_von,
 dat_bis,
 kjwo_von
FROM kfl_production_dbp_view.v_aktion AS v01;