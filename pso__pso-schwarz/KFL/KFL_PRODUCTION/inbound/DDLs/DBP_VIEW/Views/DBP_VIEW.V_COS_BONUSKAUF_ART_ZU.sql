CREATE OR REPLACE VIEW DBP_VIEW.V_COS_BONUSKAUF_ART_ZU AS 
    SELECT 
        mandant_id
        ,bonuskauf_id
        ,kl_art_id
        ,gratis_artikel_fg


FROM DBP_DATA.cos_bonuskauf_art_zu ;