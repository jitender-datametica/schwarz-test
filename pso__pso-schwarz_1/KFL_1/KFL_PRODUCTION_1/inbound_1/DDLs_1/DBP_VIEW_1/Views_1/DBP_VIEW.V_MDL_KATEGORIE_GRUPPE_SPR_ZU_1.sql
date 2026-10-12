CREATE OR REPLACE VIEW DBP_VIEW.V_mdl_kategorie_gruppe_spr_zu_1 AS 
    SELECT 
        kategorie_gruppe_id,
        spr_id,
        kategorie_gruppe_bez
        ,TD_UPDATE 
        ,TD_INSERT 
FROM DBP_DATA.mdl_kategorie_gruppe_spr_zu_1 ;