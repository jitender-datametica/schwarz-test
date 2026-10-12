/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_stc_item_wh_wawi_2
#----------------------------------------------------------------------------


#----------------------------------------------------------------------------
# History:
#  2.0  19.03.2019    Thole, Jens              add the speed access fields from the new bil-object
#  2.1  28.01.2021    Michal, Malinowski       20210127_2723_A20_HUF_Overflow
#                                              REP3-8097 Changed precision of decimals due to TD Overflow Error on INT-A-020
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_STC_ITEM_WH_WAWI_2
COMMENT = '$Revision: 16598 $ '

AS

SELECT
   bil.client_id
  ,cry.currency_iso_cd
  ,bil.dwh_cal_dt AS dat_formdate
  ,itmp.item_sid_map AS item_id
  ,CAST((bil.price / cry.rate_currency_exchange) AS FLOAT) AS price_retail_stc_wh
  ,CAST((bil.price_net / cry.rate_currency_exchange) AS FLOAT) AS price_retail_net_stc_wh
  ,CAST(bil.stock_calc_qty AS FLOAT) AS qty_piece_stc_wh
  ,b.src_wh_id AS wh_id
  ,bil.src_space_switch
  ,bil.dwh_valid_from
  ,bil.dwh_valid_to
FROM P_LEW_BIL_AC.V_STOCK_LOCATION_ITEM_2 AS bil

INNER JOIN P_LEW_CORE_AC.V_WAWI_REF_CLIENT_CURRENCY_RATE_2 AS cry
ON bil.client_id = cry.client_id
  AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN P_LEW_CORE_AC.V_LOCATION_2 AS b
ON bil.client_id = b.client_id
  AND bil.loc_sid = b.loc_sid
  AND b.wh_store_mark = 'B'  /* Warehouse */

INNER JOIN P_LEW_CORE_AC.V_ITEM_MAP_KEY_2 AS itmp
ON itmp.client_id = bil.client_id
  AND itmp.item_sid = bil.item_sid

INNER JOIN  P_LEW_PROCESS.T_SAP_MIGRATION_CLIENT_2 AS mig
ON bil.client_id = mig.wawi_dwh_client_id
AND mig.migrated_fg = 0
;



