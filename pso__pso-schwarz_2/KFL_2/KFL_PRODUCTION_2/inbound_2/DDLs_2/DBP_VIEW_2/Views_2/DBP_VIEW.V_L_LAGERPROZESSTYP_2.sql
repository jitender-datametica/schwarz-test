CREATE OR REPLACE VIEW DBP_VIEW.V_l_lagerprozesstyp_2 AS 
    SELECT 
        lagerprozesstyp_id,
        aktivitaet_fg,
        td_update,
        td_insert
FROM DBP_DATA.l_lagerprozesstyp_2 ;