CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_ts_lin_gf_org_ebene_zu_2 AS 
    SELECT 
        user_id,
        hr_objekt_ebene2_id,
        hr_objekt_ebene3_id,
        hr_objekt_ebene4_id
FROM DBP_MSI_DATA.ts_lin_gf_org_ebene_zu_2 ;