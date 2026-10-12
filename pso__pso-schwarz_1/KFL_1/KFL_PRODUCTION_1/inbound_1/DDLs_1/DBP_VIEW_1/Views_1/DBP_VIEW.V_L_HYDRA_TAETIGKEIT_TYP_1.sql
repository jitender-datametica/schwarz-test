CREATE OR REPLACE VIEW DBP_VIEW.V_L_HYDRA_TAETIGKEIT_TYP_1 AS 
    SELECT 
        mandant_id,
        taetigkeit_typ_id,
        taetigkeit_typ_bez

FROM DBP_DATA.L_HYDRA_TAETIGKEIT_TYP_1 ;