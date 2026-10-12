--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.lagerbew_2 (
    mandant_id, lagerbew_beleg_id, kj, vorgangsart_id, dat_buch,
    beleg_user_name, ref_lagerbew_beleg_id, dat_beleg, dat_erfasst, belegart_id, belegkopftext, waren_begl_schein_id,
    system_id, ref_lagerbew_beleg_id_num, lief_gp_id, zeit_erfasst, transaktion_code, td_insert, td_update
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    kj,
    vorgangsart_id,
    dat_buch,
    beleg_user_name,
    ref_lagerbew_beleg_id,
    dat_beleg,
    dat_erfasst,
    belegart_id,
    belegkopftext,
    waren_begl_schein_id,
    system_id,
    ref_lagerbew_beleg_id_num,
    lief_gp_id,
    zeit_erfasst,
    transaktion_code,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_data.lagerbew_delta_2
WHERE mandant_id = 1);


INSERT INTO dbp_data.lagerbew_det_2 (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, grund_id,
    lager_bewart_id, art_id, wup_id, nb_id, auto_fg, lagerort_id, gp_id, einkaufsorganisation_id, soll_haben_kz, wrg_id,
    best_beleg_id, best_beleg_pos_id, betrag_lagerbew, betrag_verkauf, erfsngs_menge_einh_id, lagerplatz_id, kunde_id,
    menge_lagerbew_kolli, menge_lagerbew_bme, menge_lagerbew_palette, menge_lieferschein, menge_lief, menge_erf,
    empfaenger_id, dat_buch, lagerbew_beleg_storno_id, lagerbew_beleg_pos_storno_id, lagerbew_beleg_storno_kj,
    betrag_vk_netto, system_id, betrag_belegfluss_wg_art, mandant_id_kunde, mandant_id_empfaenger, bw_vorgang_id,
    betrag_verkauf_ist, betrag_vk_netto_vz, betrag_verkauf_ist_netto, td_update, td_insert
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id,
    kj,
    grund_id,
    lager_bewart_id,
    art_id,
    wup_id,
    nb_id,
    auto_fg,
    lagerort_id,
    gp_id,
    einkaufsorganisation_id,
    soll_haben_kz,
    wrg_id,
    best_beleg_id,
    best_beleg_pos_id,
    betrag_lagerbew,
    betrag_verkauf,
    erfsngs_menge_einh_id,
    lagerplatz_id,
    kunde_id,
    menge_lagerbew_kolli,
    menge_lagerbew_bme,
    menge_lagerbew_palette,
    menge_lieferschein,
    menge_lief,
    menge_erf,
    empfaenger_id,
    dat_buch,
    lagerbew_beleg_storno_id,
    lagerbew_beleg_pos_storno_id,
    lagerbew_beleg_storno_kj,
    betrag_vk_netto,
    system_id,
    betrag_belegfluss_wg_art,
    mandant_id_kunde,
    mandant_id_empfaenger,
    bw_vorgang_id,
    betrag_verkauf_ist,
    betrag_vk_netto_vz,
    betrag_verkauf_ist_netto,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_data.lagerbew_det_delta_2
WHERE mandant_id = 1);


INSERT INTO dbp_data.lagerbew_det_wwc_2 (
    lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, mandant_id, dat_buch,
    menge_bestand_bme, wert_bestand, system_id, buchungskreis_id, shkum, kostenstelle_id, sachkonto_id, art_id_empfaenger,
    lagerort_id_empfaenger, art_id_bf, lagerbew_beleg_pos_mutter_id, line_id, endlief_fg, xruem_fg, betrag_exbwr,
    betrag_bnk, betrag_umbewertung, td_update, td_insert
)
(
    SELECT
        lagerbew_beleg_id,
        lagerbew_beleg_pos_id,
        kj,
        mandant_id,
        dat_buch,
        menge_bestand_bme,
        wert_bestand,
        system_id,
        buchungskreis_id,
        shkum,
        kostenstelle_id,
        sachkonto_id,
        art_id_empfaenger,
        lagerort_id_empfaenger,
        art_id_bf,
        lagerbew_beleg_pos_mutter_id,
        line_id,
        endlief_fg,
        xruem_fg,
        betrag_exbwr,
        betrag_bnk,
        betrag_umbewertung,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.lagerbew_det_delta_2
    WHERE
        CAST(FORMAT_DATE('%Y%m%d', dat_buch) AS INT64) >= 1100101 --PE-Review
        AND mandant_id = 1
);


DELETE FROM dbp_data.lagerbew_delta_2
WHERE mandant_id = 1;


DELETE FROM dbp_data.lagerbew_det_delta_2
WHERE mandant_id = 1;


DROP TABLE IF EXISTS dbp_etl.de_mseg_work_2;


DROP TABLE IF EXISTS dbp_etl.de_mseg_menge_2;
