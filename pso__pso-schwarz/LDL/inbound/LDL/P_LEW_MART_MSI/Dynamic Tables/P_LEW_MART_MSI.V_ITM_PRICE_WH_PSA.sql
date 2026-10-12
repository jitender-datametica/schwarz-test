CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_PRICE_WH_PSA 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*	
 #DescStart#	
 #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
 #DescEnd#	
 */
/* Only Wawi */
SELECT
   price.client_id
   ,price.item_id
   ,whmap.src_orig_wh_nr AS wh_id
   ,price.dat_calendar
   ,price.price_retail
   ,price.price_retail_net AS price_retail_net
   ,price.price_retail / cry.rate_currency_ctr_to_eur AS price_retail_eur
   ,price.price_retail_net / cry.rate_currency_ctr_to_eur AS price_retail_net_eur
FROM
   (
      SELECT
         sub1.*
         ,ROW_NUMBER() OVER (
            PARTITION BY client_id
            ,wh_loc_sid
            ,item_id
            ,dat_calendar
            ORDER BY
               PRIORITY DESC NULLS LAST
         ) AS rang
      FROM
         (
            -- Landespreise	
            SELECT
               PG3.client_id
               ,PG3.wh_loc_sid
               ,P3.item_id
               ,P3.dat_calendar
               ,PG3.pricegroup_id
               ,PG3.priority
               ,P3.price_retail
               ,P3.price_retail_net
            FROM
               (
                  SELECT
                     ip3.client_id
                     ,ip3.item_sid AS item_id
                     ,cal3.dat_calendar
                     ,ip3.pricegroup_id
                     ,ip3.price_retail
                     ,ip3.price_retail_net
                  FROM
                     p_lew_core_ac.v_wawi_itm_price AS ip3
                     INNER JOIN p_lew_core_ac.v_wawi_itm_item_act AS a12 ON ip3.client_id = a12.client_id
                     AND ip3.item_sid = a12.item_sid
                     INNER JOIN p_lew_mart_msi.v_psa_item AS psa ON a12.client_id = psa.client_id
                     AND a12.orig_item_nr = psa.orig_item_nr
                     INNER JOIN p_lew_mart_msi.v_cal_calendarday AS cal3 ON cal3.dat_calendar BETWEEN ip3.dat_valid_from
                     AND ip3.dat_valid_until
                     AND cal3.dat_calendar <= CURRENT_DATE
                     AND cal3.dat_calendar >= '2007-01-01'
                     INNER JOIN p_lew_core_ac.v_client_migration_per mig
                     /* Harald Wieber Join hinzugefügt bzgl der Abgrenzung zu migrierten Client nach SAP */
                     ON mig.client_id = ip3.client_id
                     AND mig.active_fg = 0
                     /* Nicht migriert */
               ) P3
               INNER JOIN (
                  SELECT
                     ipg3.client_id
                     ,ipg3.wh_loc_sid
                     ,ipg3.st_loc_sid
                     ,cal3.dat_calendar
                     ,ipg3.pricegroup_id
                     ,ipg3.priority
                  FROM
                     p_lew_core_ac.v_wawi_itm_pricegroup AS ipg3
                     INNER JOIN p_lew_mart_msi.v_cal_calendarday AS cal3 ON cal3.dat_calendar BETWEEN ipg3.dat_valid_from
                     AND ipg3.dat_valid_until
                     AND cal3.dat_calendar <= CURRENT_DATE
                     AND cal3.dat_calendar >= '2007-01-01'
                     LEFT JOIN p_lew_core_ac.v_location AS s ON ipg3.st_loc_sid = s.loc_sid
                     AND ipg3.client_id = s.client_id
                  WHERE
                     s.src_store_id = 0
                     AND ipg3.language_id <> 7
               ) PG3 ON PG3.client_id = P3.client_id
               AND PG3.dat_calendar = P3.dat_calendar
               AND PG3.pricegroup_id = P3.pricegroup_id
            UNION
            ALL -- Lagerpreise	
            SELECT
               PG2.client_id
               ,PG2.wh_loc_sid
               ,P2.item_id
               ,P2.dat_calendar
               ,PG2.pricegroup_id
               ,PG2.priority
               ,P2.price_retail
               ,P2.price_retail_net
            FROM
               (
                  SELECT
                     ip2.client_id
                     ,ip2.item_sid AS item_id
                     ,cal2.dat_calendar
                     ,ip2.pricegroup_id
                     ,ip2.price_retail
                     ,ip2.price_retail_net
                  FROM
                     p_lew_core_ac.v_wawi_itm_price AS ip2
                     INNER JOIN p_lew_mart_msi.v_itm_item AS a12 ON ip2.client_id = a12.client_id
                     AND ip2.item_sid = a12.item_id
                     INNER JOIN p_lew_mart_msi.v_psa_item AS psa ON a12.client_id = psa.client_id
                     AND a12.orig_item_nr = psa.orig_item_nr
                     INNER JOIN p_lew_mart_msi.v_cal_calendarday AS cal2 ON cal2.dat_calendar BETWEEN ip2.dat_valid_from
                     AND ip2.dat_valid_until
                     AND cal2.dat_calendar <= CURRENT_DATE
                     AND cal2.dat_calendar >= '2007-01-01'
                     INNER JOIN p_lew_core_ac.v_client_migration_per mig
                     /* Harald Wieber Join hinzugefügt bzgl der Abgrenzung zu migrierten Client nach SAP */
                     ON mig.client_id = ip2.client_id
                     AND mig.active_fg = 0
                     /* nicht migriert */
               ) P2
               INNER JOIN (
                  SELECT
                     ipg2.client_id
                     ,ipg2.wh_loc_sid
                     ,ipg2.st_loc_sid
                     ,cal2.dat_calendar
                     ,ipg2.pricegroup_id
                     ,ipg2.priority
                  FROM
                     p_lew_core_ac.v_wawi_itm_pricegroup AS ipg2
                     INNER JOIN p_lew_mart_msi.v_cal_calendarday AS cal2 ON cal2.dat_calendar BETWEEN ipg2.dat_valid_from
                     AND ipg2.dat_valid_until
                     AND cal2.dat_calendar <= CURRENT_DATE
                     AND cal2.dat_calendar >= '2007-01-01'
                     LEFT JOIN p_lew_core_ac.v_location s ON ipg2.st_loc_sid = s.loc_sid
                     AND ipg2.client_id = s.client_id
                  WHERE
                     s.src_store_id <> 0
                     AND (ipg2.client_id, ipg2.st_loc_sid) IN (
                        SELECT
                           org.client_id
                           ,org.st_loc_sid
                        FROM
                           p_lew_core_ac.v_wawi_org_store_skey_act AS org
                           INNER JOIN p_lew_bil_ac.v_warehouse AS wh ON org.client_id = wh.client_id
                           AND org.wh_loc_sid = wh.loc_sid_wh
                           AND wh.dwh_actual_fg = 1
                        WHERE
                           org.orig_store_nr = wh.src_wh_id
                     )
                     AND ipg2.language_id <> 7
               ) PG2 ON PG2.client_id = P2.client_id
               AND PG2.dat_calendar = P2.dat_calendar
               AND PG2.pricegroup_id = P2.pricegroup_id
         ) sub1
   ) price
   INNER JOIN (
      SELECT
         dt.client_id
         ,MIN(
            CASE
               WHEN dt.currency_seq_id = 1 THEN dt.rate_currency_exchange
               ELSE NULL
            END
         ) AS rate_currency_ctr_to_eur
      FROM
         (
            SELECT
               cryx.client_id
               ,cryx.rate_currency_exchange
               ,COUNT(1) OVER (
                  PARTITION BY cryx.client_id
                  ORDER BY
                     CASE
                        WHEN cryx.currency_iso_cd = 'EUR' THEN 1
                        WHEN cryx.currency_iso_cd = cryx.to_currency_iso_cd THEN 2
                        ELSE 3
                     END
                     ,cryx.currency_iso_cd ROWS UNBOUNDED PRECEDING
               ) AS currency_seq_id
            FROM
               p_lew_core_ac.v_wawi_ref_client_currency_rate cryx
            WHERE
               CURRENT_DATE BETWEEN cryx.dat_rec_start
               AND cryx.dat_rec_end QUALIFY currency_seq_id <= 2
         ) dt
      GROUP BY
         dt.client_id
   ) AS cry ON price.client_id = cry.client_id
   INNER JOIN p_lew_core_ac.v_location AS whmap ON price.wh_loc_sid = whmap.loc_sid
