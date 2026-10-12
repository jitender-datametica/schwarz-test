/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_WRITEOFF_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* #
   #Summary for Land_1 
   # */ CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_inventory_writeoff_1 (client_id, iso_cd,
cy_month, kpi_aspect, wh_id, v_id, currency_iso_cd, abschriften_betrieb, abschriften_filiale, abschriften_warengeschaeft
, restantenverwertung, rabattierung) AS SELECT client_id,
 iso_cd,
 cy_month,
 kpi_aspect,
 wh_id,
 v_id,
 currency_iso_cd,
 abschriften_betrieb,
 abschriften_filiale,
 abschriften_warengeschaeft,
 restantenverwertung,
 rabattierung
FROM ldl_p_lew_mart_cs.v_bw_inventory_writeoff_base_1
UNION ALL
SELECT client_id,
 iso_cd,
 cy_month,
 'LAND_1' AS kpi_aspect,
 CAST(NULL AS BIGNUMERIC) AS wh_id,
 CAST(NULL AS INTEGER) AS v_id,
 currency_iso_cd,
 SUM(abschriften_betrieb) AS abschriften_betrieb,
 SUM(abschriften_filiale) AS abschriften_filiale,
 SUM(abschriften_warengeschaeft) AS abschriften_warengeschaeft,
 SUM(restantenverwertung) AS restantenverwertung,
 SUM(rabattierung) AS rabattierung
FROM ldl_p_lew_mart_cs.v_bw_inventory_writeoff_base_1
WHERE aspect_id = 1
GROUP BY client_id,
 iso_cd,
 cy_month,
 currency_iso_cd;