CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TS_IN_LAGERORT_TECHNIKBEREICH_ZU(
	MANDANT_ID,
	WERK_ID,
	IN_LAGERORT_ID,
	TECHNIKBEREICH_BEZ
) AS
--AP0133256_SPEC0166769, dknop, initial

SELECT 
 mandant_id
,werk_id
,in_lagerort_id
,technikbereich_bez

FROM dbp_msi_view_log.v_ts_in_lagerort_technikbereich_zu
;