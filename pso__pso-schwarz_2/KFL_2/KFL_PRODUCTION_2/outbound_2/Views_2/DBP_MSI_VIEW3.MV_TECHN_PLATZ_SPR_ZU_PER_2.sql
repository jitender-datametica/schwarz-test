-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_techn_platz_spr_zu_per_2(USERID STRING) AS SELECT V01.techn_platz_id,
 V01.spr_id,
 V01.dat_von,
 V01.dat_bis,
 V01.tech_platz_bez
FROM kfl_production_dbp_view.v_techn_platz_spr_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_2(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.dat_bis = DATE '9999-12-31';