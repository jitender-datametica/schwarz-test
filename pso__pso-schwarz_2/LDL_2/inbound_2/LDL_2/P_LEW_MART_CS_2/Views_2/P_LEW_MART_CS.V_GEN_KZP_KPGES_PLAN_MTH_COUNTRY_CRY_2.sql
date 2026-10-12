/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_KZP_KPGES_PLAN_MTH_COUNTRY_CRY_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_KZP_KPGES_PLAN_MTH_COUNTRY_CRY_2
/*************************************************************************************************************
* Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
*************************************************************************************************************/
(
  client_id
, indicator_id
, cy_month
, val_indicator
, currency_iso_cd
, dat_dayend
, cry_valid_from
, cry_valid_until
)
AS
   SELECT
   imth.client_id,
   imth.indicator_id,
   imth.cy * 100 + imth.month_id AS cy_month,
   CASE WHEN imth.indicator_id IN (105,108,112,117,120,125,126,133,135,136,146,151,155,
           156,157,158,161,162,163,168,169,170,172,174,177,179,203,204,209,210,212,216,
           271,272,273,276,280,281,282,283,284,286,288,289)
        THEN imth.val_indicator / cry.rate_currency_exchange ELSE imth.val_indicator END AS val_indicator,
   cry.currency_iso_cd,
   imth.dat_dayend AS dat_dayend,
   cry.dat_rec_start AS cry_valid_from,
   cry.dat_rec_end AS cry_valid_until
   FROM p_lew_bil_ac.v_kpi_month_2 AS imth
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
   ON  imth.client_id = cry.client_id
   AND imth.indicator_type_id = 2
   AND imth.org_type_id = 20
;