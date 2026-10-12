-- 13.12.2018, aszu1204, AP0027269, neue View
 -- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_transportstatus_spr_zu_1(USERID STRING) AS SELECT V01.mandant_id,
 V01.transportstatus_id,
 V01.spr_id,
 V01.transportstatus_bez
FROM kfl_production_dbp_view.v_transportstatus_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id;