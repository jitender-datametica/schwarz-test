CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_ENGINE_CONFIG AS 
    SELECT 
        mandant_id,
        config_id,
        config_val,
        config_descr

FROM DBP_DATA.AAD_ENGINE_CONFIG ;