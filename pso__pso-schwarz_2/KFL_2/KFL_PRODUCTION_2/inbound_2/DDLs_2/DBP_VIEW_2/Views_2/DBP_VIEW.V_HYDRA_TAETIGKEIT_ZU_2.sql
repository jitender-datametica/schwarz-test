CREATE OR REPLACE VIEW DBP_VIEW.V_HYDRA_TAETIGKEIT_ZU_2 AS 
    SELECT 
        mandant_id,
        pers_teilbereich_id,
        taetigkeit_id,
        taetigkeit_bez,
        taetigkeit_typ_id,
        taetigkeit_int_id

FROM DBP_DATA.HYDRA_TAETIGKEIT_ZU_2 ;