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
#                                              REP3-8097 Changed precision of decimals due to TD Overflow Error on INTEGER -A-020
# 
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_stc_store_item_wawi_2 OPTIONS(DESCRIPTION = `$Revision: 16598 $ `) AS
/* BIL View */ SELECT BIL.client_id,
 BIL.loc_sid AS store_id,
 B.src_wh_id AS wh_id,
 ITMP.item_sid_map AS item_id,
 BIL.dwh_cal_dt AS dat_formdate,
 CAST(BIL.stock_calc_qty AS FLOAT64) AS qty_stc_calc,
 CAST(BIL.stock_inv_qty AS FLOAT64) AS qty_stc_inv,
  CASE
  WHEN IFNULL(BIL.stock_inv_diff_calc, 0) = 0
  THEN CAST(BIL.stock_calc_qty AS FLOAT64)
  ELSE CAST(BIL.stock_inv_qty AS FLOAT64)
  END AS qty_stc_real,
 BIL.stock_inv_diff_calc AS diff_stc_inv_calc,
 CAST(BIL.price / CRY.rate_currency_exchange AS FLOAT64) AS price_retail,
 CAST(BIL.price_net / CRY.rate_currency_exchange AS FLOAT64) AS price_retail_net,
 CRY.currency_iso_cd
FROM ldl_p_lew_bil_ac.v_stock_location_item_2 AS BIL
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act_2 AS OSK ON BIL.client_id = OSK.client_id AND BIL.loc_sid = OSK.st_loc_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS B ON OSK.client_id = B.client_id AND OSK.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' /* Warehouse */
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON BIL.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON BIL.client_id = ITMP.client_id AND BIL.item_sid
   /* Filter auf Wawi Länder */ = ITMP.item_sid
 INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client_2 AS MIG ON BIL.client_id = MIG.wawi_dwh_client_id AND MIG.migrated_fg
    = 0;