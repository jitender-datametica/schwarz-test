CREATE OR REPLACE VIEW DBP_VIEW.V_l_lagerprozess_1 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        lagerprozess_id,
        richtung_id,
        td_update,
        td_insert
FROM DBP_DATA.l_lagerprozess_1 ;