CREATE OR REPLACE VIEW DBP_VIEW.V_lagerort_lagersortiment_zu_1 AS 
    SELECT 
        mandant_id,
        lagerort_id,
        lagersortiment_id,
        wup_id,
        nb_id
FROM DBP_DATA.lagerort_lagersortiment_zu_1 ;