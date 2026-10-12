CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_arthiertyp_1 (arthiertyp_id, arthiertyp_bez) AS SELECT
 arthiertyp_id,
 arthiertyp_bez
FROM kfl_production_dbp_view.v_arthiertyp_1
WHERE arthiertyp_id = 2;