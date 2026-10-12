CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_ACTIONGROUP_DESC_2 COMMENT = 'Mulri language item_2 action group descriptions'
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
#  2.0  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              Patch: 20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#-----------------------------------------------------------------------------
*/
(
    client_id                COMMENT 'Landeskennzeichen'
  , item_actiongroup_id      COMMENT 'Referenziert auf C665_MAINGRPNR, in der WAWI auf VARCHAR 13, da zuerst geplant war, ACTIONGRP und AC'
  , dat_valid_from           COMMENT 'Gültig ab, wird vom Vorsystem Wawi geliefert'
  , dat_valid_until          COMMENT 'Gültig bis, wird vom Vorsystem Wawi geliefert'
  , item_actgroup_desc_AT    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung AT'
  , item_actgroup_desc_BE    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung BE'
  , item_actgroup_desc_BE_FR COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung BE_FR'
  , item_actgroup_desc_BG    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung BG'
  , item_actgroup_desc_CH    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung CH'
  , item_actgroup_desc_CY    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung CY'
  , item_actgroup_desc_CZ    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung CZ'
  , item_actgroup_desc       COMMENT 'Artikel_2 - Aktionsgruppe Beschreibung'
  , item_actgroup_desc_DK    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung DK'
  , item_actgroup_desc_EE    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung EE'
  , item_actgroup_desc_ES    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung ES'
  , item_actgroup_desc_FI    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung FI'
  , item_actgroup_desc_FR    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung FR'
  , item_actgroup_desc_GB    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung GB'
  , item_actgroup_desc_GR    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung GR'
  , item_actgroup_desc_HR    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung HR'
  , item_actgroup_desc_HU    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung HU'
  , item_actgroup_desc_IE    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung IE'
  , item_actgroup_desc_IT    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung IT'
  , item_actgroup_desc_LT    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung LT'
  , item_actgroup_desc_LV    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung LV'
  , item_actgroup_desc_NI    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung NI'
  , item_actgroup_desc_NL    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung NL'
  , item_actgroup_desc_DE    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung DE'
  , item_actgroup_desc_PL    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung PL'
  , item_actgroup_desc_PT    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung PT'
  , item_actgroup_desc_RO    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung RO'
  , item_actgroup_desc_SE    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung SE'
  , item_actgroup_desc_SI    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung SI'
  , item_actgroup_desc_SK    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung SK'
  , item_actgroup_desc_CS    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung CS'
  , item_actgroup_desc_MT    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung MT'
  , item_actgroup_desc_US    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung US'
  , item_actgroup_desc_RS    COMMENT 'Artikel_2 - Aktionsgruppe Landesspezifische Bezeichnung RS_2'
 )
AS
SELECT  client_id
      , item_actiongroup_id
      , dat_valid_from
      , dat_valid_until
      , item_actgroup_desc_AT
      , item_actgroup_desc_BE
      , item_actgroup_desc_BE_FR
      , item_actgroup_desc_BG
      , item_actgroup_desc_CH
      , item_actgroup_desc_CY
      , item_actgroup_desc_CZ
      , item_actgroup_desc
      , item_actgroup_desc_DK
      , item_actgroup_desc_EE
      , item_actgroup_desc_ES
      , item_actgroup_desc_FI
      , item_actgroup_desc_FR
      , item_actgroup_desc_GB
      , item_actgroup_desc_GR
      , item_actgroup_desc_HR
      , item_actgroup_desc_HU
      , item_actgroup_desc_IE
      , item_actgroup_desc_IT
      , item_actgroup_desc_LT
      , item_actgroup_desc_LV
      , item_actgroup_desc_NI
      , item_actgroup_desc_NL
      , item_actgroup_desc_DE
      , item_actgroup_desc_PL
      , item_actgroup_desc_PT
      , item_actgroup_desc_RO
      , item_actgroup_desc_SE
      , item_actgroup_desc_SI
      , item_actgroup_desc_SK
      , item_actgroup_desc_CS
      , item_actgroup_desc_MT
      , item_actgroup_desc_US
      , item_actgroup_desc_RS
FROM P_LEW_MART_MSI.v_itm_actiongroup_desc_2
;