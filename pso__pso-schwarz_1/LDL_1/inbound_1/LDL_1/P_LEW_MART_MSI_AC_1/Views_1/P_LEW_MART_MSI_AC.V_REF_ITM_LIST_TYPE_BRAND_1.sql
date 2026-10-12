CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_ITM_LIST_TYPE_BRAND_1 COMMENT = 'Multispache Markenartbezeichnungen'
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
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  brand_type_id         COMMENT 'Markenart ID'
, brand_type_desc_AT    COMMENT 'Landesspezifische Bezeichnung der Markenart AT'
, brand_type_desc_BE    COMMENT 'Landesspezifische Bezeichnung der Markenart BE'
, brand_type_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung der Markenart BE_FR'
, brand_type_desc_BG    COMMENT 'Landesspezifische Bezeichnung der Markenart BG'
, brand_type_desc_CH    COMMENT 'Landesspezifische Bezeichnung der Markenart CH'
, brand_type_desc_CY    COMMENT 'Landesspezifische Bezeichnung der Markenart CY'
, brand_type_desc_CZ    COMMENT 'Landesspezifische Bezeichnung der Markenart CZ'
, brand_type_desc       COMMENT 'Bezeichnung der Markenart'
, brand_type_desc_DK    COMMENT 'Landesspezifische Bezeichnung der Markenart DK'
, brand_type_desc_EE    COMMENT 'Landesspezifische Bezeichnung der Markenart EE'
, brand_type_desc_ES    COMMENT 'Landesspezifische Bezeichnung der Markenart ES'
, brand_type_desc_FI    COMMENT 'Landesspezifische Bezeichnung der Markenart FI'
, brand_type_desc_FR    COMMENT 'Landesspezifische Bezeichnung der Markenart FR'
, brand_type_desc_GB    COMMENT 'Landesspezifische Bezeichnung der Markenart GB'
, brand_type_desc_GR    COMMENT 'Landesspezifische Bezeichnung der Markenart GR'
, brand_type_desc_HR    COMMENT 'Landesspezifische Bezeichnung der Markenart HR'
, brand_type_desc_HU    COMMENT 'Landesspezifische Bezeichnung der Markenart HU'
, brand_type_desc_IE    COMMENT 'Landesspezifische Bezeichnung der Markenart IE'
, brand_type_desc_IT    COMMENT 'Landesspezifische Bezeichnung der Markenart IT'
, brand_type_desc_LT    COMMENT 'Landesspezifische Bezeichnung der Markenart LT'
, brand_type_desc_LV    COMMENT 'Landesspezifische Bezeichnung der Markenart LV'
, brand_type_desc_NI    COMMENT 'Landesspezifische Bezeichnung der Markenart NI'
, brand_type_desc_NL    COMMENT 'Landesspezifische Bezeichnung der Markenart NL'
, brand_type_desc_DE    COMMENT 'Landesspezifische Bezeichnung der Markenart DE'
, brand_type_desc_PL    COMMENT 'Landesspezifische Bezeichnung der Markenart PL'
, brand_type_desc_PT    COMMENT 'Landesspezifische Bezeichnung der Markenart PT'
, brand_type_desc_RO    COMMENT 'Landesspezifische Bezeichnung der Markenart RO'
, brand_type_desc_SE    COMMENT 'Landesspezifische Bezeichnung der Markenart SE'
, brand_type_desc_SI    COMMENT 'Landesspezifische Bezeichnung der Markenart SI'
, brand_type_desc_SK    COMMENT 'Landesspezifische Bezeichnung der Markenart SK'
, brand_type_desc_CS    COMMENT 'Landesspezifische Bezeichnung der Markenart CS'
, brand_type_desc_MT    COMMENT 'Landesspezifische Bezeichnung der Markenart MT'
, brand_type_desc_US    COMMENT 'Landesspezifische Bezeichnung der Markenart US'
, brand_type_desc_RS    COMMENT 'Landesspezifische Bezeichnung der Markenart RS_1'
 )
AS
SELECT   brand_type_id
       , brand_type_desc_AT
       , brand_type_desc_BE
       , brand_type_desc_BE_FR
       , brand_type_desc_BG
       , brand_type_desc_CH
       , brand_type_desc_CY
       , brand_type_desc_CZ
       , brand_type_desc
       , brand_type_desc_DK
       , brand_type_desc_EE
       , brand_type_desc_ES
       , brand_type_desc_FI
       , brand_type_desc_FR
       , brand_type_desc_GB
       , brand_type_desc_GR
       , brand_type_desc_HR
       , brand_type_desc_HU
       , brand_type_desc_IE
       , brand_type_desc_IT
       , brand_type_desc_LT
       , brand_type_desc_LV
       , brand_type_desc_NI
       , brand_type_desc_NL
       , brand_type_desc_DE
       , brand_type_desc_PL
       , brand_type_desc_PT
       , brand_type_desc_RO
       , brand_type_desc_SE
       , brand_type_desc_SI
       , brand_type_desc_SK
       , brand_type_desc_CS
       , brand_type_desc_MT
       , brand_type_desc_US
       , brand_type_desc_RS
  FROM P_LEW_MART_MSI.v_ref_itm_list_type_brand_1
;