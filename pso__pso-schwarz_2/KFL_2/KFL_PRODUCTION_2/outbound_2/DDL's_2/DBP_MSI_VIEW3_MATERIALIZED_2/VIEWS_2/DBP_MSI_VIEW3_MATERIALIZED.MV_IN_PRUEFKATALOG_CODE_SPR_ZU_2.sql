-- v011
 -- 10.02.2016, srom0404, AP0004702 Dummy_2 Pruefcode/Text
 -- v01

-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_in_pruefkatalog_code_spr_zu_2(USERID STRING) AS SELECT v01.mandant_id,
 v01.katalogart_id,
 v01.codegruppe_id,
 v01.pruefcode_id,
 v01.version_id,
 v01.spr_id,
 v01.qtxt_code
FROM (SELECT mandant_id,
   katalogart_id,
    CASE
    WHEN codegruppe_id = 'KLOAUTM'
    THEN SUBSTR(codegruppe_id, 1, 3)
    ELSE codegruppe_id
    END AS codegruppe_id,
   pruefcode_id,
   version_id,
   spr_id,
   qtxt_code
  FROM kfl_production_dbp_view.v_in_pruefkatalog_code_spr_zu_2 AS V01_1) AS v01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_2(USERID) AS V02 ON v01.spr_id = V02.spr_id
GROUP BY v01.mandant_id,
 v01.katalogart_id,
 v01.codegruppe_id,
 v01.pruefcode_id,
 v01.version_id,
 v01.spr_id,
 v01.qtxt_code
UNION DISTINCT
SELECT mandant_id,
 '0' AS katalogart_id,
 '-1' AS codegruppe_id,
 '-1' AS pruefcode_id,
 '-1' AS version_id,
 spr_id,
 'DWH - no reason' AS qtxt_code
FROM kfl_production_dbp_view.v_mandant_spr_zu_2 AS V03;