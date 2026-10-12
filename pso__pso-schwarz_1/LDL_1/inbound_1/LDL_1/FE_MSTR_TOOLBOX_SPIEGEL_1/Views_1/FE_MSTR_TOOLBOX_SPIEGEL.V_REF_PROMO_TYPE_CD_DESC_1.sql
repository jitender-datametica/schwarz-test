/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_PRICE_LABEL_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  22.03.2024    Simeon Nikolaev           Initial DDL
#  1.0  23.04.2024    Simeon Nikolaev           Update _BE_FR
#  1.0  20.05.2024    Simeon Nikolaev           Update Gesamt/Total
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_PROMO_TYPE_CD_DESC_1(
  STORAGE_TEST_PROMO_TYPE_CD
 ,PROMO_DESC
 ,PROMO_DESC_CH
 ,PROMO_DESC_AT 
 ,PROMO_DESC_BE_FR 
 ,PROMO_DESC_BG 
 ,PROMO_DESC_CY 
 ,PROMO_DESC_CZ 
 ,PROMO_DESC_DK 
 ,PROMO_DESC_ES 
 ,PROMO_DESC_FI 
 ,PROMO_DESC_FR 
 ,PROMO_DESC_GB 
 ,PROMO_DESC_GR 
 ,PROMO_DESC_HR 
 ,PROMO_DESC_HU 
 ,PROMO_DESC_IE 
 ,PROMO_DESC_IT 
 ,PROMO_DESC_LT 
 ,PROMO_DESC_NI 
 ,PROMO_DESC_NL 
 ,PROMO_DESC_DE 
 ,PROMO_DESC_PL 
 ,PROMO_DESC_PT 
 ,PROMO_DESC_RO 
 ,PROMO_DESC_SE 
 ,PROMO_DESC_SI 
 ,PROMO_DESC_SK 
 ,PROMO_DESC_CS 
 ,PROMO_DESC_MT 
 ,PROMO_DESC_US 
 ,PROMO_DESC_RS 
) AS
SELECT
  STORAGE_TEST_PROMO_TYPE_CD
 ,PROMO_DESC
 ,PROMO_DESC_CH
 ,PROMO_DESC_AT 
 ,PROMO_DESC_BE_FR 
 ,PROMO_DESC_BG 
 ,PROMO_DESC_CY 
 ,PROMO_DESC_CZ 
 ,PROMO_DESC_DK 
 ,PROMO_DESC_ES 
 ,PROMO_DESC_FI 
 ,PROMO_DESC_FR 
 ,PROMO_DESC_GB 
 ,PROMO_DESC_GR 
 ,PROMO_DESC_HR 
 ,PROMO_DESC_HU 
 ,PROMO_DESC_IE 
 ,PROMO_DESC_IT 
 ,PROMO_DESC_LT 
 ,PROMO_DESC_NI 
 ,PROMO_DESC_NL 
 ,PROMO_DESC_DE 
 ,PROMO_DESC_PL 
 ,PROMO_DESC_PT 
 ,PROMO_DESC_RO 
 ,PROMO_DESC_SE 
 ,PROMO_DESC_SI 
 ,PROMO_DESC_SK 
 ,PROMO_DESC_CS 
 ,PROMO_DESC_MT 
 ,PROMO_DESC_US 
 ,PROMO_DESC_RS 

