CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_wup_zu_per_2 (art_id, bwscl, dat_bis, dat_von, listung_id,
mandant_id, nb_id, vk_brutto, wup_id, kdis_kz, kdis_aenderung_dat) AS SELECT art_id,
 bezugsweg_id AS bwscl,
 dat_bis,
 dat_von,
 listung_id,
 mandant_id,
 nb_id,
 vk_brutto,
 wup_id,
 kdis AS kdis_kz,
 CURRENT_DATE AS kdis_aenderung_dat
FROM kfl_production_dbp_view.v_art_wup_zu_per_2 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND nb_id <> 99;