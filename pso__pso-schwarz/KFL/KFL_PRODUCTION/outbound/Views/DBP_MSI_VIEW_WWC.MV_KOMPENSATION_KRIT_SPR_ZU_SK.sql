CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kompensation_krit_spr_zu_sk (zcgadv, zcgadv_bez, spr_id) AS
SELECT 0 AS zcgadv,
 'Compensation | (equal unit of measure)' AS zcgadv_bez,
 108 AS spr_id
UNION DISTINCT
SELECT 1 AS zcgadv,
 'Compensation | (different unit of measure)' AS zcgadv_bez,
 108 AS spr_id;