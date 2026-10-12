CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_flw_kalk_variante_spr_zu_2 AS SELECT V01.mandant_id,
 V01.kalk_variante_id,
 V01.spr_id,
 V01.kalk_variante_bez,
 V03.mandant_kbez
FROM kfl_production_dbp_view.v_flw_kalk_variante_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V03 ON V01.mandant_id = V03.mandant_id;