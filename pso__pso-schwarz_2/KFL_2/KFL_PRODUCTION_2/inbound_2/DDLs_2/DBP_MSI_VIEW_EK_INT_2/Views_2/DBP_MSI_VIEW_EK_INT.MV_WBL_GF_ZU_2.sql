CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WBL_GF_ZU_2
(
mandant_id
,wbl_id
,gf_id
)
AS
   SELECT
   mandant_id, wbl_id, gf_id
   FROM dbp_security.wbl_gf_zu_2;