CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_AUFTRAGART_2(
	MANDANT_ID,
	TMS_AUFTRAGSART_ID,
	TMS_AUFTRAGSART_BEZ
) AS
--2025-05-15, AP0252146, dknop, initial 
SELECT 
 mandant_id 
,tms_auftragsart_id
,tms_auftragsart_bez
FROM dbp_view.v_l_tms_auftragsart_2
;