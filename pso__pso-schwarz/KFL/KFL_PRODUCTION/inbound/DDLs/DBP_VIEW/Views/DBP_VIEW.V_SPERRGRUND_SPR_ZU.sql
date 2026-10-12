CREATE OR REPLACE VIEW DBP_VIEW.V_SPERRGRUND_SPR_ZU AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,wup_id
        ,nb_id
        ,spr_id
        ,sperrgrund_id
        ,sperrgrund_bez


FROM DBP_DATA.sperrgrund_spr_zu ;