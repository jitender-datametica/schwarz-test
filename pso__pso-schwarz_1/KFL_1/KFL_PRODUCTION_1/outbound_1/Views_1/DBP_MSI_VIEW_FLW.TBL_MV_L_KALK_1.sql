CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_kalk_1 (mandant_id, schnittliste_id, werk_id, dat_kalk_ab
, dat_kalk_bis, fortgesch_kalk_fg, kalk_nr, kalk_bez, kalk_kennz, kalk_variante_id, plan_soll_kz, spr_id) AS SELECT V01
 .mandant_id,
 V01.schnittliste_id,
 V01.werk_id,
 V01.dat_kalk_ab,
 V01.dat_kalk_bis,
 V01.fortgesch_kalk_fg,
 V01.plan_kalk_id AS kalk_nr,
 V02.plan_kalk_bez AS kalk_bez,
 SUBSTR('PK ', 1, 3) AS kalk_kennz,
 V01.kalk_variante_id,
 V01.plan_soll_kz,
 V02.spr_id
FROM kfl_production_dbp_view.v_flw_kalk_plan_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kalk_plan_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.plan_kalk_id
    = V02.plan_kalk_id
UNION ALL
SELECT V04.mandant_id,
 V04.schnittliste_id,
 V04.werk_id,
 V04.dat_kalk_ab,
 V04.dat_kalk_bis,
 V04.fortgesch_kalk_fg,
 V04.materialwert_kalk_id AS kalk_nr,
 V05.material_kalk_bez AS kalk_bez,
 'MWK' AS kalk_kennz,
 V04.kalk_variante_id,
 V04.plan_soll_kz,
 V05.spr_id
FROM kfl_production_dbp_view.v_flw_kalk_material_1 AS V04
 INNER JOIN kfl_production_dbp_view.v_flw_kalk_material_spr_zu_1 AS V05 ON V04.mandant_id = V05.mandant_id AND V04.materialwert_kalk_id
    = V05.materialwert_kalk_id;