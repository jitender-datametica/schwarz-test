CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_listung_von_2 (mandant_id, art_id, dat_aenderung_listung
, dat_erst_listung) AS SELECT mandant_id,
 art_id,
 MIN(dat_von) AS dat_aenderung_listung,
 MIN(dat_erst_listung) AS dat_erst_listung
FROM kfl_production_dbp_view.v_art_vw_listung_von_2 AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 art_id;