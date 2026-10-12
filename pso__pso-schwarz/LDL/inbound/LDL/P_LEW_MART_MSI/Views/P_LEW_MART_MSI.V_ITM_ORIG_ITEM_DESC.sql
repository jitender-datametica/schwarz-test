CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ORIG_ITEM_DESC COMMENT = 'Multi language Artikelbeschreibungen'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  18.12.2017    Harald Wieber            Change the Stiftung Language from DE to @
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  29.01.2018    Toth.Gabriel             Refactored
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  02.02.2018    Toth,Gabriel             Applied dat_valid_from Logic from n_itm_item
#  1.7  05.02.2018    Toth,Gabriel             Finetuning of dat_valid_from_logic
#  2.8  14.02.2018    Michael Ueding           Persistierung: Logik nach v_mat_itm_orig_item_desc verschoben
#                                              Referenz auf t Tabelle
#  2.9  06.08.2020    Roy,Ritanjal             Introduce new country LV
#  2.10 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  2.11 12.04.2021    Marcin Malec             adding Coalesce to desc columns
#                                              https://jira.schwarz/browse/REP2-9356
#  2.12 21.12.2021    Michel Morris            Added Estonia EE
#------------------------------------------------------------------------------
*/
(
  client_id       COMMENT 'Landes ID' 
, orig_item_nr    COMMENT 'Original Artikelnummer'
, dat_valid_from  COMMENT 'Gültig ab'
, item_desc_AT    COMMENT 'Landesspezifische Artikelbeschreibung AT'
, item_desc_BE    COMMENT 'Landesspezifische Artikelbeschreibung BE'
, item_desc_BE_FR COMMENT 'Landesspezifische Artikelbeschreibung BE_FR'
, item_desc_BG    COMMENT 'Landesspezifische Artikelbeschreibung BG'
, item_desc_CH    COMMENT 'Landesspezifische Artikelbeschreibung CH'
, item_desc_CY    COMMENT 'Landesspezifische Artikelbeschreibung CY'
, item_desc_CZ    COMMENT 'Landesspezifische Artikelbeschreibung CZ'
, item_desc       COMMENT 'Generische Artikelbeschreibung'
, item_desc_DK    COMMENT 'Landesspezifische Artikelbeschreibung DK'
, item_desc_EE    COMMENT 'Landesspezifische Artikelbeschreibung EE'
, item_desc_ES    COMMENT 'Landesspezifische Artikelbeschreibung ES'
, item_desc_FI    COMMENT 'Landesspezifische Artikelbeschreibung FI'
, item_desc_FR    COMMENT 'Landesspezifische Artikelbeschreibung FR'
, item_desc_GB    COMMENT 'Landesspezifische Artikelbeschreibung GB'
, item_desc_GR    COMMENT 'Landesspezifische Artikelbeschreibung GR'
, item_desc_HR    COMMENT 'Landesspezifische Artikelbeschreibung HR'
, item_desc_HU    COMMENT 'Landesspezifische Artikelbeschreibung HU'
, item_desc_IE    COMMENT 'Landesspezifische Artikelbeschreibung IE'
, item_desc_IT    COMMENT 'Landesspezifische Artikelbeschreibung IT'
, item_desc_LT    COMMENT 'Landesspezifische Artikelbeschreibung LT'
, item_desc_LV    COMMENT 'Landesspezifische Artikelbeschreibung LV'
, item_desc_NI    COMMENT 'Landesspezifische Artikelbeschreibung NI'
, item_desc_NL    COMMENT 'Landesspezifische Artikelbeschreibung NL'
, item_desc_DE    COMMENT 'Landesspezifische Artikelbeschreibung DE'
, item_desc_PL    COMMENT 'Landesspezifische Artikelbeschreibung PL'
, item_desc_PT    COMMENT 'Landesspezifische Artikelbeschreibung PT'
, item_desc_RO    COMMENT 'Landesspezifische Artikelbeschreibung RO'
, item_desc_SE    COMMENT 'Landesspezifische Artikelbeschreibung SE'
, item_desc_SI    COMMENT 'Landesspezifische Artikelbeschreibung SI'
, item_desc_SK    COMMENT 'Landesspezifische Artikelbeschreibung SK'
, item_desc_CS    COMMENT 'Landesspezifische Artikelbeschreibung CS'
, item_desc_MT    COMMENT 'Landesspezifische Artikelbeschreibung MT'
, item_desc_US    COMMENT 'Landesspezifische Artikelbeschreibung US'
, item_desc_RS    COMMENT 'Landesspezifische Artikelbeschreibung RS'
)
AS
SELECT   client_id
       , orig_item_nr
       , dat_valid_from
       , COALESCE(item_desc_AT, item_desc) AS item_desc_AT
       , COALESCE(item_desc_BE, item_desc) AS item_desc_BE
       , COALESCE(item_desc_BE, item_desc) AS item_desc_BE_FR
       , COALESCE(item_desc_BG, item_desc) AS item_desc_BG
       , COALESCE(item_desc_CH, item_desc) AS item_desc_CH
       , COALESCE(item_desc_CY, item_desc) AS item_desc_CY
       , COALESCE(item_desc_CZ, item_desc) AS item_desc_CZ
       , item_desc
       , COALESCE(item_desc_DK, item_desc) AS item_desc_DK
       , COALESCE(item_desc_EE, item_desc) AS item_desc_EE
       , COALESCE(item_desc_ES, item_desc) AS item_desc_ES
       , COALESCE(item_desc_FI, item_desc) AS item_desc_FI
       , COALESCE(item_desc_FR, item_desc) AS item_desc_FR
       , COALESCE(item_desc_GB, item_desc) AS item_desc_GB
       , COALESCE(item_desc_GR, item_desc) AS item_desc_GR
       , COALESCE(item_desc_HR, item_desc) AS item_desc_HR
       , COALESCE(item_desc_HU, item_desc) AS item_desc_HU
       , COALESCE(item_desc_IE, item_desc) AS item_desc_IE
       , COALESCE(item_desc_IT, item_desc) AS item_desc_IT
       , COALESCE(item_desc_LT, item_desc) AS item_desc_LT
       , COALESCE(item_desc_LV, item_desc) AS item_desc_LV
       , COALESCE(item_desc_NI, item_desc) AS item_desc_NI
       , COALESCE(item_desc_NL, item_desc) AS item_desc_NL
       , COALESCE(item_desc_DE, item_desc) AS item_desc_DE
       , COALESCE(item_desc_PL, item_desc) AS item_desc_PL
       , COALESCE(item_desc_PT, item_desc) AS item_desc_PT
       , COALESCE(item_desc_RO, item_desc) AS item_desc_RO
       , COALESCE(item_desc_SE, item_desc) AS item_desc_SE
       , COALESCE(item_desc_SI, item_desc) AS item_desc_SI
       , COALESCE(item_desc_SK, item_desc) AS item_desc_SK
       , COALESCE(item_desc_CS, item_desc) AS item_desc_CS
       , COALESCE(item_desc_MT, item_desc) AS item_desc_MT
       , COALESCE(item_desc_US, item_desc) AS item_desc_US
       , COALESCE(item_desc_RS, item_desc) AS item_desc_RS
  FROM P_LEW_MART_MSI.t_itm_orig_item_desc
;