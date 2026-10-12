CREATE OR REPLACE VIEW DBP_VIEW.V_L_GEKU_BEREICH_1 AS 
    SELECT 
        geku_bereich_uid
        ,geku_bereich_id
        ,wmd_fg
        ,kdc_fg
        ,mzk_fg


FROM DBP_DATA.l_geku_bereich_1 ;