CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_arthiertyp (arthiertyp_id, arthiertyp_bez) AS SELECT
 arthiertyp_id,
 arthiertyp_bez
FROM kfl_production_dbp_view.v_arthiertyp
WHERE arthiertyp_id = 2;