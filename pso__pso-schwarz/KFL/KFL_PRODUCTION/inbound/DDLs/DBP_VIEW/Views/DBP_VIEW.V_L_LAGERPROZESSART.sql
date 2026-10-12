CREATE OR REPLACE VIEW DBP_VIEW.V_l_lagerprozessart AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        lagerprozessart_id,
        td_update,
        td_insert
FROM DBP_DATA.l_lagerprozessart ;