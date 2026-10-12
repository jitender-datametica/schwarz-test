/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_WH_BGES
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_wh_bges (client_id, client_desc, wh_id, bges_desc1, bges_desc2) AS
SELECT *
FROM ldl_p_lew_mart_cs.v_bw_wh_bges;