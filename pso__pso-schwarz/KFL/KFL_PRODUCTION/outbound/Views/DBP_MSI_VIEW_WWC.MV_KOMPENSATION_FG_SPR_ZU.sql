CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kompensation_fg_spr_zu (zapprove, zapprove_bez, spr_id) AS
SELECT 0 AS zapprove,
 'noch nicht genehmigt' AS zapprove_bez,
 22 AS spr_id
UNION DISTINCT
SELECT 1 AS zapprove,
 'genehmigte Gruppe' AS zapprove_bez,
 22 AS spr_id;