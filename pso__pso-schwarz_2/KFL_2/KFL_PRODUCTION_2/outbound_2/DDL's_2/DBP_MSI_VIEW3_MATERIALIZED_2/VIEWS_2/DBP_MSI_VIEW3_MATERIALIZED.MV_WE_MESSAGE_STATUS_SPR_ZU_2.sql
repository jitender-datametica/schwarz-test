CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_we_message_status_spr_zu_2(USERID STRING) AS SELECT V01_DE.mandant_id,
 V01_DE.we_message_status_id,
 V02.spr_id,
 COALESCE(V01.we_message_status_bez, V01_DE.we_message_status_bez) AS we_message_status_bez
FROM kfl_production_dbp_view.v_we_message_status_spr_zu_2 AS V01_DE
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_2(USERID) AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_we_message_status_spr_zu_2 AS V01 ON V01_DE.mandant_id = V01.mandant_id AND V01_DE.we_message_status_id
     = V01.we_message_status_id AND V02.spr_id = V01.spr_id
WHERE V01_DE.spr_id = 22
UNION ALL
SELECT mandant_id,
 -1 AS we_message_status_id,
 spr_id,
 '-' AS we_message_status_bez
FROM kfl_production_dbp_view.v_we_message_status_spr_zu_2 AS V01
WHERE we_message_status_id = 0;