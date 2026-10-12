CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDENKARTE_1
-- 190503 nfis: Initialanlage
-- mcie1607, 05/03/2020, SPEC0072295, added mandant_id
AS
SELECT
kundenkarte_id
,mandant_id
,crm_kundenkarte_art_id
,crm_kundenkarte_nr
,crm_konto_id
,gesperrt_fg
,zeit_von
,zeit_bis
,geloescht_fg AS geloescht_fg_kundenkarte
FROM dbp_view.v_crm_l_kundenkarte_1
;