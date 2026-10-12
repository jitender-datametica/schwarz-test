/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_LOSS
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_INVENTORY_LOSS
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,wh_id
,v_id
,currency_iso_cd
,warenverlust_anlieferung_val     /* sonstige Warenverluste Anlieferung */
,warenverlust_betrieb_val /* sonstige Warenverluste Betrieb */
,warenverlust_filiale_val     /* sonstige Warenverluste Filiale */
,warenverlust_wg_val  /* sonstige Warenverluste wg */
,anlieferung_qual_filiale_val /* Anlieferung QualitÄ´Âýt Filiale */
 )
AS
SELECT
client_id                                  AS client_id,
iso_cd                                  AS iso_cd,
cy_month                                AS cy_month,
kpi_aspect                              AS kpi_aspect,
wh_id                                   AS wh_id,
v_id                                    AS v_id,
currency_iso_cd                         AS currency_iso_cd,
warenverlust_anlieferung_val  AS warenverlust_anlieferung_val,
warenverlust_betrieb_val       AS warenverlust_betrieb_val,
warenverlust_filiale_val       AS warenverlust_filiale_val,
warenverlust_wg_val            AS warenverlust_wg_val,
anlieferung_qual_filiale_val   AS anlieferung_qual_filiale_val
FROM p_lew_mart_cs.v_bw_inventory_loss_base

UNION  ALL
SELECT
client_id AS client_id,
iso_cd AS iso_cd,
cy_month AS cy_month,
'LAND' AS kpi_aspect,
CAST(NULL AS INTEGER)     AS wh_id,
CAST(NULL AS VARCHAR(10)) AS v_id,
currency_iso_cd AS currency_iso_cd,
SUM(warenverlust_anlieferung_val) AS warenverlust_anlieferung_val,
SUM(warenverlust_betrieb_val) AS warenverlust_betrieb_val,
SUM(warenverlust_filiale_val) AS warenverlust_filiale_val,
SUM(warenverlust_wg_val) AS warenverlust_wg_val,
SUM(anlieferung_qual_filiale_val) AS anlieferung_qual_filiale_val
FROM p_lew_mart_cs.v_bw_inventory_loss_base
WHERE aspect_id = 1

GROUP BY
   client_id
  ,iso_cd
  ,cy_month
  ,currency_iso_cd
;


