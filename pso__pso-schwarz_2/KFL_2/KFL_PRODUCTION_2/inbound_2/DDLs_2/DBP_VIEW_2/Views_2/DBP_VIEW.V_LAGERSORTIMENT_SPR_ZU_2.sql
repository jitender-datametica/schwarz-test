CREATE OR REPLACE VIEW DBP_VIEW.V_lagersortiment_spr_zu_2 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        lagersortiment_id,
        spr_id,
        wup_id,
        nb_id,
        lagersortiment_bez
FROM DBP_DATA.lagersortiment_spr_zu_2 ;