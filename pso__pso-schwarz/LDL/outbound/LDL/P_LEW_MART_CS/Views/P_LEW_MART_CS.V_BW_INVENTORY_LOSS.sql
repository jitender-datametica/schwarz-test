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


/* sonstige Warenverluste Anlieferung */ /* Anlieferung QualitÄ´Âýt Filiale */ /* sonstige Warenverluste wg */
/* sonstige Warenverluste Betrieb */ /* sonstige Warenverluste Filiale */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_inventory_loss (client_id, iso_cd, cy_month, kpi_aspect, wh_id, v_id,
currency_iso_cd, warenverlust_anlieferung_val, warenverlust_betrieb_val, warenverlust_filiale_val, warenverlust_wg_val,
anlieferung_qual_filiale_val) AS SELECT client_id,
 iso_cd,
 cy_month,
 kpi_aspect,
 wh_id,
 v_id,
 currency_iso_cd,
 warenverlust_anlieferung_val,
 warenverlust_betrieb_val,
 warenverlust_filiale_val,
 warenverlust_wg_val,
 anlieferung_qual_filiale_val
FROM ldl_p_lew_mart_cs.v_bw_inventory_loss_base
UNION ALL
SELECT client_id,
 iso_cd,
 cy_month,
 'LAND' AS kpi_aspect,
 CAST(NULL AS BIGNUMERIC) AS wh_id,
 CAST(NULL AS INTEGER) AS v_id,
 currency_iso_cd,
 SUM(warenverlust_anlieferung_val) AS warenverlust_anlieferung_val,
 SUM(warenverlust_betrieb_val) AS warenverlust_betrieb_val,
 SUM(warenverlust_filiale_val) AS warenverlust_filiale_val,
 SUM(warenverlust_wg_val) AS warenverlust_wg_val,
 SUM(anlieferung_qual_filiale_val) AS anlieferung_qual_filiale_val
FROM ldl_p_lew_mart_cs.v_bw_inventory_loss_base
WHERE aspect_id = 1
GROUP BY client_id,
 iso_cd,
 cy_month,
 currency_iso_cd;