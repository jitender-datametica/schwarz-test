CREATE OR REPLACE VIEW DBP_VIEW.V_L_SPERRGRUND_2 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,wup_id
        ,nb_id
        ,sperrgrund_id


FROM DBP_DATA.l_sperrgrund_2 ;