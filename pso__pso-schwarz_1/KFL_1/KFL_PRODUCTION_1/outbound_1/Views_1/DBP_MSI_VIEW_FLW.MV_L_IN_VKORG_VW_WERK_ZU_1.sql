CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_vkorg_vw_werk_zu_1 (mandant_id, in_verkaufsorganisation_id
, in_vw_id, werk_id) AS SELECT mandant_id,
 flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
 flw_vw_id AS in_vw_id,
 werk_id
FROM kfl_production_dbp_view.v_flw_vkorg_vw_werk_zu_1 AS V01;