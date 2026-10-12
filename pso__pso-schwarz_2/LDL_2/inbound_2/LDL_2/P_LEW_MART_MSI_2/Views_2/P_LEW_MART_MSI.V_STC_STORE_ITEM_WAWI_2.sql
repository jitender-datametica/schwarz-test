/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_stc_store_item_wawi_2
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------

#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  1.1  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  1.2  05.11.2018    Thole,Jens               Umhängen auf vollhistorisierte Basis
#  1.3  28.01.2021    Michal, Malinowski       20210127_2723_A20_HUF_Overflow
#                                              REP3-8097 Changed precision of decimals due to TD Overflow Error on INT-A-020
# 
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_STC_STORE_ITEM_WAWI_2
COMMENT = '$Revision: 16598 $ '

AS

SELECT
   bil.client_id  AS client_id
  ,bil.loc_sid  AS store_id
  ,b.src_wh_id  AS wh_id
  ,itmp.item_sid_map AS item_id
  ,bil.dwh_cal_dt AS dat_formdate
  ,CAST(bil.stock_calc_qty AS FLOAT) AS qty_stc_calc
  ,CAST(bil.stock_inv_qty  AS FLOAT) AS qty_stc_inv
  ,CASE WHEN ZeroIfNull(bil.stock_inv_diff_calc) = 0 THEN CAST(bil.stock_calc_qty AS FLOAT) ELSE CAST(bil.stock_inv_qty AS FLOAT) END AS qty_stc_real
  ,bil.stock_inv_diff_calc  AS diff_stc_inv_calc
  ,CAST((bil.price / cry.rate_currency_exchange) AS FLOAT) AS price_retail
  ,CAST((bil.price_net / cry.rate_currency_exchange) AS FLOAT) AS price_retail_net
  ,cry.currency_iso_cd  AS currency_iso_cd
FROM P_LEW_BIL_AC.V_STOCK_LOCATION_ITEM_2 AS bil /* BIL View */

INNER JOIN P_LEW_CORE_AC.V_WAWI_ORG_STORE_SKEY_ACT_2 AS osk
ON bil.client_id = osk.client_id
  AND bil.loc_sid = osk.st_loc_sid

INNER JOIN P_LEW_CORE_AC.V_LOCATION_2 AS b
ON osk.client_id = b.client_id
  AND osk.wh_loc_sid = b.loc_sid
  AND b.wh_store_mark = 'B' /* Warehouse */

INNER JOIN P_LEW_CORE_AC.V_WAWI_REF_CLIENT_CURRENCY_RATE_2 AS cry
ON bil.client_id = cry.client_id
  AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN P_LEW_CORE_AC.V_ITEM_MAP_KEY_2 AS itmp
ON itmp.client_id = bil.client_id
  AND itmp.item_sid = bil.item_sid

/* Filter auf Wawi Länder */
INNER JOIN P_LEW_PROCESS_AC.V_SAP_MIGRATION_CLIENT_2 AS mig
ON bil.client_id = mig.wawi_dwh_client_id
AND mig.migrated_fg = 0
;


