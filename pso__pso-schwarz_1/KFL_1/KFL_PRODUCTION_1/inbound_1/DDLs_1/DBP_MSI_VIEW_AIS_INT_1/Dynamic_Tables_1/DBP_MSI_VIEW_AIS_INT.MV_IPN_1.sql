CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_IPN_1
--AP0017049 dummy_1 id added in order to avoid cutting rows in inner joins

(
  ipn_id
, ipn_bez
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
  ipn_id,
   ipn_bez

  FROM dbp_view.v_ipn_1

  UNION

  SELECT
  CAST (0 AS DECIMAL(18,0)) AS ipn_id,
   '' AS ipn_bez
   FROM dbp_view.v_ipn_1;