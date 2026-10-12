CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_ITEMGROUP_INT_2 COMMENT = 'Multi language International Item_2 Group descriptions'
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
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  itemgroup_int_id         COMMENT 'Artikelgruppe ID'
, itemgroup_int_remark     COMMENT 'Artikelgruppe Kommentar'
, itemgroup_int_desc_AT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung AT'
, itemgroup_int_desc_BE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung BE'
, itemgroup_int_desc_BE_FR COMMENT 'Artikelgruppe Landesspezifische Bezeichnung BE_FR'
, itemgroup_int_desc_BG    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung BG'
, itemgroup_int_desc_CH    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CH'
, itemgroup_int_desc_CY    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CY'
, itemgroup_int_desc_CZ    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CZ'
, itemgroup_int_desc       COMMENT 'Artikelgruppe Generische Bezeichnung '
, itemgroup_int_desc_DK    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung DK'
, itemgroup_int_desc_EE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung EE'
, itemgroup_int_desc_ES    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung ES'
, itemgroup_int_desc_FI    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung FI'
, itemgroup_int_desc_FR    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung FR'
, itemgroup_int_desc_GB    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung GB'
, itemgroup_int_desc_GR    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung GR'
, itemgroup_int_desc_HR    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung HR'
, itemgroup_int_desc_HU    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung HU'
, itemgroup_int_desc_IE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung IE'
, itemgroup_int_desc_IT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung IT'
, itemgroup_int_desc_LT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung LT'
, itemgroup_int_desc_LV    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung LV'
, itemgroup_int_desc_NI    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung NI'
, itemgroup_int_desc_NL    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung NL'
, itemgroup_int_desc_DE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung DE'
, itemgroup_int_desc_PL    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung PL'
, itemgroup_int_desc_PT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung PT'
, itemgroup_int_desc_RO    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung RO'
, itemgroup_int_desc_SE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung SE'
, itemgroup_int_desc_SI    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung SI'
, itemgroup_int_desc_SK    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung SK'
, itemgroup_int_desc_CS    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CS'
, itemgroup_int_desc_MT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung MT'
, itemgroup_int_desc_US    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung US'
, itemgroup_int_desc_RS    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung RS_2'
)
AS
SELECT   itemgroup_int_id
       , itemgroup_int_remark
       , itemgroup_int_desc_AT
       , itemgroup_int_desc_BE
       , itemgroup_int_desc_BE_FR
       , itemgroup_int_desc_BG
       , itemgroup_int_desc_CH
       , itemgroup_int_desc_CY
       , itemgroup_int_desc_CZ
       , itemgroup_int_desc
       , itemgroup_int_desc_DK
       , itemgroup_int_desc_EE
       , itemgroup_int_desc_ES
       , itemgroup_int_desc_FI
       , itemgroup_int_desc_FR
       , itemgroup_int_desc_GB
       , itemgroup_int_desc_GR
       , itemgroup_int_desc_HR
       , itemgroup_int_desc_HU
       , itemgroup_int_desc_IE
       , itemgroup_int_desc_IT
       , itemgroup_int_desc_LT
       , itemgroup_int_desc_LV
       , itemgroup_int_desc_NI
       , itemgroup_int_desc_NL
       , itemgroup_int_desc_DE
       , itemgroup_int_desc_PL
       , itemgroup_int_desc_PT
       , itemgroup_int_desc_RO
       , itemgroup_int_desc_SE
       , itemgroup_int_desc_SI
       , itemgroup_int_desc_SK
       , itemgroup_int_desc_CS
       , itemgroup_int_desc_MT
       , itemgroup_int_desc_US
       , itemgroup_int_desc_RS
  FROM P_LEW_MART_MSI.v_itm_itemgroup_int_2
;