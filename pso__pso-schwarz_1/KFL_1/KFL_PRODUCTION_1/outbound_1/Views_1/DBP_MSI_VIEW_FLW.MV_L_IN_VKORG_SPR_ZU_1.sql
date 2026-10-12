CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_vkorg_spr_zu_1 (mandant_id, in_verkaufsorganisation_id,
spr_id, verkaufsorganisation_bez) AS SELECT V01.mandant_id,
 V01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
 V01.spr_id,
 V01.verkaufsorganisation_bez
FROM kfl_production_dbp_view.v_flw_vkorg_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id = 1 AND V01.flw_verkaufsorganisation_id IN ('DE03', 'DE04', 'DE07', 'DE08', 'DE09')
 OR V01.mandant_id = 2 AND V01.flw_verkaufsorganisation_id IN ('CZ03');