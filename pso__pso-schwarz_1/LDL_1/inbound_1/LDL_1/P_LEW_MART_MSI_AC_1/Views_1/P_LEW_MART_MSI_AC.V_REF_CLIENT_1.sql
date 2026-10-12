CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_CLIENT_1 COMMENT = 'Multi language Client/Country_1 descriptions'
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
#  1.10  17.05.2018   Wieber,Harald            Update Release 3.8
#  1.11  17.11.2020   Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.12  27.11.2020   Morris, Michael          Add Column(s) for _BE_fr
#                                               20200824_2572_trans_NR_FR_corr
#                                               https://jira.schwarz/browse/REP4-7173
#  1.13  27.12.2021   Zied Nanaa                Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  int_id            COMMENT 'Lidl International ID'
, client_id         COMMENT 'Landeskennzeichen'
, country_id        COMMENT 'Landeskennzeichen'
, client_desc_AT    COMMENT 'Landesspezifische Bezeichnung des Landes AT'
, client_desc_BE    COMMENT 'Landesspezifische Bezeichnung des Landes BE'
, client_desc_BE_FR COMMENT 'Landesspezifische Bezeichnung des Landes BE_FR'
, client_desc_BG    COMMENT 'Landesspezifische Bezeichnung des Landes BG'
, client_desc_CH    COMMENT 'Landesspezifische Bezeichnung des Landes CH'
, client_desc_CY    COMMENT 'Landesspezifische Bezeichnung des Landes CY'
, client_desc_CZ    COMMENT 'Landesspezifische Bezeichnung des Landes CZ'
, client_desc       COMMENT 'Bezeichnung des Landes'
, client_desc_DK    COMMENT 'Landesspezifische Bezeichnung des Landes DK'
, client_desc_EE    COMMENT 'Landesspezifische Bezeichnung des Landes EE'
, client_desc_ES    COMMENT 'Landesspezifische Bezeichnung des Landes ES'
, client_desc_FI    COMMENT 'Landesspezifische Bezeichnung des Landes FI'
, client_desc_FR    COMMENT 'Landesspezifische Bezeichnung des Landes FR'
, client_desc_GB    COMMENT 'Landesspezifische Bezeichnung des Landes GB'
, client_desc_GR    COMMENT 'Landesspezifische Bezeichnung des Landes GR'
, client_desc_HR    COMMENT 'Landesspezifische Bezeichnung des Landes HR'
, client_desc_HU    COMMENT 'Landesspezifische Bezeichnung des Landes HU'
, client_desc_IE    COMMENT 'Landesspezifische Bezeichnung des Landes IE'
, client_desc_IT    COMMENT 'Landesspezifische Bezeichnung des Landes IT'
, client_desc_LT    COMMENT 'Landesspezifische Bezeichnung des Landes LT'
, client_desc_LV    COMMENT 'Landesspezifische Bezeichnung des Landes LV'
, client_desc_NI    COMMENT 'Landesspezifische Bezeichnung des Landes NI'
, client_desc_NL    COMMENT 'Landesspezifische Bezeichnung des Landes NL'
, client_desc_DE    COMMENT 'Landesspezifische Bezeichnung des Landes DE'
, client_desc_PL    COMMENT 'Landesspezifische Bezeichnung des Landes PL'
, client_desc_PT    COMMENT 'Landesspezifische Bezeichnung des Landes PT'
, client_desc_RO    COMMENT 'Landesspezifische Bezeichnung des Landes RO'
, client_desc_SE    COMMENT 'Landesspezifische Bezeichnung des Landes SE'
, client_desc_SI    COMMENT 'Landesspezifische Bezeichnung des Landes SI'
, client_desc_SK    COMMENT 'Landesspezifische Bezeichnung des Landes SK'
, client_desc_CS    COMMENT 'Landesspezifische Bezeichnung des Landes CS'
, client_desc_MT    COMMENT 'Landesspezifische Bezeichnung des Landes MT'
, client_desc_US    COMMENT 'Landesspezifische Bezeichnung des Landes US'
, client_desc_RS    COMMENT 'Landesspezifische Bezeichnung des Landes RS_1'
 )
AS
SELECT   int_id
       , client_id
       , country_id
       , client_desc_AT
       , client_desc_BE
       , client_desc_BE_FR
       , client_desc_BG
       , client_desc_CH
       , client_desc_CY
       , client_desc_CZ
       , client_desc
       , client_desc_DK
       , client_desc_EE
       , client_desc_ES
       , client_desc_FI
       , client_desc_FR
       , client_desc_GB
       , client_desc_GR
       , client_desc_HR
       , client_desc_HU
       , client_desc_IE
       , client_desc_IT
       , client_desc_LT
       , client_desc_LV
       , client_desc_NI
       , client_desc_NL
       , client_desc_DE
       , client_desc_PL
       , client_desc_PT
       , client_desc_RO
       , client_desc_SE
       , client_desc_SI
       , client_desc_SK
       , client_desc_CS
       , client_desc_MT
       , client_desc_US
       , client_desc_RS
  FROM P_LEW_MART_MSI.v_ref_client_1
;