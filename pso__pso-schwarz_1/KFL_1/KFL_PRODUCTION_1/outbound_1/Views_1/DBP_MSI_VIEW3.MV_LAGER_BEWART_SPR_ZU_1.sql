-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_lager_bewart_spr_zu_1(USERID STRING) AS SELECT V01.lager_bewart_id,
 V01.bewart_bez,
 V01.mandant_id,
 V01.spr_id
FROM kfl_production_dbp_msi_view3.tbl_mv_lager_bewart_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE -- keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
 V01.system_id NOT IN (2, 17, 28, 32, 48, 53);