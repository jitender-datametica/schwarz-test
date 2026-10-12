-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_lis_rekl_grund_spr_zu_1(USERID STRING) AS SELECT V01.mandant_id,
 V01.lis_rekl_grund_id,
 V01.spr_id,
 V01.lis_rekl_grund_bez
FROM kfl_production_dbp_view.v_lis_rekl_grund_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id;