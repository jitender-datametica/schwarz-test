CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_art_spr_zu_1 AS SELECT V01.mandant_id,
 V01.art_id,
 V02.kl_art_id,
 V01.art_bez,
 V01.spr_id
FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id <> 1;