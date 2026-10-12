-- 2022.02.03, dknop, initial
 -- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_monat_kj_spr_zu_1(USERID STRING) AS
SELECT V01.kjmo,
 V01.kj,
 V01.mo_kj,
 MAX(TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))) AS kjmo_bez
FROM kfl_production_dbp_view.v_monat_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS V02 ON V01.mo_kj = V02.mo_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V03 ON V02.spr_id = V03.spr_id
GROUP BY V01.kjmo,
 V01.kj,
 V01.mo_kj;