CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_ITM_LIST_TYPE_ID_GR COMMENT = 'Multisprache Einlistungstype Gruppen Referenz'
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
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.13 28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  listing_type_group_id         COMMENT 'Guppe Einlistungstype Id'
, listing_type_group_desc_AT    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung AT'
, listing_type_group_desc_BE    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung BE'
, listing_type_group_desc_BE_FR COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung BE_FR'
, listing_type_group_desc_BG    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung BG'
, listing_type_group_desc_CH    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung CH'
, listing_type_group_desc_CY    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung CY'
, listing_type_group_desc_CZ    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung CZ'
, listing_type_group_desc       COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung'
, listing_type_group_desc_DK    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung DK'
, listing_type_group_desc_EE    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung EE'
, listing_type_group_desc_ES    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung ES'
, listing_type_group_desc_FI    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung FI'
, listing_type_group_desc_FR    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung FR'
, listing_type_group_desc_GB    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung GB'
, listing_type_group_desc_GR    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung GR'
, listing_type_group_desc_HR    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung HR'
, listing_type_group_desc_HU    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung HU'
, listing_type_group_desc_IE    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung IE'
, listing_type_group_desc_IT    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung IT'
, listing_type_group_desc_LT    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung LT'
, listing_type_group_desc_LV    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung LV'
, listing_type_group_desc_NI    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung NI'
, listing_type_group_desc_NL    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung NL'
, listing_type_group_desc_DE    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung DE'
, listing_type_group_desc_PL    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung PL'
, listing_type_group_desc_PT    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung PT'
, listing_type_group_desc_RO    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung RO'
, listing_type_group_desc_SE    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung SE'
, listing_type_group_desc_SI    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung SI'
, listing_type_group_desc_SK    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung SK'
, listing_type_group_desc_CS    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung CS'
, listing_type_group_desc_MT    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung MT'
, listing_type_group_desc_US    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung US'
, listing_type_group_desc_RS    COMMENT 'Gruppe Einlistungstype Landesspezifische Bezeichnung RS'
 )
AS
SELECT   listing_type_group_id
       , listing_type_group_desc_BE
       , listing_type_group_desc_AT
       , listing_type_group_desc_BE_FR
       , listing_type_group_desc_BG
       , listing_type_group_desc_CH
       , listing_type_group_desc_CY
       , listing_type_group_desc_CZ
       , listing_type_group_desc
       , listing_type_group_desc_DK
       , listing_type_group_desc_EE
       , listing_type_group_desc_ES
       , listing_type_group_desc_FI
       , listing_type_group_desc_FR
       , listing_type_group_desc_GB
       , listing_type_group_desc_GR
       , listing_type_group_desc_HR
       , listing_type_group_desc_HU
       , listing_type_group_desc_IE
       , listing_type_group_desc_IT
       , listing_type_group_desc_LT
       , listing_type_group_desc_LV
       , listing_type_group_desc_NI
       , listing_type_group_desc_NL
       , listing_type_group_desc_DE
       , listing_type_group_desc_PL
       , listing_type_group_desc_PT
       , listing_type_group_desc_RO
       , listing_type_group_desc_SE
       , listing_type_group_desc_SI
       , listing_type_group_desc_SK
       , listing_type_group_desc_CS
       , listing_type_group_desc_MT
       , listing_type_group_desc_US
       , listing_type_group_desc_RS
  FROM P_LEW_MART_MSI.v_ref_itm_list_type_id_gr
;