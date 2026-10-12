create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_REF_ITM_LIST_TYPE_BUYLIST(
	BUYING_LIST_TYPE_ID COMMENT 'Art des Artikels ( Saison, ... )',
	BUYING_LIST_TYPE_DESC_AT COMMENT 'Landesspezifische Bezeichnung der Art des Artikels AT',
	BUYING_LIST_TYPE_DESC_BE COMMENT 'Landesspezifische Bezeichnung der Art des Artikels BE',
	BUYING_LIST_TYPE_DESC_BE_FR COMMENT 'Landesspezifische Bezeichnung der Art des Artikels BE_FR',
	BUYING_LIST_TYPE_DESC_BG COMMENT 'Landesspezifische Bezeichnung der Art des Artikels BG',
	BUYING_LIST_TYPE_DESC_CH COMMENT 'Landesspezifische Bezeichnung der Art des Artikels CH',
	BUYING_LIST_TYPE_DESC_CY COMMENT 'Landesspezifische Bezeichnung der Art des Artikels CY',
	BUYING_LIST_TYPE_DESC_CZ COMMENT 'Landesspezifische Bezeichnung der Art des Artikels CZ',
	BUYING_LIST_TYPE_DESC COMMENT 'Bezeichnung der Art des Artikels ( Saison, ... )',
	BUYING_LIST_TYPE_DESC_DK COMMENT 'Landesspezifische Bezeichnung der Art des Artikels DK',
	BUYING_LIST_TYPE_DESC_EE COMMENT 'Landesspezifische Bezeichnung der Art des Artikels EE',
	BUYING_LIST_TYPE_DESC_ES COMMENT 'Landesspezifische Bezeichnung der Art des Artikels ES',
	BUYING_LIST_TYPE_DESC_FI COMMENT 'Landesspezifische Bezeichnung der Art des Artikels FI',
	BUYING_LIST_TYPE_DESC_FR COMMENT 'Landesspezifische Bezeichnung der Art des Artikels FR',
	BUYING_LIST_TYPE_DESC_GB COMMENT 'Landesspezifische Bezeichnung der Art des Artikels GB',
	BUYING_LIST_TYPE_DESC_GR COMMENT 'Landesspezifische Bezeichnung der Art des Artikels GR',
	BUYING_LIST_TYPE_DESC_HR COMMENT 'Landesspezifische Bezeichnung der Art des Artikels HR',
	BUYING_LIST_TYPE_DESC_HU COMMENT 'Landesspezifische Bezeichnung der Art des Artikels HU',
	BUYING_LIST_TYPE_DESC_IE COMMENT 'Landesspezifische Bezeichnung der Art des Artikels IE',
	BUYING_LIST_TYPE_DESC_IT COMMENT 'Landesspezifische Bezeichnung der Art des Artikels IT',
	BUYING_LIST_TYPE_DESC_LT COMMENT 'Landesspezifische Bezeichnung der Art des Artikels LT',
	BUYING_LIST_TYPE_DESC_LV COMMENT 'Landesspezifische Bezeichnung der Art des Artikels LV',
	BUYING_LIST_TYPE_DESC_NI COMMENT 'Landesspezifische Bezeichnung der Art des Artikels NI',
	BUYING_LIST_TYPE_DESC_NL COMMENT 'Landesspezifische Bezeichnung der Art des Artikels NL',
	BUYING_LIST_TYPE_DESC_DE COMMENT 'Landesspezifische Bezeichnung der Art des Artikels DE',
	BUYING_LIST_TYPE_DESC_PL COMMENT 'Landesspezifische Bezeichnung der Art des Artikels PL',
	BUYING_LIST_TYPE_DESC_PT COMMENT 'Landesspezifische Bezeichnung der Art des Artikels PT',
	BUYING_LIST_TYPE_DESC_RO COMMENT 'Landesspezifische Bezeichnung der Art des Artikels RO',
	BUYING_LIST_TYPE_DESC_SE COMMENT 'Landesspezifische Bezeichnung der Art des Artikels SE',
	BUYING_LIST_TYPE_DESC_SI COMMENT 'Landesspezifische Bezeichnung der Art des Artikels SI',
	BUYING_LIST_TYPE_DESC_SK COMMENT 'Landesspezifische Bezeichnung der Art des Artikels SK',
	BUYING_LIST_TYPE_DESC_CS COMMENT 'Landesspezifische Bezeichnung der Art des Artikels CS',
	BUYING_LIST_TYPE_DESC_MT COMMENT 'Landesspezifische Bezeichnung der Art des Artikels MT',
	BUYING_LIST_TYPE_DESC_US COMMENT 'Landesspezifische Bezeichnung der Art des Artikels US',
	BUYING_LIST_TYPE_DESC_RS COMMENT 'Landesspezifische Bezeichnung der Art des Artikels RS'
) COMMENT='Multisprache Artikelarten Referenz'
 as
SELECT   buying_list_type_id
       , buying_list_type_desc_AT
       , buying_list_type_desc_BE
       , buying_list_type_desc_BE_FR
       , buying_list_type_desc_BG
       , buying_list_type_desc_CH
       , buying_list_type_desc_CY
       , buying_list_type_desc_CZ
       , buying_list_type_desc
       , buying_list_type_desc_DK
       , buying_list_type_desc_EE
       , buying_list_type_desc_ES
       , buying_list_type_desc_FI
       , buying_list_type_desc_FR
       , buying_list_type_desc_GB
       , buying_list_type_desc_GR
       , buying_list_type_desc_HR
       , buying_list_type_desc_HU
       , buying_list_type_desc_IE
       , buying_list_type_desc_IT
       , buying_list_type_desc_LT
       , buying_list_type_desc_LV
       , buying_list_type_desc_NI
       , buying_list_type_desc_NL
       , buying_list_type_desc_DE
       , buying_list_type_desc_PL
       , buying_list_type_desc_PT
       , buying_list_type_desc_RO
       , buying_list_type_desc_SE
       , buying_list_type_desc_SI
       , buying_list_type_desc_SK
       , buying_list_type_desc_CS
       , buying_list_type_desc_MT
       , buying_list_type_desc_US
       , buying_list_type_desc_RS
  FROM P_LEW_MART_MSI.v_ref_itm_list_type_buylist
;
