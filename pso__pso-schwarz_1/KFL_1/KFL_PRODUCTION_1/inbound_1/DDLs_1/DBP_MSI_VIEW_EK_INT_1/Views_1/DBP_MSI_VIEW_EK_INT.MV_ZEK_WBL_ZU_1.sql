CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ZEK_WBL_ZU_1
(
 mandant_id
,zek_id
,wbl_id
)
AS
SELECT
 mandant_id
,zek_id
,wbl_id
 
FROM dbp_security.zek_wbl_zu_1;