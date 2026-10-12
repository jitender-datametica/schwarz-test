CREATE OR REPLACE VIEW DBP_VIEW.V_l_lagersortiment_2 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        lagersortiment_id,
        wup_id,
        nb_id
FROM DBP_DATA.l_lagersortiment_2 ;