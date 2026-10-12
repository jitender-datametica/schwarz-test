CREATE OR REPLACE VIEW DBP_VIEW.V_SKIPPED_POSITIONS_EWM AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,lagerauftrag_id
        ,lageraufgabe_id
        ,lageraufgabe_pos_id
        ,lagersortiment_id
        ,lagerauftrag_status_id
        ,lageraufgabe_status_id
        ,lagerprozessart_id
        ,artikelsortiment_id
        ,lief_beleg_id
        ,lief_beleg_pos_id
        ,lief_pal_typ_id
        ,ewm_gv_grp_id
        ,ewm_exc_kategorie_id
        ,lagerauftrag_has_exc_1_fg
        ,lagerauftrag_has_exc_2_fg
        ,lagerauftrag_has_exc_3_fg
        ,dat_lief_soll
        ,wg_verkett_lief
        ,werbeware_id
        ,art_id
        ,ausnahme_code
        ,bus_kontext
        ,ausfuehr_schritt_id
        ,menge_ist_bme
        ,manuell_erzeugt_fg


FROM DBP_DATA.skipped_positions_ewm ;