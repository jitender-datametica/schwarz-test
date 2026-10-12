CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_LP_REVISION_TYPE
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
#  1.10 07.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
    revision_type_id
  , revision_type_desc_AT
  , revision_type_desc_BE
  , revision_type_desc_BE_FR
  , revision_type_desc_BG
  , revision_type_desc_CH
  , revision_type_desc_CY
  , revision_type_desc_CZ
  , revision_type_desc
  , revision_type_desc_DK
  , revision_type_desc_EE
  , revision_type_desc_ES
  , revision_type_desc_FI
  , revision_type_desc_FR
  , revision_type_desc_GB
  , revision_type_desc_GR
  , revision_type_desc_HR
  , revision_type_desc_HU
  , revision_type_desc_IE
  , revision_type_desc_IT
  , revision_type_desc_LT
  , revision_type_desc_LV
  , revision_type_desc_NI
  , revision_type_desc_NL
  , revision_type_desc_DE
  , revision_type_desc_PL
  , revision_type_desc_PT
  , revision_type_desc_RO
  , revision_type_desc_SE
  , revision_type_desc_SI
  , revision_type_desc_SK
  , revision_type_desc_CS
  , revision_type_desc_MT
  , revision_type_desc_US
  , revision_type_desc_RS
)
AS
SELECT  revision_type_id
      , revision_type_desc_AT
      , revision_type_desc_BE
      , revision_type_desc_BE_FR
      , revision_type_desc_BG
      , revision_type_desc_CH
      , revision_type_desc_CY
      , revision_type_desc_CZ
      , revision_type_desc
      , revision_type_desc_DK
      , revision_type_desc_EE
      , revision_type_desc_ES
      , revision_type_desc_FI
      , revision_type_desc_FR
      , revision_type_desc_GB
      , revision_type_desc_GR
      , revision_type_desc_HR
      , revision_type_desc_HU
      , revision_type_desc_IE
      , revision_type_desc_IT
      , revision_type_desc_LT
      , revision_type_desc_LV
      , revision_type_desc_NI
      , revision_type_desc_NL
      , revision_type_desc_DE
      , revision_type_desc_PL
      , revision_type_desc_PT
      , revision_type_desc_RO
      , revision_type_desc_SE
      , revision_type_desc_SI
      , revision_type_desc_SK
      , revision_type_desc_CS
      , revision_type_desc_MT
      , revision_type_desc_US
      , revision_type_desc_RS
FROM    P_LEW_MART_MSI.v_ejr_lp_revision_type
;