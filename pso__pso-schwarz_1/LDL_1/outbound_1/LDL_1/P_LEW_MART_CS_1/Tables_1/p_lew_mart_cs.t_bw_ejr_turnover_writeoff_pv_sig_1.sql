/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_sig_1
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_sig_1 (
client_id BIGNUMERIC(38) NOT NULL,
item_id INTEGER NOT NULL,
item_familygroup_id BIGNUMERIC(38) NOT NULL,
subitemgroup_id BIGNUMERIC(38) NOT NULL
);