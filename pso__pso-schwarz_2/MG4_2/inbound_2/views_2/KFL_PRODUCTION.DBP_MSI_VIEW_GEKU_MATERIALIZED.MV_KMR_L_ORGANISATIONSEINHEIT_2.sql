create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_ORGANISATIONSEINHEIT_2(
	ORGA_EINHEIT_ID,
	AMX_SYSTEM_ID,
	ORGA_EINHEIT_BEZ,
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	ORGA_EINHEIT_IMP_REFERENZ
) as





SELECT 
         v01.orga_einheit_id
        ,v01.amx_system_id
        ,v01.orga_einheit_bez
        ,v02.aktuell_wup_id AS wup_id
        ,v01.mandant_id
        ,v01.nb_id
        ,v01.orga_einheit_imp_referenz 

FROM dbp_view.v_kmr_l_organisationseinheit_2 v01

INNER JOIN  dbp_view.v_wup_2 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;