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


/* Harald Wieber CROSS JOIN hinzugefügt bzgl der Abgrenzung zu migrierten Client nach SAP */ -- Landespreise

/* Harald Wieber CROSS JOIN hinzugefügt bzgl der Abgrenzung zu migrierten Client nach SAP */ /* Only Wawi */
-- Lagerpreise
 CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_itm_price_wh_2 (client_id, item_id, wh_id, calendar_dt,
price_retail, price_retail_net, price_retail_eur, price_retail_net_eur) AS SELECT price.client_id,
 price.item_id,
 WHMAP.src_orig_wh_nr AS wh_id,
 price.dat_calendar AS calendar_dt,
 price.price_retail,
 price.price_retail_net,
  price.price_retail / cry.rate_currency_ctr_to_eur AS price_retail_eur,
  price.price_retail_net / cry.rate_currency_ctr_to_eur AS price_retail_net_eur
FROM (SELECT client_id,
   wh_loc_sid,
   item_id,
   dat_calendar,
   pricegroup_id,
   priority,
   price_retail,
   price_retail_net,
   ROW_NUMBER() OVER (PARTITION BY client_id, wh_loc_sid, CAST(item_id AS STRING), dat_calendar ORDER BY priority
      IS NULL, priority) AS rang
  FROM (SELECT pg3.client_id,
      pg3.wh_loc_sid,
      p3.item_id,
      p3.dat_calendar,
      pg3.pricegroup_id,
      pg3.priority,
      p3.price_retail,
      p3.price_retail_net
     FROM (SELECT IP3.client_id,
        IP3.item_sid AS item_id,
        CAL3.cal_dt AS dat_calendar,
        IP3.pricegroup_id,
        IP3.price_retail,
        IP3.price_retail_net
       FROM ldl_p_lew_core_ac.v_wawi_itm_price_2 AS IP3
        INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS A12 ON IP3.client_id = A12.client_id AND IP3.item_sid = A12
          .item_sid
        INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL3 ON CAL3.cal_dt BETWEEN IP3.dat_valid_from AND IP3.dat_valid_until
            AND CAL3.cal_dt <= CURRENT_DATE AND CAL3.cal_dt >= DATE '2007-01-01'
        INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON IP3.client_id = MIG.client_id AND MIG.active_fg =
          0 /* Nicht migriert */ /* Nicht migriert */) AS p3
      INNER JOIN (SELECT IPG3.client_id,
        IPG3.wh_loc_sid,
        IPG3.st_loc_sid,
        CAL30.cal_dt AS dat_calendar,
        IPG3.pricegroup_id,
        IPG3.priority
       FROM ldl_p_lew_core_ac.v_wawi_itm_pricegroup_2 AS IPG3
        INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL30 ON CAL30.cal_dt BETWEEN IPG3.dat_valid_from AND IPG3.dat_valid_until
            AND CAL30.cal_dt <= CURRENT_DATE AND CAL30.cal_dt >= DATE '2007-01-01'
        LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS S ON IPG3.st_loc_sid = S.loc_sid AND IPG3.client_id = S.client_id
       WHERE S.src_store_id = 0
        AND IPG3.language_id <> 7) AS pg3 ON p3.client_id = pg3.client_id AND p3.dat_calendar = pg3.dat_calendar AND p3
        .pricegroup_id = pg3.pricegroup_id
     UNION ALL
     SELECT pg2.client_id,
      pg2.wh_loc_sid,
      p2.item_id,
      p2.dat_calendar,
      pg2.pricegroup_id,
      pg2.priority,
      p2.price_retail,
      p2.price_retail_net
     FROM (SELECT IP2.client_id,
        IP2.item_sid AS item_id,
        CAL2.cal_dt AS dat_calendar,
        IP2.pricegroup_id,
        IP2.price_retail,
        IP2.price_retail_net
       FROM ldl_p_lew_core_ac.v_wawi_itm_price_2 AS IP2
        INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS A12 ON IP2.client_id = A12.client_id AND IP2.item_sid = A12.item_sid
          
        INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL2 ON CAL2.cal_dt BETWEEN IP2.dat_valid_from AND IP2.dat_valid_until
            AND CAL2.cal_dt <= CURRENT_DATE AND CAL2.cal_dt >= DATE '2007-01-01'
        INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON IP2.client_id = MIG.client_id AND MIG.active_fg =
          0 /* nicht migriert */ /* nicht migriert */) AS p2
      INNER JOIN (SELECT IPG2.client_id,
        IPG2.wh_loc_sid,
        IPG2.st_loc_sid,
        CAL20.cal_dt AS dat_calendar,
        IPG2.pricegroup_id,
        IPG2.priority
       FROM ldl_p_lew_core_ac.v_wawi_itm_pricegroup_2 AS IPG2
        INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL20 ON CAL20.cal_dt BETWEEN IPG2.dat_valid_from AND IPG2.dat_valid_until
            AND CAL20.cal_dt <= CURRENT_DATE AND CAL20.cal_dt >= DATE '2007-01-01'
        LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS S ON IPG2.st_loc_sid = S.loc_sid AND IPG2.client_id = S.client_id
       WHERE S.src_store_id <> 0
        AND (CAST(IPG2.client_id AS BIGNUMERIC), CAST(IPG2.st_loc_sid AS BIGNUMERIC)) IN (SELECT (ORG.client_id, ORG.st_loc_sid
            )
          FROM ldl_p_lew_core_ac.v_wawi_org_store_skey_act_2 AS ORG
           INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON ORG.client_id = WH.client_id AND ORG.wh_loc_sid = WH.loc_sid_wh
               AND WH.dwh_actual_fg = 1
          WHERE ORG.orig_store_nr = WH.src_wh_id)
        AND IPG2.language_id <> 7) AS pg2 ON p2.client_id = pg2.client_id AND p2.dat_calendar = pg2.dat_calendar AND p2
        .pricegroup_id = pg2.pricegroup_id) AS sub1) AS price
 INNER JOIN (SELECT client_id,
   MIN(`A11863`) AS rate_currency_ctr_to_eur
  FROM (SELECT client_id,
      CASE
      WHEN (COUNT(1) OVER (PARTITION BY CAST(client_id AS STRING) ORDER BY CASE
            WHEN currency_iso_cd = 'EUR'
            THEN 1
            WHEN currency_iso_cd = to_currency_iso_cd
            THEN 2
            ELSE 3
            END IS NULL, CASE
            WHEN currency_iso_cd = 'EUR'
            THEN 1
            WHEN currency_iso_cd = to_currency_iso_cd
            THEN 2
            ELSE 3
            END, currency_iso_cd IS NULL, currency_iso_cd ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1
      THEN rate_currency_exchange
      ELSE NULL
      END AS `A11863`
    FROM ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRYX
    WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
    QUALIFY (COUNT(1) OVER (PARTITION BY CAST(client_id AS STRING) ORDER BY CASE
           WHEN currency_iso_cd = 'EUR'
           THEN 1
           WHEN currency_iso_cd = to_currency_iso_cd
           THEN 2
           ELSE 3
           END IS NULL, CASE
           WHEN currency_iso_cd = 'EUR'
           THEN 1
           WHEN currency_iso_cd = to_currency_iso_cd
           THEN 2
           ELSE 3
           END, currency_iso_cd IS NULL, currency_iso_cd ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) <= 2) AS t14
   
  GROUP BY client_id) AS cry ON price.client_id = cry.client_id
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS WHMAP ON price.wh_loc_sid = WHMAP.loc_sid
WHERE price.rang = 1
UNION ALL
SELECT dwh.client_id,
 dwh.item_sid AS item_id,
 WHMAP2.src_orig_wh_nr AS wh_id,
 dwh.dat_calendar,
 dwh.cond_val_eff_calc AS price_retail,
 dwh.net_val_eff_calc AS price_retail_net,
  dwh.cond_val_eff_calc / cry2.rate_currency_ctr_to_eur AS price_retail_eur,
  dwh.net_val_eff_calc / cry2.rate_currency_ctr_to_eur AS price_retail_net_eur
FROM (SELECT A.client_id,
   A.item_sid,
   A.loc_sid,
   CAL.cal_dt AS dat_calendar,
   A.cond_val_eff_calc,
   A.net_val_eff_calc,
   A.curr_cd
  FROM ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS A
   INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS I ON A.client_id = I.client_id AND A.item_sid = I.item_sid AND I.deleted_fg = 0
       AND I.dwh_actual_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON A.client_id = MIG.client_id AND MIG.active_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON CAL.cal_dt BETWEEN A.dwh_valid_from AND A.dwh_valid_to AND
      CAL.cal_dt <= CURRENT_DATE AND CAL.cal_dt >= DATE '2007-01-01') AS dwh
 INNER JOIN (SELECT client_id,
   MIN(`A11863`) AS rate_currency_ctr_to_eur
  FROM (SELECT client_id,
      CASE
      WHEN (COUNT(1) OVER (PARTITION BY CAST(client_id AS STRING) ORDER BY CASE
            WHEN currency_iso_cd = 'EUR'
            THEN 1
            WHEN currency_iso_cd = to_currency_iso_cd
            THEN 2
            ELSE 3
            END IS NULL, CASE
            WHEN currency_iso_cd = 'EUR'
            THEN 1
            WHEN currency_iso_cd = to_currency_iso_cd
            THEN 2
            ELSE 3
            END, currency_iso_cd IS NULL, currency_iso_cd ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1
      THEN rate_currency_exchange
      ELSE NULL
      END AS `A11863`
    FROM ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRYX
    WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
    QUALIFY (COUNT(1) OVER (PARTITION BY CAST(client_id AS STRING) ORDER BY CASE
           WHEN currency_iso_cd = 'EUR'
           THEN 1
           WHEN currency_iso_cd = to_currency_iso_cd
           THEN 2
           ELSE 3
           END IS NULL, CASE
           WHEN currency_iso_cd = 'EUR'
           THEN 1
           WHEN currency_iso_cd = to_currency_iso_cd
           THEN 2
           ELSE 3
           END, currency_iso_cd IS NULL, currency_iso_cd ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) <= 2) AS t22
   
  GROUP BY client_id) AS cry2 ON dwh.client_id = cry2.client_id
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS WHMAP2 ON dwh.loc_sid = WHMAP2.loc_sid
WHERE WHMAP2.src_orig_wh_nr IS NOT NULL;