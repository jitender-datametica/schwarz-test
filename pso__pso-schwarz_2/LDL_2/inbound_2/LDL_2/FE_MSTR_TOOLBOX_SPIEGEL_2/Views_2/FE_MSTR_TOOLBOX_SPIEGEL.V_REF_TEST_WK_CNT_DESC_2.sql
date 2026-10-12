/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_PRICE_LABEL_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  22.03.2024    Simeon Nikolaev           Initial DDL
#  2.0  23.04.2024    Simeon Nikolaev           Update _BE_FR
#
#----------------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_TEST_WK_CNT_DESC_2(
  TEST_WEEK_CNT
 ,TST_WK_CNT_DESC
 ,TST_WK_CNT_DESC_CH
 ,TST_WK_CNT_DESC_AT 
 ,TST_WK_CNT_DESC_BE_FR 
 ,TST_WK_CNT_DESC_BG 
 ,TST_WK_CNT_DESC_CY 
 ,TST_WK_CNT_DESC_CZ 
 ,TST_WK_CNT_DESC_DK 
 ,TST_WK_CNT_DESC_ES 
 ,TST_WK_CNT_DESC_FI 
 ,TST_WK_CNT_DESC_FR 
 ,TST_WK_CNT_DESC_GB 
 ,TST_WK_CNT_DESC_GR 
 ,TST_WK_CNT_DESC_HR 
 ,TST_WK_CNT_DESC_HU 
 ,TST_WK_CNT_DESC_IE 
 ,TST_WK_CNT_DESC_IT 
 ,TST_WK_CNT_DESC_LT 
 ,TST_WK_CNT_DESC_NI 
 ,TST_WK_CNT_DESC_NL 
 ,TST_WK_CNT_DESC_DE 
 ,TST_WK_CNT_DESC_PL 
 ,TST_WK_CNT_DESC_PT 
 ,TST_WK_CNT_DESC_RO 
 ,TST_WK_CNT_DESC_SE 
 ,TST_WK_CNT_DESC_SI 
 ,TST_WK_CNT_DESC_SK 
 ,TST_WK_CNT_DESC_CS 
 ,TST_WK_CNT_DESC_MT 
 ,TST_WK_CNT_DESC_US 
 ,TST_WK_CNT_DESC_RS 
) AS
SELECT
  TEST_WEEK_CNT
 ,TST_WK_CNT_DESC
 ,TST_WK_CNT_DESC_CH
 ,TST_WK_CNT_DESC_AT 
 ,TST_WK_CNT_DESC_BE_FR 
 ,TST_WK_CNT_DESC_BG 
 ,TST_WK_CNT_DESC_CY 
 ,TST_WK_CNT_DESC_CZ 
 ,TST_WK_CNT_DESC_DK 
 ,TST_WK_CNT_DESC_ES 
 ,TST_WK_CNT_DESC_FI 
 ,TST_WK_CNT_DESC_FR 
 ,TST_WK_CNT_DESC_GB 
 ,TST_WK_CNT_DESC_GR 
 ,TST_WK_CNT_DESC_HR 
 ,TST_WK_CNT_DESC_HU 
 ,TST_WK_CNT_DESC_IE 
 ,TST_WK_CNT_DESC_IT 
 ,TST_WK_CNT_DESC_LT 
 ,TST_WK_CNT_DESC_NI 
 ,TST_WK_CNT_DESC_NL 
 ,TST_WK_CNT_DESC_DE 
 ,TST_WK_CNT_DESC_PL 
 ,TST_WK_CNT_DESC_PT 
 ,TST_WK_CNT_DESC_RO 
 ,TST_WK_CNT_DESC_SE 
 ,TST_WK_CNT_DESC_SI 
 ,TST_WK_CNT_DESC_SK 
 ,TST_WK_CNT_DESC_CS 
 ,TST_WK_CNT_DESC_MT 
 ,TST_WK_CNT_DESC_US 
 ,TST_WK_CNT_DESC_RS 

