/*
#----------------------------------------------------------------------------
# Description:
# Static table for Reporting.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     27.11.2023      Aparna Rayanki          Initial Version
#  2.0     22.12.2023      Simeon Nikolaev         Translation Update US + GB
#  3.0     22.03.2024      Simeon Nikolaev         Translation Update For all other countries
#  4.0     23.04.2024      Simeon Nikolaev         Update _BE_FR
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_GROUP_NAMES(
  GROUPID
 ,GROUPNAME
 ,GROUPNAME_CH
 ,GROUPNAME_AT 
 ,GROUPNAME_BE_FR 
 ,GROUPNAME_BG 
 ,GROUPNAME_CY 
 ,GROUPNAME_CZ 
 ,GROUPNAME_DK 
 ,GROUPNAME_ES 
 ,GROUPNAME_FI 
 ,GROUPNAME_FR 
 ,GROUPNAME_GB 
 ,GROUPNAME_GR 
 ,GROUPNAME_HR 
 ,GROUPNAME_HU 
 ,GROUPNAME_IE 
 ,GROUPNAME_IT 
 ,GROUPNAME_LT 
 ,GROUPNAME_NI 
 ,GROUPNAME_NL 
 ,GROUPNAME_DE 
 ,GROUPNAME_PL 
 ,GROUPNAME_PT 
 ,GROUPNAME_RO 
 ,GROUPNAME_SE 
 ,GROUPNAME_SI 
 ,GROUPNAME_SK 
 ,GROUPNAME_CS 
 ,GROUPNAME_MT 
 ,GROUPNAME_US 
 ,GROUPNAME_RS 
) AS
SELECT
  GROUPID
 ,GROUPNAME
 ,GROUPNAME_CH
 ,GROUPNAME_AT 
 ,GROUPNAME_BE_FR 
 ,GROUPNAME_BG 
 ,GROUPNAME_CY 
 ,GROUPNAME_CZ 
 ,GROUPNAME_DK 
 ,GROUPNAME_ES 
 ,GROUPNAME_FI 
 ,GROUPNAME_FR 
 ,GROUPNAME_GB 
 ,GROUPNAME_GR 
 ,GROUPNAME_HR 
 ,GROUPNAME_HU 
 ,GROUPNAME_IE 
 ,GROUPNAME_IT 
 ,GROUPNAME_LT 
 ,GROUPNAME_NI 
 ,GROUPNAME_NL 
 ,GROUPNAME_DE 
 ,GROUPNAME_PL 
 ,GROUPNAME_PT 
 ,GROUPNAME_RO 
 ,GROUPNAME_SE 
 ,GROUPNAME_SI 
 ,GROUPNAME_SK 
 ,GROUPNAME_CS 
 ,GROUPNAME_MT 
 ,GROUPNAME_US 
 ,GROUPNAME_RS 

FROM
(
SELECT
1	AS groupid
,'Nettoumsatz'	AS groupname
,'Nettoumsatz' AS groupname_DE
,'Nettoumsatz'	AS groupname_CH
,'Nettoumsatz'	AS groupname_AT
,'Net Sales' AS groupname_BE_FR
,'Net Sales' AS groupname_BG
,'Net Sales' AS groupname_CY
,'Net Sales' AS groupname_CZ
,'Net Sales' AS groupname_DK
,'Net Sales' AS groupname_ES
,'Net Sales' AS groupname_FI
,'Net Sales' AS groupname_FR
,'Net Sales' AS groupname_GB
,'Net Sales' AS groupname_GR
,'Net Sales' AS groupname_HR
,'Net Sales' AS groupname_HU
,'Net Sales' AS groupname_IE
,'Net Sales' AS groupname_IT
,'Net Sales' AS groupname_LT
,'Net Sales' AS groupname_NI
,'Net Sales' AS groupname_NL
,'Net Sales' AS groupname_PL
,'Net Sales' AS groupname_PT
,'Net Sales' AS groupname_RO
,'Net Sales' AS groupname_SE
,'Net Sales' AS groupname_SI
,'Net Sales' AS groupname_SK
,'Net Sales' AS groupname_CS
,'Net Sales' AS groupname_MT
,'Net Sales' AS groupname_US
,'Net Sales' AS groupname_RS

UNION
SELECT
2	AS groupid
,'Abverkaufskalkulation'	AS groupname
,'Abverkaufskalkulation' AS groupname_DE
,'Abverkaufskalkulation'	AS groupname_CH
,'Abverkaufskalkulation'	AS groupname_AT
,'Sales Calculation' AS groupname_BE_FR
,'Sales Calculation' AS groupname_BG
,'Sales Calculation' AS groupname_CY
,'Sales Calculation' AS groupname_CZ
,'Sales Calculation' AS groupname_DK
,'Sales Calculation' AS groupname_ES
,'Sales Calculation' AS groupname_FI
,'Sales Calculation' AS groupname_FR
,'Sales Calculation' AS groupname_GB
,'Sales Calculation' AS groupname_GR
,'Sales Calculation' AS groupname_HR
,'Sales Calculation' AS groupname_HU
,'Sales Calculation' AS groupname_IE
,'Sales Calculation' AS groupname_IT
,'Sales Calculation' AS groupname_LT
,'Sales Calculation' AS groupname_NI
,'Sales Calculation' AS groupname_NL
,'Sales Calculation' AS groupname_PL
,'Sales Calculation' AS groupname_PT
,'Sales Calculation' AS groupname_RO
,'Sales Calculation' AS groupname_SE
,'Sales Calculation' AS groupname_SI
,'Sales Calculation' AS groupname_SK
,'Sales Calculation' AS groupname_CS
,'Sales Calculation' AS groupname_MT
,'Sales Calculation' AS groupname_US
,'Sales Calculation' AS groupname_RS

UNION
SELECT
3	AS groupid
,'Abschriften'	AS groupname
,'Abschriften' AS groupname_DE
,'Abschriften'	AS groupname_CH
,'Abschriften'	AS groupname_AT
,'Write-Offs' AS groupname_BE_FR
,'Write-Offs' AS groupname_BG
,'Write-Offs' AS groupname_CY
,'Write-Offs' AS groupname_CZ
,'Write-Offs' AS groupname_DK
,'Write-Offs' AS groupname_ES
,'Write-Offs' AS groupname_FI
,'Write-Offs' AS groupname_FR
,'Write-Offs' AS groupname_GB
,'Write-Offs' AS groupname_GR
,'Write-Offs' AS groupname_HR
,'Write-Offs' AS groupname_HU
,'Write-Offs' AS groupname_IE
,'Write-Offs' AS groupname_IT
,'Write-Offs' AS groupname_LT
,'Write-Offs' AS groupname_NI
,'Write-Offs' AS groupname_NL
,'Write-Offs' AS groupname_PL
,'Write-Offs' AS groupname_PT
,'Write-Offs' AS groupname_RO
,'Write-Offs' AS groupname_SE
,'Write-Offs' AS groupname_SI
,'Write-Offs' AS groupname_SK
,'Write-Offs' AS groupname_CS
,'Write-Offs' AS groupname_MT
,'Write-Offs' AS groupname_US
,'Write-Offs' AS groupname_RS

UNION
SELECT
4	AS groupid
,'Anzahl Bons'	AS groupname
,'Anzahl Bons' AS groupname_DE
,'Anzahl Bons'	AS groupname_CH
,'Anzahl Bons'	AS groupname_AT
,'No of Receipts' AS groupname_BE_FR
,'No of Receipts' AS groupname_BG
,'No of Receipts' AS groupname_CY
,'No of Receipts' AS groupname_CZ
,'No of Receipts' AS groupname_DK
,'No of Receipts' AS groupname_ES
,'No of Receipts' AS groupname_FI
,'No of Receipts' AS groupname_FR
,'No of Receipts' AS groupname_GB
,'No of Receipts' AS groupname_GR
,'No of Receipts' AS groupname_HR
,'No of Receipts' AS groupname_HU
,'No of Receipts' AS groupname_IE
,'No of Receipts' AS groupname_IT
,'No of Receipts' AS groupname_LT
,'No of Receipts' AS groupname_NI
,'No of Receipts' AS groupname_NL
,'No of Receipts' AS groupname_PL
,'No of Receipts' AS groupname_PT
,'No of Receipts' AS groupname_RO
,'No of Receipts' AS groupname_SE
,'No of Receipts' AS groupname_SI
,'No of Receipts' AS groupname_SK
,'No of Receipts' AS groupname_CS
,'No of Receipts' AS groupname_MT
,'No of Receipts' AS groupname_US
,'No of Receipts' AS groupname_RS

UNION
SELECT
5	AS groupid
,'Ø-Bon'	AS groupname
,'Ø-Bon' AS groupname_DE
,'Ø-Bon'	AS groupname_CH
,'Ø-Bon'	AS groupname_AT
,'Average Receipt' AS groupname_BE_FR
,'Average Receipt' AS groupname_BG
,'Average Receipt' AS groupname_CY
,'Average Receipt' AS groupname_CZ
,'Average Receipt' AS groupname_DK
,'Average Receipt' AS groupname_ES
,'Average Receipt' AS groupname_FI
,'Average Receipt' AS groupname_FR
,'Average Receipt' AS groupname_GB
,'Average Receipt' AS groupname_GR
,'Average Receipt' AS groupname_HR
,'Average Receipt' AS groupname_HU
,'Average Receipt' AS groupname_IE
,'Average Receipt' AS groupname_IT
,'Average Receipt' AS groupname_LT
,'Average Receipt' AS groupname_NI
,'Average Receipt' AS groupname_NL
,'Average Receipt' AS groupname_PL
,'Average Receipt' AS groupname_PT
,'Average Receipt' AS groupname_RO
,'Average Receipt' AS groupname_SE
,'Average Receipt' AS groupname_SI
,'Average Receipt' AS groupname_SK
,'Average Receipt' AS groupname_CS
,'Average Receipt' AS groupname_MT
,'Average Receipt' AS groupname_US
,'Average Receipt' AS groupname_RS

UNION
SELECT
6	AS groupid
,'Abverkaufte Stück'	AS groupname
,'Abverkaufte Stück' AS groupname_DE
,'Abverkaufte Stück'	AS groupname_CH
,'Abverkaufte Stück'	AS groupname_AT
,'Sales Quantity' AS groupname_BE_FR
,'Sales Quantity' AS groupname_BG
,'Sales Quantity' AS groupname_CY
,'Sales Quantity' AS groupname_CZ
,'Sales Quantity' AS groupname_DK
,'Sales Quantity' AS groupname_ES
,'Sales Quantity' AS groupname_FI
,'Sales Quantity' AS groupname_FR
,'Sales Quantity' AS groupname_GB
,'Sales Quantity' AS groupname_GR
,'Sales Quantity' AS groupname_HR
,'Sales Quantity' AS groupname_HU
,'Sales Quantity' AS groupname_IE
,'Sales Quantity' AS groupname_IT
,'Sales Quantity' AS groupname_LT
,'Sales Quantity' AS groupname_NI
,'Sales Quantity' AS groupname_NL
,'Sales Quantity' AS groupname_PL
,'Sales Quantity' AS groupname_PT
,'Sales Quantity' AS groupname_RO
,'Sales Quantity' AS groupname_SE
,'Sales Quantity' AS groupname_SI
,'Sales Quantity' AS groupname_SK
,'Sales Quantity' AS groupname_CS
,'Sales Quantity' AS groupname_MT
,'Sales Quantity' AS groupname_US
,'Sales Quantity' AS groupname_RS

UNION
SELECT
7	AS groupid
,'Netto Personalstunden'	AS groupname
,'Netto Personalstunden' AS groupname_DE
,'Netto Personalstunden'	AS groupname_CH
,'Netto Personalstunden'	AS groupname_AT
,'Net Hours' AS groupname_BE_FR
,'Net Hours' AS groupname_BG
,'Net Hours' AS groupname_CY
,'Net Hours' AS groupname_CZ
,'Net Hours' AS groupname_DK
,'Net Hours' AS groupname_ES
,'Net Hours' AS groupname_FI
,'Net Hours' AS groupname_FR
,'Net Hours' AS groupname_GB
,'Net Hours' AS groupname_GR
,'Net Hours' AS groupname_HR
,'Net Hours' AS groupname_HU
,'Net Hours' AS groupname_IE
,'Net Hours' AS groupname_IT
,'Net Hours' AS groupname_LT
,'Net Hours' AS groupname_NI
,'Net Hours' AS groupname_NL
,'Net Hours' AS groupname_PL
,'Net Hours' AS groupname_PT
,'Net Hours' AS groupname_RO
,'Net Hours' AS groupname_SE
,'Net Hours' AS groupname_SI
,'Net Hours' AS groupname_SK
,'Net Hours' AS groupname_CS
,'Net Hours' AS groupname_MT
,'Net Hours' AS groupname_US
,'Net Hours' AS groupname_RS

UNION
SELECT
8	AS groupid
,'Stückleistung'	AS groupname
,'Stückleistung' AS groupname_DE
,'Stückleistung'	AS groupname_CH
,'Stückleistung'	AS groupname_AT
,'Piece Performance' AS groupname_BE_FR
,'Piece Performance' AS groupname_BG
,'Piece Performance' AS groupname_CY
,'Piece Performance' AS groupname_CZ
,'Piece Performance' AS groupname_DK
,'Piece Performance' AS groupname_ES
,'Piece Performance' AS groupname_FI
,'Piece Performance' AS groupname_FR
,'Piece Performance' AS groupname_GB
,'Piece Performance' AS groupname_GR
,'Piece Performance' AS groupname_HR
,'Piece Performance' AS groupname_HU
,'Piece Performance' AS groupname_IE
,'Piece Performance' AS groupname_IT
,'Piece Performance' AS groupname_LT
,'Piece Performance' AS groupname_NI
,'Piece Performance' AS groupname_NL
,'Piece Performance' AS groupname_PL
,'Piece Performance' AS groupname_PT
,'Piece Performance' AS groupname_RO
,'Piece Performance' AS groupname_SE
,'Piece Performance' AS groupname_SI
,'Piece Performance' AS groupname_SK
,'Piece Performance' AS groupname_CS
,'Piece Performance' AS groupname_MT
,'Piece Performance' AS groupname_US
,'Piece Performance' AS groupname_RS
)refa
;