CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_zeitentwicklung_2 (zeit_id, zeit_filter_id, tag_2) AS SELECT CAST(ZEITRAUM.gj AS BIGNUMERIC)
 AS zeit_id,
  'GJ' || TRIM(SUBSTR(CAST(ZEITRAUM.akt_gj - EINGABE.akt_gj AS STRING), 1, 39)) AS zeit_filter_id,
 EINGABE.dat AS tag_2
FROM kfl_production_dbp_view.v_tag_2 AS EINGABE
 INNER JOIN kfl_production_dbp_view.v_jahr_gj_2 AS ZEITRAUM ON TRUE
UNION ALL
SELECT ZEITRAUM.kjwo * 10,
  'KW' || TRIM(SUBSTR(CAST(ZEITRAUM.akt_wo - EINGABE.akt_wo AS STRING), 1, 39)) AS zeit_filter_id,
 EINGABE.dat AS tag_2
FROM kfl_production_dbp_view.v_tag_2 AS EINGABE
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS ZEITRAUM ON TRUE
WHERE ZEITRAUM.wtag_id = 7
UNION ALL
SELECT ZEITRAUM.kjmo AS zeit_id,
  'Mon' || TRIM(SUBSTR(CAST(ZEITRAUM.akt_mo - EINGABE.akt_mo AS STRING), 1, 39)) AS zeit_filter_id,
 EINGABE.dat AS tag_2
FROM kfl_production_dbp_view.v_tag_2 AS EINGABE
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS ZEITRAUM ON TRUE;