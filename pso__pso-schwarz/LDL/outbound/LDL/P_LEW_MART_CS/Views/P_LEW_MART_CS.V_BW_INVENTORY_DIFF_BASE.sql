/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_DIFF_BASE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* inventurdifferenzenlautsic */ /* inventurdifferenz_procent */ /* inventurumsatzlautsic */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_inventory_diff_base (client_id, iso_cd, cy_month, kpi_aspect, wh_id,
wh_descr, v_id, v_descr, currency_iso_cd, inventory_diff_sic_val, inventory_turnover_sic_val, inventory_diff_percent) AS
/* #----------------------------------------------------------------------------
   #WAWI Laender
   #---------------------------------------------------------------------------- */
/* #----------------------------------------------------------------------------
 #SAP Laender
 #---------------------------------------------------------------------------- */
SELECT client_id,
 iso_cd,
 cy_month,
 aspect_cd AS kpi_aspect,
 wh_id,
 UPPER(SUBSTR(wh_descr, 1, 3)) AS wh_descr,
 v_id,
 UPPER(SUBSTR(v_descr, 1, 3)) AS v_descr,
 currency_iso_cd,
 inventory_diff_sic_val,
 inventory_turnover_sic_val,
 inventory_diff_percent
FROM (SELECT INVS.client_id,
    CL.src_country_lidl_cd AS iso_cd,
    CAL.busyear,
    CAL.cy_month,
    MAX(CASE
      WHEN ASP.aspect_id = 1
      THEN WH.src_wh_id
      ELSE 0
      END) OVER (PARTITION BY CAST(WHMA.parent_wh_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING) AS wh_id,
    MAX(CASE
      WHEN ASP.aspect_id = 1
      THEN WHMA.wh_desc
      ELSE ''
      END) OVER (PARTITION BY CAST(WHMA.parent_wh_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING) AS wh_descr,
     CASE
     WHEN ASP.aspect_id = 1
     THEN 'BGES'
     ELSE 'VGES'
     END AS aspect_cd,
     CASE
     WHEN ASP.aspect_id = 2
     THEN WH.src_wh_id
     ELSE NULL
     END AS v_id,
     CASE
     WHEN ASP.aspect_id = 2
     THEN WHMA.wh_desc
     ELSE ''
     END AS v_descr,
    SUM(INVS.diff_net_inv) AS inventory_diff_sic_val,
    SUM(INVS.val_retail_store_net_inv_stc) AS inventory_turnover_sic_val,
    CRY.curr_cd_to AS currency_iso_cd,
    IFNULL(SUM(INVS.diff_net_inv) / CASE
        WHEN SUM(INVS.val_retail_store_net_inv_stc) = 0
        THEN NULL
        ELSE SUM(INVS.val_retail_store_net_inv_stc)
        END * 100, 0) AS inventory_diff_percent
   FROM ldl_p_lew_core_ac.v_wawi_inv_store AS INVS
    INNER JOIN ldl_p_lew_core_ac.v_client AS CL ON INVS.client_id = CL.client_id
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON INVS.dat_formdate = CAL.cal_dt
    INNER JOIN ldl_p_lew_core_ac.v_cal_busyear AS BYR ON CAL.busyear = BYR.busyear AND BYR.cy_by_seq IN (0, - 1)
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act AS ASP ON INVS.client_id = ASP.client_id AND INVS.st_loc_sid
       = ASP.st_loc_sid
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_merge_act AS WHMA ON ASP.client_id = WHMA.client_id AND ASP.wh_loc_sid =
       WHMA.wh_loc_sid AND ASP.aspect_id = WHMA.aspect_id
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON WHMA.client_id = WH.client_id AND WHMA.wh_loc_sid = WH.loc_sid_wh
     AND CURRENT_DATE BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON INVS.client_id = CRY.client_id AND CRY.curr_cd_from
         = 'EUR' /* Filtering for Home currency */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
       /* latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
      /* latest history (version) */
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid =
       ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
   WHERE
     /* #----------------------------------------------------------------------------
 #Diese Teilmenge stellt wahrscheinlich die Vollinventuren dar ggue. den ausgeblendeten Teilinventuren (mit inv_fg=73 ?)
 #71:Inventur
 #73:Tageszaehlung
 #---------------------------------------------------------------------------- */
     INVS.inv_fg = 71
    AND
     /* #----------------------------------------------------------------------------
 #Die Einschraenkung status_inv_sic = 64 kann nicht interpretiert werden. Es gibt noch Auspraegungen ""-99"" und ""0"" ohne Hinweis auf die Bedeutung.
 #=> Einfache Uebernahme aus der Alt-View.
 #64: Inventur ist gespeichert und gebucht
 #---------------------------------------------------------------------------- */
     INVS.status_inv_sic = 64
     /* #----------------------------------------------------------------------------
 #moeglicherweise wegzulassende Einschaenkungen - falls obige Kommentierung falsch sein sollte, bitte wieder hereinnehmen
 #---------------------------------------------------------------------------- */
     
    AND ASP.test_store_fg = 0
    AND ASP.mis_store_active_fg = 1
   GROUP BY INVS.client_id,
    iso_cd,
    CAL.busyear,
    CAL.cy_month,
    WH.src_wh_id,
    WHMA.wh_desc,
    ASP.aspect_id,
    CRY.exchange_rate,
    currency_iso_cd,
    WHMA.parent_wh_loc_sid
   UNION ALL
   SELECT AISD.client_id,
    CL.src_country_lidl_cd AS iso_cd,
    CAL.busyear,
    AISD.cy_month,
    MAX(CASE
      WHEN ASP.aspect_id = 1
      THEN WH.src_wh_id
      ELSE 0
      END) OVER (PARTITION BY CAST(WHMA.parent_wh_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING) AS wh_id,
    MAX(CASE
      WHEN ASP.aspect_id = 1
      THEN WHMA.wh_desc
      ELSE ''
      END) OVER (PARTITION BY CAST(WHMA.parent_wh_loc_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING) AS wh_descr,
     CASE
     WHEN ASP.aspect_id = 1
     THEN 'BGES'
     ELSE 'VGES'
     END AS aspect_cd,
     CASE
     WHEN ASP.aspect_id = 2
     THEN WH.src_wh_id
     ELSE NULL
     END AS v_id,
     CASE
     WHEN ASP.aspect_id = 2
     THEN WHMA.wh_desc
     ELSE ''
     END AS v_descr,
    SUM(COALESCE(AISD.diff_inv_stc_calc_net_val, 0) + COALESCE(AISD.diff_inv_return_net_val, 0)) AS
    inventory_diff_sic_val,
    SUM(COALESCE(AISD.retail_net_val, 0)) AS inventory_turnover_sic_val,
    CRY.curr_cd_to AS currency_iso_cd,
    IFNULL(SUM(COALESCE(AISD.diff_inv_stc_calc_net_val, 0) + COALESCE(AISD.diff_inv_return_net_val, 0)) / CASE
        WHEN SUM(COALESCE(AISD.retail_net_val, 0)) = 0
        THEN NULL
        ELSE SUM(COALESCE(AISD.retail_net_val, 0))
        END * 100, 0) AS inventory_diff_percent
   FROM ldl_p_lew_bil_ac.v_agg_item_store_day AS AISD
    INNER JOIN ldl_p_lew_core_ac.v_client AS CL ON AISD.client_id = CL.client_id
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON AISD.dwh_cal_dt = CAL.cal_dt
    INNER JOIN ldl_p_lew_core_ac.v_cal_busyear AS BYR ON CAL.busyear = BYR.busyear AND BYR.cy_by_seq IN (0, - 1)
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act AS ASP ON AISD.client_id = ASP.client_id AND AISD.loc_sid_store
       = ASP.st_loc_sid
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_merge_act AS WHMA ON ASP.client_id = WHMA.client_id AND ASP.wh_loc_sid =
       WHMA.wh_loc_sid AND ASP.aspect_id = WHMA.aspect_id
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON WHMA.client_id = WH.client_id AND WHMA.wh_loc_sid = WH.loc_sid_wh
     AND CURRENT_DATE BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON AISD.client_id = CRY.client_id AND CRY.curr_cd_from
         = 'EUR' /* Filtering for Home currency */ AND CURRENT_DATE BETWEEN CRY.active_from_dt AND CRY.active_to_dt
       /* latest rate (point in history) */ AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
      /* latest history (version) */
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS ERT ON CRY.client_id = ERT.client_id AND CRY.x_rate_type_sid =
       ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
   GROUP BY AISD.client_id,
    iso_cd,
    CAL.busyear,
    AISD.cy_month,
    WH.src_wh_id,
    WHMA.wh_desc,
    ASP.aspect_id,
    CRY.exchange_rate,
    currency_iso_cd,
    WHMA.parent_wh_loc_sid) AS inv_base;