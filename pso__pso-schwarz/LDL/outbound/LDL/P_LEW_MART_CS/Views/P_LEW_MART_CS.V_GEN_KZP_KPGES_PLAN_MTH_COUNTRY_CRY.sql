/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_KZP_KPGES_PLAN_MTH_COUNTRY_CRY
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* * Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
************************************************************************************************************ */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_kzp_kpges_plan_mth_country_cry (client_id, indicator_id, cy_month,
val_indicator, currency_iso_cd, dat_dayend, cry_valid_from, cry_valid_until) AS SELECT IMTH.client_id,
 IMTH.indicator_id,
   IMTH.cy * 100 + IMTH.month_id AS cy_month,
  CASE
  WHEN IMTH.indicator_id IN (105, 108, 112, 117, 120, 125, 126, 133, 135, 136, 146, 151, 155, 156, 157, 158, 161, 162,
    163, 168, 169, 170, 172, 174, 177, 179, 203, 204, 209, 210, 212, 216, 271, 272, 273, 276, 280, 281, 282, 283, 284,
    286, 288, 289)
  THEN IMTH.val_indicator / CRY.rate_currency_exchange
  ELSE IMTH.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 IMTH.dat_dayend,
 CRY.dat_rec_start AS cry_valid_from,
 CRY.dat_rec_end AS cry_valid_until
FROM ldl_p_lew_bil_ac.v_kpi_month AS IMTH
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON IMTH.client_id = CRY.client_id AND IMTH.indicator_type_id
     = 2 AND IMTH.org_type_id = 20;