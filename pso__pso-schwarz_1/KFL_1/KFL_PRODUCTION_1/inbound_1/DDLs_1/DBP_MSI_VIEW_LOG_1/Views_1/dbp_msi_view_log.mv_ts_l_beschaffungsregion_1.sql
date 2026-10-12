CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TS_L_BESCHAFFUNGSREGION_1(
	BESCH_REGION_ID,
	BESCH_REGION_BEZ
) AS
--AP0140953, dknop, initial
  SELECT
  besch_region_id
  ,besch_region_bez
  FROM dbp_msi_data.ts_l_beschaffungsregion_1
  UNION
  SELECT
  -1
  ,'n/a'
  ;