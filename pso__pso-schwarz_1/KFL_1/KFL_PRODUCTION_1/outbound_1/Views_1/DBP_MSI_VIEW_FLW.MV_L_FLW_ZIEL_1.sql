CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_ziel_1 (mandant_id, flw_ziel_id) AS SELECT mandant_id,
 flw_ziel_id
FROM kfl_production_dbp_view.v_flw_l_bew_ziel_1 AS V01
WHERE EXISTS (SELECT 1
  FROM kfl_production_dbp_view.v_flw_bew_ziel_spr_zu_1 AS V02
  WHERE domaene_bez IN ('ZFWZIEL')
   AND V01.mandant_id = mandant_id
   AND V01.flw_ziel_id = flw_ziel_id);