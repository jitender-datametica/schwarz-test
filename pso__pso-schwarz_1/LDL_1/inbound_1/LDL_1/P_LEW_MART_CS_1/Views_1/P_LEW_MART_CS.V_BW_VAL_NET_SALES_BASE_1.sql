/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_SALES_BASE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_VAL_NET_SALES_BASE_1
(
  client_id
 ,iso_cd
 ,busyear
 ,cy_month
 ,kpi_aspect
 ,wh_id
 ,wh_descr
 ,v_id
 ,v_descr
 ,currency_iso_cd
 ,turnover_wh_month_val               /* Total turnover Warehouse per month EJR net */
 ,turnover_wh_country_by_val          /* Total turnover Warehouse Business Year */
 ,turnover_country_month_val          /* Total turnover Country_1 per month */
 ,wh_country_month_percent            /* Ratio% per level country_1/month, BGES/month, VGES/month */
 )
AS
(SELECT
agg.client_id                                                                                                                            AS client_id,
cl.src_country_lidl_cd                                                                                                                   AS iso_cd,
byr.busyear                                                                                                                              AS busyear,
agg.cy_month                                                                                                                             AS cy_month,
(CASE WHEN agg.aspect_id = 1 THEN 'BGES' ELSE 'VGES' END)                                                                                AS kpi_aspect,
MAX(CASE WHEN agg.aspect_id = 1 THEN loc.src_wh_id ELSE 0 END) OVER (PARTITION BY whma.parent_wh_loc_sid )                                    AS wh_id,
UPPER(SUBSTRING(MAX(CASE WHEN agg.aspect_id = 1 THEN whma.wh_desc ELSE '' END) OVER (PARTITION BY whma.parent_wh_loc_sid ), 1, 3))     AS wh_descr,
(CASE WHEN agg.aspect_id = 2 THEN loc.src_wh_id ELSE null END)                                                                           AS v_id,
UPPER(SUBSTRING((CASE WHEN agg.aspect_id = 2 THEN whma.wh_desc ELSE '' END), 1, 3))                                              AS v_descr,
cry.curr_cd_to                                                                                                                           AS currency_iso_cd,
ROUND(SUM(agg.sales_net_val) + SUM(agg.return_net_val),2)                                    AS turnover_wh_month_val               /* Total turnover Warehouse per month EJR net */,
ROUND(SUM(turnover_wh_month_val) OVER (PARTITION BY agg.client_id,agg.aspect_id,cry.curr_cd_to,byr.busyear),2)                           AS turnover_wh_country_by_val          /* Total turnover Warehouse Business Year */,
ROUND(SUM(turnover_wh_month_val) OVER (PARTITION BY agg.client_id,agg.aspect_id,agg.cy_month,cry.curr_cd_to),2)                          AS turnover_country_month_val          /* Total turnover Country_1 per month */,
ROUND((turnover_wh_month_val /NULLIF( turnover_country_month_val, 0)) * 100,2)                                                           AS wh_country_month_percent            /* Ratio% per level country_1/month, BGES/month, VGES/month */
FROM p_lew_bil_ac.v_agg_pos_wh_org_day_item_asis_1 AS agg
INNER JOIN p_lew_core_ac.v_client_1 AS cl
ON agg.client_id = cl.client_id
INNER JOIN p_lew_core_ac.v_wawi_org_wh_merge_act_1 AS whma
ON whma.client_id  = agg.client_id
AND whma.wh_loc_sid = agg.loc_sid_wh
AND whma.aspect_id  = agg.aspect_id
 /*
#------------------------------------------------------------------------------
#Laut Anforderungen letztes Geschaeftsjahr und dieses Geschaeftsjahr soll selektiert werden
#------------------------------------------------------------------------------
*/
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
ON agg.dwh_cal_dt = cal.cal_dt
INNER JOIN p_lew_core_ac.v_cal_busyear_1 AS byr
ON byr.busyear = cal.busyear
AND byr.cy_by_seq IN (0,-1)
INNER JOIN p_lew_core_ac.v_location_1 AS loc
ON agg.client_id = loc.client_id
AND agg.loc_sid_wh = loc.loc_sid
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
ON agg.client_id = cry.client_id
AND cry.curr_cd_from = 'EUR' /* Filtering for Home currency */
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt /* latest rate (point in history) */
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to /* latest history (version) */
/*
#------------------------------------------------------------------------------
#Einschraenkung auf relevanten Kurstyp
#------------------------------------------------------------------------------
*/
INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS ert
ON ert.client_id = cry.client_id
AND ert.x_rate_type_sid = cry.x_rate_type_sid
AND ert.src_kurst = '@BEWE'
INNER JOIN p_lew_core_ac.v_item_map_key_1 AS itmp
ON itmp.client_id = agg.client_id
AND itmp.item_sid = agg.item_sid

GROUP BY
 agg.client_id
,cl.src_country_lidl_cd
,agg.cy_month
,agg.aspect_id
,loc.src_wh_id
,cry.curr_cd_to
,cry.exchange_rate
,byr.busyear
,whma.wh_desc
,whma.parent_wh_loc_sid
)
;



