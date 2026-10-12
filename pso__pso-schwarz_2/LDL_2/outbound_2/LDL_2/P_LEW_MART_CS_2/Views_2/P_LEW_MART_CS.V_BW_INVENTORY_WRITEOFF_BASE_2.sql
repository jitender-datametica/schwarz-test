/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_WRITEOFF_BASE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_inventory_writeoff_base_2 (client_id, iso_cd, cy_month, kpi_aspect,
aspect_id, wh_id, v_id, currency_iso_cd, abschriften_betrieb, abschriften_filiale, abschriften_warengeschaeft,
restantenverwertung, rabattierung) AS SELECT abschriften.client_id,
 CTY.src_country_lidl_cd AS iso_cd,
 abschriften.cy_month,
  CASE
  WHEN abschriften.aspect_id = 1
  THEN 'BGES'
  ELSE 'VGES'
  END AS kpi_aspect,
 abschriften.aspect_id,
 abschriften.wh_id,
 abschriften.v_id,
 curr.curr_cd_to AS currency_iso_cd,
  SUM(CASE
    WHEN abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (23)
    THEN abschriften.val
    ELSE 0
    END) + SUM(CASE
    WHEN abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (24)
    THEN abschriften.val
    ELSE 0
    END) AS abschriften_betrieb,
  SUM(CASE
    WHEN abschriften.sfotype_id IN (137, 147) AND abschriften.pcwo_reason_id IN (1, 127, 134, 135)
    THEN abschriften.val
    ELSE 0
    END) + SUM(CASE
    WHEN abschriften.sfotype_id IN (137, 147) AND abschriften.pcwo_reason_id IN (2, 128)
    THEN abschriften.val
    ELSE 0
    END) AS abschriften_filiale,
  SUM(CASE
    WHEN abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (21) OR abschriften.sfotype_id IN (181,
        191) AND abschriften.pcwo_reason_id IN (83)
    THEN abschriften.val
    ELSE 0
    END) + SUM(CASE
    WHEN abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (22, 126)
    THEN abschriften.val
    ELSE 0
    END) AS abschriften_warengeschaeft,
 SUM(CASE
   WHEN abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (22, 126)
   THEN abschriften.val
   ELSE 0
   END) AS restantenverwertung,
 SUM(CASE
   WHEN abschriften.sfotype_id IN (137, 147) AND abschriften.pcwo_reason_id IN (5)
   THEN abschriften.val
   ELSE 0
   END) AS rabattierung
FROM (SELECT AGG.client_id,
    CASE
    WHEN OSM.aspect_id = 1
    THEN STW.loc_sid_wh
    ELSE OSM.wh_loc_sid
    END AS wh_loc_sid,
   STW.orig_wh_nr AS wh_id,
    CASE
    WHEN OSM.aspect_id = 2
    THEN WH.src_wh_id
    ELSE NULL
    END AS v_id,
   AGG.cy_month,
   OSM.aspect_id,
   AGG.sfotype_id,
   AGG.pcwo_reason_id,
   AGG.sfo_total_rtl_rl_net_val_asis AS val
  FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_2 AS AGG
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act_2 AS OSM ON AGG.client_id = OSM.client_id AND AGG.loc_sid_store
      = OSM.st_loc_sid
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_merge_act_2 AS OWM ON OSM.client_id = OWM.client_id AND OSM.wh_loc_sid = OWM
      .wh_loc_sid AND OSM.aspect_id = OWM.aspect_id
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON OSM.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_valid_to = PARSE_DATE('%m/%d/%Y'
       , '12/30/9999') AND OSM.client_id IS NOT NULL
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON AGG.booking_dat = CAL.cal_dt AND CAL.busyear_seq IN (0, - 1
      )
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_2 AS STW ON AGG.client_id = STW.client_id AND OSM.move_to_st_loc_sid =
      STW.loc_sid_store AND STW.dwh_valid_to = PARSE_DATE('%m/%d/%Y', '12/30/9999')
  WHERE AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (23, 24, 21, 22, 126)
   OR AGG.sfotype_id IN (137, 147) AND AGG.pcwo_reason_id IN (1, 127, 134, 135, 2, 128, 5)) AS abschriften_2
 INNER JOIN (SELECT CURR.exchange_rate,
   CURR.client_id,
   CURR.curr_cd_to
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CURR
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON CURR.x_rate_type_sid = ERT.x_rate_type_sid AND ERT.src_kurst
        = '@BEWE' AND CURR.curr_cd_from = 'EUR' AND CURR.dwh_valid_to = PARSE_DATE('%m/%d/%Y', '12/30/9999')
  WHERE CURRENT_DATE BETWEEN CURR.active_from_dt AND CURR.active_to_dt) AS curr ON abschriften.client_id = curr.client_id
  
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CTY ON abschriften.client_id = CTY.country_sid
GROUP BY abschriften.client_id,
 iso_cd,
 abschriften.cy_month,
 abschriften.wh_id,
 abschriften.v_id,
 abschriften.wh_loc_sid,
 currency_iso_cd,
 abschriften.aspect_id,
 curr.exchange_rate;