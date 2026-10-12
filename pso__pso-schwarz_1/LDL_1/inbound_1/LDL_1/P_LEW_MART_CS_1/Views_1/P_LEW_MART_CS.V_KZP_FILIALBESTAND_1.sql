/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.V_KZP_FILIALBESTAND_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2020    Ulrich Ross            Init KZP
#  1.1  11.03.2021    Ulrich Ross            Add aggregation for quantities and alter GROUP BY to remove multiple rows for items with differnt cas_size
#  1.2  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.3  17.03.2021    Guenes, Oguzhan          CloudMig FS - KZP Nachfolgepatch 3 TD: Änderungen in SNFLK
#                                              https://jira.schwarz/browse/DDLE-1995
#  1.4  12.05.2021    Ross, Ulrich            Remove Aggregation and add sub-select to remove duplicate rows.
#  1.5  24.06.2021    Ross, Ulrich            Remove deleted_fg in subSelect for v_gen_item_hist_1 to get all items 
#  1.6  09.11.2021    Ross, Ulrich            Remove timeline logic for attribut valid_to.  https://jira.schwarz/browse/DDLE-2778
#  1.7  28.02.2022    Ross, Ulrich            Remove 90 days backward where clause; UserStory 292052
#  1.8  30.03.2022    Ross, Ulrich            Fix missing Filialbestand while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_FILIALBESTAND_1 COMMENT = '$Revision: 16943 $ '
(
  client_id
, country_iso_cd
, orig_item_nr
, src_orig_store_nr
, calc_qty
, inv_qty
, diff_qty_inv_calc
, valid_from
, valid_to
, load_id
, dwh_created           
, timestamp_delta
)
AS
SELECT  
    erg.client_id
  , erg.country_iso_cd
  , erg.orig_item_nr
  , erg.src_orig_store_nr
  , erg.calc_qty
  , erg.inv_qty
  , erg.diff_qty_inv_calc
  , erg.dwh_valid_from                                                                                       AS valid_from
  , erg.dwh_valid_to                                                                                         AS valid_to
  , erg.load_id
  , erg.dwh_created           
  , erg.timestamp_delta
FROM 
(
  SELECT 
      vilsh.client_id                                                                                        AS client_id
    , t.src_country_lidl_cd                                                                                  AS country_iso_cd
    , item.orig_item_nr                                                                                      AS orig_item_nr
    , store.src_orig_store_nr                                                                                AS src_orig_store_nr
    , vilsh.calc_qty                                                                                         AS calc_qty
    , vilsh.inv_qty                                                                                          AS inv_qty
    , vilsh.diff_qty_inv_calc                                                                                AS diff_qty_inv_calc
    , vilsh.dwh_valid_from                                                                                   AS dwh_valid_from
    , vilsh.dwh_valid_to                                                                                     AS dwh_valid_to
    , vilsh.dwh_load_id                                                                                      AS load_id
    , vilsh.dwh_created                                                                                      AS dwh_created
    , vilsh.dwh_updated                                                                                      AS timestamp_delta
  FROM  P_LEW_CORE_AC.v_item_location_stock_hist_1 AS vilsh
  
  -- Country_1
  INNER JOIN P_LEW_CORE_AC.v_client_1 c
    ON vilsh.client_id = c.client_id

  INNER JOIN P_LEW_CORE_AC.v_country_1 t
    ON c.country_sid = t.country_sid

  LEFT OUTER JOIN ( SELECT client_id, item_sid, orig_item_nr
                FROM P_LEW_MART_CS.v_gen_item_hist_1
                WHERE CURRENT_DATE - 1 BETWEEN valid_from AND valid_until
                GROUP BY 1,2,3) item_1
    ON item.client_id = vilsh.client_id
    AND item.item_sid = vilsh.item_sid    

  INNER JOIN
      (SELECT client_id, loc_sid_store, src_orig_store_nr
       FROM p_lew_mart_cs.v_gen_kzp_store_1 
       WHERE src_wh_id <> src_orig_store_nr
       GROUP BY client_id, loc_sid_store, src_orig_store_nr) AS store
    ON store.client_id = vilsh.client_id
    AND store.loc_sid_store = vilsh.loc_sid

  WHERE item.orig_item_nr IS NOT NULL
  AND store.src_orig_store_nr IS NOT NULL
  
) AS erg
;