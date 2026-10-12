CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_VKL_1 
-- 190529 - nfis: Initialanlage
AS 
SELECT 
mandant_id
, vkl_id
, vkl_name
, gf_id
FROM dbp_view.v_vkl_1
;