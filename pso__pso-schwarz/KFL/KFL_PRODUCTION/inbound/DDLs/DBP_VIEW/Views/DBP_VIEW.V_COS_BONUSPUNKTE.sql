CREATE OR REPLACE VIEW DBP_VIEW.V_COS_BONUSPUNKTE AS 
    SELECT 
        crm_konto_id,
        dat_verfall_bonuspunkte,
        mandant_id,
        anz_bonuspunkte,
        datzeit_update

FROM DBP_DATA.COS_BONUSPUNKTE ;