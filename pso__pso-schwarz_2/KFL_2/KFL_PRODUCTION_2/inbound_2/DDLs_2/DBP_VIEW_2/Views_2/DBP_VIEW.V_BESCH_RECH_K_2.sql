CREATE OR REPLACE VIEW DBP_VIEW.V_BESCH_RECH_K_2 AS 
    SELECT 
        system_id
        ,mandant_id
        ,beleg_typ_id
        ,rech_beleg_id
        ,gj
        ,obj_id
        ,dat_erfasst
        ,dat_buch
        ,dat_beleg
        ,dat_leist_erstellung
        ,dat_vorerfasst
        ,gp_id
        ,einkaufsorganisation_id
        ,wup_id
        ,nb_id
        ,belegart_id
        ,rech_beleg_status_id
        ,erfassung_id
        ,ersteller_id
        ,rech_beleg_storno_id
        ,storno_gj
        ,buch_grund_int_id
        ,buch_grund_ext_id
        ,storno_fg
        ,row_fg
        ,geloescht_fg
        ,gebucht_fg
        ,vorgang_fg
        ,vorgang_beleg_typ_fg
        ,betrag_brutto
        ,betrag_netto
        ,betrag_mwst
        ,anz_beleg
        ,anz_beleg_vorgang
        ,wrg_id


FROM DBP_DATA.besch_rech_k_2 ;