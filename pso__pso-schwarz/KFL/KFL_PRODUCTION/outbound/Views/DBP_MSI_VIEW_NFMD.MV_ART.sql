CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_art AS SELECT DISTINCT V01.art_id,
 V01.mandant_id,
 V01.mwst_id,
 V01.land_id,
 V01.region_id,
 V01.kl_art_id,
 V01.dat_von,
 V01.dat_bis,
 V01.loesch_id,
 V01.mutter_wb_id,
 V02.kl_art_id AS mutter_wb_kl_art_id,
 V01.posten_kz_sap,
 V01.zek_id,
 V01.saison_id,
  CASE
  WHEN V001.art_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS art_promo_flag
FROM kfl_production_dbp_view.v_art AS V01
 LEFT JOIN kfl_production_dbp_view.v_nfmd_art_promotion AS V001 ON V01.art_id = V001.art_id AND V001.mandant_id
  IS NOT NULL
 LEFT JOIN kfl_production_dbp_view.v_art AS V02 ON V01.mandant_id = V02.mandant_id AND V01.mutter_wb_id = V02.art_id;