FROM
(
SELECT 
 'abgeschlossen'	AS TEST_WEEK_CNT
,'abgeschlossen'	AS TST_WK_CNT_DESC
,'abgeschlossen' 	AS TST_WK_CNT_DESC_DE
,'abgeschlossen'	AS TST_WK_CNT_DESC_CH
,'abgeschlossen'	AS TST_WK_CNT_DESC_AT
,'completed' 		AS TST_WK_CNT_DESC_BE_FR
,'completed' 		AS TST_WK_CNT_DESC_BG
,'completed' 		AS TST_WK_CNT_DESC_CY
,'completed' 		AS TST_WK_CNT_DESC_CZ
,'completed' 		AS TST_WK_CNT_DESC_DK
,'completed' 		AS TST_WK_CNT_DESC_ES
,'completed' 		AS TST_WK_CNT_DESC_FI
,'completed' 		AS TST_WK_CNT_DESC_FR
,'completed' 		AS TST_WK_CNT_DESC_GB
,'completed' 		AS TST_WK_CNT_DESC_GR
,'completed' 		AS TST_WK_CNT_DESC_HR
,'completed' 		AS TST_WK_CNT_DESC_HU
,'completed' 		AS TST_WK_CNT_DESC_IE
,'completed' 		AS TST_WK_CNT_DESC_IT
,'completed' 		AS TST_WK_CNT_DESC_LT
,'completed' 		AS TST_WK_CNT_DESC_NI
,'completed' 		AS TST_WK_CNT_DESC_NL
,'completed' 		AS TST_WK_CNT_DESC_PL
,'completed' 		AS TST_WK_CNT_DESC_PT
,'completed' 		AS TST_WK_CNT_DESC_RO
,'completed' 		AS TST_WK_CNT_DESC_SE
,'completed' 		AS TST_WK_CNT_DESC_SI
,'completed' 		AS TST_WK_CNT_DESC_SK
,'completed' 		AS TST_WK_CNT_DESC_CS
,'completed' 		AS TST_WK_CNT_DESC_MT
,'completed' 		AS TST_WK_CNT_DESC_US
,'completed' 		AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '1 Testwoche(n)'	AS TEST_WEEK_CNT
,'1 Testwoche(n)'	AS TST_WK_CNT_DESC
,'1 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'1 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'1 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'1 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '2 Testwoche(n)'	AS TEST_WEEK_CNT
,'2 Testwoche(n)'	AS TST_WK_CNT_DESC
,'2 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'2 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'2 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'2 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '3 Testwoche(n)'	AS TEST_WEEK_CNT
,'3 Testwoche(n)'	AS TST_WK_CNT_DESC
,'3 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'3 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'3 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'3 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '4 Testwoche(n)'	AS TEST_WEEK_CNT
,'4 Testwoche(n)'	AS TST_WK_CNT_DESC
,'4 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'4 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'4 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'4 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '5 Testwoche(n)'	AS TEST_WEEK_CNT
,'5 Testwoche(n)'	AS TST_WK_CNT_DESC
,'5 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'5 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'5 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'5 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '6 Testwoche(n)'	AS TEST_WEEK_CNT
,'6 Testwoche(n)'	AS TST_WK_CNT_DESC
,'6 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'6 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'6 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'6 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '7 Testwoche(n)'	AS TEST_WEEK_CNT
,'7 Testwoche(n)'	AS TST_WK_CNT_DESC
,'7 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'7 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'7 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'7 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '8 Testwoche(n)'	AS TEST_WEEK_CNT
,'8 Testwoche(n)'	AS TST_WK_CNT_DESC
,'8 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'8 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'8 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'8 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '9 Testwoche(n)'	AS TEST_WEEK_CNT
,'9 Testwoche(n)'	AS TST_WK_CNT_DESC
,'9 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'9 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'9 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'9 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '10 Testwoche(n)'	AS TEST_WEEK_CNT
,'10 Testwoche(n)'	AS TST_WK_CNT_DESC
,'10 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'10 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'10 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'10 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '11 Testwoche(n)'	AS TEST_WEEK_CNT
,'11 Testwoche(n)'	AS TST_WK_CNT_DESC
,'11 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'11 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'11 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'11 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '12 Testwoche(n)'	AS TEST_WEEK_CNT
,'12 Testwoche(n)'	AS TST_WK_CNT_DESC
,'12 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'12 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'12 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'12 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '13 Testwoche(n)'	AS TEST_WEEK_CNT
,'13 Testwoche(n)'	AS TST_WK_CNT_DESC
,'13 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'13 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'13 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'13 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '14 Testwoche(n)'	AS TEST_WEEK_CNT
,'14 Testwoche(n)'	AS TST_WK_CNT_DESC
,'14 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'14 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'14 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'14 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '15 Testwoche(n)'	AS TEST_WEEK_CNT
,'15 Testwoche(n)'	AS TST_WK_CNT_DESC
,'15 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'15 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'15 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'15 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '16 Testwoche(n)'	AS TEST_WEEK_CNT
,'16 Testwoche(n)'	AS TST_WK_CNT_DESC
,'16 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'16 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'16 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'16 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '17 Testwoche(n)'	AS TEST_WEEK_CNT
,'17 Testwoche(n)'	AS TST_WK_CNT_DESC
,'17 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'17 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'17 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'17 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '18 Testwoche(n)'	AS TEST_WEEK_CNT
,'18 Testwoche(n)'	AS TST_WK_CNT_DESC
,'18 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'18 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'18 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'18 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '19 Testwoche(n)'	AS TEST_WEEK_CNT
,'19 Testwoche(n)'	AS TST_WK_CNT_DESC
,'19 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'19 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'19 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'19 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '20 Testwoche(n)'	AS TEST_WEEK_CNT
,'20 Testwoche(n)'	AS TST_WK_CNT_DESC
,'20 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'20 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'20 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'20 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '21 Testwoche(n)'	AS TEST_WEEK_CNT
,'21 Testwoche(n)'	AS TST_WK_CNT_DESC
,'21 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'21 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'21 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'21 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '22 Testwoche(n)'	AS TEST_WEEK_CNT
,'22 Testwoche(n)'	AS TST_WK_CNT_DESC
,'22 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'22 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'22 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'22 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '23 Testwoche(n)'	AS TEST_WEEK_CNT
,'23 Testwoche(n)'	AS TST_WK_CNT_DESC
,'23 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'23 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'23 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'23 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '24 Testwoche(n)'	AS TEST_WEEK_CNT
,'24 Testwoche(n)'	AS TST_WK_CNT_DESC
,'24 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'24 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'24 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'24 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '25 Testwoche(n)'	AS TEST_WEEK_CNT
,'25 Testwoche(n)'	AS TST_WK_CNT_DESC
,'25 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'25 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'25 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'25 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '26 Testwoche(n)'	AS TEST_WEEK_CNT
,'26 Testwoche(n)'	AS TST_WK_CNT_DESC
,'26 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'26 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'26 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'26 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '27 Testwoche(n)'	AS TEST_WEEK_CNT
,'27 Testwoche(n)'	AS TST_WK_CNT_DESC
,'27 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'27 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'27 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'27 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '28 Testwoche(n)'	AS TEST_WEEK_CNT
,'28 Testwoche(n)'	AS TST_WK_CNT_DESC
,'28 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'28 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'28 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'28 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '29 Testwoche(n)'	AS TEST_WEEK_CNT
,'29 Testwoche(n)'	AS TST_WK_CNT_DESC
,'29 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'29 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'29 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'29 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '30 Testwoche(n)'	AS TEST_WEEK_CNT
,'30 Testwoche(n)'	AS TST_WK_CNT_DESC
,'30 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'30 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'30 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'30 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '31 Testwoche(n)'	AS TEST_WEEK_CNT
,'31 Testwoche(n)'	AS TST_WK_CNT_DESC
,'31 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'31 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'31 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'31 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '32 Testwoche(n)'	AS TEST_WEEK_CNT
,'32 Testwoche(n)'	AS TST_WK_CNT_DESC
,'32 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'32 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'32 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'32 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '33 Testwoche(n)'	AS TEST_WEEK_CNT
,'33 Testwoche(n)'	AS TST_WK_CNT_DESC
,'33 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'33 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'33 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'33 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '34 Testwoche(n)'	AS TEST_WEEK_CNT
,'34 Testwoche(n)'	AS TST_WK_CNT_DESC
,'34 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'34 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'34 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'34 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '35 Testwoche(n)'	AS TEST_WEEK_CNT
,'35 Testwoche(n)'	AS TST_WK_CNT_DESC
,'35 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'35 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'35 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'35 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '36 Testwoche(n)'	AS TEST_WEEK_CNT
,'36 Testwoche(n)'	AS TST_WK_CNT_DESC
,'36 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'36 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'36 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'36 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '37 Testwoche(n)'	AS TEST_WEEK_CNT
,'37 Testwoche(n)'	AS TST_WK_CNT_DESC
,'37 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'37 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'37 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'37 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '38 Testwoche(n)'	AS TEST_WEEK_CNT
,'38 Testwoche(n)'	AS TST_WK_CNT_DESC
,'38 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'38 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'38 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'38 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '39 Testwoche(n)'	AS TEST_WEEK_CNT
,'39 Testwoche(n)'	AS TST_WK_CNT_DESC
,'39 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'39 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'39 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'39 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '40 Testwoche(n)'	AS TEST_WEEK_CNT
,'40 Testwoche(n)'	AS TST_WK_CNT_DESC
,'40 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'40 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'40 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'40 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '41 Testwoche(n)'	AS TEST_WEEK_CNT
,'41 Testwoche(n)'	AS TST_WK_CNT_DESC
,'41 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'41 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'41 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'41 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '42 Testwoche(n)'	AS TEST_WEEK_CNT
,'42 Testwoche(n)'	AS TST_WK_CNT_DESC
,'42 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'42 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'42 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'42 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '43 Testwoche(n)'	AS TEST_WEEK_CNT
,'43 Testwoche(n)'	AS TST_WK_CNT_DESC
,'43 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'43 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'43 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'43 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '44 Testwoche(n)'	AS TEST_WEEK_CNT
,'44 Testwoche(n)'	AS TST_WK_CNT_DESC
,'44 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'44 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'44 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'44 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '45 Testwoche(n)'	AS TEST_WEEK_CNT
,'45 Testwoche(n)'	AS TST_WK_CNT_DESC
,'45 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'45 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'45 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'45 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '46 Testwoche(n)'	AS TEST_WEEK_CNT
,'46 Testwoche(n)'	AS TST_WK_CNT_DESC
,'46 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'46 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'46 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'46 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '47 Testwoche(n)'	AS TEST_WEEK_CNT
,'47 Testwoche(n)'	AS TST_WK_CNT_DESC
,'47 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'47 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'47 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'47 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '48 Testwoche(n)'	AS TEST_WEEK_CNT
,'48 Testwoche(n)'	AS TST_WK_CNT_DESC
,'48 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'48 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'48 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'48 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '49 Testwoche(n)'	AS TEST_WEEK_CNT
,'49 Testwoche(n)'	AS TST_WK_CNT_DESC
,'49 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'49 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'49 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'49 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '50 Testwoche(n)'	AS TEST_WEEK_CNT
,'50 Testwoche(n)'	AS TST_WK_CNT_DESC
,'50 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'50 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'50 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'50 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '60 Testwoche(n)'	AS TEST_WEEK_CNT
,'60 Testwoche(n)'	AS TST_WK_CNT_DESC
,'60 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'60 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'60 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'60 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '61 Testwoche(n)'	AS TEST_WEEK_CNT
,'61 Testwoche(n)'	AS TST_WK_CNT_DESC
,'61 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'61 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'61 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'61 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '62 Testwoche(n)'	AS TEST_WEEK_CNT
,'62 Testwoche(n)'	AS TST_WK_CNT_DESC
,'62 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'62 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'62 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'62 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '63 Testwoche(n)'	AS TEST_WEEK_CNT
,'63 Testwoche(n)'	AS TST_WK_CNT_DESC
,'63 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'63 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'63 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'63 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '64 Testwoche(n)'	AS TEST_WEEK_CNT
,'64 Testwoche(n)'	AS TST_WK_CNT_DESC
,'64 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'64 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'64 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'64 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '65 Testwoche(n)'	AS TEST_WEEK_CNT
,'65 Testwoche(n)'	AS TST_WK_CNT_DESC
,'65 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'65 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'65 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'65 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '66 Testwoche(n)'	AS TEST_WEEK_CNT
,'66 Testwoche(n)'	AS TST_WK_CNT_DESC
,'66 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'66 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'66 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'66 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '67 Testwoche(n)'	AS TEST_WEEK_CNT
,'67 Testwoche(n)'	AS TST_WK_CNT_DESC
,'67 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'67 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'67 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'67 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '68 Testwoche(n)'	AS TEST_WEEK_CNT
,'68 Testwoche(n)'	AS TST_WK_CNT_DESC
,'68 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'68 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'68 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'68 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '69 Testwoche(n)'	AS TEST_WEEK_CNT
,'69 Testwoche(n)'	AS TST_WK_CNT_DESC
,'69 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'69 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'69 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'69 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '70 Testwoche(n)'	AS TEST_WEEK_CNT
,'70 Testwoche(n)'	AS TST_WK_CNT_DESC
,'70 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'70 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'70 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'70 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '71 Testwoche(n)'	AS TEST_WEEK_CNT
,'71 Testwoche(n)'	AS TST_WK_CNT_DESC
,'71 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'71 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'71 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'71 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '72 Testwoche(n)'	AS TEST_WEEK_CNT
,'72 Testwoche(n)'	AS TST_WK_CNT_DESC
,'72 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'72 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'72 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'72 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '73 Testwoche(n)'	AS TEST_WEEK_CNT
,'73 Testwoche(n)'	AS TST_WK_CNT_DESC
,'73 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'73 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'73 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'73 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '74 Testwoche(n)'	AS TEST_WEEK_CNT
,'74 Testwoche(n)'	AS TST_WK_CNT_DESC
,'74 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'74 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'74 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'74 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '75 Testwoche(n)'	AS TEST_WEEK_CNT
,'75 Testwoche(n)'	AS TST_WK_CNT_DESC
,'75 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'75 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'75 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'75 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '76 Testwoche(n)'	AS TEST_WEEK_CNT
,'76 Testwoche(n)'	AS TST_WK_CNT_DESC
,'76 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'76 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'76 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'76 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '77 Testwoche(n)'	AS TEST_WEEK_CNT
,'77 Testwoche(n)'	AS TST_WK_CNT_DESC
,'77 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'77 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'77 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'77 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '78 Testwoche(n)'	AS TEST_WEEK_CNT
,'78 Testwoche(n)'	AS TST_WK_CNT_DESC
,'78 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'78 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'78 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'78 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '79 Testwoche(n)'	AS TEST_WEEK_CNT
,'79 Testwoche(n)'	AS TST_WK_CNT_DESC
,'79 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'79 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'79 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'79 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '80 Testwoche(n)'	AS TEST_WEEK_CNT
,'80 Testwoche(n)'	AS TST_WK_CNT_DESC
,'80 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'80 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'80 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'80 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '81 Testwoche(n)'	AS TEST_WEEK_CNT
,'81 Testwoche(n)'	AS TST_WK_CNT_DESC
,'81 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'81 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'81 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'81 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '82 Testwoche(n)'	AS TEST_WEEK_CNT
,'82 Testwoche(n)'	AS TST_WK_CNT_DESC
,'82 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'82 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'82 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'82 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '83 Testwoche(n)'	AS TEST_WEEK_CNT
,'83 Testwoche(n)'	AS TST_WK_CNT_DESC
,'83 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'83 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'83 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'83 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '84 Testwoche(n)'	AS TEST_WEEK_CNT
,'84 Testwoche(n)'	AS TST_WK_CNT_DESC
,'84 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'84 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'84 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'84 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '85 Testwoche(n)'	AS TEST_WEEK_CNT
,'85 Testwoche(n)'	AS TST_WK_CNT_DESC
,'85 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'85 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'85 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'85 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '86 Testwoche(n)'	AS TEST_WEEK_CNT
,'86 Testwoche(n)'	AS TST_WK_CNT_DESC
,'86 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'86 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'86 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'86 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '87 Testwoche(n)'	AS TEST_WEEK_CNT
,'87 Testwoche(n)'	AS TST_WK_CNT_DESC
,'87 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'87 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'87 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'87 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '88 Testwoche(n)'	AS TEST_WEEK_CNT
,'88 Testwoche(n)'	AS TST_WK_CNT_DESC
,'88 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'88 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'88 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'88 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '89 Testwoche(n)'	AS TEST_WEEK_CNT
,'89 Testwoche(n)'	AS TST_WK_CNT_DESC
,'89 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'89 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'89 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'89 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '90 Testwoche(n)'	AS TEST_WEEK_CNT
,'90 Testwoche(n)'	AS TST_WK_CNT_DESC
,'90 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'90 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'90 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'90 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '91 Testwoche(n)'	AS TEST_WEEK_CNT
,'91 Testwoche(n)'	AS TST_WK_CNT_DESC
,'91 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'91 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'91 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'91 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '92 Testwoche(n)'	AS TEST_WEEK_CNT
,'92 Testwoche(n)'	AS TST_WK_CNT_DESC
,'92 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'92 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'92 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'92 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '93 Testwoche(n)'	AS TEST_WEEK_CNT
,'93 Testwoche(n)'	AS TST_WK_CNT_DESC
,'93 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'93 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'93 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'93 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '94 Testwoche(n)'	AS TEST_WEEK_CNT
,'94 Testwoche(n)'	AS TST_WK_CNT_DESC
,'94 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'94 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'94 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'94 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '95 Testwoche(n)'	AS TEST_WEEK_CNT
,'95 Testwoche(n)'	AS TST_WK_CNT_DESC
,'95 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'95 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'95 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'95 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '96 Testwoche(n)'	AS TEST_WEEK_CNT
,'96 Testwoche(n)'	AS TST_WK_CNT_DESC
,'96 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'96 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'96 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'96 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '97 Testwoche(n)'	AS TEST_WEEK_CNT
,'97 Testwoche(n)'	AS TST_WK_CNT_DESC
,'97 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'97 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'97 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'97 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '98 Testwoche(n)'	AS TEST_WEEK_CNT
,'98 Testwoche(n)'	AS TST_WK_CNT_DESC
,'98 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'98 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'98 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'98 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '99 Testwoche(n)'	AS TEST_WEEK_CNT
,'99 Testwoche(n)'	AS TST_WK_CNT_DESC
,'99 Testwoche(n)' 	AS TST_WK_CNT_DESC_DE
,'99 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'99 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'99 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

UNION
SELECT
 '100 Testwoche(n)'	AS TEST_WEEK_CNT
,'100 Testwoche(n)'	AS TST_WK_CNT_DESC
,'100 Testwoche(n)' AS TST_WK_CNT_DESC_DE
,'100 Testwoche(n)'	AS TST_WK_CNT_DESC_CH
,'100 Testwoche(n)'	AS TST_WK_CNT_DESC_AT
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BE_FR
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_BG
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CY
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CZ
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_DK
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_ES
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FI
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_FR
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GB
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_GR
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HR
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_HU
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IE
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_IT
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_LT
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NI
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_NL
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PL
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_PT
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RO
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SE
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SI
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_SK
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_CS
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_MT
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_US
,'100 Test_2 week(s)' 	AS TST_WK_CNT_DESC_RS

);