CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_wtd_adv_week_1 AS SELECT wtd.adv_week_sid,
 wtd.client_id,
 wtd.adv_week_id,
 wtd.wtd_adv_week_sid,
 wtd.wtd_adv_week_id,
 COALESCE(AWR.adv_week_rltd_type_id, - 1) AS adv_week_rltd_type_id
FROM (SELECT 100 * WK.adv_week_id + WK.client_id AS adv_week_sid,
   WK.client_id,
   WK.adv_week_id,
     100 * WKR.adv_week_id + WKR.client_id AS wtd_adv_week_sid,
   WKR.adv_week_id AS wtd_adv_week_id
  FROM ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS WK
   INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS WKR ON WK.client_id = WKR.client_id AND WK.adv_week_id > WKR.adv_week_id
     
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(WK.client_id AS STRING), CAST(WK.adv_week_id AS STRING) ORDER BY WKR.adv_week_id
        IS NULL, WKR.adv_week_id)) <= 53) AS wtd
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_related_1 AS AWR ON wtd.client_id = AWR.client_id AND wtd.adv_week_id =
    AWR.adv_week_id AND wtd.wtd_adv_week_id = AWR.rltd_adv_week_id;