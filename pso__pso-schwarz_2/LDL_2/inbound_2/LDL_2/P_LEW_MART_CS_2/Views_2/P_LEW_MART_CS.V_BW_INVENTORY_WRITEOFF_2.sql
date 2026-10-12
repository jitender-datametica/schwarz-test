/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_WRITEOFF_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_INVENTORY_WRITEOFF_2
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,wh_id
,v_id
,currency_iso_cd
,abschriften_betrieb
,abschriften_filiale
,abschriften_warengeschaeft
,restantenverwertung
,rabattierung
 )
AS


   SELECT client_id,
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
     FROM p_lew_mart_cs.v_bw_inventory_writeoff_base_2
   UNION ALL
   /*
   #
   #Summary for Land_2 
   #
   */
   SELECT client_id                          AS client_id,
   iso_cd                            AS iso_cd,
   cy_month                          AS cy_month,
   'LAND_2'                            AS kpi_aspect,
   NULL                              AS wh_id,
   NULL                              AS v_id,
   currency_iso_cd                   AS currency_iso_cd,
   SUM(abschriften_betrieb)          AS abschriften_betrieb,
   SUM(abschriften_filiale)          AS abschriften_filiale,
   SUM(abschriften_warengeschaeft)   AS abschriften_warengeschaeft,
   SUM(restantenverwertung)          AS restantenverwertung,
   SUM(rabattierung)                 AS rabattierung
    FROM p_lew_mart_cs.v_bw_inventory_writeoff_base_2
    WHERE aspect_id = 1
    GROUP BY client_id
             ,iso_cd
             ,cy_month
             ,currency_iso_cd

;