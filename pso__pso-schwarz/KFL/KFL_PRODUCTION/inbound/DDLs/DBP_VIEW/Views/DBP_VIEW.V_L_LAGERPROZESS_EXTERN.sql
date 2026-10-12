CREATE OR REPLACE VIEW DBP_VIEW.V_l_lagerprozess_extern AS 
    SELECT 
        mandant_id,
        lagerprozess_extern_id,
        lagerprozess_intern_id,
        td_update,
        td_insert
FROM DBP_DATA.l_lagerprozess_extern ;