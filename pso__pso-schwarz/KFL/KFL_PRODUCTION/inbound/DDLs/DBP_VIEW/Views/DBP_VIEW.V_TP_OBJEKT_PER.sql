CREATE OR REPLACE VIEW DBP_VIEW.V_TP_OBJEKT_PER AS 
    SELECT 
        mandant_id
        ,tp_objekt_id
        ,dat_von
        ,techn_platz_id
        ,dat_bis
        ,tp_objekt_typ
        ,hersteller_name
        ,hersteller_land_id
        ,hersteller_typ_bez
        ,hersteller_serial_id
        ,bau_kj
        ,bau_kjmo
        ,dat_gewaehrleistung_start
        ,dat_gewaehrleistung_ende
        ,tp_objekt_nr


FROM DBP_DATA.tp_objekt_per ;