-- 20230717 staeblern Umstellung auf Session Variable

-- 15.11.2016, AP0006317 - Vor- und Nachlaufpaletten, srom0404 CD-Vorgang lt. Konzept nicht immer gefüllt

-- 26.07.2017, srom0404 Korrektur auf CROSS JOIN, Dummy_2 muss für jedes LAnd_2 in jeder Sprache erzeugt werden

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_cd_typ_spr_zu_2(USERID STRING) AS SELECT T01.mandant_id,
 T01.cd_typ_id,
 T01.spr_id,
 T01.cd_typ_bez
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_cd_typ_spr_zu_2 AS T01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_2(USERID) AS V03 ON T01.spr_id = V03.spr_id;