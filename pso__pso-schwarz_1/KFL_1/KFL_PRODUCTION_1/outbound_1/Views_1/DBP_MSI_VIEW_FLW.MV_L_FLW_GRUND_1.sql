CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_grund_1 (mandant_id, flw_bew_grund_id) AS SELECT
 mandant_id,
 flw_bew_grund_id
FROM kfl_production_dbp_view.v_flw_l_bew_grund_1 AS V01
WHERE EXISTS (SELECT 1
  FROM kfl_production_dbp_view.v_flw_bew_grund_spr_zu_1 AS V02
  WHERE lager_bewart_id IN ('531')
   AND V01.mandant_id = mandant_id
   AND V01.flw_bew_grund_id = flw_bew_grund_id);