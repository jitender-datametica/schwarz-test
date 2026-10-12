CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WG_ZEK_ZU_2
(
  arthiertyp_id
, mandant_id
, wg_id
, zek_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
  arthiertyp_id
, mandant_id
, wg_id
, zek_id
FROM dbp_msi_v_view.v_wg_zek_zu_2;