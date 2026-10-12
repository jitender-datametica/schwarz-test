CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_art_wup_zu_per_1 (system_id, mandant_id, wup_id, dat_von, nb_id
, art_id, bezugsweg_id, listung_id, vk_brutto, dat_bis, kdis) AS SELECT 7 AS system_id,
 mandant_id,
 wup_id,
 dat_von,
 nb_id,
 art_id,
 bezugsweg_id,
 listung_id,
 vk_brutto,
 dat_bis,
 kdis
FROM kfl_production_dbp_view.v_art_wup_zu_per_1
WHERE dat_bis = DATE '9999-12-31'
 AND mandant_id = 1;