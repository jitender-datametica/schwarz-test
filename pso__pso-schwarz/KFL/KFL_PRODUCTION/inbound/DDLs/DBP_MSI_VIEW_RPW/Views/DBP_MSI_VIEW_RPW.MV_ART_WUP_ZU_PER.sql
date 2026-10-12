CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ART_WUP_ZU_PER
    (
    system_id
    ,mandant_id
    ,wup_id
    ,dat_von
    ,nb_id
    ,art_id
    ,bezugsweg_id
    ,listung_id
    ,vk_brutto
    ,dat_bis
    ,kdis
    )
    AS
       SELECT
       7 AS system_id,
       mandant_id,
       wup_id,
       dat_von,
       nb_id,
       art_id,
       bezugsweg_id,
       listung_id,
       vk_brutto,
       dat_bis,
       kdis
       FROM dbp_view.v_art_wup_zu_per
       WHERE dat_bis = '9999-12-31'
       AND mandant_id = 1;