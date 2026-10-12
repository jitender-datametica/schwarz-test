CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KONTO_TYP
-- 190503 nfis: Initialanlage
AS
SELECT
crm_konto_typ_id
FROM dbp_view.v_crm_l_konto_typ
;