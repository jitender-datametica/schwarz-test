CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_ORIG_ITEM_DESC_2 COMMENT = 'Multi language Artikelbeschreibungen'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#  2.0  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  2.1  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  2.2  27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#-----------------------------------------------------------------------------
*/
(
  client_id        COMMENT 'Landes ID' 
, orig_item_nr     COMMENT 'Original Artikelnummer'
, dat_valid_from   COMMENT 'Gültig ab'
, item_desc_AT     COMMENT 'Landesspezifische Artikelbeschreibung AT'
, item_desc_BE     COMMENT 'Landesspezifische Artikelbeschreibung BE'
, item_desc_BE_FR  COMMENT 'Landesspezifische Artikelbeschreibung BE_FR'
, item_desc_BG     COMMENT 'Landesspezifische Artikelbeschreibung BG'
, item_desc_CH     COMMENT 'Landesspezifische Artikelbeschreibung CH'
, item_desc_CY     COMMENT 'Landesspezifische Artikelbeschreibung CY'
, item_desc_CZ     COMMENT 'Landesspezifische Artikelbeschreibung CZ'
, item_desc        COMMENT 'Generische Artikelbeschreibung'
, item_desc_DK     COMMENT 'Landesspezifische Artikelbeschreibung DK'
, item_desc_EE     COMMENT 'Landesspezifische Artikelbeschreibung EE'
, item_desc_ES     COMMENT 'Landesspezifische Artikelbeschreibung ES'
, item_desc_FI     COMMENT 'Landesspezifische Artikelbeschreibung FI'
, item_desc_FR     COMMENT 'Landesspezifische Artikelbeschreibung FR'
, item_desc_GB     COMMENT 'Landesspezifische Artikelbeschreibung GB'
, item_desc_GR     COMMENT 'Landesspezifische Artikelbeschreibung GR'
, item_desc_HR     COMMENT 'Landesspezifische Artikelbeschreibung HR'
, item_desc_HU     COMMENT 'Landesspezifische Artikelbeschreibung HU'
, item_desc_IE     COMMENT 'Landesspezifische Artikelbeschreibung IE'
, item_desc_IT     COMMENT 'Landesspezifische Artikelbeschreibung IT'
, item_desc_LT     COMMENT 'Landesspezifische Artikelbeschreibung LT'
, item_desc_LV     COMMENT 'Landesspezifische Artikelbeschreibung LV'
, item_desc_NI     COMMENT 'Landesspezifische Artikelbeschreibung NI'
, item_desc_NL     COMMENT 'Landesspezifische Artikelbeschreibung NL'
, item_desc_DE     COMMENT 'Landesspezifische Artikelbeschreibung DE'
, item_desc_PL     COMMENT 'Landesspezifische Artikelbeschreibung PL'
, item_desc_PT     COMMENT 'Landesspezifische Artikelbeschreibung PT'
, item_desc_RO     COMMENT 'Landesspezifische Artikelbeschreibung RO'
, item_desc_SE     COMMENT 'Landesspezifische Artikelbeschreibung SE'
, item_desc_SI     COMMENT 'Landesspezifische Artikelbeschreibung SI'
, item_desc_SK     COMMENT 'Landesspezifische Artikelbeschreibung SK'
, item_desc_CS     COMMENT 'Landesspezifische Artikelbeschreibung CS'
, item_desc_MT     COMMENT 'Landesspezifische Artikelbeschreibung MT'
, item_desc_US     COMMENT 'Landesspezifische Artikelbeschreibung US'
, item_desc_RS     COMMENT 'Landesspezifische Artikelbeschreibung RS_2'
 )
AS
SELECT  client_id
      , orig_item_nr
      , dat_valid_from
      , item_desc_AT
      , item_desc_BE
      , item_desc_BE_FR
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
      , item_desc_LV
      , item_desc_NI
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
FROM    P_LEW_MART_MSI.v_itm_orig_item_desc_2
;