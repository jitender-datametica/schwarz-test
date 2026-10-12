CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_OWG_BEZ_2
(
SPR_ID,
OWG_ID,
OWG_BEZ
) 
AS
SELECT
spr_id,
owg_id,
Max(owg_bez) owg_bez
FROM dbp_view.v_owg_spr_zu_2
GROUP BY 1,2;