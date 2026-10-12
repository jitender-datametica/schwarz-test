/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_WH_BGES_1
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#                                             
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_wh_bges_1 (client_id, client_desc, wh_id, bges_desc1, bges_desc2) AS SELECT
 WH.client_id,
 CL.country_iso_cd,
 WH.src_wh_id AS wh_id,
 WH.loc_name AS bges_desc1,
 WH.loc_name2 AS bges_desc2
FROM ldl_p_lew_bil.v_warehouse_1 AS WH
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS CL ON WH.client_id = CL.client_id
WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to
 AND WH.bges_active_fg = 1
 AND WH.active_fg = 1;