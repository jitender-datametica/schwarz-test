/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_REF_ORDER_CHANGE_REASON
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2023    Bachmann, Torsten        Initial version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_order_change_reason (reason_cd, reason_desc) AS SELECT reason_cd,
 reason_desc
FROM ldl_p_lew_mart_lead.t_ref_order_change_reason;