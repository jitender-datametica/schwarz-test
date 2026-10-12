CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_PRUEF_LOS_2 
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 12.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO_2 beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 22.07.2013 twieder: Bew.art_2 531 und 532 hinzu
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO (im Kommentar)
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Y29 + Y30 ergaenzt, Filterung auf CHAR statt INT
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014
(
    mandant_id --, system_id
,
    best_beleg_id,
    best_beleg_pos_id,
    dat_buch,
    prueflos_id,
    werk_id,
    in_art_id,
    in_lief_id,
    herkunft,
    pruefart_id,
    anz_stp_merkmal,
    anz_wert_ergebnis,
    wrg_id,
    default_wrg,
    betrag_lagerbew,
    vorzeichen,
    betrag_lagerbew_altnv,
    menge_lagerbew_bme,
    basismenge_einh_id,
    altnv_menge_einh_id,
    umrech_faktor,
    best_menge_einh_id,
    preis_steuer_kz
) AS
SELECT
    v00.mandant_id,
    v00.best_beleg_id,
    v00.best_beleg_pos_id,
    v00.dat_buch,
    v00.prueflos_id,
    v00.werk_id,
    v00.flw_art_id AS in_art_id,
    v00.flw_lief_id AS in_lief_id,
    v00.herkunft,
    v00.pruefart_id,
    v00.anz_stp_merkmal,
    v00.anz_wert_ergebnis,
    wrg_id,
    default_wrg,
    betrag_lagerbew,
    vorzeichen,
    betrag_lagerbew_altnv,
    menge_lagerbew_bme,
    basismenge_einh_id,
    altnv_menge_einh_id,
    umrech_faktor,
    best_menge_einh_id,
    preis_steuer_kz
FROM
    (
        SELECT
            v01.mandant_id,
            v01.best_beleg_id,
            v01.best_beleg_pos_id,
            v05.dat_buch,
            v01.prueflos_id,
            v01.werk_id,
            v01.flw_art_id,
            v01.flw_lief_id,
            v01.herkunft,
            v01.pruefart_id,
            CASE
                -- Ausweisung Positiv
                WHEN v04.lager_bewart_id IN (
                    '101',
                    '501',
                    '521',
                    '202',
                    '162',
                    '262',
                    '552',
                    '602',
                    '644',
                    '912',
                    '531',
                    'Y30'
                ) THEN 1 -- Ausweisung Negativ
                WHEN v04.lager_bewart_id IN (
                    '102',
                    '502',
                    '522',
                    '201',
                    '161',
                    '261',
                    '551',
                    '601',
                    '643',
                    '911',
                    '532',
                    'Y29'
                ) THEN -1 -- Ausweisung Position 1 Negativ, Position 2 Positiv
                WHEN v04.lager_bewart_id IN ('309', '311')
                AND soll_haben_kz = 'H' THEN -1
                WHEN v04.lager_bewart_id IN ('309', '311')
                AND soll_haben_kz = 'S' THEN 1 -- Ausweisung Position 1 Positiv, Position 2 Negativ
                WHEN v04.lager_bewart_id IN ('310', '312')
                AND soll_haben_kz = 'H' THEN -1
                WHEN v04.lager_bewart_id IN ('310', '312')
                AND soll_haben_kz = 'S' THEN 1
            END AS vorzeichen,
            1 AS anz_stp_merkmal,
            1 AS anz_wert_ergebnis,
            v04.wrg_id,
            v100.default_wrg,
            v04.betrag_lagerbew,
            v04.betrag_lagerbew_altnv,
            v04.menge_lagerbew_bme,
            v10.basismenge_einh_id,
            v11.altnv_menge_einh_id,
            v11.umrech_faktor,
            v03.best_menge_einh_id,
            v07.preis_steuer_kz
        FROM
            dbp_view.v_flw_pruef_los_2 v01
            JOIN dbp_view.v_flw_besch_best_det_2 v03 ON v01.mandant_id = v03.mandant_id
            AND v01.best_beleg_id = v03.best_beleg_id
            AND v01.best_beleg_pos_id = v03.best_beleg_pos_id
            JOIN dbp_view.v_flw_besch_best_2 v03a ON v03.best_beleg_id = v03a.best_beleg_id
            AND v03.mandant_id = v03a.mandant_id
            JOIN dbp_view.v_flw_lagerbew_det_2 v04 ON v01.mandant_id = v04.mandant_id
            AND v01.best_beleg_id = v04.best_beleg_id
            AND v01.best_beleg_pos_id = v04.best_beleg_pos_id
            JOIN dbp_view.v_flw_lagerbew_2 v05 ON v04.mandant_id = v05.mandant_id
            AND v04.lagerbew_beleg_id = v05.lagerbew_beleg_id
            AND v04.kj = v05.kj
            AND v05.vorgangsart_id = 'WE'
            JOIN dbp_view.v_flw_werk_2 v06 ON v04.werk_id = v06.werk_id
            AND v04.mandant_id = v06.mandant_id
            JOIN dbp_view.v_flw_art_bewertungskreis_per_2 v07 ON v04.mandant_id = v07.mandant_id
            AND v04.flw_art_id = v07.flw_art_id
            AND v06.werk_nr = v07.bewertungskreis_id
            AND v05.dat_buch BETWEEN v07.dat_von
            AND v07.dat_bis -- Einschraenkgung auf bestimmte Materialarten ueber artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO')
            JOIN dbp_view.v_flw_art_2 v10 ON v03.mandant_id = v10.mandant_id
            AND v03.flw_art_id = v10.flw_art_id -- Ermittlung der default Waehrung
            JOIN dbp_view.v_mandant_2 v100 ON v01.mandant_id = v100.mandant_id
            LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v11 ON v10.flw_art_id = v11.flw_art_id
            AND v10.mandant_id = v11.mandant_id
            AND v10.basismenge_einh_id = v11.altnv_menge_einh_id
        WHERE
            v01.mandant_id IN (1, 2)
            and v03a.einkaufsorganisation_id IN (5000, 5013, 5014)
    ) v00;