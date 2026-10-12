CREATE OR REPLACE VIEW DBP_VIEW.V_LIEF_PLANTOUR_ARBEITSVORRAT AS 
    SELECT 
        mandant_id
        ,lief_beleg_id
        ,av_herkunft_id
        ,wup_id
        ,nb_id
        ,plantour_id
        ,vp_fg
        ,stp_faktor_tour
        ,anz_stp
        ,dat_aenderung
        ,dat_lief_soll


FROM DBP_DATA.lief_plantour_arbeitsvorrat ;