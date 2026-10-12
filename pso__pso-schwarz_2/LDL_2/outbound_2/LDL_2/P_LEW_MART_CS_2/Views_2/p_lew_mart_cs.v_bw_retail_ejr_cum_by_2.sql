/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_RETAIL_EJR_CUM_BY_2
#----------------------------------------------------------------------------
# History:
#   1.0      14.11.2023      Ulrich Ross              Init
#                                                     User Story 532005                                                                             
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_retail_ejr_cum_by_2 (client_id, wh_id, cy_month, aspect_id,
item_familygroup_id, subitemgroup_id, subitemgroup_id0, buying_list_type_id, curr_tot_id, currency_iso_cd,
val_ejr_cum_by) AS SELECT client_id,
 wh_id,
 cy_month,
 aspect_id,
 item_familygroup_id,
 subitemgroup_id,
 subitemgroup_id0,
 buying_list_type_id,
 curr_tot_id,
 currency_iso_cd,
 val_ejr_cum_by
FROM ldl_p_lew_mart_cs.t_bw_retail_ejr_cum_by_2;