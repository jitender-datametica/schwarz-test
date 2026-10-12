CREATE OR REPLACE VIEW DBP_VIEW.V_AS_FOOD AS 
    SELECT 
        art_id
        ,mandant_id
        ,nb_id
        ,wup_id
        ,dat_auslistung
        ,gp_id
        ,wrg_id
        ,phase_status
        ,erl_fg
        ,dat_final
        ,menge_startbestand
        ,vk_netto
        ,menge_endbestand
        ,erl_kz
        ,dat_aend
FROM DBP_DATA.as_food ;