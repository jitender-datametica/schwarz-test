create or replace view LDL_PRODUCTION.P_LEW_MART_MSI.V_REF_COUNTRY_2(
	INT_ID COMMENT 'Lidl International ID',
	COUNTRY_ID COMMENT 'Landeskennzeichen',
	COUNTRY_ISO_CD COMMENT 'Landes ISO Code',
	CLUSTER_ID COMMENT 'Cluster ID',
	SORTING_ORDER COMMENT 'Lisy Sort Wert',
	DASHBOARD_RELEVANT_FG COMMENT 'Dashboeard relevant Flag',
	COUNTRY_DESC_AT COMMENT 'Landesspezifische Bezeichnung des Landes AT',
	COUNTRY_DESC_BE COMMENT 'Landesspezifische Bezeichnung des Landes BE',
	COUNTRY_DESC_BE_FR COMMENT 'Landesspezifische Bezeichnung des Landes BE_FR',
	COUNTRY_DESC_BG COMMENT 'Landesspezifische Bezeichnung des Landes BG',
	COUNTRY_DESC_CH COMMENT 'Landesspezifische Bezeichnung des Landes CH',
	COUNTRY_DESC_CY COMMENT 'Landesspezifische Bezeichnung des Landes CY',
	COUNTRY_DESC_CZ COMMENT 'Landesspezifische Bezeichnung des Landes CZ',
	COUNTRY_DESC COMMENT 'Bezeichnung des Landes',
	COUNTRY_DESC_DK COMMENT 'Landesspezifische Bezeichnung des Landes DK',
	COUNTRY_DESC_EE COMMENT 'Landesspezifische Bezeichnung des Landes EE',
	COUNTRY_DESC_ES COMMENT 'Landesspezifische Bezeichnung des Landes ES',
	COUNTRY_DESC_FI COMMENT 'Landesspezifische Bezeichnung des Landes FI',
	COUNTRY_DESC_FR COMMENT 'Landesspezifische Bezeichnung des Landes FR',
	COUNTRY_DESC_GB COMMENT 'Landesspezifische Bezeichnung des Landes GB',
	COUNTRY_DESC_GR COMMENT 'Landesspezifische Bezeichnung des Landes GR',
	COUNTRY_DESC_HR COMMENT 'Landesspezifische Bezeichnung des Landes HR',
	COUNTRY_DESC_HU COMMENT 'Landesspezifische Bezeichnung des Landes HU',
	COUNTRY_DESC_IE COMMENT 'Landesspezifische Bezeichnung des Landes IE',
	COUNTRY_DESC_IT COMMENT 'Landesspezifische Bezeichnung des Landes IT',
	COUNTRY_DESC_LT COMMENT 'Landesspezifische Bezeichnung des Landes LT',
	COUNTRY_DESC_LV COMMENT 'Landesspezifische Bezeichnung des Landes LV',
	COUNTRY_DESC_NI COMMENT 'Landesspezifische Bezeichnung des Landes NI',
	COUNTRY_DESC_NL COMMENT 'Landesspezifische Bezeichnung des Landes NL',
	COUNTRY_DESC_DE COMMENT 'Landesspezifische Bezeichnung des Landes DE',
	COUNTRY_DESC_PL COMMENT 'Landesspezifische Bezeichnung des Landes PL',
	COUNTRY_DESC_PT COMMENT 'Landesspezifische Bezeichnung des Landes PT',
	COUNTRY_DESC_RO COMMENT 'Landesspezifische Bezeichnung des Landes RO',
	COUNTRY_DESC_SE COMMENT 'Landesspezifische Bezeichnung des Landes SE',
	COUNTRY_DESC_SI COMMENT 'Landesspezifische Bezeichnung des Landes SI',
	COUNTRY_DESC_SK COMMENT 'Landesspezifische Bezeichnung des Landes SK',
	COUNTRY_DESC_CS COMMENT 'Landesspezifische Bezeichnung des Landes CS',
	COUNTRY_DESC_MT COMMENT 'Landesspezifische Bezeichnung des Landes MT',
	COUNTRY_DESC_US COMMENT 'Landesspezifische Bezeichnung des Landes US',
	COUNTRY_DESC_RS COMMENT 'Landesspezifische Bezeichnung des Landes RS_2'
) as
SELECT   int_id
       , country_id            
       , country_iso_cd        
       , cluster_id            
       , sorting_order         
       , dashboard_relevant_fg 
       , MAX(CASE WHEN language_id = 1  THEN country_desc ELSE NULL END ) AS country_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN country_desc ELSE NULL END ) AS country_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN country_desc ELSE NULL END ) AS country_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN country_desc ELSE NULL END ) AS country_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN country_desc ELSE NULL END ) AS country_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN country_desc ELSE NULL END ) AS country_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN country_desc ELSE NULL END ) AS country_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN country_desc ELSE NULL END ) AS country_desc
       , MAX(CASE WHEN language_id = 8  THEN country_desc ELSE NULL END ) AS country_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN country_desc ELSE NULL END ) AS country_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN country_desc ELSE NULL END ) AS country_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN country_desc ELSE NULL END ) AS country_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN country_desc ELSE NULL END ) AS country_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN country_desc ELSE NULL END ) AS country_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN country_desc ELSE NULL END ) AS country_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN country_desc ELSE NULL END ) AS country_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN country_desc ELSE NULL END ) AS country_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN country_desc ELSE NULL END ) AS country_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN country_desc ELSE NULL END ) AS country_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN country_desc ELSE NULL END ) AS country_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN country_desc ELSE NULL END ) AS country_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN country_desc ELSE NULL END ) AS country_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN country_desc ELSE NULL END ) AS country_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN country_desc ELSE NULL END ) AS country_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN country_desc ELSE NULL END ) AS country_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN country_desc ELSE NULL END ) AS country_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN country_desc ELSE NULL END ) AS country_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN country_desc ELSE NULL END ) AS country_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN country_desc ELSE NULL END ) AS country_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN country_desc ELSE NULL END ) AS country_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN country_desc ELSE NULL END ) AS country_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN country_desc ELSE NULL END ) AS country_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN country_desc ELSE NULL END ) AS country_desc_US
       , MAX(CASE WHEN language_id = 34 THEN country_desc ELSE NULL END ) AS country_desc_RS
  FROM P_LEW_CORE_AC.v_wawi_ref_country_act_2 cn
 GROUP BY   int_id
          , country_id
          , country_iso_cd
          , cluster_id
          , sorting_order
          , dashboard_relevant_fg
;
