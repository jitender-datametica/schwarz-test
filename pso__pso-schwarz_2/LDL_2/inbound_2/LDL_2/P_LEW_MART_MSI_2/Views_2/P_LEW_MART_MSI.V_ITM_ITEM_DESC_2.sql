CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEM_DESC_2 COMMENT ='Multi language Item_2 descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Klamann,Norbert          uses n_itm_item_desc_act now w
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  29.11.2017    Michael Ueding           complete redesign, version 1.1 is false and slow
#  1.5  06.12.2017    Michael Ueding           for Lidl language use Language Code INT
#  1.6  17.01.2018    Wieber,Harald            Release 2.2
#  1.7  14.02.2018    Michael Ueding           Persistierung: Logik nach v_mat_itm_item_desc_2 verschoben.
#                                              Referenz auf t Tabelle
#  1.8  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  1.9  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.10 21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id       COMMENT 'Landes ID'
, item_id         COMMENT 'System intern Artikelschlüssel'
, orig_item_nr    COMMENT 'Originale Artikelnummer'
, item_desc_AT    COMMENT 'Artikel_2 Landesspezifische Bezeichnung AT'
, item_desc_BE    COMMENT 'Artikel_2 Landesspezifische Bezeichnung BE'
, item_desc_BE_FR COMMENT 'Artikel_2 Landesspezifische Bezeichnung BE_FR'
, item_desc_BG    COMMENT 'Artikel_2 Landesspezifische Bezeichnung BG'
, item_desc_CH    COMMENT 'Artikel_2 Landesspezifische Bezeichnung CH'
, item_desc_CY    COMMENT 'Artikel_2 Landesspezifische Bezeichnung CY'
, item_desc_CZ    COMMENT 'Artikel_2 Landesspezifische Bezeichnung CZ'
, item_desc       COMMENT 'Generische Artikel_2 Bezeichnung'
, item_desc_DK    COMMENT 'Artikel_2 Landesspezifische Bezeichnung DK'
, item_desc_EE    COMMENT 'Artikel_2 Landesspezifische Bezeichnung EE'
, item_desc_ES    COMMENT 'Artikel_2 Landesspezifische Bezeichnung ES'
, item_desc_FI    COMMENT 'Artikel_2 Landesspezifische Bezeichnung FI'
, item_desc_FR    COMMENT 'Artikel_2 Landesspezifische Bezeichnung FR'
, item_desc_GB    COMMENT 'Artikel_2 Landesspezifische Bezeichnung GB'
, item_desc_GR    COMMENT 'Artikel_2 Landesspezifische Bezeichnung GR'
, item_desc_HR    COMMENT 'Artikel_2 Landesspezifische Bezeichnung HR'
, item_desc_HU    COMMENT 'Artikel_2 Landesspezifische Bezeichnung HU'
, item_desc_IE    COMMENT 'Artikel_2 Landesspezifische Bezeichnung IE'
, item_desc_IT    COMMENT 'Artikel_2 Landesspezifische Bezeichnung IT'
, item_desc_LT    COMMENT 'Artikel_2 Landesspezifische Bezeichnung LT'
, item_desc_LV    COMMENT 'Artikel_2 Landesspezifische Bezeichnung LV'
, item_desc_NI    COMMENT 'Artikel_2 Landesspezifische Bezeichnung NI'
, item_desc_NL    COMMENT 'Artikel_2 Landesspezifische Bezeichnung NL'
, item_desc_DE    COMMENT 'Artikel_2 Landesspezifische Bezeichnung DE'
, item_desc_PL    COMMENT 'Artikel_2 Landesspezifische Bezeichnung PL'
, item_desc_PT    COMMENT 'Artikel_2 Landesspezifische Bezeichnung PT'
, item_desc_RO    COMMENT 'Artikel_2 Landesspezifische Bezeichnung RO'
, item_desc_SE    COMMENT 'Artikel_2 Landesspezifische Bezeichnung SE'
, item_desc_SI    COMMENT 'Artikel_2 Landesspezifische Bezeichnung SI'
, item_desc_SK    COMMENT 'Artikel_2 Landesspezifische Bezeichnung SK'
, item_desc_CS    COMMENT 'Artikel_2 Landesspezifische Bezeichnung CS'
, item_desc_MT    COMMENT 'Artikel_2 Landesspezifische Bezeichnung MT'
, item_desc_US    COMMENT 'Artikel_2 Landesspezifische Bezeichnung US'
, item_desc_RS    COMMENT 'Artikel_2 Landesspezifische Bezeichnung RS_2'
)
AS
SELECT   client_id
       , item_id
       , orig_item_nr
       , item_desc_AT
       , item_desc_BE
       , item_desc_BE AS item_desc_BE_FR
       , item_desc_BG
       , item_desc_CH
       , item_desc_CY
       , item_desc_CZ
       , item_desc
       , item_desc_DK
       , item_desc_EE
       , item_desc_ES
       , item_desc_FI
       , item_desc_FR
       , item_desc_GB
       , item_desc_GR
       , item_desc_HR
       , item_desc_HU
       , item_desc_IE
       , item_desc_IT
       , item_desc_LT
       , item_desc_LV
       , item_desc_NI
       , item_desc_NL
       , item_desc_DE
       , item_desc_PL
       , item_desc_PT
       , item_desc_RO
       , item_desc_SE
       , item_desc_SI
       , item_desc_SK
       , item_desc_CS
       , item_desc_MT
       , item_desc_US
       , item_desc_RS
  FROM P_LEW_MART_MSI.t_itm_item_desc_2
;