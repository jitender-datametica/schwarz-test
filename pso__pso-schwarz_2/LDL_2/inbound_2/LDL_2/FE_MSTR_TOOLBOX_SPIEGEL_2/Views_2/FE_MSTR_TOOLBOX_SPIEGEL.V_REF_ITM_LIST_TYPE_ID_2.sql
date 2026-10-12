CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_ITM_LIST_TYPE_ID_2(
	LISTING_TYPE_ID COMMENT 'Einlistungstype Id',
	LISTING_TYPE_DESC_AT COMMENT 'Einlistungstype Landesspezifische Bezeichnung AT',
	LISTING_TYPE_DESC_BE COMMENT 'Einlistungstype Landesspezifische Bezeichnung BE',
	LISTING_TYPE_DESC_BE_FR COMMENT 'Einlistungstype Landesspezifische Bezeichnung BE_FR',
	LISTING_TYPE_DESC_BG COMMENT 'Einlistungstype Landesspezifische Bezeichnung BG',
	LISTING_TYPE_DESC_CH COMMENT 'Einlistungstype Landesspezifische Bezeichnung CH',
	LISTING_TYPE_DESC_CY COMMENT 'Einlistungstype Landesspezifische Bezeichnung CY',
	LISTING_TYPE_DESC_CZ COMMENT 'Einlistungstype Landesspezifische Bezeichnung CZ',
	LISTING_TYPE_DESC COMMENT 'Einlistungstype Beschreibung',
	LISTING_TYPE_DESC_DK COMMENT 'Einlistungstype Landesspezifische Bezeichnung DK',
	LISTING_TYPE_DESC_EE COMMENT 'Einlistungstype Landesspezifische Bezeichnung EE',
	LISTING_TYPE_DESC_ES COMMENT 'Einlistungstype Landesspezifische Bezeichnung ES',
	LISTING_TYPE_DESC_FI COMMENT 'Einlistungstype Landesspezifische Bezeichnung FI',
	LISTING_TYPE_DESC_FR COMMENT 'Einlistungstype Landesspezifische Bezeichnung FR',
	LISTING_TYPE_DESC_GB COMMENT 'Einlistungstype Landesspezifische Bezeichnung GB',
	LISTING_TYPE_DESC_GR COMMENT 'Einlistungstype Landesspezifische Bezeichnung GR',
	LISTING_TYPE_DESC_HR COMMENT 'Einlistungstype Landesspezifische Bezeichnung HR',
	LISTING_TYPE_DESC_HU COMMENT 'Einlistungstype Landesspezifische Bezeichnung HU',
	LISTING_TYPE_DESC_IE COMMENT 'Einlistungstype Landesspezifische Bezeichnung IE',
	LISTING_TYPE_DESC_IT COMMENT 'Einlistungstype Landesspezifische Bezeichnung IT',
	LISTING_TYPE_DESC_LT COMMENT 'Einlistungstype Landesspezifische Bezeichnung LT',
	LISTING_TYPE_DESC_LV COMMENT 'Einlistungstype Landesspezifische Bezeichnung LV',
	LISTING_TYPE_DESC_NI COMMENT 'Einlistungstype Landesspezifische Bezeichnung NI',
	LISTING_TYPE_DESC_NL COMMENT 'Einlistungstype Landesspezifische Bezeichnung NL',
	LISTING_TYPE_DESC_DE COMMENT 'Einlistungstype Landesspezifische Bezeichnung DE',
	LISTING_TYPE_DESC_PL COMMENT 'Einlistungstype Landesspezifische Bezeichnung PL',
	LISTING_TYPE_DESC_PT COMMENT 'Einlistungstype Landesspezifische Bezeichnung PT',
	LISTING_TYPE_DESC_RO COMMENT 'Einlistungstype Landesspezifische Bezeichnung RO',
	LISTING_TYPE_DESC_SE COMMENT 'Einlistungstype Landesspezifische Bezeichnung SE',
	LISTING_TYPE_DESC_SI COMMENT 'Einlistungstype Landesspezifische Bezeichnung SI',
	LISTING_TYPE_DESC_SK COMMENT 'Einlistungstype Landesspezifische Bezeichnung SK',
	LISTING_TYPE_DESC_CS COMMENT 'Einlistungstype Landesspezifische Bezeichnung CS',
	LISTING_TYPE_DESC_MT COMMENT 'Einlistungstype Landesspezifische Bezeichnung MT',
	LISTING_TYPE_DESC_US COMMENT 'Einlistungstype Landesspezifische Bezeichnung US',
	LISTING_TYPE_DESC_RS COMMENT 'Einlistungstype Landesspezifische Bezeichnung RS_2'
) COMMENT='Multisprache Einlistungstypen Referenz'
 AS
SELECT   listing_type_id
       , MAX(CASE WHEN language_id = 1        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc
       , MAX(CASE WHEN language_id = 8        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_US
       , MAX(CASE WHEN language_id = 34       THEN listing_type_desc ELSE NULL END ) AS listing_type_desc_RS
  FROM (
        SELECT   listing_type_id
               , listing_type_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2
       ) AS r
 GROUP BY listing_type_id
;