CREATE OR REPLACE VIEW DBP_VIEW.V_LIEF_BELEGFLUSS_SPLIT_1 AS 
    SELECT 
        mandant_id
        ,lief_beleg_id
        ,lief_beleg_gruppe_id
        ,lief_beleg_pos_id
        ,lief_beleg_split_id
        ,lief_beleg_split_pos_id
        ,split_fortschreibung_kz
        ,menge_lief_ist_lme
        ,split_lfd_nr_id
        ,split_vorgang_id


FROM DBP_DATA.lief_belegfluss_split_1 ;