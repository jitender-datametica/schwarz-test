-- 20250425 nwag, DE as fallback
 -- 20230717 staeblern Umstellung auf Session Variable

-- 03.12.2018, mkub1811, AP0027269, neue View

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_kritische_zone_status_spr_zu_1(USERID STRING) AS SELECT V01_DE.mandant_id,
 V01_DE.kritische_zone_status_id,
 V02.spr_id,
 COALESCE(V01.kritische_zone_status_bez, V01_DE.kritische_zone_status_bez) AS kritische_zone_status_bez
FROM kfl_production_dbp_view.v_kritische_zone_status_spr_zu_1 AS V01_DE
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_kritische_zone_status_spr_zu_1 AS V01 ON V01_DE.mandant_id = V01.mandant_id AND
    V01_DE.kritische_zone_status_id = V01.kritische_zone_status_id AND V02.spr_id = V01.spr_id
WHERE V01_DE.spr_id = 22;