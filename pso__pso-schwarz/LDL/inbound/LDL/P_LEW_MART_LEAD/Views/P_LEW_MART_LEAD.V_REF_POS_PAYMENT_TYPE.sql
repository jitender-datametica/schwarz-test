/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_ref_pos_payment_type
#----------------------------------------------------------------------------
# History:
#  1.0  2020-11-27  Marcin Malec          Initial Version
#                                         REP2-8447 [TD] Create tables and views for Payment Type (Zahlungsarten)
#  1.1  2021-06-17  Prasanna Ranjan       REP2-9743 [TD] Rename payment_type_descr and mapping_attr_descr - i_lew_mart_lead.v_ref_pos_payment_type
#--------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_POS_PAYMENT_TYPE COMMENT = 'Payment types reference view'
(
  payment_type_id                COMMENT 'Payment type ID'
 ,payment_type_descr             COMMENT 'Payment type description'
 ,mapping_attr_id                COMMENT 'Mapping attribute ID - 1=Karte, 2=Bar or 3=Rest'
 ,mapping_attr_descr             COMMENT 'Mapping attribute description'
)
AS
SELECT
  payment_type_id
 ,CASE WHEN payment_type_id = 12 THEN 'Zahlung per Karte'
       ELSE  payment_type_descr
  END AS payment_type_descr
 ,CASE WHEN payment_type_id = 11 THEN 1
       WHEN payment_type_id = 12 THEN 2
       ELSE 3
  END AS mapping_attr_id
 ,CASE WHEN payment_type_id = 11 THEN payment_type_descr
       WHEN payment_type_id = 12 THEN 'Zahlung per Karte'
       ELSE 'Rest'
  END AS mapping_attr_descr
FROM p_lew_core_ac.v_ref_pos_payment_type;