CREATE OR REPLACE VIEW DBP_VIEW.V_lagerprozessart_spr_zu_2 AS 
    SELECT 
        mandant_id,
        spr_id,
        lagernummer_id,
        lagerprozessart_id,
        lagerprozessart_bez,
        td_update,
        td_insert
FROM DBP_DATA.lagerprozessart_spr_zu_2 ;