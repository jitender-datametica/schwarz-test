CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_ginfo_baujahr_2 AS SELECT DISTINCT baujahr,
 SUBSTR(CAST(baujahr AS STRING), 1, 4) AS baujahr_bez
FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per_2
UNION DISTINCT
SELECT 9999 AS baujahr,
 '' AS baujahr_bez
FROM kfl_production_dbp_view.v_jahr_kj_2;