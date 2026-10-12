CREATE OR REPLACE VIEW DBP_VIEW.V_lagerprozesstyp_spr_zu_2 AS 
    SELECT 
        lagerprozesstyp_id,
        spr_id,
        lagerprozesstyp_bez,
        td_update,
        td_insert
FROM DBP_DATA.lagerprozesstyp_spr_zu_2 ;