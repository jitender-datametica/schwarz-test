CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_ITM_LIST_TYPE_BRAND_GR_2 COMMENT = 'Multisprache Markenartgruppen Referenz'
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
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr 
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  brand_type_group_id         COMMENT 'Guppen Markenart ID'
, brand_type_group_desc_AT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  AT'
, brand_type_group_desc_BE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  BE'
, brand_type_group_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  BE_FR'
, brand_type_group_desc_BG    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  BG'
, brand_type_group_desc_CH    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  CH'
, brand_type_group_desc_CY    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  CY'
, brand_type_group_desc_CZ    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  CZ'
, brand_type_group_desc       COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart'
, brand_type_group_desc_DK    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  DK'
, brand_type_group_desc_EE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  EE'
, brand_type_group_desc_ES    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  ES'
, brand_type_group_desc_FI    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  FI'
, brand_type_group_desc_FR    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  FR'
, brand_type_group_desc_GB    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  GB'
, brand_type_group_desc_GR    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  GR'
, brand_type_group_desc_HR    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  HR'
, brand_type_group_desc_HU    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  HU'
, brand_type_group_desc_IE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  IE'
, brand_type_group_desc_IT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  IT'
, brand_type_group_desc_LT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  LT'
, brand_type_group_desc_LV    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  LV'
, brand_type_group_desc_NI    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  NI'
, brand_type_group_desc_NL    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  NL'
, brand_type_group_desc_DE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  DE'
, brand_type_group_desc_PL    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  PL'
, brand_type_group_desc_PT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  PT'
, brand_type_group_desc_RO    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  RO'
, brand_type_group_desc_SE    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  SE'
, brand_type_group_desc_SI    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  SI'
, brand_type_group_desc_SK    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  SK'
, brand_type_group_desc_CS    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  CS'
, brand_type_group_desc_MT    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  MT'
, brand_type_group_desc_US    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  US'
, brand_type_group_desc_RS    COMMENT 'Landesspezifische Bezeichnung der Gruppe_2 der Markenart  RS_2'
 )
AS
SELECT   brand_type_group_id
       , brand_type_group_desc_AT
       , brand_type_group_desc_BE
       , brand_type_group_desc_BE_FR
       , brand_type_group_desc_BG
       , brand_type_group_desc_CH
       , brand_type_group_desc_CY
       , brand_type_group_desc_CZ
       , brand_type_group_desc
       , brand_type_group_desc_DK
       , brand_type_group_desc_EE
       , brand_type_group_desc_ES
       , brand_type_group_desc_FI
       , brand_type_group_desc_FR
       , brand_type_group_desc_GB
       , brand_type_group_desc_GR
       , brand_type_group_desc_HR
       , brand_type_group_desc_HU
       , brand_type_group_desc_IE
       , brand_type_group_desc_IT
       , brand_type_group_desc_LT
       , brand_type_group_desc_LV
       , brand_type_group_desc_NI
       , brand_type_group_desc_NL
       , brand_type_group_desc_DE
       , brand_type_group_desc_PL
       , brand_type_group_desc_PT
       , brand_type_group_desc_RO
       , brand_type_group_desc_SE
       , brand_type_group_desc_SI
       , brand_type_group_desc_SK
       , brand_type_group_desc_CS
       , brand_type_group_desc_MT
       , brand_type_group_desc_US
       , brand_type_group_desc_RS
  FROM P_LEW_MART_MSI.v_ref_itm_list_type_brand_gr_2
;