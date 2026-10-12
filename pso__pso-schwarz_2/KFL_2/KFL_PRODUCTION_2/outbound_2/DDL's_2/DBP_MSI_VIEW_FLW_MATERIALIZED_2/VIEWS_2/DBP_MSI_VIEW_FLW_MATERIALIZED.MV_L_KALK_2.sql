CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_kalk_2 (mandant_id, schnittliste_id, werk_id,
dat_kalk_ab, dat_kalk_bis, fortgesch_kalk_fg, kalk_nr, kalk_bez, kalk_kennz, kalk_variante_id, plan_soll_kz) AS SELECT
 V01.mandant_id,
 V01.schnittliste_id,
 V01.werk_id,
 V01.dat_kalk_ab,
 V01.dat_kalk_bis,
 V01.fortgesch_kalk_fg,
 V01.kalk_nr,
 V01.kalk_bez,
 V01.kalk_kennz,
 V01.kalk_variante_id,
 V01.plan_soll_kz
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_l_kalk_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V06 ON V01.spr_id = V06.spr_id;