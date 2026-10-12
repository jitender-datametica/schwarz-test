CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_GEWICHTE_STUNDE AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,aktion_id
        ,dat_von
        ,dat_bis
        ,anzahl_faelle
        ,anzahl_faelle_im_korridor
        ,korridor_level
        ,kategorie
        ,menge_max
        ,menge_min
        ,menge_avg_21tage
        ,anteil_zeitfenster1
        ,anteil_zeitfenster2
        ,referenziert_fg
        ,wbs_level
        ,wbs_level_id

FROM DBP_DATA.WBS_GEWICHTE_STUNDE ;