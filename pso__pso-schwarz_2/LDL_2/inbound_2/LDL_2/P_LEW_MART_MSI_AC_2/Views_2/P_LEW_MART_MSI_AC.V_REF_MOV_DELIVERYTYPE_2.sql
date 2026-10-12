CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_MOV_DELIVERYTYPE_2 COMMENT = 'Multi language delivery type reference view'
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
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#----------------------------------------------------------------------------
*/
(
  client_id               COMMENT 'Landeskennzeichen'
, deliverytype_id         COMMENT 'Anlieferart - Konstanten: 1 = Zuteilungen / 2 = Kommisionierlisten'
, deliverytype_desc_AT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung AT'
, deliverytype_desc_BE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung BE'
, deliverytype_desc_BE_FR COMMENT 'Anlieferart - Landesspezifische Bezeichnung BE_FR'
, deliverytype_desc_BG    COMMENT 'Anlieferart - Landesspezifische Bezeichnung BG'
, deliverytype_desc_CH    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CH'
, deliverytype_desc_CY    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CY'
, deliverytype_desc_CZ    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CZ'
, deliverytype_desc       COMMENT 'Anlieferart - Bezeichnung'
, deliverytype_desc_DK    COMMENT 'Anlieferart - Landesspezifische Bezeichnung DK'
, deliverytype_desc_EE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung EE'
, deliverytype_desc_ES    COMMENT 'Anlieferart - Landesspezifische Bezeichnung ES'
, deliverytype_desc_FI    COMMENT 'Anlieferart - Landesspezifische Bezeichnung FI'
, deliverytype_desc_FR    COMMENT 'Anlieferart - Landesspezifische Bezeichnung FR'
, deliverytype_desc_GB    COMMENT 'Anlieferart - Landesspezifische Bezeichnung GB'
, deliverytype_desc_GR    COMMENT 'Anlieferart - Landesspezifische Bezeichnung GR'
, deliverytype_desc_HR    COMMENT 'Anlieferart - Landesspezifische Bezeichnung HR'
, deliverytype_desc_HU    COMMENT 'Anlieferart - Landesspezifische Bezeichnung HU'
, deliverytype_desc_IE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung IE'
, deliverytype_desc_IT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung IT'
, deliverytype_desc_LT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung LT'
, deliverytype_desc_LV    COMMENT 'Anlieferart - Landesspezifische Bezeichnung LV'
, deliverytype_desc_NI    COMMENT 'Anlieferart - Landesspezifische Bezeichnung NI'
, deliverytype_desc_NL    COMMENT 'Anlieferart - Landesspezifische Bezeichnung NL'
, deliverytype_desc_DE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung DE'
, deliverytype_desc_PL    COMMENT 'Anlieferart - Landesspezifische Bezeichnung PL'
, deliverytype_desc_PT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung PT'
, deliverytype_desc_RO    COMMENT 'Anlieferart - Landesspezifische Bezeichnung RO'
, deliverytype_desc_SE    COMMENT 'Anlieferart - Landesspezifische Bezeichnung SE'
, deliverytype_desc_SI    COMMENT 'Anlieferart - Landesspezifische Bezeichnung SI'
, deliverytype_desc_SK    COMMENT 'Anlieferart - Landesspezifische Bezeichnung SK'
, deliverytype_desc_CS    COMMENT 'Anlieferart - Landesspezifische Bezeichnung CS'
, deliverytype_desc_MT    COMMENT 'Anlieferart - Landesspezifische Bezeichnung MT'
, deliverytype_desc_US    COMMENT 'Anlieferart - Landesspezifische Bezeichnung US'
, deliverytype_desc_RS    COMMENT 'Anlieferart - Landesspezifische Bezeichnung RS_2'
 )
AS
SELECT   client_id
       , deliverytype_id
       , deliverytype_desc_AT
       , deliverytype_desc_BE
       , deliverytype_desc_BE_FR
       , deliverytype_desc_BG
       , deliverytype_desc_CH
       , deliverytype_desc_CY
       , deliverytype_desc_CZ
       , deliverytype_desc
       , deliverytype_desc_DK
       , deliverytype_desc_EE
       , deliverytype_desc_ES
       , deliverytype_desc_FI
       , deliverytype_desc_FR
       , deliverytype_desc_GB
       , deliverytype_desc_GR
       , deliverytype_desc_HR
       , deliverytype_desc_HU
       , deliverytype_desc_IE
       , deliverytype_desc_IT
       , deliverytype_desc_LT
       , deliverytype_desc_LV
       , deliverytype_desc_NI
       , deliverytype_desc_NL
       , deliverytype_desc_DE
       , deliverytype_desc_PL
       , deliverytype_desc_PT
       , deliverytype_desc_RO
       , deliverytype_desc_SE
       , deliverytype_desc_SI
       , deliverytype_desc_SK
       , deliverytype_desc_CS
       , deliverytype_desc_MT
       , deliverytype_desc_US
       , deliverytype_desc_RS
  FROM P_LEW_MART_MSI.v_ref_mov_deliverytype_2
;