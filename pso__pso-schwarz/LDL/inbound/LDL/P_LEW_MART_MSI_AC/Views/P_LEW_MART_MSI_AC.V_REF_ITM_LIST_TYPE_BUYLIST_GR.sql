CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_ITM_LIST_TYPE_BUYLIST_GR COMMENT = 'Multisprache Gruppen der Artikelarten Referenz'
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
# 1.11  10.08.2020    Roy,Ritanjal             Introduce new country Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr 
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  buying_list_type_group_id         COMMENT 'Gruppe der Art des Artikels ( Saison, ... )'
, buying_list_type_group_desc_AT    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels AT'
, buying_list_type_group_desc_BE    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels BE'
, buying_list_type_group_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels BE_FR'
, buying_list_type_group_desc_BG    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels BG'
, buying_list_type_group_desc_CH    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels CH'
, buying_list_type_group_desc_CY    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels CY'
, buying_list_type_group_desc_CZ    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels CZ'
, buying_list_type_group_desc       COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels ( Saison, ... )'
, buying_list_type_group_desc_DK    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels DK'
, buying_list_type_group_desc_EE    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels EE'
, buying_list_type_group_desc_ES    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels ES'
, buying_list_type_group_desc_FI    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels FI'
, buying_list_type_group_desc_FR    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels FR'
, buying_list_type_group_desc_GB    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels GB'
, buying_list_type_group_desc_GR    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels DG'
, buying_list_type_group_desc_HR    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels HR'
, buying_list_type_group_desc_HU    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels HU'
, buying_list_type_group_desc_IE    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels IE'
, buying_list_type_group_desc_IT    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels IT'
, buying_list_type_group_desc_LT    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels LT'
, buying_list_type_group_desc_LV    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels LV'
, buying_list_type_group_desc_NI    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels NI'
, buying_list_type_group_desc_NL    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels NL'
, buying_list_type_group_desc_DE    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels DE'
, buying_list_type_group_desc_PL    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels PL'
, buying_list_type_group_desc_PT    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels PT'
, buying_list_type_group_desc_RO    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels RO'
, buying_list_type_group_desc_SE    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels SE'
, buying_list_type_group_desc_SI    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels SI'
, buying_list_type_group_desc_SK    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels SK'
, buying_list_type_group_desc_CS    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels CS'
, buying_list_type_group_desc_MT    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels MT'
, buying_list_type_group_desc_US    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels US'
, buying_list_type_group_desc_RS    COMMENT 'Landesspezifische Bezeichnung Gruppe der Art des Artikels RS'
)
AS
SELECT  buying_list_type_group_id
      , buying_list_type_group_desc_AT
      , buying_list_type_group_desc_BE
      , buying_list_type_group_desc_BE_FR
      , buying_list_type_group_desc_BG
      , buying_list_type_group_desc_CH
      , buying_list_type_group_desc_CY
      , buying_list_type_group_desc_CZ
      , buying_list_type_group_desc
      , buying_list_type_group_desc_DK
      , buying_list_type_group_desc_EE
      , buying_list_type_group_desc_ES
      , buying_list_type_group_desc_FI
      , buying_list_type_group_desc_FR
      , buying_list_type_group_desc_GB
      , buying_list_type_group_desc_GR
      , buying_list_type_group_desc_HR
      , buying_list_type_group_desc_HU
      , buying_list_type_group_desc_IE
      , buying_list_type_group_desc_IT
      , buying_list_type_group_desc_LT
      , buying_list_type_group_desc_LV
      , buying_list_type_group_desc_NI
      , buying_list_type_group_desc_NL
      , buying_list_type_group_desc_DE
      , buying_list_type_group_desc_PL
      , buying_list_type_group_desc_PT
      , buying_list_type_group_desc_RO
      , buying_list_type_group_desc_SE
      , buying_list_type_group_desc_SI
      , buying_list_type_group_desc_SK
      , buying_list_type_group_desc_CS
      , buying_list_type_group_desc_MT
      , buying_list_type_group_desc_US
      , buying_list_type_group_desc_RS
FROM    p_lew_mart_msi.v_ref_itm_list_type_buylist_gr
;