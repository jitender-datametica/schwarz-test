CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_monat_letzter_tag (kj, kjmo, dat) AS SELECT kj,
 kjmo,
 MAX(dat) AS dat
FROM kfl_production_dbp_view.v_tag
WHERE dat <= CURRENT_DATE
 AND kj >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY kj,
 kjmo;