FROM
(
SELECT 
 'Sortiment'		AS STORAGE_TEST_PROMO_TYPE_CD
,'Sortiment'		AS PROMO_DESC
,'Sortiment' 		AS PROMO_DESC_DE
,'Sortiment'		AS PROMO_DESC_CH
,'Sortiment'		AS PROMO_DESC_AT
,'Assortment' 		AS PROMO_DESC_BE_FR
,'Assortment' 		AS PROMO_DESC_BG
,'Assortment' 		AS PROMO_DESC_CY
,'Assortment' 		AS PROMO_DESC_CZ
,'Assortment' 		AS PROMO_DESC_DK
,'Assortment' 		AS PROMO_DESC_ES
,'Assortment' 		AS PROMO_DESC_FI
,'Assortment' 		AS PROMO_DESC_FR
,'Assortment' 		AS PROMO_DESC_GB
,'Assortment' 		AS PROMO_DESC_GR
,'Assortment' 		AS PROMO_DESC_HR
,'Assortment' 		AS PROMO_DESC_HU
,'Assortment' 		AS PROMO_DESC_IE
,'Assortment' 		AS PROMO_DESC_IT
,'Assortment' 		AS PROMO_DESC_LT
,'Assortment' 		AS PROMO_DESC_NI
,'Assortment' 		AS PROMO_DESC_NL
,'Assortment' 		AS PROMO_DESC_PL
,'Assortment' 		AS PROMO_DESC_PT
,'Assortment' 		AS PROMO_DESC_RO
,'Assortment' 		AS PROMO_DESC_SE
,'Assortment' 		AS PROMO_DESC_SI
,'Assortment' 		AS PROMO_DESC_SK
,'Assortment' 		AS PROMO_DESC_CS
,'Assortment' 		AS PROMO_DESC_MT
,'Assortment' 		AS PROMO_DESC_US
,'Assortment' 		AS PROMO_DESC_RS

UNION
SELECT
 'Aktion_1'		AS STORAGE_TEST_PROMO_TYPE_CD
,'Aktion_1'		AS PROMO_DESC
,'Aktion_1' 		AS PROMO_DESC_DE
,'Aktion_1'		AS PROMO_DESC_CH
,'Aktion_1'		AS PROMO_DESC_AT
,'Promotion' 	AS PROMO_DESC_BE_FR
,'Promotion' 	AS PROMO_DESC_BG
,'Promotion' 	AS PROMO_DESC_CY
,'Promotion' 	AS PROMO_DESC_CZ
,'Promotion' 	AS PROMO_DESC_DK
,'Promotion' 	AS PROMO_DESC_ES
,'Promotion' 	AS PROMO_DESC_FI
,'Promotion' 	AS PROMO_DESC_FR
,'Promotion' 	AS PROMO_DESC_GB
,'Promotion' 	AS PROMO_DESC_GR
,'Promotion' 	AS PROMO_DESC_HR
,'Promotion' 	AS PROMO_DESC_HU
,'Promotion' 	AS PROMO_DESC_IE
,'Promotion' 	AS PROMO_DESC_IT
,'Promotion' 	AS PROMO_DESC_LT
,'Promotion' 	AS PROMO_DESC_NI
,'Promotion' 	AS PROMO_DESC_NL
,'Promotion' 	AS PROMO_DESC_PL
,'Promotion' 	AS PROMO_DESC_PT
,'Promotion' 	AS PROMO_DESC_RO
,'Promotion' 	AS PROMO_DESC_SE
,'Promotion' 	AS PROMO_DESC_SI
,'Promotion' 	AS PROMO_DESC_SK
,'Promotion' 	AS PROMO_DESC_CS
,'Promotion' 	AS PROMO_DESC_MT
,'Promotion' 	AS PROMO_DESC_US
,'Promotion' 	AS PROMO_DESC_RS

UNION
SELECT
 ''			AS STORAGE_TEST_PROMO_TYPE_CD
,'Gesamt'	AS PROMO_DESC
,'Gesamt' 	AS PROMO_DESC_DE
,'Gesamt'	AS PROMO_DESC_CH
,'Gesamt'	AS PROMO_DESC_AT
,'Total' 	AS PROMO_DESC_BE_FR
,'Total' 	AS PROMO_DESC_BG
,'Total' 	AS PROMO_DESC_CY
,'Total' 	AS PROMO_DESC_CZ
,'Total' 	AS PROMO_DESC_DK
,'Total' 	AS PROMO_DESC_ES
,'Total' 	AS PROMO_DESC_FI
,'Total' 	AS PROMO_DESC_FR
,'Total' 	AS PROMO_DESC_GB
,'Total' 	AS PROMO_DESC_GR
,'Total' 	AS PROMO_DESC_HR
,'Total' 	AS PROMO_DESC_HU
,'Total' 	AS PROMO_DESC_IE
,'Total' 	AS PROMO_DESC_IT
,'Total' 	AS PROMO_DESC_LT
,'Total' 	AS PROMO_DESC_NI
,'Total' 	AS PROMO_DESC_NL
,'Total' 	AS PROMO_DESC_PL
,'Total' 	AS PROMO_DESC_PT
,'Total' 	AS PROMO_DESC_RO
,'Total' 	AS PROMO_DESC_SE
,'Total' 	AS PROMO_DESC_SI
,'Total' 	AS PROMO_DESC_SK
,'Total' 	AS PROMO_DESC_CS
,'Total' 	AS PROMO_DESC_MT
,'Total' 	AS PROMO_DESC_US
,'Total' 	AS PROMO_DESC_RS
);