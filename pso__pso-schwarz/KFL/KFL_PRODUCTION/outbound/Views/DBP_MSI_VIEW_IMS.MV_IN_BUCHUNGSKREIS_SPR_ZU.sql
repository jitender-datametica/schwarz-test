CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_buchungskreis_spr_zu AS SELECT mandant_id,
 buchungskreis_id,
  CASE
  WHEN buchungskreis_id = - 1
  THEN ''
  ELSE buchungskreis_bez
  END AS buchungskreis_bez
FROM kfl_production_dbp_view.v_in_buchungskreis_spr_zu;