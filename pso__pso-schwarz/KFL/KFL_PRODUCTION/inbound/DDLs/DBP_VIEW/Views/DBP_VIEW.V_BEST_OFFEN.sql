CREATE OR REPLACE VIEW DBP_VIEW.V_BEST_OFFEN AS 
    SELECT 
        mandant_id
        ,best_beleg_id
        ,best_beleg_pos_id
        ,wup_id
        ,nb_id
        ,gp_id
        ,art_id
        ,dat_best_beleg
        ,dat_lief_wunsch
        ,kunde_id
        ,nb_id_kunde
        ,einkaufsorganisation_id
        ,einkaeufer_grp_id
        ,menge_best
        ,menge_einh_id
        ,menge_lief_ist
        ,endlief_fg
        ,menge_offen
        ,bestellart_id
        ,dat_generierung
        ,block_stock_fg
        ,cpo_fg
        ,best_aend_kz


FROM DBP_DATA.BEST_OFFEN ;