/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_OPEN_STORES
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-09-30 Rodrigo Cione           Table added to be used for filtering in FE
#                                         20200930_2603_Add_obj_QV_Dummy_Recs
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_open_stores (
client_id BIGNUMERIC(38,0) NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
sales_manager_id BIGNUMERIC(38,0),
account_manager_id BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
wh_id_exp BIGNUMERIC(38,0),
qv_open_store_flag BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) OPTIONS(description='QuickView load table : Open stores (any store with a transaction in the last 13 months)');