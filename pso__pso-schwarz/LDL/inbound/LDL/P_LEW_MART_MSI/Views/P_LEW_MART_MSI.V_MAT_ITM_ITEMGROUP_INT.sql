CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_ITEMGROUP_INT
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  13.10.2017    Meister,Ulrich logic moved from mart_msi to lew_bil llll ll
#  1.2  18.09.2017    -                        Generiert aus Teradata
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  18.09.2017    -                        Generiert aus Teradata
#  1.5  05.12.2017    Proch, Marika            Änderung des BIL-Layers
#  1.6  21.12.2017    Proch,Marika             Austausch des BIL-Layers
#  1.7  10.01.2018    Proch,Marika             Änderung der desc von max auf min
#  1.8  08.02.2018    Proch,Marika             Änderung der Logik für die itemgroup_int_remark
#  1.0  14.02.2018    Ueding,Michael           Initial: Logik aus v_itm_itemgroup_int
#  1.9  10.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  2.0  08.03.2021    Piotr Krawczyk           Used DE/US description for itemgroup_int
#  2.1  24.03.2021    Torsten Bachmann         Further adjustment for description for WGI 0
#  2.2  17.12.2021    Michael Morris           Added Estonia EE
#----------------------------------------------------------------------------
*/
AS
SELECT  CAST(TO_NUMBER(src_itemgrp_int_cd) AS INTEGER) AS itemgroup_int_id /* Datentypangleichung */
/* pick best der verfügbaren Bezeichnungen pro client_id durch Maximumbestimmung */
, MAX (COALESCE (itemgroup_desc_lidl_long, itemgroup_desc_lidl) ) itemgroup_int_remark
, MAX(CASE WHEN client_id = 1  THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_AT
, MAX(CASE WHEN client_id = 2  THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_BE
, MAX(CASE WHEN client_id = 3  THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_BG
, MAX(CASE WHEN client_id = 4  THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_CH
, MAX(CASE WHEN client_id = 5  THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_CY
, MAX(CASE WHEN client_id = 6  THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_CZ
, MAX(CASE WHEN client_id = 23 AND itemgroup_int_id <> 0    THEN CONCAT(CAST(itemgroup_int_id AS VARCHAR(20)),' ',itemgroup_desc_lidl)
           WHEN client_id = 33 AND itemgroup_int_id =  0    THEN '0 Administration'
           WHEN client_id = 33 AND itemgroup_int_id = -2000 THEN CONCAT(CAST(itemgroup_int_id AS VARCHAR(20)),' ',item_grp_int_name)
           ELSE NULL END ) AS itemgroup_int_desc
, MAX(CASE WHEN client_id =  8 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_DK
, MAX(CASE WHEN client_id =  9 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_EE
, MAX(CASE WHEN client_id = 10 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_ES
, MAX(CASE WHEN client_id = 11 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_FI
, MAX(CASE WHEN client_id = 12 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_FR
, MAX(CASE WHEN client_id = 13 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_GB
, MAX(CASE WHEN client_id = 14 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_GR
, MAX(CASE WHEN client_id = 15 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_HR
, MAX(CASE WHEN client_id = 16 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_HU
, MAX(CASE WHEN client_id = 17 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_IE
, MAX(CASE WHEN client_id = 18 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_IT
, MAX(CASE WHEN client_id = 19 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_LT
, MAX(CASE WHEN client_id = 20 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_LV
, MAX(CASE WHEN client_id = 21 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_NI
, MAX(CASE WHEN client_id = 22 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_NL
, MAX(CASE WHEN client_id = 23 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_DE
, MAX(CASE WHEN client_id = 24 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_PL
, MAX(CASE WHEN client_id = 25 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_PT
, MAX(CASE WHEN client_id = 26 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_RO
, MAX(CASE WHEN client_id = 27 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_SE
, MAX(CASE WHEN client_id = 28 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_SI
, MAX(CASE WHEN client_id = 29 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_SK
, MAX(CASE WHEN client_id = 31 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_CS
, MAX(CASE WHEN client_id = 32 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_MT
, MAX(CASE WHEN client_id = 33 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_US
, MAX(CASE WHEN client_id = 34 THEN itemgroup_desc_default ELSE NULL END ) AS itemgroup_int_desc_RS
 FROM P_LEW_BIL_AC.v_itemgroup_international
GROUP BY itemgroup_int_id
;

