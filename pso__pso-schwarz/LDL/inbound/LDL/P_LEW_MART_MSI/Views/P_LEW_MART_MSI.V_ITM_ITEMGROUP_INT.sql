CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEMGROUP_INT COMMENT = 'Multi language International Item Group descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  13.10.2017    Meister,Ulrich logic moved from mart_msi to lew_bil llll ll
#  1.2  18.09.2017    -                        Generiert aus Teradata
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  18.09.2017    -                        Generiert aus Teradata
#  1.5  05.12.2017    Proch, Marika            Änderung des BIL-Layers
#  1.6  21.12.2017    Proch,Marika             Austausch des BIL-Layers
#  1.7  10.01.2018    Proch,Marika             Änderung der desc von max auf min
#  1.8  08.02.2018    Proch,Marika             Änderung der Logik für die itemgroup_int_remark
#  1.9  14.02.2018    Michael Ueding           Persistierung: Logik nach v_mat_itm_itemgroup_int verschoben.
#                                              Referenz auf t Tabelle
#  1.1  06.08.2020    Roy,Ritanjal             Introducing new country Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.1  05.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
   itemgroup_int_id         COMMENT 'Artikelgruppe ID'
  ,itemgroup_int_remark     COMMENT 'Artikelgruppe Kommentar'
  ,itemgroup_int_desc_AT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung AT'
  ,itemgroup_int_desc_BE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung BE'
  ,itemgroup_int_desc_BE_FR COMMENT 'Artikelgruppe Landesspezifische Bezeichnung BE_FR'
  ,itemgroup_int_desc_BG    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung BG'
  ,itemgroup_int_desc_CH    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CH'
  ,itemgroup_int_desc_CY    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CY'
  ,itemgroup_int_desc_CZ    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CZ'
  ,itemgroup_int_desc       COMMENT 'Artikelgruppe Generische Bezeichnung'
  ,itemgroup_int_desc_DK    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung DK'
  ,itemgroup_int_desc_EE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung EE'
  ,itemgroup_int_desc_ES    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung ES'
  ,itemgroup_int_desc_FI    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung FI'
  ,itemgroup_int_desc_FR    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung FR'
  ,itemgroup_int_desc_GB    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung GB'
  ,itemgroup_int_desc_GR    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung GR'
  ,itemgroup_int_desc_HR    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung HR'
  ,itemgroup_int_desc_HU    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung HU'
  ,itemgroup_int_desc_IE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung IE'
  ,itemgroup_int_desc_IT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung IT'
  ,itemgroup_int_desc_LT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung LT'
  ,itemgroup_int_desc_LV    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung LV'
  ,itemgroup_int_desc_NI    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung NI'
  ,itemgroup_int_desc_NL    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung NL'
  ,itemgroup_int_desc_DE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung DE'
  ,itemgroup_int_desc_PL    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung PL'
  ,itemgroup_int_desc_PT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung PT'
  ,itemgroup_int_desc_RO    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung RO'
  ,itemgroup_int_desc_SE    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung SE'
  ,itemgroup_int_desc_SI    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung SI'
  ,itemgroup_int_desc_SK    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung SK'
  ,itemgroup_int_desc_CS    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung CS'
  ,itemgroup_int_desc_MT    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung MT'
  ,itemgroup_int_desc_US    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung US'
  ,itemgroup_int_desc_RS    COMMENT 'Artikelgruppe Landesspezifische Bezeichnung RS'
)
AS
SELECT   itemgroup_int_id
       , itemgroup_int_remark
       , itemgroup_int_desc_AT
       , itemgroup_int_desc_BE
       , itemgroup_int_desc_FR AS itemgroup_int_desc_BE_FR
       , itemgroup_int_desc_BG
       , itemgroup_int_desc_CH
       , itemgroup_int_desc_CY
       , itemgroup_int_desc_CZ
       , itemgroup_int_desc
       , itemgroup_int_desc_DK
       , itemgroup_int_desc_EE
       , itemgroup_int_desc_ES
       , itemgroup_int_desc_FI
       , itemgroup_int_desc_FR
       , itemgroup_int_desc_GB
       , itemgroup_int_desc_GR
       , itemgroup_int_desc_HR
       , itemgroup_int_desc_HU
       , itemgroup_int_desc_IE
       , itemgroup_int_desc_IT
       , itemgroup_int_desc_LT
       , itemgroup_int_desc_LV
       , itemgroup_int_desc_NI
       , itemgroup_int_desc_NL
       , itemgroup_int_desc_DE
       , itemgroup_int_desc_PL
       , itemgroup_int_desc_PT
       , itemgroup_int_desc_RO
       , itemgroup_int_desc_SE
       , itemgroup_int_desc_SI
       , itemgroup_int_desc_SK
       , itemgroup_int_desc_CS
       , itemgroup_int_desc_MT
       , itemgroup_int_desc_US
       , itemgroup_int_desc_RS
  FROM P_LEW_MART_MSI.t_itm_itemgroup_int
;