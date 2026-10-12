CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_ITM_LIST_TYPE_ID COMMENT = 'Multisprache Einlistungstypen Referenz'
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
#  2.0  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  2.1  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  2.2  28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  listing_type_id         COMMENT 'Einlistungstype Id'
, listing_type_desc_AT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung AT'
, listing_type_desc_BE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung BE'
, listing_type_desc_BE_FR COMMENT 'Einlistungstype Landesspezifische Bezeichnung BE_FR'
, listing_type_desc_BG    COMMENT 'Einlistungstype Landesspezifische Bezeichnung BG'
, listing_type_desc_CH    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CH'
, listing_type_desc_CY    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CY'
, listing_type_desc_CZ    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CZ'
, listing_type_desc       COMMENT 'Einlistungstype Beschreibung'
, listing_type_desc_DK    COMMENT 'Einlistungstype Landesspezifische Bezeichnung DK'
, listing_type_desc_EE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung EE'
, listing_type_desc_ES    COMMENT 'Einlistungstype Landesspezifische Bezeichnung ES'
, listing_type_desc_FI    COMMENT 'Einlistungstype Landesspezifische Bezeichnung FI'
, listing_type_desc_FR    COMMENT 'Einlistungstype Landesspezifische Bezeichnung FR'
, listing_type_desc_GB    COMMENT 'Einlistungstype Landesspezifische Bezeichnung GB'
, listing_type_desc_GR    COMMENT 'Einlistungstype Landesspezifische Bezeichnung GR'
, listing_type_desc_HR    COMMENT 'Einlistungstype Landesspezifische Bezeichnung HR'
, listing_type_desc_HU    COMMENT 'Einlistungstype Landesspezifische Bezeichnung HU'
, listing_type_desc_IE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung IE'
, listing_type_desc_IT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung IT'
, listing_type_desc_LT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung LT'
, listing_type_desc_LV    COMMENT 'Einlistungstype Landesspezifische Bezeichnung LV'
, listing_type_desc_NI    COMMENT 'Einlistungstype Landesspezifische Bezeichnung NI'
, listing_type_desc_NL    COMMENT 'Einlistungstype Landesspezifische Bezeichnung NL'
, listing_type_desc_DE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung DE'
, listing_type_desc_PL    COMMENT 'Einlistungstype Landesspezifische Bezeichnung PL'
, listing_type_desc_PT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung PT'
, listing_type_desc_RO    COMMENT 'Einlistungstype Landesspezifische Bezeichnung RO'
, listing_type_desc_SE    COMMENT 'Einlistungstype Landesspezifische Bezeichnung SE'
, listing_type_desc_SI    COMMENT 'Einlistungstype Landesspezifische Bezeichnung SI'
, listing_type_desc_SK    COMMENT 'Einlistungstype Landesspezifische Bezeichnung SK'
, listing_type_desc_CS    COMMENT 'Einlistungstype Landesspezifische Bezeichnung CS'
, listing_type_desc_MT    COMMENT 'Einlistungstype Landesspezifische Bezeichnung MT'
, listing_type_desc_US    COMMENT 'Einlistungstype Landesspezifische Bezeichnung US'
, listing_type_desc_RS    COMMENT 'Einlistungstype Landesspezifische Bezeichnung RS'
 )
AS
SELECT   listing_type_id
       , listing_type_desc_AT
       , listing_type_desc_BE
       , listing_type_desc_BE_FR
       , listing_type_desc_BG
       , listing_type_desc_CH
       , listing_type_desc_CY
       , listing_type_desc_CZ
       , listing_type_desc
       , listing_type_desc_DK
       , listing_type_desc_EE
       , listing_type_desc_ES
       , listing_type_desc_FI
       , listing_type_desc_FR
       , listing_type_desc_GB
       , listing_type_desc_GR
       , listing_type_desc_HR
       , listing_type_desc_HU
       , listing_type_desc_IE
       , listing_type_desc_IT
       , listing_type_desc_LT
       , listing_type_desc_LV
       , listing_type_desc_NI
       , listing_type_desc_NL
       , listing_type_desc_DE
       , listing_type_desc_PL
       , listing_type_desc_PT
       , listing_type_desc_RO
       , listing_type_desc_SE
       , listing_type_desc_SI
       , listing_type_desc_SK
       , listing_type_desc_CS
       , listing_type_desc_MT
       , listing_type_desc_US
       , listing_type_desc_RS
  FROM P_LEW_MART_MSI.v_ref_itm_list_type_id
;