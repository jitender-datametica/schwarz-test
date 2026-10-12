CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_monat_letzter_tag_2 AS
SELECT kj,
 kjmo,
 MAX(dat) AS dat
FROM kfl_production_dbp_view.v_tag_2
WHERE dat <= CURRENT_DATE
 AND kj >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY kj,
 kjmo;