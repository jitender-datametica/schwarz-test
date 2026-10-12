CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_FAMILYGROUP_1 COMMENT = 'Multi language Item_1 Family Group descriptions'
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
#  1.7  22.03.2018    Meister.Ulrich           Update to Release 3.1
#  1.8  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13 27.12.2021     Zied Nanaa               Add languages BE_FR and EE
# 1.12 15.05.2024     Bialek, Aleksander       Add the AF Code to the view for EK-Security filtering use, ADO WI:618120
#----------------------------------------------------------------------------
*/
(
  client_id                    COMMENT 'Landeskennzeichen'
, family_cd                    COMMENT 'Artikelfamile Landesspezifischer Code WAWI'
, item_familygroup_id          COMMENT 'Artikelfamilen ID'
, subitemgroup_id              COMMENT 'WAWI CD'
, src_familygrp_cd             COMMENT 'Full Artikelfamile Landesspezifischer Code WAWI'
, item_family_desc_AT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang AT'
, item_family_desc_BE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE'
, item_family_desc_BE_FR       COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE_FR'
, item_family_desc_BG          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BG'
, item_family_desc_CH          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CH'
, item_family_desc_CY          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CY'
, item_family_desc_CZ          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CZ'
, item_family_desc             COMMENT 'Artikelfamile Bezeichnung Lang'
, item_family_desc_DK          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DK'
, item_family_desc_EE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang EE'
, item_family_desc_ES          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang ES'
, item_family_desc_FI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FI'
, item_family_desc_FR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FR'
, item_family_desc_GB          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GB'
, item_family_desc_GR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GR'
, item_family_desc_HR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HR'
, item_family_desc_HU          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HU'
, item_family_desc_IE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IE'
, item_family_desc_IT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IT'
, item_family_desc_LT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LT'
, item_family_desc_LV          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LV'
, item_family_desc_NI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NI'
, item_family_desc_NL          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NL'
, item_family_desc_DE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DE'
, item_family_desc_PL          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PL'
, item_family_desc_PT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PT'
, item_family_desc_RO          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RO'
, item_family_desc_SE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SE'
, item_family_desc_SI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SI'
, item_family_desc_SK          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SK'
, item_family_desc_CS          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CS'
, item_family_desc_MT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang MT'
, item_family_desc_US          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang US'
, item_family_desc_RS          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RS_1'
, item_family_short_desc_AT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung AT'
, item_family_short_desc_BE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE'
, item_family_short_desc_BE_FR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE_FR'
, item_family_short_desc_BG    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BG'
, item_family_short_desc_CH    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CH'
, item_family_short_desc_CY    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CY'
, item_family_short_desc_CZ    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CZ'
, item_family_short_desc       COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung'
, item_family_short_desc_DK    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DK'
, item_family_short_desc_EE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung EE'
, item_family_short_desc_ES    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung ES'
, item_family_short_desc_FI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FI'
, item_family_short_desc_FR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FR'
, item_family_short_desc_GB    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GB'
, item_family_short_desc_GR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GR'
, item_family_short_desc_HR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HR'
, item_family_short_desc_HU    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HU'
, item_family_short_desc_IE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IE'
, item_family_short_desc_IT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IT'
, item_family_short_desc_LT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LT'
, item_family_short_desc_LV    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LV'
, item_family_short_desc_NI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NI'
, item_family_short_desc_NL    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NL'
, item_family_short_desc_DE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DE'
, item_family_short_desc_PL    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PL'
, item_family_short_desc_PT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PT'
, item_family_short_desc_RO    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RO'
, item_family_short_desc_SE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SE'
, item_family_short_desc_SI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SI'
, item_family_short_desc_SK    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SK'
, item_family_short_desc_CS    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CS'
, item_family_short_desc_MT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung MT'
, item_family_short_desc_US    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung US'
, item_family_short_desc_RS    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RS_1'
)
AS
SELECT   client_id
       , family_cd
       , item_familygroup_id
       , subitemgroup_id
	   , src_familygrp_cd
       , item_family_desc_AT
       , item_family_desc_BE
       , item_family_desc_BE_FR
       , item_family_desc_BG
       , item_family_desc_CH
       , item_family_desc_CY
       , item_family_desc_CZ
       , item_family_desc
       , item_family_desc_DK
       , item_family_desc_EE
       , item_family_desc_ES
       , item_family_desc_FI
       , item_family_desc_FR
       , item_family_desc_GB
       , item_family_desc_GR
       , item_family_desc_HR
       , item_family_desc_HU
       , item_family_desc_IE
       , item_family_desc_IT
       , item_family_desc_LT
       , item_family_desc_LV
       , item_family_desc_NI
       , item_family_desc_NL
       , item_family_desc_DE
       , item_family_desc_PL
       , item_family_desc_PT
       , item_family_desc_RO
       , item_family_desc_SE
       , item_family_desc_SI
       , item_family_desc_SK
       , item_family_desc_CS
       , item_family_desc_MT
       , item_family_desc_US
       , item_family_desc_RS
       , item_family_short_desc_AT
       , item_family_short_desc_BE
       , item_family_short_desc_BE_FR
       , item_family_short_desc_BG
       , item_family_short_desc_CH
       , item_family_short_desc_CY
       , item_family_short_desc_CZ
       , item_family_short_desc
       , item_family_short_desc_DK
       , item_family_short_desc_EE
       , item_family_short_desc_ES
       , item_family_short_desc_FI
       , item_family_short_desc_FR
       , item_family_short_desc_GB
       , item_family_short_desc_GR
       , item_family_short_desc_HR
       , item_family_short_desc_HU
       , item_family_short_desc_IE
       , item_family_short_desc_IT
       , item_family_short_desc_LT
       , item_family_short_desc_LV
       , item_family_short_desc_NI
       , item_family_short_desc_NL
       , item_family_short_desc_DE
       , item_family_short_desc_PL
       , item_family_short_desc_PT
       , item_family_short_desc_RO
       , item_family_short_desc_SE
       , item_family_short_desc_SI
       , item_family_short_desc_SK
       , item_family_short_desc_CS
       , item_family_short_desc_MT
       , item_family_short_desc_US
       , item_family_short_desc_RS
  FROM P_LEW_MART_MSI.v_itm_familygroup_1
;