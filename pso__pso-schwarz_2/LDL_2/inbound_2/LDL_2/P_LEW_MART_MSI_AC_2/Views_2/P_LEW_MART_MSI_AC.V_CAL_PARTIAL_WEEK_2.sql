CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_PARTIAL_WEEK_2 COMMENT = 'Multi language partial week reference'
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
#  1.9  17.05.2018    Wieber.Harald            Update Release 3.8
# 1.10  16.01.2019    Mike Davis               Tidy incl explicit field list
# 1.11  19.11.2019    Meister,Ulrich           Patch 20191118_2292_Persistierung_Kalender_DWH20 (IDMO-2460, DWH-4137)
# 1.12  11.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  23.12.2021    Zied Nanaa               Add languages BE_FR and EE.
#----------------------------------------------------------------------------
*/
(
      cy_week                           COMMENT 'Iso week number in form YYYYWW. Iso week number uses the calendar_2 year in which the Thursday of the week lies and the count of Thursdays so far in that calendar_2 year (inclusive).'
    , cy_partial_week                   COMMENT 'Component number of the partial week in the week. If a week lies wholly in 1 month then it has 1 component (1 partial week) of component number 1. If it straddles 2 months then the component in the 1st month is 1 and in the second month is 2'
    , cy_partial_week_name              COMMENT 'Name of partial week in form "TW WW/ P  YYYY" where TW=TW WW=01-53 P=1or2 YYYY=cy.'
    , cy_partial_week_short_name        COMMENT 'Shorter version of cy_week_part name in form "TW WW/ P".'
    , cy_month                          COMMENT 'Month in which the partial week lies. In the form year+month ie. YYYYMM.'
    , cy                                COMMENT 'Calendar_2 year.'
    , byr                               COMMENT 'Business year. I.e. from beginning of March to end of the following February inclusively.'
    , dat_valid_from                    COMMENT 'Calendar_2 date of the first day in the partial week.'
    , dat_valid_until                   COMMENT 'Calendar_2 date of the last day in the partial week.'
    , partialweek_in_mth_seq_asc        COMMENT 'Sequence number of the partial week in the calendar_2 month (in cy_month) in ascending order starting at 1.'
    , partialweek_in_mth_seq_desc       COMMENT 'Sequence number of the partial week in the calendar_2 month (in cy_month) in descending order finishing at 1.'
    , cy_partial_week_short_desc_AT     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation AT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_BE     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation BE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_BE_FR  COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation BE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_BG     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation BG of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_CH     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CH of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_CY     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CY of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_CZ     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CZ of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc        COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the organizational language (German) of the first and last weekdays in the format "DD - DD". For example "Mo - Do" for Monday to Thursday.'
    , cy_partial_week_short_desc_DK     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation DK of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_EE     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation EE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_ES     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation ES of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_FI     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation FI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_FR     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation FR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_GB     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation GB of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_GR     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation GR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_HR     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation HR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_HU     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation HU of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_IE     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation IE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_IT     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation IT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_LT     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation LT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_LV     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation LT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_NI     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation NI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_NL     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation NL of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_DE     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation DE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_PL     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation PL of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_PT     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation PT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_RO     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation RO of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_SE     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation SE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_SI     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation SI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_SK     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation SK of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_CS     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CS of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_MT     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation MT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_US     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation US of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
    , cy_partial_week_short_desc_RS     COMMENT 'If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation RS_2 of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'
)
AS
SELECT   cy_week
       , cy_partial_week
       , cy_partial_week_name
       , cy_partial_week_short_name
       , cy_month
       , cy
       , byr
       , dat_valid_from
       , dat_valid_until
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
FROM     p_lew_mart_msi.v_cal_partial_week_2
;