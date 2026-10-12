CREATE OR REPLACE VIEW DBP_VIEW.V_aktivitaetsbereich_spr_zu_1 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        aktivitaetsbereich_id,
        spr_id,
        aktivitaetsbereich_bez,
        td_update,
        td_insert
FROM DBP_DATA.aktivitaetsbereich_spr_zu_1 ;