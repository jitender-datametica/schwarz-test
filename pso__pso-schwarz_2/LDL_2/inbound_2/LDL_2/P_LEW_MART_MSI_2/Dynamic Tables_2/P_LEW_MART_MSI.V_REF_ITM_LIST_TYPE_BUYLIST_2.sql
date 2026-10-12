create or replace dynamic table LDL_PRODUCTION.P_LEW_MART_MSI.V_REF_ITM_LIST_TYPE_BUYLIST_2(
	BUYING_LIST_TYPE_ID COMMENT 'Art_2 des Artikels ( Saison, ... )',
	BUYING_LIST_TYPE_DESC_AT COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels AT',
	BUYING_LIST_TYPE_DESC_BE COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels BE',
	BUYING_LIST_TYPE_DESC_BE_FR COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels BE_FR',
	BUYING_LIST_TYPE_DESC_BG COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels BG',
	BUYING_LIST_TYPE_DESC_CH COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels CH',
	BUYING_LIST_TYPE_DESC_CY COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels CY',
	BUYING_LIST_TYPE_DESC_CZ COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels CZ',
	BUYING_LIST_TYPE_DESC COMMENT 'Bezeichnung der Art_2 des Artikels ( Saison, ... )',
	BUYING_LIST_TYPE_DESC_DK COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels DK',
	BUYING_LIST_TYPE_DESC_EE COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels EE',
	BUYING_LIST_TYPE_DESC_ES COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels ES',
	BUYING_LIST_TYPE_DESC_FI COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels FI',
	BUYING_LIST_TYPE_DESC_FR COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels FR',
	BUYING_LIST_TYPE_DESC_GB COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels GB',
	BUYING_LIST_TYPE_DESC_GR COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels GR',
	BUYING_LIST_TYPE_DESC_HR COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels HR',
	BUYING_LIST_TYPE_DESC_HU COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels HU',
	BUYING_LIST_TYPE_DESC_IE COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels IE',
	BUYING_LIST_TYPE_DESC_IT COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels IT',
	BUYING_LIST_TYPE_DESC_LT COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels LT',
	BUYING_LIST_TYPE_DESC_LV COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels LV',
	BUYING_LIST_TYPE_DESC_NI COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels NI',
	BUYING_LIST_TYPE_DESC_NL COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels NL',
	BUYING_LIST_TYPE_DESC_DE COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels DE',
	BUYING_LIST_TYPE_DESC_PL COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels PL',
	BUYING_LIST_TYPE_DESC_PT COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels PT',
	BUYING_LIST_TYPE_DESC_RO COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels RO',
	BUYING_LIST_TYPE_DESC_SE COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels SE',
	BUYING_LIST_TYPE_DESC_SI COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels SI',
	BUYING_LIST_TYPE_DESC_SK COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels SK',
	BUYING_LIST_TYPE_DESC_CS COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels CS',
	BUYING_LIST_TYPE_DESC_MT COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels MT',
	BUYING_LIST_TYPE_DESC_US COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels US',
	BUYING_LIST_TYPE_DESC_RS COMMENT 'Landesspezifische Bezeichnung der Art_2 des Artikels RS_2'
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_P_DYNAMIC_TABLE_P_LEW_MART_MSI
 COMMENT='Multisprache Artikelarten Referenz'
 as
SELECT   buying_list_type_id
       , MAX(CASE WHEN language_id = 1        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_AT
       , MAX(CASE WHEN language_id = 2        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_BE
       , MAX(CASE WHEN language_id = 12       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_BE_FR
       , MAX(CASE WHEN language_id = 3        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_BG
       , MAX(CASE WHEN language_id = 4        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_CH
       , MAX(CASE WHEN language_id = 5        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_CY
       , MAX(CASE WHEN language_id = 6        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_CZ
       , MAX(CASE WHEN language_id = 7        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc
       , MAX(CASE WHEN language_id = 8        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_DK
       , MAX(CASE WHEN language_id = 9        THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_ES
       , MAX(CASE WHEN language_id = 11       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_FI
       , MAX(CASE WHEN language_id = 12       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_FR
       , MAX(CASE WHEN language_id = 13       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_GR
       , MAX(CASE WHEN language_id = 15       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_HR
       , MAX(CASE WHEN language_id = 16       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_IT
       , MAX(CASE WHEN language_id = 19       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_LT
       , MAX(CASE WHEN language_id = 20       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_LV
       , MAX(CASE WHEN language_id = 21       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_NI
       , MAX(CASE WHEN language_id = 22       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_NL
       , MAX(CASE WHEN language_id = 23       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_DE
       , MAX(CASE WHEN language_id = 24       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_PL
       , MAX(CASE WHEN language_id = 25       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_PT
       , MAX(CASE WHEN language_id = 26       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_RO
       , MAX(CASE WHEN language_id = 27       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_SE
       , MAX(CASE WHEN language_id = 28       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_SI
       , MAX(CASE WHEN language_id = 29       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_SK
       , MAX(CASE WHEN language_id = 31       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_CS
       , MAX(CASE WHEN language_id = 32       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_MT
       , MAX(CASE WHEN language_id = 33       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_US
       , MAX(CASE WHEN language_id = 34       THEN buying_list_type_desc ELSE NULL END ) AS buying_list_type_desc_RS
  FROM (
        SELECT   buying_list_type_id
               , buying_list_type_desc
               , language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2
         UNION ALL
        SELECT   -1 * r.buying_list_type_id    AS def_buying_list_type_id
               , CASE r.buying_list_type_id
                          WHEN 2 THEN 'EM ohne Listungsart'
                          WHEN 3 THEN 'M ohne Listungsart'
                          WHEN 4 THEN 'Aktionsartikel ohne Markenart'
                          WHEN 5 THEN 'Normalsortiment ohne Markenart'
                  END                          AS buying_list_type_desc
               , r.language_id
          FROM P_LEW_CORE_AC.v_wawi_ref_itm_list_type_2 AS r
         WHERE r.buying_list_type_id IN (2,3,4,5)
           AND NOT EXISTS (
                           SELECT   1
                             FROM p_lew_core_ac.v_wawi_ref_itm_list_type_2 AS wawi
                            WHERE r.language_id               = wawi.language_id
                              AND -1 * r.buying_list_type_id  = wawi.buying_list_type_id
                          )
        ) AS d
  GROUP BY buying_list_type_id
;
