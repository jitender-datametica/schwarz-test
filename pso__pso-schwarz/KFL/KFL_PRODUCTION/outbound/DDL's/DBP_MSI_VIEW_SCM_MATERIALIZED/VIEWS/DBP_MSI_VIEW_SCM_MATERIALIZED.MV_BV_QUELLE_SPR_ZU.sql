CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_bv_quelle_spr_zu (bv_quelle_id, bv_quelle_bez) AS
SELECT bv_quelle_id,
 bv_quelle_bez
FROM kfl_production_dbp_view.v_bv_quelle_spr_zu AS V01
GROUP BY bv_quelle_id,
 bv_quelle_bez
UNION DISTINCT
SELECT 0,
 'Kein BV';