CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDENPROGRAMM_1
AS 
SELECT
v01.crm_kundenprogramm_id
,v01.mandant_id
,v02.mandant_kbez

FROM dbp_view.v_crm_l_kundenprogramm_1 v01

JOIN dbp_view.v_mandant_1 v02
ON (v01.mandant_id=v02.mandant_id)
;