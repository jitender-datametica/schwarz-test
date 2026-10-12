CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_LOAD_STATUS_SOURCE_ASIS
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
#  1.9  25.04.2018    Wieber.Harald            Update Release 3.5
# 1.10  03.05.2018    Wieber.Harald            Release 3.6
# 1.11  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.12  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  04.01.2022    Morris, Michael          Added Estonia
#----------------------------------------------------------------------------
*/
(
  source_id
, source_desc_AT
, source_desc_BE
, source_desc_BE_FR
, source_desc_BG
, source_desc_CH
, source_desc_CY
, source_desc_CZ
, source_desc
, source_desc_DK
, source_desc_EE
, source_desc_ES
, source_desc_FI
, source_desc_FR
, source_desc_GB
, source_desc_GR
, source_desc_HR
, source_desc_HU
, source_desc_IE
, source_desc_IT
, source_desc_LT
, source_desc_LV
, source_desc_NI
, source_desc_NL
, source_desc_DE
, source_desc_PL
, source_desc_PT
, source_desc_RO
, source_desc_SE
, source_desc_SI
, source_desc_SK
, source_desc_CS
, source_desc_MT
, source_desc_US
, source_desc_RS
, mod_tmsp
)
AS
SELECT   source_id
       , source_desc_AT
       , source_desc_BE
       , source_desc_BE_FR
       , source_desc_BG
       , source_desc_CH
       , source_desc_CY
       , source_desc_CZ
       , source_desc
       , source_desc_DK
       , source_desc_EE
       , source_desc_ES
       , source_desc_FI
       , source_desc_FR
       , source_desc_GB
       , source_desc_GR
       , source_desc_HR
       , source_desc_HU
       , source_desc_IE
       , source_desc_IT
       , source_desc_LT
       , source_desc_LV
       , source_desc_NI
       , source_desc_NL
       , source_desc_DE
       , source_desc_PL
       , source_desc_PT
       , source_desc_RO
       , source_desc_SE
       , source_desc_SI
       , source_desc_SK
       , source_desc_CS
       , source_desc_MT
       , source_desc_US
       , source_desc_RS
       , mod_tmsp
  FROM P_LEW_MART_MSI.v_ref_load_status_source_asis
;