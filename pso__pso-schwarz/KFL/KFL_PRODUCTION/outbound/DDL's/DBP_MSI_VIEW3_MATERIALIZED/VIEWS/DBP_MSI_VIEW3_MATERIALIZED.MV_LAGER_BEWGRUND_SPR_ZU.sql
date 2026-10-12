-- 20230717 staeblern Umstellung auf Session Variable
 -- AP0014173, srom0404, hist_fg aufgenommen

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_lager_bewgrund_spr_zu(USERID STRING) AS SELECT V01.grund_id,
 V01.spr_id,
 V01.lager_bewart_id,
 V01.mandant_id,
 V01.hist_fg,
 V01.grund_bez
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_lager_bewgrund_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.hist_fg = 0;