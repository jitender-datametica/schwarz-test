CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_SUBITEMGROUP_DESC_1 COMMENT = 'Multi language Sub Item_1 Group descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.1  28.11.2017    Proch, Marika            Nutzung des neuen BIL-Layers
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  14.02.2018    Michael Ueding           Persistierung: Logik nach v_mat_itm_subitemgroup_desc_1 verschoben
#                                              Referenz auf t Tabelle
#  1.6  06.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.7  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.8  21.12.2021    Morris, Michael          Added Estonia EE
#-----------------------------------------------------------------------------
*/
(
  subitemgroup_id               COMMENT 'Sub Item_1 Group ID'
, subitemgroup_desc_AT          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung AR'
, subitemgroup_desc_BE          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung BE'
, subitemgroup_desc_BE_FR       COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung BE_FR'
, subitemgroup_desc_BG          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung BG'
, subitemgroup_desc_CH          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung CH'
, subitemgroup_desc_CY          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung CY'
, subitemgroup_desc_CZ          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung CZ'
, subitemgroup_desc             COMMENT 'Generische Sub Item_1 Group Beschreibung'
, subitemgroup_desc_DK          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung DK'
, subitemgroup_desc_EE          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung EE'
, subitemgroup_desc_ES          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung ES'
, subitemgroup_desc_FI          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung FI'
, subitemgroup_desc_FR          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung FR'
, subitemgroup_desc_GB          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung GB'
, subitemgroup_desc_GR          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung GR'
, subitemgroup_desc_HR          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung HR'
, subitemgroup_desc_HU          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung HU'
, subitemgroup_desc_IE          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung IE'
, subitemgroup_desc_IT          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung IT'
, subitemgroup_desc_LT          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung LT'
, subitemgroup_desc_LV          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung LV'
, subitemgroup_desc_NI          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung NI'
, subitemgroup_desc_NL          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung NL'
, subitemgroup_desc_DE          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung DE'
, subitemgroup_desc_PL          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung PL'
, subitemgroup_desc_PT          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung PT'
, subitemgroup_desc_RO          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung RO'
, subitemgroup_desc_SE          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung SE'
, subitemgroup_desc_SI          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung SI'
, subitemgroup_desc_SK          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung SK'
, subitemgroup_desc_CS          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung CS'
, subitemgroup_desc_MT          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung MT'
, subitemgroup_desc_US          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung US'
, subitemgroup_desc_RS          COMMENT 'Landesspezifische Sub Item_1 Group Beschreibung RS_1'
, subitemgroup_short_desc_AT    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung AT'
, subitemgroup_short_desc_BE    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung BE'
, subitemgroup_short_desc_BE_FR COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung BE_FR'
, subitemgroup_short_desc_BG    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung BG'
, subitemgroup_short_desc_CH    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung CH'
, subitemgroup_short_desc_CY    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung CY'
, subitemgroup_short_desc_CZ    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung CZ'
, subitemgroup_short_desc       COMMENT 'Generische Sub Item_1 Group Kurzbeschreibung'
, subitemgroup_short_desc_DK    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung DK'
, subitemgroup_short_desc_EE    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung EE'
, subitemgroup_short_desc_ES    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung ES'
, subitemgroup_short_desc_FI    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung FI'
, subitemgroup_short_desc_FR    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung FR'
, subitemgroup_short_desc_GB    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung GB'
, subitemgroup_short_desc_GR    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung GR'
, subitemgroup_short_desc_HR    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung HR'
, subitemgroup_short_desc_HU    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung HU'
, subitemgroup_short_desc_IE    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung IE'
, subitemgroup_short_desc_IT    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung IT'
, subitemgroup_short_desc_LT    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung LT'
, subitemgroup_short_desc_LV    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung LV'
, subitemgroup_short_desc_NI    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung NI'
, subitemgroup_short_desc_NL    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung NL'
, subitemgroup_short_desc_DE    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung DE'
, subitemgroup_short_desc_PL    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung PL'
, subitemgroup_short_desc_PT    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung PT'
, subitemgroup_short_desc_RO    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung RO'
, subitemgroup_short_desc_SE    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung SE'
, subitemgroup_short_desc_SI    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung SI'
, subitemgroup_short_desc_SK    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung SK'
, subitemgroup_short_desc_CS    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung CS'
, subitemgroup_short_desc_MT    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung MT'
, subitemgroup_short_desc_US    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung US'
, subitemgroup_short_desc_RS    COMMENT 'Landesspezifische Sub Item_1 Group Kurzbeschreibung RS_1'
)
AS
SELECT   subitemgroup_id
       , subitemgroup_desc_AT
       , subitemgroup_desc_BE
       , subitemgroup_desc_FR AS subitemgroup_desc_BE_FR
       , subitemgroup_desc_BG
       , subitemgroup_desc_CH
       , subitemgroup_desc_CY
       , subitemgroup_desc_CZ
       , subitemgroup_desc
       , subitemgroup_desc_DK
       , subitemgroup_desc_EE
       , subitemgroup_desc_ES
       , subitemgroup_desc_FI
       , subitemgroup_desc_FR
       , subitemgroup_desc_GB
       , subitemgroup_desc_GR
       , subitemgroup_desc_HR
       , subitemgroup_desc_HU
       , subitemgroup_desc_IE
       , subitemgroup_desc_IT
       , subitemgroup_desc_LT
       , subitemgroup_desc_LV
       , subitemgroup_desc_NI
       , subitemgroup_desc_NL
       , subitemgroup_desc_DE
       , subitemgroup_desc_PL
       , subitemgroup_desc_PT
       , subitemgroup_desc_RO
       , subitemgroup_desc_SE
       , subitemgroup_desc_SI
       , subitemgroup_desc_SK
       , subitemgroup_desc_CS
       , subitemgroup_desc_MT
       , subitemgroup_desc_US
       , subitemgroup_desc_RS
       , subitemgroup_short_desc_AT
       , subitemgroup_short_desc_BE
       , subitemgroup_short_desc_FR AS subitemgroup_short_desc_BE_FR
       , subitemgroup_short_desc_BG
       , subitemgroup_short_desc_CH
       , subitemgroup_short_desc_CY
       , subitemgroup_short_desc_CZ
       , subitemgroup_short_desc
       , subitemgroup_short_desc_DK
       , subitemgroup_short_desc_EE
       , subitemgroup_short_desc_ES
       , subitemgroup_short_desc_FI
       , subitemgroup_short_desc_FR
       , subitemgroup_short_desc_GB
       , subitemgroup_short_desc_GR
       , subitemgroup_short_desc_HR
       , subitemgroup_short_desc_HU
       , subitemgroup_short_desc_IE
       , subitemgroup_short_desc_IT
       , subitemgroup_short_desc_LT
       , subitemgroup_short_desc_LV
       , subitemgroup_short_desc_NI
       , subitemgroup_short_desc_NL
       , subitemgroup_short_desc_DE
       , subitemgroup_short_desc_PL
       , subitemgroup_short_desc_PT
       , subitemgroup_short_desc_RO
       , subitemgroup_short_desc_SE
       , subitemgroup_short_desc_SI
       , subitemgroup_short_desc_SK
       , subitemgroup_short_desc_CS
       , subitemgroup_short_desc_MT
       , subitemgroup_short_desc_US
       , subitemgroup_short_desc_RS
  FROM P_LEW_MART_MSI.t_itm_subitemgroup_desc_1
;