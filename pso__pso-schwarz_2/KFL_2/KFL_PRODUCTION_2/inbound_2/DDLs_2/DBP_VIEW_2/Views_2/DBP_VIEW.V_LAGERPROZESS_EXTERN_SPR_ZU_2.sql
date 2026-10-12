CREATE OR REPLACE VIEW DBP_VIEW.V_lagerprozess_extern_spr_zu_2 AS 
    SELECT 
        mandant_id,
        lagerprozess_extern_id,
        spr_id,
        lagerprozess_extern_bez,
        td_update,
        td_insert
FROM DBP_DATA.lagerprozess_extern_spr_zu_2 ;