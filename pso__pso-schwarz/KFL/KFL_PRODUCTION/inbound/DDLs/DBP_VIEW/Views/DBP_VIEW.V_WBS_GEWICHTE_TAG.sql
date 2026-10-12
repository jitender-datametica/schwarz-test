CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_GEWICHTE_TAG 
AS SELECT 
         mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,aktion_id
        ,dat_von
        ,dat_bis
        ,kategorie
        ,anzahl_faelle
        ,gewicht_tag1
        ,gewicht_tag5
        ,gewicht_tag3
        ,gewicht_tag2
        ,gewicht_tag4
        ,gewicht_tag11
        ,gewicht_tag10
        ,gewicht_tag9
        ,gewicht_tag8
        ,gewicht_tag7
        ,gewicht_tag6
        ,gewicht_tag14
        ,gewicht_tag13
        ,gewicht_tag12
        ,referenziert_fg
        ,wbs_level
        ,wbs_level_id

FROM DBP_DATA.WBS_GEWICHTE_TAG ;