/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_WARENEINGAENGE
#----------------------------------------------------------------------------
# History:
When       Who                   What
#  1.0  17.12.2019    Wieber.Harald            Init KZP
#  1.1  19.12.2019    Wieber,Harald            Update
#  1.2  09.03.2020    Kunz,Gernot              20200129_2358_Update_25_Mart_CS_DWH20
#                                              Add "delta" columns
#  1.3  26.02.2021    Ross, Ulrich             Add time filter in view v_gen_item_hist 
#  1.4  10.03.2021    Ross, Ulrich             Change column retail_net_fa_val to retail_net_val and buying_fa_val to buying_val
#  1.5  15.03.2021    Guenes, Oguzhan          Transfer to Snowflake.
#                                              https://jira.schwarz/browse/DDLE-1783
#                                              Create scripts for snowflake standardisation.
#  1.6  17.03.2021    Guenes, Oguzhan          CloudMig FS - KZP Nachfolgepatch 3 TD: Änderungen in SNFLK
#                                              https://jira.schwarz/browse/DDLE-1995
#  1.7  24.06.2021    Ross, Ulrich             Remove deleted_fg in subSelect for v_gen_item_hist to get all items 
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_WARENEINGAENGE
(
  client_id
, country_iso_cd
, wh_id
, orig_item_nr
, dat_formdate
, dat_entry_rcv
, val_net_retail
, val_buying_rcv
, receipt_pos_margin_rel_fg
, receipt_type_id
, currency_iso_cd
, item_valid_from
, item_valid_until
, load_id
, timestamp_delta
)
AS 
SELECT
    recv.client_id                                          AS client_id
    , t.src_country_lidl_cd                                 AS country_iso_cd
    , recv.src_wh_id                                        AS wh_id
    , COALESCE(item.orig_item_nr, -1)                       AS orig_item_nr
    , recv.dwh_cal_dt                                       AS dat_formdate
    , MIN(recv.entry_dt)                                    AS dat_entry_rcv
    , CAST(SUM(recv.retail_net_val)  AS DECIMAL(18,4))      AS val_net_retail
    , CAST(SUM(recv.buying_val)      AS DECIMAL(18,4))      AS val_buying_rcv
    , recv.receipt_pos_margin_rel_fg                        AS receipt_pos_margin_rel_fg
    , recv.receipt_type_id                                  AS receipt_type_id
    , recv.curr_cd_from                                     AS currency_iso_cd
    , item.valid_from                                       AS item_valid_from
    , item.valid_until                                      AS item_valid_until
    , MAX(recv.dwh_load_id)                                 AS load_id
    , MAX(recv.dwh_created)                                 AS timestamp_delta
    FROM P_LEW_BIL_AC.v_mov_item_receive_wh recv

    -- Country
    INNER JOIN P_LEW_CORE_AC.v_client c
    ON recv.client_id = c.client_id

    INNER JOIN P_LEW_CORE_AC.v_country t
    ON c.country_sid = t.country_sid
  
    LEFT OUTER JOIN (SELECT 
                        client_id
                        , item_sid
                        , valid_from
                        , valid_until
                        , orig_item_nr
                        FROM P_LEW_MART_CS.v_gen_item_hist
                        WHERE CURRENT_DATE - 1 BETWEEN valid_from AND valid_until
                        GROUP BY 1,2,3,4,5) item
    ON item.client_id = recv.client_id
    AND item.item_sid = recv.item_sid

    GROUP BY 1,2,3,4,5,9,10,11,12,13
;