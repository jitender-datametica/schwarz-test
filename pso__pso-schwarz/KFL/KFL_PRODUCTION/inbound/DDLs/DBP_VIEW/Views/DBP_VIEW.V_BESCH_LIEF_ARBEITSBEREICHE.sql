CREATE OR REPLACE VIEW DBP_VIEW.V_BESCH_LIEF_ARBEITSBEREICHE AS 
    SELECT 
        mandant_id
        ,lagerort_id
        ,wup_id
        ,nb_id
        ,kunde_id
        ,wtag_id
        ,dat_lief_soll
        ,wg_id
        ,arthiertyp_id
        ,disponent_id
        ,wg_verkett_id
        ,disposition_rhythmus_ltf_id
        ,terminierungsgruppe_1_id
        ,terminierungsgruppe_2_id
        ,terminierungsgruppe_3_id
        ,auslieferungsgruppe_id
        ,kunde_bez
        ,disposition_rhythmus_id
        ,disponent_name
        ,wup_standort
        ,bestellart_id
        ,lief_pal_typ_id
        ,diff_id
        ,menge_lief_ist_kolli
        ,menge_lief_soll_kolli
        ,betrag_lief_ist
        ,betrag_lief_soll
        ,menge_lief_palette
        ,mandant_id_kunde
        ,wrg_id


FROM DBP_DATA.besch_lief_arbeitsbereiche ;