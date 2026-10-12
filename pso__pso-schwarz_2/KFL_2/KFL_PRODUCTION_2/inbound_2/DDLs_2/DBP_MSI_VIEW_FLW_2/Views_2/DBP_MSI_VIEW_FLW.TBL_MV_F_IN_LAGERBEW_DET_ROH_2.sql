CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_LAGERBEW_DET_ROH_2 
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 23.01.2013 twie: Lieferantennr. 337028 und 10120130 fuer neues Werk Bad Heiligenstadt hinzugefuegt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Filterung auf CHAR statt INT
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
(
    mandant_id --, system_id
,
    werk_id,
    dat_buch,
    wrg_id_org,
    best_beleg_id,
    in_art_id,
    wrg_id,
    preis_steuer_kz,
    default_wrg,
    betrag_lagerbew,
    betrag_lagerbew_altnv
) AS
SELECT
    v02.mandant_id AS mandant_id,
    v02.werk_id AS werk_id,
    v04.dat_buch AS dat_buch,
    v04.wrg_id AS wrg_id_org,
    v02.best_beleg_id,
    v02.flw_art_id AS in_art_id,
    v02.wrg_id,
    v06.preis_steuer_kz,
    v100.default_wrg,
    v04.betrag_lagerbew,
    v04.betrag_lagerbew_altnv
FROM
    (
        SELECT
            mandant_id,
            flw_art_id,
            wrg_id,
            best_beleg_id,
            werk_id
        FROM
            dbp_view.v_flw_lagerbew_det_2 -- Warenausgang
        WHERE
            lager_bewart_id IN ('643')
            AND mandant_id IN (1, 2)
        GROUP BY
            mandant_id,
            flw_art_id,
            wrg_id,
            best_beleg_id,
            werk_id
    ) v02 -- Verbindung MSEG Bewegungsart 643 => Bewegungsart 101,102
    JOIN (
        SELECT
            v04a.mandant_id AS mandant_id,
            v04a.best_beleg_id AS best_beleg_id,
            v04a.wrg_id AS wrg_id,
            v04a.flw_art_id AS flw_art_id,
            v04a.flw_lief_id AS flw_lief_id,
            v04a.werk_id AS werk_id,
            v03.dat_buch AS dat_buch,
            SUM(v04a.betrag_lagerbew_altnv) AS betrag_lagerbew_altnv,
            SUM(v04a.betrag_lagerbew) AS betrag_lagerbew
        FROM
            dbp_view.v_flw_lagerbew_det_2 v04a
            JOIN dbp_view.v_flw_lagerbew_2 v03 ON v04a.mandant_id = v03.mandant_id
            AND v04a.lagerbew_beleg_id = v03.lagerbew_beleg_id
            AND v04a.kj = v03.kj -- Wareneingang
        WHERE
            lager_bewart_id IN ('101', '102')
            AND v04a.mandant_id IN (1, 2)
        GROUP BY
            v04a.mandant_id,
            v04a.best_beleg_id,
            v04a.wrg_id,
            v04a.flw_art_id,
            v04a.flw_lief_id,
            v04a.werk_id,
            v03.dat_buch
    ) v04 ON v02.mandant_id = v04.mandant_id
    AND v02.best_beleg_id = v04.best_beleg_id
    AND v02.flw_art_id = v04.flw_art_id 
    --HINWEIS: Der JOIN ueber erweiterte u.a. Bedingung fuehrt zu Mehrdeutigkeiten, da die Bestellposition mehrfach mit der gleichen Bestellbeleg_id vorkommt.
    --AND v02.best_beleg_pos_id = v04.best_beleg_pos_id
    --AND v02.lagerbew_beleg_id = v04.lagerbew_beleg_id
    --AND v02.lagerbew_beleg_pos_id = v04.lagerbew_beleg_pos_id
    --AND v02.kj = v04.kj
    -- FILTER auf relevante Lieferanten, hier nur interne FLW-Werke.
    JOIN dbp_view.v_flw_lieferant_2 v05a ON v04.mandant_id = v05a.mandant_id
    AND v04.flw_lief_id = v05a.flw_lief_id -- Ermittlung werk_nr zur Ermittlung preis_steuer_kz im Folgeschritt
    JOIN dbp_view.v_flw_werk_2 v05b ON v04.mandant_id = v05b.mandant_id
    AND v04.werk_id = v05b.werk_id -- JOIN zur Ermittlung preis_steuer_kz V = Verrechnungspreis, S = Standardpreis
    JOIN dbp_view.v_flw_art_bewertungskreis_per_2 v06 ON v02.mandant_id = v06.mandant_id
    AND v02.flw_art_id = v06.flw_art_id
    AND v04.dat_buch BETWEEN v06.dat_von
    AND v06.dat_bis
    AND v05b.werk_nr = v06.bewertungskreis_id -- Ermittlung der default Waehrung
    JOIN dbp_view.v_mandant_2 v100 ON v02.mandant_id = v100.mandant_id
    JOIN dbp_view.v_flw_art_2 v07 ON v02.mandant_id = v07.mandant_id
    AND v02.flw_art_id = v07.flw_art_id
WHERE
    v07.artikelart_id IN (
        'ZKMN',
        'HALB',
        'ZERL',
        'ZFER',
        'ROH',
        'VERP',
        'FERT',
        'HAWA',
        'ZDIE',
        'REWO',
        'ZHAW',
        'ZFLV'
    ) -- Die Einschraenkung sollte ueber werk_id erfolgen. Diese wird SAP seitig kuenftig in die in_lieferant_nr eingetragen.
    AND COLLATE(LTRIM(COLLATE(v05a.flw_lief_nr, ''), '0'), 'en-ci') IN (
        '834590',
        '124425',
        '237400',
        '835192',
        '337028',
        '10258',
        '10259',
        '10753',
        '10083478',
        '10092461',
        '10093675',
        '10120130'
    );