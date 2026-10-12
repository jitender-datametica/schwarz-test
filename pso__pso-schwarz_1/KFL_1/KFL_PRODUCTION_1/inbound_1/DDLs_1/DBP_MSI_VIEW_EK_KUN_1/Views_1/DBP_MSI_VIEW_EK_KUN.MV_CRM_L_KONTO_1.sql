CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KONTO_1
AS
SELECT 
 crm_konto_id
,crm_kunde_id
,crm_konto_typ_id
,crm_kundenprogramm_id
,zeit_von
,zeit_bis 
,CAST(zeit_bis AS DATE) AS dat_bis
,geloescht_fg AS geloescht_fg_konto
FROM dbp_view.v_crm_l_konto_1
;