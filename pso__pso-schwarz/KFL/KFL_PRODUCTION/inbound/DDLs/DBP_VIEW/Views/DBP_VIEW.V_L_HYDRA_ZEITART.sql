CREATE OR REPLACE VIEW DBP_VIEW.V_L_HYDRA_ZEITART AS 
    SELECT 
        mandant_id,
        zeitart_id,
        zeitart_bez

FROM DBP_DATA.L_HYDRA_ZEITART ;