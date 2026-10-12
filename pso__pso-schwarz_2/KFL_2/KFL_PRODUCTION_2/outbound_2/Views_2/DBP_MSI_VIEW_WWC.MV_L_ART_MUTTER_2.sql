CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_art_mutter_2 (art_id, mandant_id, art_id_mutter, anrmu_sap,
dat_von, dat_bis) AS SELECT V01.art_id,
 V01.mandant_id,
 V02.art_id AS art_id_mutter,
  CASE
  WHEN V02.artikelart_id = 'MWST'
  THEN TRIM(CAST(V02.kl_art_id AS STRING FORMAT '0000'))
  ELSE TRIM(CAST(V02.kl_art_id AS STRING FORMAT '00000000'))
  END AS anrmu_sap,
 V01.dat_von,
 V01.dat_bis
FROM kfl_production_dbp_view.v_art_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.mutter_vk_id = V02.art_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V02.dat_bis = DATE '9999-12-31';