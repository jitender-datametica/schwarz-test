CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_zeitentwicklung_spr_zu (zeit_id, spr_id, zeitentwicklung_bez)
AS SELECT kjmo AS zeit_id,
 22 AS spr_id,
 FORMAT_DATE('%b, %Y', dat) AS zeitentwicklung_bez
FROM kfl_production_dbp_view.v_tag
WHERE EXTRACT(DAY FROM dat) = 1
UNION ALL
SELECT gj AS zeit_id,
 22 AS spr_id,
  'GJ ' || TRIM(SUBSTR(CAST(gj AS STRING), 1, 39)) AS zeitentwicklung_bez
FROM kfl_production_dbp_view.v_jahr_gj
UNION ALL
SELECT kjwo * 10 AS zeit_id,
 22 AS spr_id,
    'KW ' || SUBSTR(TRIM(SUBSTR(CAST(kjwo AS STRING), 1, 39)), 5) || ' ' || TRIM(SUBSTR(CAST(kj AS STRING), 1, 39)) AS
 zeit_bez
FROM kfl_production_dbp_view.v_tag
WHERE wtag_id = 7;