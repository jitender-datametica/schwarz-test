CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_wup_vk_per (mandant_id, art_id, wup_id, nb_id, dat,
dat_von, dat_bis, dat_zeitraum, vk_brutto, wrg_id) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.wup_id,
 0 AS nb_id,
 V02.dat,
 V01.dat_von,
 V01.dat_bis,
   CAST(V01.dat_von AS STRING) || ' - ' || CAST(V01.dat_bis AS STRING) AS dat_zeitraum,
 V01.vk_brutto,
 V01.wrg_id
FROM kfl_production_dbp_view.v_art_wup_vk_per AS V01
 INNER JOIN kfl_production_dbp_msi_view_wwc.mv_tag_listung AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis;