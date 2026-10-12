CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAWI_CAL_WEEK_PARTIAL_WEEK_2
/*
#----------------------------------------------------------------------------
# History:
#  1.0  19.10.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Update
#  1.2  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.3  17.01.2018    Wieber.Harald            Update Release 2.2
#  1.4  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.5  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.6  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.7  03.05.2018    Wieber.Harald            Release 3.6
#  1.8  17.05.2018    Wieber,Harald            Update Release 3.8
#  1.9  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  1.10 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.11 21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  cy_week_partial_week_id1
, cy_week_partial_week_id2
, cy_week_partial_week_name
, cy_month
, busyear
, cy_week_partial_week_id
, partialweek_in_mth_seq_asc
, partialweek_in_mth_seq_desc
, cy_partial_week_short_desc_AT
, cy_partial_week_short_desc_BE
, cy_partial_week_short_desc_BE_FR
, cy_partial_week_short_desc_BG
, cy_partial_week_short_desc_CH
, cy_partial_week_short_desc_CY
, cy_partial_week_short_desc_CZ
, cy_partial_week_short_desc
, cy_partial_week_short_desc_DK
, cy_partial_week_short_desc_EE
, cy_partial_week_short_desc_ES
, cy_partial_week_short_desc_FI
, cy_partial_week_short_desc_FR
, cy_partial_week_short_desc_GB
, cy_partial_week_short_desc_GR
, cy_partial_week_short_desc_HR
, cy_partial_week_short_desc_HU
, cy_partial_week_short_desc_IE
, cy_partial_week_short_desc_IT
, cy_partial_week_short_desc_LT
, cy_partial_week_short_desc_LV
, cy_partial_week_short_desc_NI
, cy_partial_week_short_desc_NL
, cy_partial_week_short_desc_DE
, cy_partial_week_short_desc_PL
, cy_partial_week_short_desc_PT
, cy_partial_week_short_desc_RO
, cy_partial_week_short_desc_SE
, cy_partial_week_short_desc_SI
, cy_partial_week_short_desc_SK
, cy_partial_week_short_desc_CS
, cy_partial_week_short_desc_MT
, cy_partial_week_short_desc_US
, cy_partial_week_short_desc_RS
 )
AS
SELECT   cy_week_partial_week_id1
       , cy_week_partial_week_id2
       , cy_week_partial_week_name
       , cy_month
       , busyear
       , cy_week_partial_week_id
       , partialweek_in_mth_seq_asc
       , partialweek_in_mth_seq_desc
       , cy_partial_week_short_desc_AT
       , cy_partial_week_short_desc_BE
       , cy_partial_week_short_desc_FR AS cy_partial_week_short_desc_BE_FR
       , cy_partial_week_short_desc_BG
       , cy_partial_week_short_desc_CH
       , cy_partial_week_short_desc_CY
       , cy_partial_week_short_desc_CZ
       , cy_partial_week_short_desc
       , cy_partial_week_short_desc_DK
       , cy_partial_week_short_desc_EE
       , cy_partial_week_short_desc_ES
       , cy_partial_week_short_desc_FI
       , cy_partial_week_short_desc_FR
       , cy_partial_week_short_desc_GB
       , cy_partial_week_short_desc_GR
       , cy_partial_week_short_desc_HR
       , cy_partial_week_short_desc_HU
       , cy_partial_week_short_desc_IE
       , cy_partial_week_short_desc_IT
       , cy_partial_week_short_desc_LT
       , cy_partial_week_short_desc_LV
       , cy_partial_week_short_desc_NI
       , cy_partial_week_short_desc_NL
       , cy_partial_week_short_desc_DE
       , cy_partial_week_short_desc_PL
       , cy_partial_week_short_desc_PT
       , cy_partial_week_short_desc_RO
       , cy_partial_week_short_desc_SE
       , cy_partial_week_short_desc_SI
       , cy_partial_week_short_desc_SK
       , cy_partial_week_short_desc_CS
       , cy_partial_week_short_desc_MT
       , cy_partial_week_short_desc_US
       , cy_partial_week_short_desc_RS
  FROM P_LEW_CORE.t_wawi_cal_week_partial_week_2
;