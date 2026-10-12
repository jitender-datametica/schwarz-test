CREATE OR REPLACE VIEW DBP_VIEW.V_WBS_REFERENZARTIKEL_1 AS 
    SELECT 
        mandant_id
        ,art_id
        ,ref_art_id
        ,ref_anz_maerkte
        ,avg_vk_brutto
        ,avg_ref_vk_brutto
        ,ref_score_rang
        ,ref_score
        ,diff_vk
        ,diff_absatz
        ,diff_absatz_absolut
        ,diff_absatz_kennz
        ,diff_cosinus
        ,diff_gewicht
        ,diff_wug
        ,aktion_id
        ,ref_ltz_dat_von
        ,dat_von
        ,ltz_dat_von
        ,berechnung_typ
        ,dat_berechnung
        ,selektor_fg
        ,berechnung_subtyp
        ,wrg_id


FROM DBP_DATA.wbs_referenzartikel_1 ;