CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_l_grund_2 AS SELECT mandant_id,
 ausgeber_typ_id,
 ausgeber_id
FROM kfl_production_dbp_view.v_l_ausgeber_2 AS V01
UNION ALL
SELECT mandant_id,
 ausgeber_typ_id,
 '0' AS ausgeber_id
FROM kfl_production_dbp_view.v_ausgeber_typ_spr_zu_2 AS V01
WHERE mandant_id = 1;