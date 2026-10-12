create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_REF_COUNTRY_2(
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
       , country_desc_AT
       , country_desc_BE
       , country_desc_BE_FR
       , country_desc_BG
       , country_desc_CH
       , country_desc_CY
       , country_desc_CZ
       , country_desc
       , country_desc_DK
       , country_desc_EE
       , country_desc_ES
       , country_desc_FI
       , country_desc_FR
       , country_desc_GB
       , country_desc_GR
       , country_desc_HR
       , country_desc_HU
       , country_desc_IE
       , country_desc_IT
       , country_desc_LT
       , country_desc_LV
       , country_desc_NI
       , country_desc_NL
       , country_desc_DE
       , country_desc_PL
       , country_desc_PT
       , country_desc_RO
       , country_desc_SE
       , country_desc_SI
       , country_desc_SK
       , country_desc_CS
       , country_desc_MT
       , country_desc_US
       , country_desc_RS
  FROM P_LEW_MART_MSI.v_ref_country_2
;
