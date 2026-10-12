/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_ORDER_CHANGE_REASON_2
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2023    Bachmann, Torsten        Initial version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_order_change_reason_2 (reason_cd, reason_desc) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_order_change_reason_2;