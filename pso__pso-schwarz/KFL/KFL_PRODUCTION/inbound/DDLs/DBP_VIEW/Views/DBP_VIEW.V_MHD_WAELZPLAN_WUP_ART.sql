CREATE OR REPLACE VIEW DBP_VIEW.V_MHD_WAELZPLAN_WUP_ART AS 
    SELECT 
        mandant_id
        ,wup_id
        ,kjwo
        ,art_id
        ,waelzplan_pruef_id
        ,wiederholungsrhythmus_wochen
        ,kjwo_wiederholung
        ,dat_aenderung
FROM DBP_DATA.mhd_waelzplan_wup_art ;