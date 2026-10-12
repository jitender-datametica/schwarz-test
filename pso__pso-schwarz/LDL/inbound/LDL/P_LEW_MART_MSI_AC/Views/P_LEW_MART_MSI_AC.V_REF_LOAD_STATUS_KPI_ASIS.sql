CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_LOAD_STATUS_KPI_ASIS
/*
#----------------------------------------------------------------------------
# History:
#  1.0   8.11.2017    Gabriel Toth             Initial version
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.3  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.4  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.5  17.01.2018    Wieber.Harald            Release 2.2
#  1.6  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.7  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.8  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.9  12.04.2018    Wieber.Harald            Update Release 3.3
# 1.10  25.04.2018    Wieber.Harald            Update Release 3.5
# 1.11  03.05.2018    Wieber.Harald            Release 3.6
# 1.12  17.05.2018    Wieber,Harald            Update Release 3.8
#  2.0  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  04.01.2022    Morris, Michael          Added Estonia
#----------------------------------------------------------------------------
*/
(
  kpi_id
, kpi_group_id
, kpi_desc_AT
, kpi_desc_BE
, kpi_desc_BE_FR
, kpi_desc_BG
, kpi_desc_CH
, kpi_desc_CY
, kpi_desc_CZ
, kpi_desc
, kpi_desc_DK
, kpi_desc_EE
, kpi_desc_ES
, kpi_desc_FI
, kpi_desc_FR
, kpi_desc_GB
, kpi_desc_GR
, kpi_desc_HR
, kpi_desc_HU
, kpi_desc_IE
, kpi_desc_IT
, kpi_desc_LT
, kpi_desc_LV
, kpi_desc_NI
, kpi_desc_NL
, kpi_desc_DE
, kpi_desc_PL
, kpi_desc_PT
, kpi_desc_RO
, kpi_desc_SE
, kpi_desc_SI
, kpi_desc_SK
, kpi_desc_CS
, kpi_desc_MT
, kpi_desc_US
, kpi_desc_RS
, kpi_short_desc_AT
, kpi_short_desc_BE
, kpi_short_desc_BE_FR
, kpi_short_desc_BG
, kpi_short_desc_CH
, kpi_short_desc_CY
, kpi_short_desc_CZ
, kpi_short_desc
, kpi_short_desc_DK
, kpi_short_desc_EE
, kpi_short_desc_ES
, kpi_short_desc_FI
, kpi_short_desc_FR
, kpi_short_desc_GB
, kpi_short_desc_GR
, kpi_short_desc_HR
, kpi_short_desc_HU
, kpi_short_desc_IE
, kpi_short_desc_IT
, kpi_short_desc_LT
, kpi_short_desc_LV
, kpi_short_desc_NI
, kpi_short_desc_NL
, kpi_short_desc_DE
, kpi_short_desc_PL
, kpi_short_desc_PT
, kpi_short_desc_RO
, kpi_short_desc_SE
, kpi_short_desc_SI
, kpi_short_desc_SK
, kpi_short_desc_CS
, kpi_short_desc_MT
, kpi_short_desc_US
, kpi_short_desc_RS
, kpi_source_id
, kpi_level_cd
, kpi_sort_rank
, mod_tmsp
)
AS
SELECT   kpi_id
       , kpi_group_id
       , kpi_desc_AT
       , kpi_desc_BE
       , kpi_desc_BE_FR
       , kpi_desc_BG
       , kpi_desc_CH
       , kpi_desc_CY
       , kpi_desc_CZ
       , kpi_desc
       , kpi_desc_DK
       , kpi_desc_EE
       , kpi_desc_ES
       , kpi_desc_FI
       , kpi_desc_FR
       , kpi_desc_GB
       , kpi_desc_GR
       , kpi_desc_HR
       , kpi_desc_HU
       , kpi_desc_IE
       , kpi_desc_IT
       , kpi_desc_LT
       , kpi_desc_LV
       , kpi_desc_NI
       , kpi_desc_NL
       , kpi_desc_DE
       , kpi_desc_PL
       , kpi_desc_PT
       , kpi_desc_RO
       , kpi_desc_SE
       , kpi_desc_SI
       , kpi_desc_SK
       , kpi_desc_CS
       , kpi_desc_MT
       , kpi_desc_US
       , kpi_desc_RS
       , kpi_short_desc_AT
       , kpi_short_desc_BE
       , kpi_short_desc_BE_FR
       , kpi_short_desc_BG
       , kpi_short_desc_CH
       , kpi_short_desc_CY
       , kpi_short_desc_CZ
       , kpi_short_desc
       , kpi_short_desc_DK
       , kpi_short_desc_EE
       , kpi_short_desc_ES
       , kpi_short_desc_FI
       , kpi_short_desc_FR
       , kpi_short_desc_GB
       , kpi_short_desc_GR
       , kpi_short_desc_HR
       , kpi_short_desc_HU
       , kpi_short_desc_IE
       , kpi_short_desc_IT
       , kpi_short_desc_LT
       , kpi_short_desc_LV
       , kpi_short_desc_NI
       , kpi_short_desc_NL
       , kpi_short_desc_DE
       , kpi_short_desc_PL
       , kpi_short_desc_PT
       , kpi_short_desc_RO
       , kpi_short_desc_SE
       , kpi_short_desc_SI
       , kpi_short_desc_SK
       , kpi_short_desc_CS
       , kpi_short_desc_MT
       , kpi_short_desc_US
       , kpi_short_desc_RS
       , kpi_source_id
       , kpi_level_cd
       , kpi_sort_rank
       , mod_tmsp
  FROM P_LEW_MART_MSI.v_ref_load_status_kpi_asis
;