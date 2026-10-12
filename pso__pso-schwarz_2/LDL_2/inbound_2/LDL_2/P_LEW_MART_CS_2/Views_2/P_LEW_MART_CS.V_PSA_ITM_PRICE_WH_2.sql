/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_ITM_PRICE_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_ITM_PRICE_WH_2
(
  client_id
, item_id
, wh_id
, calendar_dt
, price_retail
, price_retail_net
, price_retail_eur
, price_retail_net_eur
)
AS
   /* Only Wawi */
   SELECT
   price.client_id,
   price.item_id,
   whmap.src_orig_wh_nr  AS wh_id,
   price.dat_calendar    AS calendar_dt,
   price.price_retail,
   price.price_retail_net AS  price_retail_net,
   price.price_retail / cry.rate_currency_ctr_to_eur AS price_retail_eur,
   price.price_retail_net/ cry.rate_currency_ctr_to_eur AS price_retail_net_eur
   FROM
   (SELECT
   sub1.client_id,
   sub1.wh_loc_sid,
   sub1.item_id,
   sub1.dat_calendar,
   sub1.pricegroup_id,
   sub1.priority,
   sub1.price_retail,
   sub1.price_retail_net,
   ROW_NUMBER () OVER (PARTITION BY client_id, wh_loc_sid, item_id, dat_calendar ORDER BY priority DESC NULLS LAST) AS rang
   FROM
   (
-- Landespreise
SELECT
   pg3.client_id,
   pg3.wh_loc_sid,
   p3.item_id,
   p3.dat_calendar,
   pg3.pricegroup_id,
   pg3.priority,
   p3.price_retail,
   p3.price_retail_net
   FROM
   (SELECT
   ip3.client_id,
   ip3.item_sid AS item_id,
   cal3.cal_dt AS dat_calendar,
   ip3.pricegroup_id,
   ip3.price_retail,
   ip3.price_retail_net
   FROM p_lew_core_ac.v_wawi_itm_price_2 AS ip3
   INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_2 AS a12
   ON   ip3.client_id = a12.client_id
   AND  ip3.item_sid   = a12.item_sid
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal3
   ON  cal3.cal_dt BETWEEN ip3.dat_valid_from AND ip3.dat_valid_until
   AND cal3.cal_dt <= Current_Date
   AND cal3.cal_dt >= '2007-01-01'
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 mig      /* Harald Wieber Join hinzugefügt bzgl der Abgrenzung zu migrierten Client nach SAP */
   ON mig.client_id = ip3.client_id
   AND mig.active_fg = 0                                    /* Nicht migriert */ /* Nicht migriert */
   ) p3
   INNER JOIN
   (SELECT
   ipg3.client_id,
   ipg3.wh_loc_sid,
   ipg3.st_loc_sid,
   cal3.cal_dt       AS dat_calendar,
   ipg3.pricegroup_id,
   ipg3.priority
   FROM p_lew_core_ac.v_wawi_itm_pricegroup_2 AS ipg3
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal3
   ON  cal3.cal_dt BETWEEN ipg3.dat_valid_from AND ipg3.dat_valid_until
   AND cal3.cal_dt <= Current_Date
   AND cal3.cal_dt >= '2007-01-01'
   LEFT OUTER JOIN p_lew_core_ac.v_location_2 AS s
   ON ipg3.st_loc_sid=s.loc_sid
   AND ipg3.client_id=s.client_id

   WHERE s.src_store_id= 0
   AND   ipg3.language_id <> 7
) pg3
   ON  pg3.client_id     = p3.client_id
   AND pg3.dat_calendar  = p3.dat_calendar
   AND pg3.pricegroup_id = p3.pricegroup_id

   UNION ALL
   -- Lagerpreise
   SELECT
   pg2.client_id,
   pg2.wh_loc_sid,
   p2.item_id,
   p2.dat_calendar,
   pg2.pricegroup_id,
   pg2.priority,
   p2.price_retail,
   p2.price_retail_net
   FROM
   (SELECT
   ip2.client_id,
   ip2.item_sid      AS item_id,
   cal2.cal_dt       AS dat_calendar,
   ip2.pricegroup_id,
   ip2.price_retail,
   ip2.price_retail_net
   FROM p_lew_core_ac.v_wawi_itm_price_2 AS ip2
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_2 AS a12
   ON  ip2.client_id = a12.client_id
   AND ip2.item_sid   = a12.item_sid
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal2
   ON  cal2.cal_dt BETWEEN ip2.dat_valid_from AND ip2.dat_valid_until
   AND cal2.cal_dt <= Current_Date
   AND cal2.cal_dt >= '2007-01-01'
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 mig      /* Harald Wieber Join hinzugefügt bzgl der Abgrenzung zu migrierten Client nach SAP */
   ON mig.client_id = ip2.client_id
   AND mig.active_fg = 0                                    /* nicht migriert */ /* nicht migriert */
   ) p2
   INNER JOIN
   (SELECT
   ipg2.client_id,
   ipg2.wh_loc_sid,
   ipg2.st_loc_sid,
   cal2.cal_dt       AS dat_calendar,
   ipg2.pricegroup_id,
   ipg2.priority
   FROM p_lew_core_ac.v_wawi_itm_pricegroup_2 AS ipg2
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal2
   ON  cal2.cal_dt BETWEEN ipg2.dat_valid_from AND ipg2.dat_valid_until
   AND cal2.cal_dt <= Current_Date
   AND cal2.cal_dt >= '2007-01-01'
   LEFT OUTER JOIN p_lew_core_ac.v_location_2 s
   ON ipg2.st_loc_sid=s.loc_sid
   AND ipg2.client_id=s.client_id

   WHERE s.src_store_id <> 0
   AND (ipg2.client_id, ipg2.st_loc_sid) IN (SELECT
   org.client_id,
   org.st_loc_sid
   FROM p_lew_core_ac.v_wawi_org_store_skey_act_2 AS org
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON org.client_id = wh.client_id
   AND org.wh_loc_sid =  wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1

   WHERE org.orig_store_nr = wh.src_wh_id
 )
AND ipg2.language_id <> 7
) pg2
   ON  pg2.client_id     = p2.client_id
   AND pg2.dat_calendar  = p2.dat_calendar
   AND pg2.pricegroup_id = p2.pricegroup_id
) sub1
) price
   INNER JOIN
   (SELECT
   dt.client_id,
   MIN(CASE WHEN dt.currency_seq_id = 1 THEN dt.rate_currency_exchange ELSE NULL END) AS rate_currency_ctr_to_eur
   FROM
   (SELECT
   cryx.client_id,
   cryx.rate_currency_exchange,
   COUNT(1) OVER (PARTITION BY cryx.client_id ORDER BY CASE WHEN cryx.currency_iso_cd = 'EUR' THEN 1
                                                                              WHEN cryx.currency_iso_cd = cryx.to_currency_iso_cd THEN 2
                                                                              ELSE 3 END, cryx.currency_iso_cd ROWS UNBOUNDED PRECEDING) AS currency_seq_id
   FROM p_lew_core_ac.v_wawi_ref_client_currency_rate_2 cryx
   WHERE Current_Date BETWEEN cryx.dat_rec_start AND cryx.dat_rec_end
   QUALIFY currency_seq_id <= 2
   ) dt
   GROUP BY dt.client_id
) AS cry
   ON  price.client_id = cry.client_id
   INNER JOIN p_lew_core_ac.v_location_2 AS whmap
   ON  price.wh_loc_sid =  whmap.loc_sid

   WHERE price.rang = 1


   UNION ALL
   SELECT
   dwh.client_id,
   dwh.item_sid                          AS item_id,
   whmap2.src_orig_wh_nr                  AS wh_id,
   dwh.dat_calendar,
   dwh.cond_val_eff_calc                 AS price_retail,
   dwh.net_val_eff_calc                  AS  price_retail_net,
   dwh.cond_val_eff_calc / cry2.rate_currency_ctr_to_eur  AS price_retail_eur,
   dwh.net_val_eff_calc/ cry2.rate_currency_ctr_to_eur    AS price_retail_net_eur
   FROM (SELECT
   a.client_id,
   a.item_sid,
   a.loc_sid,
   cal.cal_dt            AS dat_calendar,
   a.cond_val_eff_calc,
   a.net_val_eff_calc,
   a.curr_cd
   FROM p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS a
   INNER JOIN p_lew_bil_ac.v_item_2 AS i
   ON a.client_id = i.client_id
   AND a.item_sid = i.item_sid
   AND i.deleted_fg = 0
   AND i.dwh_actual_fg = 1
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 AS mig
   ON mig.client_id = a.client_id
   AND mig.active_fg = 1
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal
   ON cal.cal_dt BETWEEN a.dwh_valid_from AND a.dwh_valid_to
   AND cal.cal_dt <= CURRENT_DATE
   AND cal.cal_dt >= '2007-01-01'
   ) AS dwh
   INNER JOIN
   (SELECT
   dt.client_id,
   Min(CASE WHEN dt.currency_seq_id = 1 THEN dt.rate_currency_exchange ELSE NULL END) AS rate_currency_ctr_to_eur
   FROM
   (SELECT
   cryx.client_id,
   cryx.rate_currency_exchange,
   COUNT(1) OVER (PARTITION BY cryx.client_id ORDER BY CASE WHEN cryx.currency_iso_cd = 'EUR' THEN 1
                                                                              WHEN cryx.currency_iso_cd = cryx.to_currency_iso_cd THEN 2
                                                                              ELSE 3 END, cryx.currency_iso_cd ROWS UNBOUNDED PRECEDING) AS currency_seq_id
   FROM p_lew_core_ac.v_wawi_ref_client_currency_rate_2 cryx
   WHERE Current_Date BETWEEN cryx.dat_rec_start AND cryx.dat_rec_end
   QUALIFY currency_seq_id <= 2
   ) dt
   GROUP BY dt.client_id
) AS cry2
   ON  dwh.client_id = cry2.client_id
   INNER JOIN p_lew_core_ac.v_location_2 AS whmap2
   ON  dwh.loc_sid =  whmap2.loc_sid

   WHERE whmap2.src_orig_wh_nr IS NOT NULL
   ;