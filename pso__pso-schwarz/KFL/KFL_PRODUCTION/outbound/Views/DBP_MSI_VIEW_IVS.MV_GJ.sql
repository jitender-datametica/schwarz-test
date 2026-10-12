CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_gj AS SELECT gj,
 akt_gj,
 akt_gj_komplett,
 PARSE_DATE('%Y%m', SUBSTR(CAST(gj AS STRING), 1, 4) || '03') AS dat_gj_beginn,
 DATE_SUB(IF(PARSE_DATE('%Y%m', SUBSTR(SAFE_CAST(gj as STRING), 1, 4) || '03') = LAST_DAY(PARSE_DATE('%Y%m', SUBSTR(SAFE_CAST(gj
         as STRING), 1, 4) || '03')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SUBSTR(SAFE_CAST(gj as STRING), 1, 4) || '03'
       ), INTERVAL 12 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SUBSTR(SAFE_CAST(gj as STRING), 1, 4) || '03'), INTERVAL 12
    MONTH)), INTERVAL 1 DAY) AS dat_gj_ende
FROM kfl_production_dbp_view.v_jahr_gj
WHERE akt_gj BETWEEN - 5 AND 1;