CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_LAGERORT(
	IN_LAGERORT_ID,
	WERK_ID,
	IN_LAGERORT_BEZ
) AS
--AP0133256_SPEC0166769, dknop, initial
--2022-11-21, AP0133256_SPEC0166769, dknop, adding werk_id
SELECT
 in_lagerort_id
,werk_id 
,in_lagerort_bez
FROM dbp_view.v_in_lagerort
GROUP BY
 in_lagerort_id
,werk_id 
,in_lagerort_bez;