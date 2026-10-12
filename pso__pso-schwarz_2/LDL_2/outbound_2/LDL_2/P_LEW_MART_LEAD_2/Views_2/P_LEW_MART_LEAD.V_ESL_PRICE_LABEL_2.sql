/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_price_label_2 (price_label_sid, price_label_nr,
electronic_price_label_type_cd, electronic_price_label_type_cd_fe, price_label_producer_name) AS SELECT price_label_sid
 ,
 price_label_nr,
 electronic_price_label_type_cd,
  CASE
  WHEN electronic_price_label_type_cd IN ('HF_G1_2.6_BWR', 'NEWTON_GRAPHIC_2_6_RED')
  THEN '02.6'
  WHEN electronic_price_label_type_cd IN ('HF_G1_13_BWR', 'NEWTON_GRAPHIC_12_2_RED')
  THEN '12.2'
  WHEN electronic_price_label_type_cd IN ('HF_VUSION_5.9_BW_FREEZER', 'NEWTON_GRAPHIC_5_85_FREEZER',
    'NEWTON_GRAPHIC_5_85_NFC_LITE_FREEZER')
  THEN '05.9 F'
  WHEN electronic_price_label_type_cd IN ('HF_VUSION_5.9_BWR', 'NEWTON_GRAPHIC_5_85_RED')
  THEN '05.9'
  WHEN electronic_price_label_type_cd IN ('HF_VUSION_9.7_BWR', 'NEWTON_GRAPHIC_9_7_RED')
  THEN '09.7'
  ELSE NULL
  END AS electronic_price_label_type_cd_fe,
 price_label_producer_name
FROM ldl_p_lew_core_ac.v_esl_price_label_2;