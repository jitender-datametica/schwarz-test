CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_WG_ZEK_ZU AS 
    SELECT 
        wg_id,
        arthiertyp_id,
        mandant_id,
        zek_id
FROM DBP_MSI_DATA.WG_ZEK_ZU ;