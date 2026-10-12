/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_REF_ORDER_CHANGE_REASON
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2023    Bachmann, Torsten        Initial version
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_REF_ORDER_CHANGE_REASON
(
  reason_cd NUMBER(38,0), 
  reason_desc VARCHAR(250) COLLATE 'en-ci' COMMENT 'First digit = t_ref_order_change_type.order_change_type_id, Second digit = t_ref_order_change_source.order_change_src_id'
)
COMMENT = 'Combination of t_ref_order_change_type and t_ref_order_change_source'
;
