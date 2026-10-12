CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kompensation_fg_spr_zu_pl_1 (zapprove, zapprove_bez, spr_id) AS
SELECT 0 AS zapprove,
 'not approved yet' AS zapprove_bez,
 90 AS spr_id
UNION DISTINCT
SELECT 1 AS zapprove,
 'approved group' AS zapprove_bez,
 90 AS spr_id;