CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_l_vkorg (mandant_id, in_verkaufsorganisation_id) AS
SELECT mandant_id,
 flw_verkaufsorganisation_id AS in_verkaufsorganisation_id
FROM kfl_production_dbp_view.v_flw_l_vkorg AS V01
WHERE mandant_id = 1 AND flw_verkaufsorganisation_id IN ('DE03', 'DE04', 'DE07', 'DE08', 'DE09')
 OR mandant_id = 2 AND flw_verkaufsorganisation_id IN ('CZ03');