WHERE
   rang = 1
UNION
ALL
SELECT
   dwh.client_id
   ,dwh.item_sid AS item_id
   ,whmap2.src_orig_wh_nr AS wh_id
   ,dwh.dat_calendar
   ,dwh.cond_val_eff_calc AS price_retail
   ,dwh.net_val_eff_calc AS price_retail_net
   ,dwh.cond_val_eff_calc / cry2.rate_currency_ctr_to_eur AS price_retail_eur
   ,dwh.net_val_eff_calc / cry2.rate_currency_ctr_to_eur AS price_retail_net_eur
FROM
   (
      SELECT
         a.client_id
         ,a.item_sid
         ,a.loc_sid
         ,cal.dat_calendar
         ,a.cond_val_eff_calc
         ,a.net_val_eff_calc
         ,a.curr_cd
      FROM
         p_lew_bil_ac.v_item_loc_sales_cond_denorm AS a
         INNER JOIN p_lew_bil_ac.v_item AS i ON a.client_id = i.client_id
         AND a.item_sid = i.item_sid
         AND i.deleted_fg = 0
         AND i.dwh_actual_fg = 1
         INNER JOIN p_lew_mart_msi.v_psa_item AS psa ON i.client_id = psa.client_id
         AND i.src_orig_item_nr = to_varchar(psa.orig_item_nr)
         INNER JOIN p_lew_core_ac.v_client_migration_per AS mig ON mig.client_id = a.client_id
         AND mig.active_fg = 1
         INNER JOIN p_lew_mart_msi.v_cal_calendarday AS cal ON cal.dat_calendar BETWEEN a.dwh_valid_from
         AND a.dwh_valid_to
         AND cal.dat_calendar <= CURRENT_DATE
         AND cal.dat_calendar >= '2007-01-01'
   ) AS dwh
   INNER JOIN (
      SELECT
         dt.client_id
         ,MIN(
            CASE
               WHEN dt.currency_seq_id = 1 THEN dt.rate_currency_exchange
               ELSE NULL
            END
         ) AS rate_currency_ctr_to_eur
      FROM
         (
            SELECT
               cryx.client_id
               ,cryx.rate_currency_exchange
               ,COUNT(1) OVER (
                  PARTITION BY cryx.client_id
                  ORDER BY
                     CASE
                        WHEN cryx.currency_iso_cd = 'EUR' THEN 1
                        WHEN cryx.currency_iso_cd = cryx.to_currency_iso_cd THEN 2
                        ELSE 3
                     END
                     ,cryx.currency_iso_cd ROWS UNBOUNDED PRECEDING
               ) AS currency_seq_id
            FROM
               p_lew_core_ac.v_wawi_ref_client_currency_rate cryx
            WHERE
               CURRENT_DATE BETWEEN cryx.dat_rec_start
               AND cryx.dat_rec_end QUALIFY currency_seq_id <= 2
         ) dt
      GROUP BY
         dt.client_id
   ) AS cry2 ON dwh.client_id = cry2.client_id
   INNER JOIN p_lew_core_ac.v_location AS whmap2 ON dwh.loc_sid = whmap2.loc_sid
WHERE
   whmap2.src_orig_wh_nr IS NOT NULL;