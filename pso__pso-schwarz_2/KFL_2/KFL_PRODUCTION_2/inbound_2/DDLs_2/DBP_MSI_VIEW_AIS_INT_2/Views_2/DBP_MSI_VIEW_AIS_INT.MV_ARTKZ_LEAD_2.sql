CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_LEAD_2(
	MANDANT_ID,
	LEAD_ID,
	LEAD_BEZ
) AS
--SPEC0298140, prescherad, 03.04.2025, Neuanlage 
  SELECT
  mandant_id,
  lead_id, 
  lead_bez
  FROM dbp_view.v_artkz_lead_2
  WHERE mandant_id = 1;