/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_stc_item_wh_wawi_1
#----------------------------------------------------------------------------


#----------------------------------------------------------------------------
# History:
#  2.0  19.03.2019    Thole, Jens              add the speed access fields from the new bil-object
#  2.1  28.01.2021    Michal, Malinowski       20210127_2723_A20_HUF_Overflow
#                                              REP3-8097 Changed precision of decimals due to TD Overflow Error on INTEGER -A-020
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_stc_item_wh_wawi_1 OPTIONS(DESCRIPTION = `$Revision: 16598 $ `) AS SELECT
 BIL.client_id,
 CRY.currency_iso_cd,
 BIL.dwh_cal_dt AS dat_formdate,
 ITMP.item_sid_map AS item_id,
 CAST(BIL.price / CRY.rate_currency_exchange AS FLOAT64) AS price_retail_stc_wh,
 CAST(BIL.price_net / CRY.rate_currency_exchange AS FLOAT64) AS price_retail_net_stc_wh,
 CAST(BIL.stock_calc_qty AS FLOAT64) AS qty_piece_stc_wh,
 B.src_wh_id AS wh_id,
 BIL.src_space_switch,
 BIL.dwh_valid_from,
 BIL.dwh_valid_to
FROM ldl_p_lew_bil_ac.v_stock_location_item_1 AS BIL
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON BIL.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B ON BIL.client_id = B.client_id AND BIL.loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' /* Warehouse */
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON BIL.client_id = ITMP.client_id AND BIL.item_sid = ITMP.item_sid
 INNER JOIN ldl_p_lew_process.t_sap_migration_client_1 AS MIG ON BIL.client_id = MIG.wawi_dwh_client_id AND MIG.migrated_fg
    = 0;