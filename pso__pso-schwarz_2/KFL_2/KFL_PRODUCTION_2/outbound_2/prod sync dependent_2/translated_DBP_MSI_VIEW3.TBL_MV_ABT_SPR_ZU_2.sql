CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_abt_spr_zu_2 (mandant_id, abt_id, arthiertyp_id, spr_id,
abt_bez) AS SELECT mandant_id,
 abt_id,
 arthiertyp_id,
 spr_id,
 abt_bez
FROM kfl_production_dbp_view.v_abt_spr_zu_2 AS V01
WHERE arthiertyp_id = 2;