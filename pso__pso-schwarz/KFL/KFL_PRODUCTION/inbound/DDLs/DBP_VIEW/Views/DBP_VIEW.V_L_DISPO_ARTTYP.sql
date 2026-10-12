CREATE OR REPLACE VIEW DBP_VIEW.V_l_dispo_arttyp AS 
    SELECT 
        mandant_id,
        dispo_arttyp_id,
        td_update,
        td_insert
FROM DBP_DATA.l_dispo_arttyp ;