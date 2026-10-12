CREATE OR REPLACE VIEW DBP_VIEW.V_l_aktivitaetsbereich AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        aktivitaetsbereich_id,
        protokolleintraege_fg,
        joined_area_fg,
        td_update,
        td_insert
FROM DBP_DATA.l_aktivitaetsbereich ;