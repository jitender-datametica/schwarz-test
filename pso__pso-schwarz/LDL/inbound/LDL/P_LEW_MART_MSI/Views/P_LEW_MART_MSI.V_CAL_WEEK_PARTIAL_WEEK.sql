CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_PARTIAL_WEEK COMMENT = 'Multi language partial week descriptions'
/*
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  10.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
   cy_week_partial_week_id1         COMMENT 'Geschäftsjahr - Woche/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW'
 , cy_week_partial_week_id2         COMMENT 'Geschäftsjahr - Woche/Teilwoche - Wochenart Id- 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche'
 , cy_week_partial_week_name        COMMENT 'Geschäftsjahr - Woche/Teilwoche - Name der Woche - Format = JJJJ KW 99 plus /1 für den ersten Teil oder /2 für den zweiten Teil der Woche'
 , cy_month                         COMMENT 'Monat des Geschäftsjahres im Format JJJJMM'
 , byr                              COMMENT 'Käufer'
 , cy_week_partial_week_id          COMMENT 'Geschäftsjahr - Woche/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW/Wochenart - 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche'
 , partialweek_in_mth_seq_asc       COMMENT 'Partialk Bez. Einheit asc'
 , partialweek_in_mth_seq_desc      COMMENT 'Partialk Bez. Einheit desc'
 , cy_partial_week_short_desc_AT    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung AT'
 , cy_partial_week_short_desc_BE    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung BE'
 , cy_partial_week_short_desc_BE_FR COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung BE_FR'
 , cy_partial_week_short_desc_BG    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung BG'
 , cy_partial_week_short_desc_CH    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CH'
 , cy_partial_week_short_desc_CY    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CY'
 , cy_partial_week_short_desc_CZ    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CZ'
 , cy_partial_week_short_desc       COMMENT 'Geschäftsjahr - Teilwoche Kurzbezeichnung'
 , cy_partial_week_short_desc_DK    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung DK'
 , cy_partial_week_short_desc_EE    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung EE'
 , cy_partial_week_short_desc_ES    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung ES'
 , cy_partial_week_short_desc_FI    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung FI'
 , cy_partial_week_short_desc_FR    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung FR'
 , cy_partial_week_short_desc_GB    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung GB'
 , cy_partial_week_short_desc_GR    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung GR'
 , cy_partial_week_short_desc_HR    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung HR'
 , cy_partial_week_short_desc_HU    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung HU'
 , cy_partial_week_short_desc_IE    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung IE'
 , cy_partial_week_short_desc_IT    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung IT'
 , cy_partial_week_short_desc_LT    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung LT'
 , cy_partial_week_short_desc_LV    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung LV'
 , cy_partial_week_short_desc_NI    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung NI'
 , cy_partial_week_short_desc_NL    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung NL'
 , cy_partial_week_short_desc_DE    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung DE'
 , cy_partial_week_short_desc_PL    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung PL'
 , cy_partial_week_short_desc_PT    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung PT'
 , cy_partial_week_short_desc_RO    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung RO'
 , cy_partial_week_short_desc_SE    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung SE'
 , cy_partial_week_short_desc_SI    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung SI'
 , cy_partial_week_short_desc_SK    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung SK'
 , cy_partial_week_short_desc_CS    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CS'
 , cy_partial_week_short_desc_MT    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung MT'
 , cy_partial_week_short_desc_US    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung US'
 , cy_partial_week_short_desc_RS    COMMENT 'Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung RS'
)
AS
SELECT   cy_week_partial_week_id1
       , cy_week_partial_week_id2
       , cy_week_partial_week_name
       , cy_month
       , busyear                       AS byr
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
FROM     P_LEW_CORE_AC.v_wawi_cal_week_partial_week
;