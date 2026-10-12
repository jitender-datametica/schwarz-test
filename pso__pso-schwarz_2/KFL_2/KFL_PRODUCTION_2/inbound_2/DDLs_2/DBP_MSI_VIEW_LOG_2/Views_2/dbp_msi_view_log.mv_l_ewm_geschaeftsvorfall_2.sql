CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_EWM_GESCHAEFTSVORFALL_2(
	MANDANT_ID,
	LAGERNUMMER_ID,
	EWM_GV_GRP_ID,
	EWM_GV_ID,
	GV_EINHEIT_ID
) AS
--2024-02-19 , dknop, initial

SELECT 
mandant_id,
lagernummer_id,
ewm_gv_grp_id,
ewm_gv_id,
gv_einheit_id
FROM dbp_view.v_l_ewm_geschaeftsvorfall_2
WHERE LEFT(lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R')
AND LENGTH(TRIM(lagernummer_id))=4;