CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_THM COMMENT = 'Multi language reference view for thm'
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
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  04.01.2022    Morris, Michael          Added Estonia EE
#-----------------------------------------------------------------------------
*/
(
  client_id      COMMENT 'Landeskennzeichen'
, orig_thm_nr    COMMENT 'Orig_Thk Bez. Einheit nr'
, factor_ep      COMMENT 'Factor EP'
, thm_desc       COMMENT 'Thm_Desk Bez. Einheit desc'
, thm_desc_AT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit AT'
, thm_desc_BE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit BE'
, thm_desc_BE_FR COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit BE_FR'
, thm_desc_BG    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit BG'
, thm_desc_CH    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CH'
, thm_desc_CY    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CY'
, thm_desc_CZ    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CZ'
, thm_desc_DK    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit DK'
, thm_desc_EE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit EE'
, thm_desc_ES    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit ES'
, thm_desc_FI    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit FI'
, thm_desc_FR    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit FR'
, thm_desc_GB    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit GB'
, thm_desc_GR    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit GR'
, thm_desc_HR    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit HR'
, thm_desc_HU    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit HU'
, thm_desc_IE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit IE'
, thm_desc_IT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit IT'
, thm_desc_LT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit LT'
, thm_desc_LV    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit LV'
, thm_desc_NI    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit NI'
, thm_desc_NL    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit NL'
, thm_desc_DE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit DE'
, thm_desc_PL    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit PL'
, thm_desc_PT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit PT'
, thm_desc_RO    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit RO'
, thm_desc_SE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit SE'
, thm_desc_SI    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit SI'
, thm_desc_SK    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit SK'
, thm_desc_CS    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CS'
, thm_desc_MT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit MT'
, thm_desc_US    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit US'
, thm_desc_RS    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit RS'
 )
AS
SELECT   client_id
       , orig_thm_nr
       , factor_ep
       , thm_desc
       , thm_desc_AT
       , thm_desc_BE
       , thm_desc_BE_FR
       , thm_desc_BG
       , thm_desc_CH
       , thm_desc_CY
       , thm_desc_CZ
       , thm_desc_DK
       , thm_desc_EE
       , thm_desc_ES
       , thm_desc_FI
       , thm_desc_FR
       , thm_desc_GB
       , thm_desc_GR
       , thm_desc_HR
       , thm_desc_HU
       , thm_desc_IE
       , thm_desc_IT
       , thm_desc_LT
       , thm_desc_LV
       , thm_desc_NI
       , thm_desc_NL
       , thm_desc_DE
       , thm_desc_PL
       , thm_desc_PT
       , thm_desc_RO
       , thm_desc_SE
       , thm_desc_SI
       , thm_desc_SK
       , thm_desc_CS
       , thm_desc_MT
       , thm_desc_US
       , thm_desc_RS
  FROM P_LEW_MART_MSI.v_ref_thm
;