-- CASE WHEN v01.we_message_status_bez IS NULL THEN 1 ELSE 0 END AS fallback_fg,
 -- 20250425 nwag, DE as fallback

-- 13.12.2018, aszu1204, AP0027269, neue View
 -- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_we_message_status_spr_zu_1(USERID STRING) AS SELECT V01_DE.mandant_id,
 V01_DE.we_message_status_id,
 V02.spr_id,
 COALESCE(V01.we_message_status_bez, V01_DE.we_message_status_bez) AS we_message_status_bez
FROM kfl_production_dbp_view.v_we_message_status_spr_zu_1 AS V01_DE
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_we_message_status_spr_zu_1 AS V01 ON V01_DE.mandant_id = V01.mandant_id AND V01_DE.we_message_status_id
     = V01.we_message_status_id AND V02.spr_id = V01.spr_id
WHERE V01_DE.spr_id = 22
UNION ALL
SELECT mandant_id,
 - 1 AS we_message_status_id,
 spr_id,
 '-' AS we_message_status_bez
FROM kfl_production_dbp_view.v_we_message_status_spr_zu_1 AS V01
WHERE we_message_status_id = 0;