create or replace view KFL_PRODUCTION.DBP_MSI_V_VIEW.V_TS_LIN_GF_ORG_EBENE_ZU(
	USER_ID,
	HR_OBJEKT_EBENE2_ID,
	HR_OBJEKT_EBENE3_ID,
	HR_OBJEKT_EBENE4_ID
) as 
    SELECT 
        user_id,
        hr_objekt_ebene2_id,
        hr_objekt_ebene3_id,
        hr_objekt_ebene4_id
FROM DBP_MSI_DATA.ts_lin_gf_org_ebene_zu ;