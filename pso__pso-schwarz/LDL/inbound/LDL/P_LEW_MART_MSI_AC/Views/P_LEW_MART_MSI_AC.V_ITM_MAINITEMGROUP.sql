CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_MAINITEMGROUP COMMENT='Multi language Mainitek Bezeichnungen'
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
  mainitemgroup_id               COMMENT 'WAWI Quellschluessel'
, mainitemgroup_desc_AT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit AT'
, mainitemgroup_desc_BE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit BE'
, mainitemgroup_desc_BE_FR       COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit BE_FR'
, mainitemgroup_desc_BG          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit BG'
, mainitemgroup_desc_CH          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CH'
, mainitemgroup_desc_CY          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CY'
, mainitemgroup_desc_CZ          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CZ'
, mainitemgroup_desc             COMMENT 'Mainitek generische Bezeichnung'
, mainitemgroup_desc_DK          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit DK'
, mainitemgroup_desc_EE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit EE'
, mainitemgroup_desc_ES          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit ES'
, mainitemgroup_desc_FI          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit FI'
, mainitemgroup_desc_FR          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit FR'
, mainitemgroup_desc_GB          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit GB'
, mainitemgroup_desc_GR          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit GR'
, mainitemgroup_desc_HR          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit HR'
, mainitemgroup_desc_HU          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit HU'
, mainitemgroup_desc_IE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit IE'
, mainitemgroup_desc_IT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit IT'
, mainitemgroup_desc_LT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit LT'
, mainitemgroup_desc_LV          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit LV'
, mainitemgroup_desc_NI          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit NI'
, mainitemgroup_desc_NL          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit NL'
, mainitemgroup_desc_DE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit DE'
, mainitemgroup_desc_PL          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit PL'
, mainitemgroup_desc_PT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit PT'
, mainitemgroup_desc_RO          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit RO'
, mainitemgroup_desc_SE          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit SE'
, mainitemgroup_desc_SI          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit SI'
, mainitemgroup_desc_SK          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit SK'
, mainitemgroup_desc_CS          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit CS'
, mainitemgroup_desc_MT          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit MT'
, mainitemgroup_desc_US          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit US'
, mainitemgroup_desc_RS          COMMENT 'Mainitek Landesspezifische Bezeichnung Einheit RS'
, mainitemgroup_short_desc_AT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit AT'
, mainitemgroup_short_desc_BE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit BE'
, mainitemgroup_short_desc_BE_FR COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit BE_FR'
, mainitemgroup_short_desc_BG    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit BG'
, mainitemgroup_short_desc_CH    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CH'
, mainitemgroup_short_desc_CY    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CY'
, mainitemgroup_short_desc_CZ    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CZ'
, mainitemgroup_short_desc       COMMENT 'Mainitek generische Kurzbezeichnung'
, mainitemgroup_short_desc_DK    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit DK'
, mainitemgroup_short_desc_EE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit EE'
, mainitemgroup_short_desc_ES    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit ES'
, mainitemgroup_short_desc_FI    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit FI'
, mainitemgroup_short_desc_FR    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit FR'
, mainitemgroup_short_desc_GB    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit GB'
, mainitemgroup_short_desc_GR    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit GR'
, mainitemgroup_short_desc_HR    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit HR'
, mainitemgroup_short_desc_HU    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit HU'
, mainitemgroup_short_desc_IE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit IE'
, mainitemgroup_short_desc_IT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit IT'
, mainitemgroup_short_desc_LT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit LT'
, mainitemgroup_short_desc_LV    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit LV'
, mainitemgroup_short_desc_NI    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit NI'
, mainitemgroup_short_desc_NL    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit NL'
, mainitemgroup_short_desc_DE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit DE'
, mainitemgroup_short_desc_PL    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit PL'
, mainitemgroup_short_desc_PT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit PT'
, mainitemgroup_short_desc_RO    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit RO'
, mainitemgroup_short_desc_SE    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit SE'
, mainitemgroup_short_desc_SI    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit SI'
, mainitemgroup_short_desc_SK    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit SK'
, mainitemgroup_short_desc_CS    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit CS'
, mainitemgroup_short_desc_MT    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit MT'
, mainitemgroup_short_desc_US    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit US'
, mainitemgroup_short_desc_RS    COMMENT 'Mainitek Landesspezifische Kurzbezeichnung Einheit RS'
 )
AS
SELECT  mainitemgroup_id
      , mainitemgroup_desc_AT
      , mainitemgroup_desc_BE
      , mainitemgroup_desc_BE_FR
      , mainitemgroup_desc_BG
      , mainitemgroup_desc_CH
      , mainitemgroup_desc_CY
      , mainitemgroup_desc_CZ
      , mainitemgroup_desc
      , mainitemgroup_desc_DK
      , mainitemgroup_desc_EE
      , mainitemgroup_desc_ES
      , mainitemgroup_desc_FI
      , mainitemgroup_desc_FR
      , mainitemgroup_desc_GB
      , mainitemgroup_desc_GR
      , mainitemgroup_desc_HR
      , mainitemgroup_desc_HU
      , mainitemgroup_desc_IE
      , mainitemgroup_desc_IT
      , mainitemgroup_desc_LT
      , mainitemgroup_desc_LV
      , mainitemgroup_desc_NI
      , mainitemgroup_desc_NL
      , mainitemgroup_desc_DE
      , mainitemgroup_desc_PL
      , mainitemgroup_desc_PT
      , mainitemgroup_desc_RO
      , mainitemgroup_desc_SE
      , mainitemgroup_desc_SI
      , mainitemgroup_desc_SK
      , mainitemgroup_desc_CS
      , mainitemgroup_desc_MT
      , mainitemgroup_desc_US
      , mainitemgroup_desc_RS
      , mainitemgroup_short_desc_AT
      , mainitemgroup_short_desc_BE
      , mainitemgroup_short_desc_BE_FR
      , mainitemgroup_short_desc_BG
      , mainitemgroup_short_desc_CH
      , mainitemgroup_short_desc_CY
      , mainitemgroup_short_desc_CZ
      , mainitemgroup_short_desc
      , mainitemgroup_short_desc_DK
      , mainitemgroup_short_desc_EE
      , mainitemgroup_short_desc_ES
      , mainitemgroup_short_desc_FI
      , mainitemgroup_short_desc_FR
      , mainitemgroup_short_desc_GB
      , mainitemgroup_short_desc_GR
      , mainitemgroup_short_desc_HR
      , mainitemgroup_short_desc_HU
      , mainitemgroup_short_desc_IE
      , mainitemgroup_short_desc_IT
      , mainitemgroup_short_desc_LT
      , mainitemgroup_short_desc_LV
      , mainitemgroup_short_desc_NI
      , mainitemgroup_short_desc_NL
      , mainitemgroup_short_desc_DE
      , mainitemgroup_short_desc_PL
      , mainitemgroup_short_desc_PT
      , mainitemgroup_short_desc_RO
      , mainitemgroup_short_desc_SE
      , mainitemgroup_short_desc_SI
      , mainitemgroup_short_desc_SK
      , mainitemgroup_short_desc_CS
      , mainitemgroup_short_desc_MT
      , mainitemgroup_short_desc_US
      , mainitemgroup_short_desc_RS
FROM P_LEW_MART_MSI.v_itm_mainitemgroup
;