CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_soll_haben (soll_haben_kz, mandant_id) AS SELECT 'S' AS
 soll_haben_kz,
 mandant_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1
UNION ALL
SELECT 'H' AS soll_haben_kz,
 mandant_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;