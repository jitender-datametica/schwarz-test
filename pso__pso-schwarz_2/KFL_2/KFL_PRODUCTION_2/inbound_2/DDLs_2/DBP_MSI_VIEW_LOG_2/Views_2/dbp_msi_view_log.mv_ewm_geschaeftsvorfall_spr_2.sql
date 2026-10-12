CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_EWM_GESCHAEFTSVORFALL_SPR_2(
	EWM_GV_ID,
	MANDANT_ID,
	LAGERNUMMER_ID,
	EWM_GV_BEZ,
	SPR_ID
) AS
SELECT
--2024-02-19 , dknop, initial
 v01.ewm_gv_id
,v01.mandant_id
,v01.lagernummer_id
,v01.ewm_gv_bez
,v01.spr_id
FROM dbp_view.v_ewm_geschaeftsvorfall_spr_zu_2 v01



;