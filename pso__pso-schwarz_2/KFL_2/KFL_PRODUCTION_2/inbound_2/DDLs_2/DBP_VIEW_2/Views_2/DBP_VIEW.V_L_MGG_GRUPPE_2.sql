CREATE OR REPLACE VIEW DBP_VIEW.V_L_MGG_GRUPPE_2 AS 
    SELECT 
        mandant_id,
        mgg_gruppe_id,
        mgg_abteilung_id
FROM DBP_DATA.L_MGG_GRUPPE_2;