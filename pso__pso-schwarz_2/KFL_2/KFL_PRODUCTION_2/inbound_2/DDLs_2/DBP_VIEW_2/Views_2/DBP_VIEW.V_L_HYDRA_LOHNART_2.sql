CREATE OR REPLACE VIEW DBP_VIEW.V_L_HYDRA_LOHNART_2 AS 
    SELECT 
        mandant_id,
        lohnart_id,
        lohnart_bez

FROM DBP_DATA.L_HYDRA_LOHNART_2 ;