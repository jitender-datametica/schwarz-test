CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_abt_spr_zu AS SELECT mandant_id,
 abt_id,
 arthiertyp_id,
 spr_id,
 abt_bez
FROM kfl_production_dbp_view.v_abt_spr_zu AS V01
WHERE spr_id = 22
 AND arthiertyp_id = 2
 AND mandant_id = 1
 AND abt_id BETWEEN - 3 AND 8;