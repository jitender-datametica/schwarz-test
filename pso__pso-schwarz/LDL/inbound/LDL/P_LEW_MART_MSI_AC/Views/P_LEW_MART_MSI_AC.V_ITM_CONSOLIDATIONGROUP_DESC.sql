CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_CONSOLIDATIONGROUP_DESC COMMENT = 'Multi language Item Consolidation Group descriptions'
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
#  2.0  10.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#-----------------------------------------------------------------------------
*/
(
    client_id                 COMMENT 'Landeskennzeichen'
  , wh_id                     COMMENT 'Gesellschafts-Nr.'
  , itm_consgrp_id            COMMENT 'BGES (1)/VGES (2)'
  , cons_orig_item_nr         COMMENT 'Konsolidierungsobergruppennummer'
  , cons_dat_valid_from_item  COMMENT 'Gültig von Datum'
  , cons_fg                   COMMENT 'Consolidierungs-Gruppen Flag'
  , cons_item_desc_AT         COMMENT 'Consolidierungsgruppe Bezeichnung '
  , cons_item_desc_BE         COMMENT 'Consolidierungsgruppe Bezeichnung BE'
  , cons_item_desc_BE_FR      COMMENT 'Consolidierungsgruppe Bezeichnung BE_FR'
  , cons_item_desc_BG         COMMENT 'Consolidierungsgruppe Bezeichnung BG'
  , cons_item_desc_CH         COMMENT 'Consolidierungsgruppe Bezeichnung CH'
  , cons_item_desc_CY         COMMENT 'Consolidierungsgruppe Bezeichnung CY'
  , cons_item_desc_CZ         COMMENT 'Consolidierungsgruppe Bezeichnung CZ'
  , cons_item_desc            COMMENT 'Consolidierungsgruppe Bezeichnung'
  , cons_item_desc_DK         COMMENT 'Consolidierungsgruppe Bezeichnung DK'
  , cons_item_desc_EE         COMMENT 'Consolidierungsgruppe Bezeichnung EE'
  , cons_item_desc_ES         COMMENT 'Consolidierungsgruppe Bezeichnung ES'
  , cons_item_desc_FI         COMMENT 'Consolidierungsgruppe Bezeichnung FI'
  , cons_item_desc_FR         COMMENT 'Consolidierungsgruppe Bezeichnung FR'
  , cons_item_desc_GB         COMMENT 'Consolidierungsgruppe Bezeichnung GB'
  , cons_item_desc_GR         COMMENT 'Consolidierungsgruppe Bezeichnung GR'
  , cons_item_desc_HR         COMMENT 'Consolidierungsgruppe Bezeichnung HR'
  , cons_item_desc_HU         COMMENT 'Consolidierungsgruppe Bezeichnung HU'
  , cons_item_desc_IE         COMMENT 'Consolidierungsgruppe Bezeichnung IE'
  , cons_item_desc_IT         COMMENT 'Consolidierungsgruppe Bezeichnung IT'
  , cons_item_desc_LT         COMMENT 'Consolidierungsgruppe Bezeichnung LT'
  , cons_item_desc_LV         COMMENT 'Consolidierungsgruppe Bezeichnung LV'
  , cons_item_desc_NI         COMMENT 'Consolidierungsgruppe Bezeichnung NI'
  , cons_item_desc_NL         COMMENT 'Consolidierungsgruppe Bezeichnung NL'
  , cons_item_desc_DE         COMMENT 'Consolidierungsgruppe Bezeichnung DE'
  , cons_item_desc_PL         COMMENT 'Consolidierungsgruppe Bezeichnung PL'
  , cons_item_desc_PT         COMMENT 'Consolidierungsgruppe Bezeichnung PT'
  , cons_item_desc_RO         COMMENT 'Consolidierungsgruppe Bezeichnung RO'
  , cons_item_desc_SE         COMMENT 'Consolidierungsgruppe Bezeichnung SE'
  , cons_item_desc_SI         COMMENT 'Consolidierungsgruppe Bezeichnung SI'
  , cons_item_desc_SK         COMMENT 'Consolidierungsgruppe Bezeichnung SK'
  , cons_item_desc_CS         COMMENT 'Consolidierungsgruppe Bezeichnung CS'
  , cons_item_desc_MT         COMMENT 'Consolidierungsgruppe Bezeichnung MT'
  , cons_item_desc_US         COMMENT 'Consolidierungsgruppe Bezeichnung US'
  , cons_item_desc_RS         COMMENT 'Consolidierungsgruppe Bezeichnung RS'
 )
AS
SELECT  client_id
      , wh_id
      , itm_consgrp_id
      , cons_orig_item_nr
      , cons_dat_valid_from_item
      , cons_fg
      , cons_item_desc_AT
      , cons_item_desc_BE
      , cons_item_desc_BE_FR
      , cons_item_desc_BG
      , cons_item_desc_CH
      , cons_item_desc_CY
      , cons_item_desc_CZ
      , cons_item_desc
      , cons_item_desc_DK
      , cons_item_desc_EE
      , cons_item_desc_ES
      , cons_item_desc_FI
      , cons_item_desc_FR
      , cons_item_desc_GB
      , cons_item_desc_GR
      , cons_item_desc_HR
      , cons_item_desc_HU
      , cons_item_desc_IE
      , cons_item_desc_IT
      , cons_item_desc_LT
      , cons_item_desc_LV
      , cons_item_desc_NI
      , cons_item_desc_NL
      , cons_item_desc_DE
      , cons_item_desc_PL
      , cons_item_desc_PT
      , cons_item_desc_RO
      , cons_item_desc_SE
      , cons_item_desc_SI
      , cons_item_desc_SK
      , cons_item_desc_CS
      , cons_item_desc_MT
      , cons_item_desc_US
      , cons_item_desc_RS
FROM    P_LEW_MART_MSI.v_itm_consolidationgroup_desc
;