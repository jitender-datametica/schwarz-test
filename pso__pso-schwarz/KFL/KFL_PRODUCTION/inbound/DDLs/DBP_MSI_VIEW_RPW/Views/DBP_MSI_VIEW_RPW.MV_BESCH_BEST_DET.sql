CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESCH_BEST_DET
 (
 mandant_id
 , best_beleg_id
 , best_beleg_pos_id
 , art_id
 , empfaenger_wup_id
 , nb_id
 , lagerort_id
 , loesch_fg
 , menge_best
 , selbstabhol_fg
 , best_preis_menge_einh_id
 , menge_kolli
 , menge_palette
 , endlief_fg
 , dat_aenderung
 , kunde_id
 , dat_best_beleg
 , best_basismenge_einh_id
 , ean_id
 , betrag_kond_zw_sum2
 , pos_kostenlos_fg
 , betrag_pos_netto
 , betrag_pos_netto_best_wrg
 , vk_brutto
 , system_id
 , kj
 , menge_block_bestand
 , gp_teilsortiment_id
 )
 AS
    SELECT
    v01.mandant_id,
    v01.best_beleg_id,
    v01.best_beleg_pos_id,
    v01.art_id,
    v01.wup_id  AS empfaenger_wup_id,
    v01.nb_id,
    v01.lagerort_id,
    v01.loesch_fg,
    v01.menge_best_bme,
    v01.selbstabhol_fg,
    v01.best_preis_menge_einh_id,
    v01.menge_best_kolli,
    v01.menge_best_palette,
    v01.endlief_fg,
    v01.dat_aenderung,
    v01.kunde_id,
    v01.dat_best_beleg,
    v01.best_menge_einh_id,
    v01.ean_id,
    v01.betrag_kond_zw_sum2,
    v01.pos_kostenlos_fg,
    v01.betrag_pos_netto,
    v01.betrag_pos_netto_best_wrg,
    v03.vk_brutto * menge_best_bme,
    7,
    EXTRACT(YEAR FROM v01.dat_best_beleg),
    v01.menge_block_bestand,
    v01.gp_teilsortiment_id

FROM dbp_view.v_besch_best_det v01

    JOIN dbp_view.v_besch_best v02
    ON v01.best_beleg_id = v02.best_beleg_id
    AND v01.mandant_id = v02.mandant_id
    AND v01.dat_best_beleg = v02.dat_best_beleg
    LEFT OUTER JOIN dbp_view.v_art_wup_zu_per v03
    ON v03.mandant_id = v01.mandant_id
    AND v03.art_id = v01.art_id
    AND v03.wup_id = v01.wup_id
    AND v03.nb_id = v01.nb_id
    AND v01.dat_best_beleg BETWEEN v03.dat_von AND v03.dat_bis

    WHERE v01.mandant_id = 1
    AND v02.einkaufsorganisation_id <> 5000;