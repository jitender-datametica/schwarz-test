CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_l_soll_haben_1 AS
SELECT 'S' AS soll_haben_kz,
 mandant_id
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1
UNION ALL
SELECT 'H' AS soll_haben_kz,
 mandant_id
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;