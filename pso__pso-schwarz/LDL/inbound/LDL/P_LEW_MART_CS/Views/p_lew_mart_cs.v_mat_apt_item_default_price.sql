/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_default_price
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_item_default_price
(
    client_id
  , country_iso_cd
  , org_item_nr
  , valid_from_item
  , case_size
  , saleprice_gross1
  , saleprice_gross2
  , saleprice_gross3
  , currency_iso_code
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id
)
AS
   SELECT
   a.client_id,
   a.country_iso_cd,
   a.org_item_nr,
   a.valid_from_item,
   a.case_size,
   CAST(MAX(a.saleprice_gross1) AS DECIMAL (20, 4))  AS saleprice_gross1,
   CAST(MAX(a.saleprice_gross2) AS DECIMAL (20, 4))  AS saleprice_gross2,
   CAST(MAX(a.saleprice_gross3) AS DECIMAL (20, 4))  AS saleprice_gross3,
   a.currency_iso_cd                                 AS currency_iso_code,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   a.load_id,
   a.src_id
   FROM (SELECT
   ip.client_id,
   ip.item_sid,
   i.src_country_lidl_cd                 AS country_iso_cd,
   i.orig_item_nr                        AS org_item_nr,
   i.case_size,
   i.valid_from                          AS valid_from_item,
   CASE  WHEN pg.position_article_sales_rep = 1
                       OR pg.position_article_sales_rep IS NULL
                  THEN ip.price_retail
                  END                             AS saleprice_gross1,
   CASE  WHEN pg.position_article_sales_rep = 2
                  THEN ip.price_retail
                  END                             AS saleprice_gross2,
   CASE  WHEN pg.position_article_sales_rep = 3
                  THEN ip.price_retail
                  END                             AS saleprice_gross3,
   c.currency_iso_cd,
   TIMESTAMP '1900-01-01 00:00:00'       AS dwh_updated,
   TIMESTAMP '1900-01-01 00:00:00'       AS dwh_created,
   CAST(-1 AS INTEGER)                   AS dwh_load_id,
   ip.load_id                            AS load_id,
   1                                     AS src_id
   FROM p_lew_core_ac.v_wawi_itm_price ip  /*fuer obere logik relevant mit einstufung in preisgruppen*/
   INNER JOIN p_lew_mart_cs.v_gen_item_asis i
   ON ip.client_id = i.client_id
   AND ip.item_sid = i.item_sid
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_pricegrp pg
   ON ip.client_id = pg.client_id
   AND ip.pricegroup_id = pg.pricegroup_id
   AND CURRENT_DATE  BETWEEN pg.dat_valid_from AND pg.dat_valid_until
   INNER JOIN p_lew_core_ac.v_wawi_ref_currency_act c
   ON ip.client_id = c.client_id
   AND c.rate_currency_exchange = 1

   WHERE ip.price_retail IS NOT NULL
      AND ip.item_sid > 0
      AND i.itemstatus_cd > 3
      AND i.itemstatus_cd < 10
      AND i.buying_list_type_id IS NOT NULL
      AND i.buying_list_type_id > 0 
      AND CURRENT_DATE -1 BETWEEN ip.dat_valid_from AND ip.dat_valid_until
) a
GROUP BY 1,2,3,4,5,9,10,11,12,13,14
   QUALIFY ROW_NUMBER () OVER (PARTITION BY a.client_id, a.org_item_nr, a.valid_from_item, a.case_size ORDER BY a.load_id DESC NULLS LAST) = 1

UNION
    
SELECT
  b.client_id                                         AS client_id
  , b.country_iso_cd                                  AS country_iso_cd
  , b.org_item_nr                                     AS org_item_nr
  , b.valid_from_item                                 AS valid_from_item
  , b.case_size                                       AS case_size
  , CAST(MAX(b.saleprice_gross1) AS DECIMAL (20, 4))  AS saleprice_gross1
  , CAST(MAX(b.saleprice_gross2) AS DECIMAL (20, 4))  AS saleprice_gross2
  , CAST(MAX(b.saleprice_gross3) AS DECIMAL (20, 4))  AS saleprice_gross3
  , b.currency_iso_cd                                 AS currency_iso_code
  , b.dwh_updated                                     AS dwh_updated
  , b.dwh_created                                     AS dwh_created
  , b.dwh_load_id                                     AS dwh_load_id
  , b.load_id                                         AS load_id
  , b.src_id                                          AS src_id
  FROM (SELECT 
        scd.client_id
        , scd.item_sid
        , i.src_country_lidl_cd                       AS country_iso_cd
        , i.orig_item_nr                              AS org_item_nr
        , i.valid_from                                AS valid_from_item
        , i.case_size
        , scd.cond_val                                AS saleprice_gross1
        /*ELWIS (US, RS) besitzt keine Preisgruppen -> or null*/        
        , NULL                                        AS saleprice_gross2
        , NULL                                        AS saleprice_gross3
        , c.currency_iso_cd
        , TIMESTAMP '1900-01-01 00:00:00'             AS dwh_updated
        , TIMESTAMP '1900-01-01 00:00:00'             AS dwh_created
        , CAST(-1 AS INTEGER)                         AS dwh_load_id
        , CAST(-1 AS INTEGER)                         AS load_id
        , 2                                           AS src_id
        FROM P_LEW_BIL_AC.v_item_loc_sales_cond_denorm AS scd

        INNER JOIN P_LEW_MART_CS.v_gen_item_asis AS  i
            ON scd.client_id = i.client_id
            AND scd.item_sid = i.item_sid

        INNER JOIN P_LEW_CORE_AC.v_wawi_ref_currency_act AS  c
          ON scd.client_id = c.client_id
          AND c.rate_currency_exchange = 1

        INNER JOIN P_LEW_CORE_AC.v_client_migration_per AS cmp    --To identify WAWI or ELWIS client
            ON scd.client_id = cmp.client_id    
            AND cmp.active_fg = 1
          

        WHERE scd.cond_val IS NOT NULL
          AND scd.item_sid > 0
          AND CURRENT_DATE -1 BETWEEN scd.dwh_valid_from AND  scd.dwh_valid_to
          AND i.itemstatus_cd > 3
          AND i.itemstatus_cd < 10
          AND i.buying_list_type_id IS NOT NULL
          AND i.buying_list_type_id > 0                  
) b
GROUP BY 1,2,3,4,5,9,10,11,12,13,14    
;


