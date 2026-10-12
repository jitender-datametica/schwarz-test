CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_SUB_ACTIONGROUP_DESC_1
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
#  1.10 07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
    client_id
  , item_sub_actiongroup_id
  , item_actiongroup_id
  , dat_valid_from
  , dat_valid_until
  , item_sub_actgroup_desc_AT
  , item_sub_actgroup_desc_BE
  , item_sub_actgroup_desc_BE_FR
  , item_sub_actgroup_desc_BG
  , item_sub_actgroup_desc_CH
  , item_sub_actgroup_desc_CY
  , item_sub_actgroup_desc_CZ
  , item_sub_actgroup_desc
  , item_sub_actgroup_desc_DK
  , item_sub_actgroup_desc_EE
  , item_sub_actgroup_desc_ES
  , item_sub_actgroup_desc_FI
  , item_sub_actgroup_desc_FR
  , item_sub_actgroup_desc_GB
  , item_sub_actgroup_desc_GR
  , item_sub_actgroup_desc_HR
  , item_sub_actgroup_desc_HU
  , item_sub_actgroup_desc_IE
  , item_sub_actgroup_desc_IT
  , item_sub_actgroup_desc_LT
  , item_sub_actgroup_desc_LV
  , item_sub_actgroup_desc_NI
  , item_sub_actgroup_desc_NL
  , item_sub_actgroup_desc_DE
  , item_sub_actgroup_desc_PL
  , item_sub_actgroup_desc_PT
  , item_sub_actgroup_desc_RO
  , item_sub_actgroup_desc_SE
  , item_sub_actgroup_desc_SI
  , item_sub_actgroup_desc_SK
  , item_sub_actgroup_desc_CS
  , item_sub_actgroup_desc_MT
  , item_sub_actgroup_desc_US
  , item_sub_actgroup_desc_RS
 )
AS
SELECT  client_id
      , item_sub_actiongroup_id
      , item_actiongroup_id
      , dat_valid_from
      , dat_valid_until
      , item_sub_actgroup_desc_AT
      , item_sub_actgroup_desc_BE
      , item_sub_actgroup_desc_BE_FR
      , item_sub_actgroup_desc_BG
      , item_sub_actgroup_desc_CH
      , item_sub_actgroup_desc_CY
      , item_sub_actgroup_desc_CZ
      , item_sub_actgroup_desc
      , item_sub_actgroup_desc_DK
      , item_sub_actgroup_desc_EE
      , item_sub_actgroup_desc_ES
      , item_sub_actgroup_desc_FI
      , item_sub_actgroup_desc_FR
      , item_sub_actgroup_desc_GB
      , item_sub_actgroup_desc_GR
      , item_sub_actgroup_desc_HR
      , item_sub_actgroup_desc_HU
      , item_sub_actgroup_desc_IE
      , item_sub_actgroup_desc_IT
      , item_sub_actgroup_desc_LT
      , item_sub_actgroup_desc_LV
      , item_sub_actgroup_desc_NI
      , item_sub_actgroup_desc_NL
      , item_sub_actgroup_desc_DE
      , item_sub_actgroup_desc_PL
      , item_sub_actgroup_desc_PT
      , item_sub_actgroup_desc_RO
      , item_sub_actgroup_desc_SE
      , item_sub_actgroup_desc_SI
      , item_sub_actgroup_desc_SK
      , item_sub_actgroup_desc_CS
      , item_sub_actgroup_desc_MT
      , item_sub_actgroup_desc_US
      , item_sub_actgroup_desc_RS
FROM P_LEW_MART_MSI.v_itm_sub_actiongroup_desc_1
;