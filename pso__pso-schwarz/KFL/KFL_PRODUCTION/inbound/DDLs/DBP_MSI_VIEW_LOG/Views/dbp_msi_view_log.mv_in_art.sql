CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_ART(
	MANDANT_ID,
	IN_ART_ID,
	IN_ART_NR,
	IN_WG_ID,
	BASISMENGE_EINH_ID
) AS
--AP0133256_SPEC0166769, dknop, initial

SELECT 
 mandant_id
,in_art_id
,in_art_nr
,in_wg_id
,basismenge_einh_id
FROM dbp_view.v_in_art;