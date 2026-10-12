
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_ADV_ASIS_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
                                 /*
                                 #DescStart#
                                 #$Revision: 9079 $, $LastChangedBy: aarnold $
                                 #SubjectAreas#: Aktionsverkauf
                                 #DescEnd#
                                 */
                                 SELECT
                                     a.client_id,
                                 wh.src_wh_id AS wh_id,
                                 a.st_loc_sid AS store_id,
                                 a.dat_adv,
                                 a.itemgroup_int_id,
                                 a.item_sid AS item_id,
                                 a.dat_formdate,
                                 a.qty_sales,
                                 a.qty_piece_ejr AS qty_piece_ejr_asis,
                                 a.qty_weight_ejr AS qty_weight_ejr_asis,
                                 a.qty_return_ejr AS qty_return_ejr_asis,
                                 a.qty_delivery,
                                 a.qty_stc_real
                                FROM p_lew_core_ac.v_wawi_agg_store_day_item_adv_asis_1 AS a
                                 INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
                                 ON wh.client_id = a.client_id
                                 AND wh.loc_sid_wh =  a.wh_loc_sid
                                 AND wh.dwh_actual_fg = 1
;
