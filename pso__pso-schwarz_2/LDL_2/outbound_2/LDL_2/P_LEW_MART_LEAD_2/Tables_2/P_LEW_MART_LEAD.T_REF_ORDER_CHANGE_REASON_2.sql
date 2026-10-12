/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_REF_ORDER_CHANGE_REASON_2
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2023    Bachmann, Torsten        Initial version
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_order_change_reason_2 (
reason_cd BIGNUMERIC(38,0),
reason_desc STRING(250) COLLATE 'und:ci'
OPTIONS(description='First digit = t_ref_order_change_type.order_change_type_id, Second digit = t_ref_order_change_source.order_change_src_id')
) OPTIONS(description='Combination of t_ref_order_change_type_2 and t_ref_order_change_source_2');