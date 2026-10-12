CREATE OR REPLACE VIEW DBP_VIEW.V_EWM_EXCEPTION_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        spr_id,
        ewm_exception_id,
        ewm_exception_bez
        ,TD_UPDATE 
        ,TD_INSERT 
FROM DBP_DATA.ewm_exception_spr_zu_1 ;
