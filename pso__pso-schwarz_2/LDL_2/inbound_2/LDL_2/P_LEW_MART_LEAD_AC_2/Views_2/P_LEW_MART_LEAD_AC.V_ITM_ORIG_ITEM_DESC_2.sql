CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITM_ORIG_ITEM_DESC_2 COMMENT = 'Original Item_2 description view'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  20.03.2018    -Sanjana Bharti - Initial version -20180319_1620_Create_Missing_Source_Rep3 
#  1.1  05.01.2022    Michael Morris    Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id      COMMENT 'Identifier of Client'
, orig_item_nr   COMMENT 'Original item_2 id'
, dat_valid_from COMMENT 'Valid from date'
, item_desc_AT   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_BE   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_BG   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_CH   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_CY   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_CZ   COMMENT 'Item_2 description in depending country_2 language'
, item_desc      COMMENT 'Main item_2 description field'
, item_desc_DK   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_EE   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_ES   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_FI   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_FR   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_GB   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_GR   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_HR   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_HU   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_IE   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_IT   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_LT   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_NI   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_NL   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_LV   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_DE   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_PL   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_PT   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_RO   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_SE   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_SI   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_SK   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_CS   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_MT   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_US   COMMENT 'Item_2 description in depending country_2 language'
, item_desc_RS   COMMENT 'Item_2 description in depending country_2 language'
)
AS
SELECT   client_id
       , orig_item_nr
       , dat_valid_from
       , item_desc_AT
       , item_desc_BE
       , item_desc_BG
       , item_desc_CH
       , item_desc_CY
       , item_desc_CZ
       , item_desc
       , item_desc_DK
       , item_desc_EE
       , item_desc_ES
       , item_desc_FI
       , item_desc_FR
       , item_desc_GB
       , item_desc_GR
       , item_desc_HR
       , item_desc_HU
       , item_desc_IE
       , item_desc_IT
       , item_desc_LT
       , item_desc_NI
       , item_desc_LV
       , item_desc_NL
       , item_desc_DE
       , item_desc_PL
       , item_desc_PT
       , item_desc_RO
       , item_desc_SE
       , item_desc_SI
       , item_desc_SK
       , item_desc_CS
       , item_desc_MT
       , item_desc_US
       , item_desc_RS
  FROM P_LEW_MART_LEAD.v_itm_orig_item_desc_2
;
