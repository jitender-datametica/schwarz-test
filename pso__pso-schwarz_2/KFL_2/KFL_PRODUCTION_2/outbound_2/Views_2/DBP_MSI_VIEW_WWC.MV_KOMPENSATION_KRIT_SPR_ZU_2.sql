CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kompensation_krit_spr_zu_2 (zcgadv, zcgadv_bez, spr_id) AS
SELECT 0 AS zcgadv,
 'Kompensation | (Verpackungseinheit gleich)' AS zcgadv_bez,
 22 AS spr_id
UNION DISTINCT
SELECT 1 AS zcgadv,
 'Kompensation | (Verpackungseinheit unterschiedlich)' AS zcgadv_bez,
 22 AS spr_id;