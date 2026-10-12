create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_ITM_FAMILYGROUP_INT(
	SUBITEMGROUP_ID COMMENT 'WAWI CD',
	FAMILY_CD COMMENT 'Artikelfamile Landesspezifischer Code WAWI',
	ITEM_FAMILY_DESC COMMENT 'Artikelfamile Bezeichnung Lang',
	ITEM_FAMILY_DESC_AT COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang AT',
	ITEM_FAMILY_DESC_BE COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE',
	ITEM_FAMILY_DESC_BE_FR COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE_FR',
	ITEM_FAMILY_DESC_BG COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BG',
	ITEM_FAMILY_DESC_CH COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CH',
	ITEM_FAMILY_DESC_CY COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CY',
	ITEM_FAMILY_DESC_CZ COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CZ',
	ITEM_FAMILY_DESC_DK COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DK',
	ITEM_FAMILY_DESC_EE COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang EE',
	ITEM_FAMILY_DESC_ES COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang ES',
	ITEM_FAMILY_DESC_FI COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FI',
	ITEM_FAMILY_DESC_FR COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FR',
	ITEM_FAMILY_DESC_GB COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GB',
	ITEM_FAMILY_DESC_GR COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GR',
	ITEM_FAMILY_DESC_HR COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HR',
	ITEM_FAMILY_DESC_HU COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HU',
	ITEM_FAMILY_DESC_IE COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IE',
	ITEM_FAMILY_DESC_IT COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IT',
	ITEM_FAMILY_DESC_LT COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LT',
	ITEM_FAMILY_DESC_LV COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LV',
	ITEM_FAMILY_DESC_NI COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NI',
	ITEM_FAMILY_DESC_NL COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NL',
	ITEM_FAMILY_DESC_DE COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DE',
	ITEM_FAMILY_DESC_PL COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PL',
	ITEM_FAMILY_DESC_PT COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PT',
	ITEM_FAMILY_DESC_RO COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RO',
	ITEM_FAMILY_DESC_SE COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SE',
	ITEM_FAMILY_DESC_SI COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SI',
	ITEM_FAMILY_DESC_SK COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SK',
	ITEM_FAMILY_DESC_CS COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CS',
	ITEM_FAMILY_DESC_MT COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang MT',
	ITEM_FAMILY_DESC_US COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang US',
	ITEM_FAMILY_DESC_RS COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RS',
	ITEM_FAMILY_SHORT_DESC COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung',
	ITEM_FAMILY_SHORT_DESC_AT COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung AT',
	ITEM_FAMILY_SHORT_DESC_BE COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE',
	ITEM_FAMILY_SHORT_DESC_BE_FR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE_FR',
	ITEM_FAMILY_SHORT_DESC_BG COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BG',
	ITEM_FAMILY_SHORT_DESC_CH COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CH',
	ITEM_FAMILY_SHORT_DESC_CY COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CY',
	ITEM_FAMILY_SHORT_DESC_CZ COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CZ',
	ITEM_FAMILY_SHORT_DESC_DK COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DK',
	ITEM_FAMILY_SHORT_DESC_EE COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung EE',
	ITEM_FAMILY_SHORT_DESC_ES COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung ES',
	ITEM_FAMILY_SHORT_DESC_FI COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FI',
	ITEM_FAMILY_SHORT_DESC_FR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FR',
	ITEM_FAMILY_SHORT_DESC_GB COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GB',
	ITEM_FAMILY_SHORT_DESC_GR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GR',
	ITEM_FAMILY_SHORT_DESC_HR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HR',
	ITEM_FAMILY_SHORT_DESC_HU COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HU',
	ITEM_FAMILY_SHORT_DESC_IE COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IE',
	ITEM_FAMILY_SHORT_DESC_IT COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IT',
	ITEM_FAMILY_SHORT_DESC_LT COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LT',
	ITEM_FAMILY_SHORT_DESC_LV COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LV',
	ITEM_FAMILY_SHORT_DESC_NI COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NI',
	ITEM_FAMILY_SHORT_DESC_NL COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NL',
	ITEM_FAMILY_SHORT_DESC_DE COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DE',
	ITEM_FAMILY_SHORT_DESC_PL COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PL',
	ITEM_FAMILY_SHORT_DESC_PT COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PT',
	ITEM_FAMILY_SHORT_DESC_RO COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RO',
	ITEM_FAMILY_SHORT_DESC_SE COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SE',
	ITEM_FAMILY_SHORT_DESC_SI COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SI',
	ITEM_FAMILY_SHORT_DESC_SK COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SK',
	ITEM_FAMILY_SHORT_DESC_CS COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CS',
	ITEM_FAMILY_SHORT_DESC_MT COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung MT',
	ITEM_FAMILY_SHORT_DESC_US COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung US',
	ITEM_FAMILY_SHORT_DESC_RS COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RS'
) COMMENT='Multi language International Item Family Group descriptions'
 as
SELECT   subitemgroup_id
       , family_cd
       , item_family_desc
       , item_family_desc_AT
       , item_family_desc_BE
       , item_family_desc_BE_FR
       , item_family_desc_BG
       , item_family_desc_CH
       , item_family_desc_CY
       , item_family_desc_CZ
       , item_family_desc_DK
       , item_family_desc_EE
       , item_family_desc_ES
       , item_family_desc_FI
       , item_family_desc_FR
       , item_family_desc_GB
       , item_family_desc_GR
       , item_family_desc_HR
       , item_family_desc_HU
       , item_family_desc_IE
       , item_family_desc_IT
       , item_family_desc_LT
       , item_family_desc_LV
       , item_family_desc_NI
       , item_family_desc_NL
       , item_family_desc_DE
       , item_family_desc_PL
       , item_family_desc_PT
       , item_family_desc_RO
       , item_family_desc_SE
       , item_family_desc_SI
       , item_family_desc_SK
       , item_family_desc_CS
       , item_family_desc_MT
       , item_family_desc_US
       , item_family_desc_RS
       , item_family_short_desc
       , item_family_short_desc_AT
       , item_family_short_desc_BE
       , item_family_short_desc_BE_FR
       , item_family_short_desc_BG
       , item_family_short_desc_CH
       , item_family_short_desc_CY
       , item_family_short_desc_CZ
       , item_family_short_desc_DK
       , item_family_short_desc_EE
       , item_family_short_desc_ES
       , item_family_short_desc_FI
       , item_family_short_desc_FR
       , item_family_short_desc_GB
       , item_family_short_desc_GR
       , item_family_short_desc_HR
       , item_family_short_desc_HU
       , item_family_short_desc_IE
       , item_family_short_desc_IT
       , item_family_short_desc_LT
       , item_family_short_desc_LV
       , item_family_short_desc_NI
       , item_family_short_desc_NL
       , item_family_short_desc_DE
       , item_family_short_desc_PL
       , item_family_short_desc_PT
       , item_family_short_desc_RO
       , item_family_short_desc_SE
       , item_family_short_desc_SI
       , item_family_short_desc_SK
       , item_family_short_desc_CS
       , item_family_short_desc_MT
       , item_family_short_desc_US
       , item_family_short_desc_RS
  FROM P_LEW_MART_MSI.v_itm_familygroup_int
;
