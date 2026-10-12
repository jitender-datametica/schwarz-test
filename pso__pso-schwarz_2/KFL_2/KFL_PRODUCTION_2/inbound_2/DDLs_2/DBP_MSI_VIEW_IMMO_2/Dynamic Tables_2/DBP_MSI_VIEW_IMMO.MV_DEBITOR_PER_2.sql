CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_DEBITOR_PER_2(
	MANDANT_ID,
	DEBITOR_ID,
	DEBITOR_STATUS_ID,
	DAT_VON,
	DAT_BIS,
	KONZESSIONAER_ID,
	IVS_FG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
 
SELECT
  dp.mandant_id
, dp.debitor_id
, dp.debitor_status_id
, dp.dat_von
, dp.dat_bis

, COALESCE(dp.konzessionaer_id, '0') konzessionaer_id
, dp.ivs_fg

FROM dbp_view.v_ivs_debitor_per_2 dp

WHERE dat_bis = '9999-12-31'
AND ivs_fg = 1 
;