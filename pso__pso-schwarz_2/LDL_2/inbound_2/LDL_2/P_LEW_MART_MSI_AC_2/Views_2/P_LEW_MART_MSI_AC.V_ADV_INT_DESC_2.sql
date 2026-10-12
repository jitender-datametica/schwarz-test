CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ADV_INT_DESC_2
/*
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.6  03.05.2018    Wieber.Harald            Release 3.6
#  1.7  17.05.2018    Wieber,Harald            Update Release 3.8
#  1.8  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.9  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  cy
, adv_week_int
, adv_wt_nr_int
, adv_desc_int
, adv_short_desc_int
, adv_desc_int_AT
, adv_short_desc_int_AT
, adv_desc_int_BE
, adv_short_desc_int_BE
, adv_desc_int_BE_FR
, adv_short_desc_int_BE_FR
, adv_desc_int_BG
, adv_short_desc_int_BG
, adv_desc_int_CH
, adv_short_desc_int_CH
, adv_desc_int_CY
, adv_short_desc_int_CY
, adv_desc_int_CZ
, adv_short_desc_int_CZ
, adv_desc_int_DK
, adv_short_desc_int_DK
, adv_desc_int_EE
, adv_short_desc_int_EE
, adv_desc_int_ES
, adv_short_desc_int_ES
, adv_desc_int_FI
, adv_short_desc_int_FI
, adv_desc_int_FR
, adv_short_desc_int_FR
, adv_desc_int_GB
, adv_short_desc_int_GB
, adv_desc_int_GR
, adv_short_desc_int_GR
, adv_desc_int_HR
, adv_short_desc_int_HR
, adv_desc_int_HU
, adv_short_desc_int_HU
, adv_desc_int_IE
, adv_short_desc_int_IE
, adv_desc_int_IT
, adv_short_desc_int_IT
, adv_desc_int_LT
, adv_short_desc_int_LT
, adv_desc_int_LV
, adv_short_desc_int_LV
, adv_desc_int_NI
, adv_short_desc_int_NI
, adv_desc_int_NL
, adv_short_desc_int_NL
, adv_desc_int_DE
, adv_short_desc_int_DE
, adv_desc_int_PL
, adv_short_desc_int_PL
, adv_desc_int_PT
, adv_short_desc_int_PT
, adv_desc_int_RO
, adv_short_desc_int_RO
, adv_desc_int_SE
, adv_short_desc_int_SE
, adv_desc_int_SI
, adv_short_desc_int_SI
, adv_desc_int_SK
, adv_short_desc_int_SK
, adv_desc_int_CS
, adv_short_desc_int_CS
, adv_desc_int_MT
, adv_short_desc_int_MT
, adv_desc_int_US
, adv_short_desc_int_US
, adv_desc_int_RS
, adv_short_desc_int_RS
, cy_week
 )
AS
SELECT   cy
       , adv_week_int
       , adv_wt_nr_int
       , adv_desc_int
       , adv_short_desc_int
       , adv_desc_int_AT
       , adv_short_desc_int_AT
       , adv_desc_int_BE
       , adv_short_desc_int_BE
       , adv_desc_int_BE_FR
       , adv_short_desc_int_BE_FR
       , adv_desc_int_BG
       , adv_short_desc_int_BG
       , adv_desc_int_CH
       , adv_short_desc_int_CH
       , adv_desc_int_CY
       , adv_short_desc_int_CY
       , adv_desc_int_CZ
       , adv_short_desc_int_CZ
       , adv_desc_int_DK
       , adv_short_desc_int_DK
       , adv_desc_int_EE
       , adv_short_desc_int_EE
       , adv_desc_int_ES
       , adv_short_desc_int_ES
       , adv_desc_int_FI
       , adv_short_desc_int_FI
       , adv_desc_int_FR
       , adv_short_desc_int_FR
       , adv_desc_int_GB
       , adv_short_desc_int_GB
       , adv_desc_int_GR
       , adv_short_desc_int_GR
       , adv_desc_int_HR
       , adv_short_desc_int_HR
       , adv_desc_int_HU
       , adv_short_desc_int_HU
       , adv_desc_int_IE
       , adv_short_desc_int_IE
       , adv_desc_int_IT
       , adv_short_desc_int_IT
       , adv_desc_int_LT
       , adv_short_desc_int_LT
       , adv_desc_int_LV
       , adv_short_desc_int_LV
       , adv_desc_int_NI
       , adv_short_desc_int_NI
       , adv_desc_int_NL
       , adv_short_desc_int_NL
       , adv_desc_int_DE
       , adv_short_desc_int_DE
       , adv_desc_int_PL
       , adv_short_desc_int_PL
       , adv_desc_int_PT
       , adv_short_desc_int_PT
       , adv_desc_int_RO
       , adv_short_desc_int_RO
       , adv_desc_int_SE
       , adv_short_desc_int_SE
       , adv_desc_int_SI
       , adv_short_desc_int_SI
       , adv_desc_int_SK
       , adv_short_desc_int_SK
       , adv_desc_int_CS
       , adv_short_desc_int_CS
       , adv_desc_int_MT
       , adv_short_desc_int_MT
       , adv_desc_int_US
       , adv_short_desc_int_US
       , adv_desc_int_RS
       , adv_short_desc_int_RS
       , cy_week
  FROM P_LEW_MART_MSI.v_adv_int_desc_2
;


