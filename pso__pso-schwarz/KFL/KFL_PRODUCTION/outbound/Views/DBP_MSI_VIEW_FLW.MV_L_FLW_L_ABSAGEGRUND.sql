CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_absagegrund (mandant_id, absagegrund_id) AS SELECT
 mandant_id,
 absagegrund_id
FROM kfl_production_dbp_view.v_flw_l_absagegrund AS V01
UNION DISTINCT
SELECT mandant_id,
 '-1' AS absagegrund_id
FROM kfl_production_dbp_view.v_mandant AS V02
WHERE mandant_id IN (1, 2);