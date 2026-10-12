CREATE OR REPLACE VIEW DBP_VIEW.V_ART_LAGERPLATZ_PER_EWM_2 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,art_guid
        ,wup_id
        ,nb_id
        ,lagerplatz_id
        ,dat_von
        ,art_id
        ,dat_bis
        ,lagertyp_id
        ,menge_max
        ,menge_max_einh_id
        ,menge_min
        ,menge_min_einh_id
        ,menge_fixiert_fg
        ,menge_min_direkt
        ,menge_min_direkt_einh_id
        ,datzeit_aenderung
        ,tr_fg
        ,tkl_fg


FROM DBP_DATA.art_lagerplatz_per_ewm_2 ;