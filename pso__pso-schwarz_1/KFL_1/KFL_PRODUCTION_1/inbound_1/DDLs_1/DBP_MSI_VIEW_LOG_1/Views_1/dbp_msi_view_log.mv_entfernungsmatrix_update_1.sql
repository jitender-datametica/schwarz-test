CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.mv_entfernungsmatrix_update_1(
	DAT_INSERT,
	ANZ_REC
) AS
-- ! dbp_view doesnt have td_insert column !
--2023-08-10, dknop, initial
SELECT 
td_insert::DATE AS dat_insert,
COUNT(*) AS anz_rec 
FROM dbp_data.wup_entfernungsmatrix_1
WHERE td_insert::DATE >= CURRENT_DATE - 365  GROUP BY 1 ;