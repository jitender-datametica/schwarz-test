CREATE OR REPLACE VIEW DBP_VIEW.V_LAGERPLATZ_BESTAND_PER_2 AS 
    SELECT 
        mandant_id
        ,lagerbestand_parent_guid
        ,lagerbestand_guid
        ,datzeit_von
        ,datzeit_bis
        ,lagernummer_id
        ,lagertyp_id
        ,lagerplatz_id
        ,ressource_id
        ,handling_unit_id
        ,transportation_unit_id
        ,in_bewegung_fg
        ,art_guid
        ,charge_guid
        ,bestandsart_id
        ,bestand_belegtyp_id
        ,bestand_beleg_id
        ,bestand_beleg_pos_id
        ,belegtyp_id
        ,bestandsverwendung_id
        ,bestand_zaehler
        ,charge_id
        ,verfuegbare_menge
        ,menge_einh_id
        ,altnv_menge_einh_id
        ,dat_mhd
        ,datzeit_we
        ,pruef_typ_id
        ,pruefung_id
        ,land_herkunft
        ,lagerplatz_verbess_fg
        ,sperr_fg
        ,quants_nachl_fg
        ,restr_fg
        ,logische_postiion_nr
        ,zeugnis_nr


FROM DBP_DATA.LAGERPLATZ_BESTAND_PER_2 ;