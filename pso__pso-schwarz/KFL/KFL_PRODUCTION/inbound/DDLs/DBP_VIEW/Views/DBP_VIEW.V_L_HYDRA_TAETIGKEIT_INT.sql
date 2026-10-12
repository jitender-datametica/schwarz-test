CREATE OR REPLACE VIEW DBP_VIEW.V_L_HYDRA_TAETIGKEIT_INT AS 
    SELECT 
        mandant_id,
        taetigkeit_int_id,
        taetigkeit_int_bez

FROM DBP_DATA.L_HYDRA_TAETIGKEIT_INT ;