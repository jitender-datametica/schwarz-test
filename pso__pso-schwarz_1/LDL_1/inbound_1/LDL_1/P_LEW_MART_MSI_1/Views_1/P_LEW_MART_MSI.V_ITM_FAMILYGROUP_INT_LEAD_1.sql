CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_FAMILYGROUP_INT_LEAD_1 COMMENT = 'Lead Project - Multi language International Item_1 Family Group descriptions'
/* 	
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  05.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  item_familygroup_id          COMMENT 'Artikelfamilen ID'
, subitemgroup_id              COMMENT 'WAWI CD'
, family_cd                    COMMENT 'Artikelfamile Landesspezifischer Code WAWI'
, item_family_desc_AT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang AT'
, item_family_desc_BE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE'
, item_family_desc_BE_FR       COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE_FR'
, item_family_desc_BG          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BG'
, item_family_desc_CH          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CH'
, item_family_desc_CY          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CY'
, item_family_desc_CZ          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CZ'
, item_family_desc             COMMENT 'Artikelfamile Bezeichnung Lang'
, item_family_desc_DK          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DK'
, item_family_desc_EE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang EE'
, item_family_desc_ES          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang ES'
, item_family_desc_FI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FI'
, item_family_desc_FR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FR'
, item_family_desc_GB          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GB'
, item_family_desc_GR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GR'
, item_family_desc_HR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HR'
, item_family_desc_HU          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HU'
, item_family_desc_IE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IE'
, item_family_desc_IT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IT'
, item_family_desc_LT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LT'
, item_family_desc_LV          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LV'
, item_family_desc_NI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NI'
, item_family_desc_NL          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NL'
, item_family_desc_DE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DE'
, item_family_desc_PL          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PL'
, item_family_desc_PT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PT'
, item_family_desc_RO          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RO'
, item_family_desc_SE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SE'
, item_family_desc_SI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SI'
, item_family_desc_SK          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SK'
, item_family_desc_CS          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CS'
, item_family_desc_MT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang MT'
, item_family_desc_US          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang US'
, item_family_desc_RS          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RS_1'
, item_family_short_desc_AT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung AT'
, item_family_short_desc_BE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE'
, item_family_short_desc_BE_FR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE_FR'
, item_family_short_desc_BG    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BG'
, item_family_short_desc_CH    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CH'
, item_family_short_desc_CY    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CY'
, item_family_short_desc_CZ    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CZ'
, item_family_short_desc       COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung'
, item_family_short_desc_DK    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DK'
, item_family_short_desc_EE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung EE'
, item_family_short_desc_ES    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung ES'
, item_family_short_desc_FI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FI'
, item_family_short_desc_FR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FR'
, item_family_short_desc_GB    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GB'
, item_family_short_desc_GR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GR'
, item_family_short_desc_HR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HR'
, item_family_short_desc_HU    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HU'
, item_family_short_desc_IE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IE'
, item_family_short_desc_IT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IT'
, item_family_short_desc_LT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LT'
, item_family_short_desc_LV    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LV'
, item_family_short_desc_NI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NI'
, item_family_short_desc_NL    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NL'
, item_family_short_desc_DE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DE'
, item_family_short_desc_PL    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PL'
, item_family_short_desc_PT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PT'
, item_family_short_desc_RO    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RO'
, item_family_short_desc_SE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SE'
, item_family_short_desc_SI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SI'
, item_family_short_desc_SK    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SK'
, item_family_short_desc_CS    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CS'
, item_family_short_desc_MT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung MT'
, item_family_short_desc_US    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung US'
, item_family_short_desc_RS    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RS_1'
)
AS
SELECT   item_familygroup_id
       , subitemgroup_id	
       , family_cd
       , MAX(CASE WHEN language_id = 1  THEN item_family_desc ELSE NULL END) AS item_family_desc_AT	
       , MAX(CASE WHEN language_id = 2  THEN item_family_desc ELSE NULL END) AS item_family_desc_BE	
       , MAX(CASE WHEN language_id = 2  THEN item_family_desc ELSE NULL END) AS item_family_desc_BE_FR	
       , MAX(CASE WHEN language_id = 3  THEN item_family_desc ELSE NULL END) AS item_family_desc_BG	
       , MAX(CASE WHEN language_id = 4  THEN item_family_desc ELSE NULL END) AS item_family_desc_CH	
       , MAX(CASE WHEN language_id = 5  THEN item_family_desc ELSE NULL END) AS item_family_desc_CY	
       , MAX(CASE WHEN language_id = 6  THEN item_family_desc ELSE NULL END) AS item_family_desc_CZ	
       , MAX(CASE WHEN language_id = 7  THEN item_family_desc ELSE NULL END) AS item_family_desc
       , MAX(CASE WHEN language_id = 8  THEN item_family_desc ELSE NULL END) AS item_family_desc_DK	
       , MAX(CASE WHEN language_id = 9  THEN item_family_desc ELSE NULL END) AS item_family_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN item_family_desc ELSE NULL END) AS item_family_desc_ES	
       , MAX(CASE WHEN language_id = 11 THEN item_family_desc ELSE NULL END) AS item_family_desc_FI	
       , MAX(CASE WHEN language_id = 12 THEN item_family_desc ELSE NULL END) AS item_family_desc_FR	
       , MAX(CASE WHEN language_id = 13 THEN item_family_desc ELSE NULL END) AS item_family_desc_GB	
       , MAX(CASE WHEN language_id = 14 THEN item_family_desc ELSE NULL END) AS item_family_desc_GR	
       , MAX(CASE WHEN language_id = 15 THEN item_family_desc ELSE NULL END) AS item_family_desc_HR	
       , MAX(CASE WHEN language_id = 16 THEN item_family_desc ELSE NULL END) AS item_family_desc_HU	
       , MAX(CASE WHEN language_id = 17 THEN item_family_desc ELSE NULL END) AS item_family_desc_IE	
       , MAX(CASE WHEN language_id = 18 THEN item_family_desc ELSE NULL END) AS item_family_desc_IT	
       , MAX(CASE WHEN language_id = 19 THEN item_family_desc ELSE NULL END) AS item_family_desc_LT	
       , MAX(CASE WHEN language_id = 20 THEN item_family_desc ELSE NULL END) AS item_family_desc_LV	
       , MAX(CASE WHEN language_id = 21 THEN item_family_desc ELSE NULL END) AS item_family_desc_NI	
       , MAX(CASE WHEN language_id = 22 THEN item_family_desc ELSE NULL END) AS item_family_desc_NL	
       , MAX(CASE WHEN language_id = 23 THEN item_family_desc ELSE NULL END) AS item_family_desc_DE	
       , MAX(CASE WHEN language_id = 24 THEN item_family_desc ELSE NULL END) AS item_family_desc_PL	
       , MAX(CASE WHEN language_id = 25 THEN item_family_desc ELSE NULL END) AS item_family_desc_PT	
       , MAX(CASE WHEN language_id = 26 THEN item_family_desc ELSE NULL END) AS item_family_desc_RO	
       , MAX(CASE WHEN language_id = 27 THEN item_family_desc ELSE NULL END) AS item_family_desc_SE	
       , MAX(CASE WHEN language_id = 28 THEN item_family_desc ELSE NULL END) AS item_family_desc_SI	
       , MAX(CASE WHEN language_id = 29 THEN item_family_desc ELSE NULL END) AS item_family_desc_SK	
       , MAX(CASE WHEN language_id = 31 THEN item_family_desc ELSE NULL END) AS item_family_desc_CS	
       , MAX(CASE WHEN language_id = 32 THEN item_family_desc ELSE NULL END) AS item_family_desc_MT	
       , MAX(CASE WHEN language_id = 33 THEN item_family_desc ELSE NULL END) AS item_family_desc_US	
       , MAX(CASE WHEN language_id = 34 THEN item_family_desc ELSE NULL END) AS item_family_desc_RS	
       , MAX(CASE WHEN language_id = 1  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_AT	
       , MAX(CASE WHEN language_id = 2  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_BE	
       , MAX(CASE WHEN language_id = 2  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_BE_FR	
       , MAX(CASE WHEN language_id = 3  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_BG	
       , MAX(CASE WHEN language_id = 4  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_CH	
       , MAX(CASE WHEN language_id = 5  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_CY	
       , MAX(CASE WHEN language_id = 6  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_CZ	
       , MAX(CASE WHEN language_id = 7  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc
       , MAX(CASE WHEN language_id = 8  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_DK	
       , MAX(CASE WHEN language_id = 9  THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_ES	
       , MAX(CASE WHEN language_id = 11 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_FI	
       , MAX(CASE WHEN language_id = 12 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_FR	
       , MAX(CASE WHEN language_id = 13 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_GB	
       , MAX(CASE WHEN language_id = 14 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_GR	
       , MAX(CASE WHEN language_id = 15 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_HR	
       , MAX(CASE WHEN language_id = 16 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_HU	
       , MAX(CASE WHEN language_id = 17 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_IE	
       , MAX(CASE WHEN language_id = 18 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_IT	
       , MAX(CASE WHEN language_id = 19 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_LT	
       , MAX(CASE WHEN language_id = 21 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_NI	
       , MAX(CASE WHEN language_id = 22 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_NL	
       , MAX(CASE WHEN language_id = 20 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_LV	
       , MAX(CASE WHEN language_id = 23 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_DE	
       , MAX(CASE WHEN language_id = 24 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_PL	
       , MAX(CASE WHEN language_id = 25 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_PT	
       , MAX(CASE WHEN language_id = 26 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_RO	
       , MAX(CASE WHEN language_id = 27 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_SE	
       , MAX(CASE WHEN language_id = 28 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_SI	
       , MAX(CASE WHEN language_id = 29 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_SK	
       , MAX(CASE WHEN language_id = 31 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_CS	
       , MAX(CASE WHEN language_id = 32 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_MT	
       , MAX(CASE WHEN language_id = 33 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_US	
       , MAX(CASE WHEN language_id = 34 THEN item_family_short_desc ELSE NULL END) AS item_family_short_desc_RS	
	
  FROM P_LEW_CORE_AC.v_wawi_itm_familygroup_1	
	
 WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
   AND client_id = language_id	
	
 GROUP BY   item_familygroup_id	
          , subitemgroup_id	
          , family_cd	
;
