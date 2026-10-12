CREATE OR REPLACE VIEW DBP_VIEW.V_PLANTOUR_2 AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,plantour_id
        ,tour_id
        ,trailer_fg
        ,trailer_id
        ,dat_trailer
        ,zeit_trailer


FROM DBP_DATA.plantour_2 ;