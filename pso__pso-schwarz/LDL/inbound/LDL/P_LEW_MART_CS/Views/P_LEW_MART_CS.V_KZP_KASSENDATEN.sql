/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_KASSENDATEN
#----------------------------------------------------------------------------
#  Version      When       Who                   What
#  1.0    2021-02-26    Wachauf, Christian    Add filter on v_gen_item_hist (only valid items considered)     
#  1.1    15.03.2021    Guenes, Oguzhan               Transfer to Snowflake.
#                                           https://jira.schwarz/browse/DDLE-1783
#                                           Create scripts for snowflake standardisation.
#  1.3    24.06.2021    Ross, Ulrich          Remove deleted_fg in subSelect for v_gen_item_hist to get all items 
#  1.4    16.08.2021    Ross,Ulrich           Erweiterung um LidlPlus Daten
#                                           (sales_net_lp_val_ejr_asis,discount_net_lp_val_ejr_asis,piece_weight_lp_qty_ejr_asis)
#                                           https://jira.schwarz/browse/DDLE-2558
#  1.5    30.03.2022    Ross, Ulrich        Fix missing Filialbestand while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_KASSENDATEN
(
  client_id
, country_iso_cd
, cnt_discount_ejr_asis
, cnt_retail_ejr_asis
, cnt_return_ejr_asis
, dat_formdate
, orig_item_nr
, orig_store_nr
, price_rtl_net_ejr_adjstd_asis
, price_rtl_ejr_asis
, price_rtl_net_ejr_asis
, qty_disc_piece_ejr_asis
, qty_disc_weight_ejr_asis
, qty_disc_piece_weight_ejr_asis
, qty_piece_ejr_asis
, qty_return_ejr_asis
, val_disc_rtl_gross_ejr_asis
, val_disc_rtl_net_ejr_asis
, val_void_ejr_asis
, val_void_net_ejr_asis
, val_rtl_net_ejr_asis
, val_return_net_ejr_asis
, qty_piece_weight_ejr_asis
, qty_rt_piece_weight_ejr_asis
, qty_rt_pc_wt_saleable_ejr_asis
, sales_net_lp_val_ejr_asis   
, discount_net_lp_val_ejr_asis
, piece_weight_lp_qty_ejr_asis
, currency_iso_cd
)
AS
SELECT
    agg.client_id                                                    AS client_id
    , t.src_country_lidl_cd                                          AS country_iso_cd
    , SUM(agg.cnt_discount_ejr_asis)                                 AS cnt_discount_ejr_asis
    , SUM(agg.cnt_retail_ejr_asis)                                   AS cnt_retail_ejr_asis
    , SUM(agg.cnt_return_ejr_asis)                                   AS cnt_return_ejr_asis
    , agg.dat_formdate                                               AS dat_formdate
    , COALESCE(item.orig_item_nr, -1)                                AS orig_item_nr
    , COALESCE(store.src_orig_store_nr, -1)                          AS orig_store_nr
    , CAST(MAX(agg.price_rtl_net_ejr_adjstd_asis)  AS DECIMAL(18,4)) AS price_rtl_net_ejr_adjstd_asis
    , CAST(MAX(agg.price_rtl_ejr_asis)             AS DECIMAL(18,4)) AS price_rtl_ejr_asis
    , CAST(MAX(agg.price_rtl_net_ejr_asis)         AS DECIMAL(18,4)) AS price_rtl_net_ejr_asis
    , CAST(SUM(agg.qty_disc_piece_ejr_asis)        AS DECIMAL(18,4)) AS qty_disc_piece_ejr_asis
    , CAST(SUM(agg.qty_disc_weight_ejr_asis)       AS DECIMAL(18,4)) AS qty_disc_weight_ejr_asis
    , CAST(SUM(agg.qty_disc_piece_weigth_ejr_asis) AS DECIMAL(18,4)) AS qty_disc_piece_weight_ejr_asis
    , CAST(SUM(agg.qty_piece_ejr_asis)                               AS DECIMAL(18,4)) AS qty_piece_ejr_asis
    , CAST(SUM(agg.qty_return_ejr_asis)            AS DECIMAL(18,4)) AS qty_return_ejr_asis
    , CAST(SUM(agg.val_disc_rtl_gross_ejr_asis)    AS DECIMAL(18,4)) AS val_disc_rtl_gross_ejr_asis
    , CAST(SUM(agg.val_disc_rtl_net_ejr_asis)      AS DECIMAL(18,4)) AS val_disc_rtl_net_ejr_asis
    , CAST(SUM(agg.val_void_ejr_asis)              AS DECIMAL(18,4)) AS val_void_ejr_asis
    , CAST(SUM(agg.val_void_net_ejr_asis)          AS DECIMAL(18,4)) AS val_void_net_ejr_asis
    , CAST(SUM(agg.val_rtl_net_ejr_asis)                              AS DECIMAL(18,4)) - CAST(SUM(agg.sales_net_lp_val_ejr_asis) AS DECIMAL(18,4))          AS val_rtl_net_ejr_asis
    , CAST(SUM(agg.val_return_net_ejr_asis)        AS DECIMAL(18,4)) AS val_return_net_ejr_asis
    , CAST(SUM(agg.qty_piece_weight_ejr_asis) AS DECIMAL(18,4)) - CAST(SUM(agg.piece_weight_lp_qty_ejr_asis) AS DECIMAL(18,4))  AS qty_piece_weight_ejr_asis
    , CAST(SUM(agg.qty_rt_piece_weight_ejr_asis)   AS DECIMAL(18,4)) AS qty_rt_piece_weight_ejr_asis
    , CAST(SUM(agg.qty_rt_pc_wt_saleable_ejr_asis) AS DECIMAL(18,4)) AS qty_rt_pc_wt_saleable_ejr_asis
    , CAST(SUM(agg.sales_net_lp_val_ejr_asis)      AS DECIMAL(18,4)) AS sales_net_lp_val_ejr_asis       --SALES_VALUE_NET_lp
    , CAST(SUM(agg.discount_net_lp_val_ejr_asis)   AS DECIMAL(18,4)) AS discount_net_lp_val_ejr_asis    --DISCOUNT_PRICE_NET_lp
    , CAST(SUM(agg.piece_weight_lp_qty_ejr_asis)   AS DECIMAL(18,4)) AS piece_weight_lp_qty_ejr_asis    --SALES_AMOUNT_PIECES_lp
    , agg.currency_iso_cd                                            AS currency_iso_cd
FROM p_lew_mart_cs.v_gen_agg_store_day_item_ejr_asis AS agg

-- Country
INNER JOIN p_lew_core_ac.v_client c
ON agg.client_id = c.client_id

INNER JOIN p_lew_core_ac.v_country t
ON c.country_sid = t.country_sid

LEFT OUTER JOIN ( SELECT client_id, item_sid, orig_item_nr
                  FROM p_lew_mart_cs.v_gen_item_hist
                  WHERE CURRENT_DATE - 1 BETWEEN valid_from AND valid_until
                  GROUP BY 1,2,3) item
ON item.client_id = agg.client_id
AND item.item_sid = agg.item_id

INNER JOIN
    (SELECT client_id, src_orig_store_nr
     FROM p_lew_mart_cs.v_gen_kzp_store 
     WHERE src_wh_id <> src_orig_store_nr
     GROUP BY client_id, src_orig_store_nr) AS store
ON store.client_id = agg.client_id
AND store.src_orig_store_nr = agg.orig_store_nr

GROUP BY  1,2,6,7,8,29
;