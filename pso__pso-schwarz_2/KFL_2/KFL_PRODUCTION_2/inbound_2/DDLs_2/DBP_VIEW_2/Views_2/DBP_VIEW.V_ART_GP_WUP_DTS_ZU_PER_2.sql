CREATE OR REPLACE VIEW DBP_VIEW.V_ART_GP_WUP_DTS_ZU_PER_2 AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,gp_id
        ,loesch_fg
        ,dat_von
        ,dat_bis
        ,verkaufsorganisation_id
        ,vw_id
        ,auslieferungsgruppe_id
        ,dispoteilsortiment_id


FROM DBP_DATA.ART_GP_WUP_DTS_ZU_PER_2 ;