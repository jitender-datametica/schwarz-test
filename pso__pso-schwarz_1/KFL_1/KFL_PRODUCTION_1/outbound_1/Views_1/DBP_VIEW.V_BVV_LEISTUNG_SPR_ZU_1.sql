CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bvv_leistung_spr_zu_1 AS SELECT bvv_leist_id,
 spr_id,
 bvv_leist_bez,
 bvv_gewerk_bez,
 bvv_u_gewerk_bez,
 bvv_immob_mob_bez
FROM kfl_production_dbp_data.bvv_leistung_spr_zu_1;