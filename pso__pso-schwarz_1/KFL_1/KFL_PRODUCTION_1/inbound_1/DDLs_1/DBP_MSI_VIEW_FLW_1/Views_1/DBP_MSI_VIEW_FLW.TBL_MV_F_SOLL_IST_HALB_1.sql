CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_SOLL_IST_HALB_1 -- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Filterung auf CHAR statt INT
(
    werk_nr,
    werk_name,
    mandant_id --, system_id
,
    auftrag_id,
    halb_in_art_id,
    halb_in_art_nr,
    in_art_id,
    typ,
    basismenge_einh_id,
    in_art_nr,
    artikelart_id,
    werk_id,
    dat_start,
    menge_lagerbew_bme,
    input_menge_ist,
    input_menge_soll,
    menge_kg,
    wrg_id,
    gld,
    preis_faktor,
    preis_steuer_kz,
    standard_preis,
    default_wrg,
    umrech_faktor
) AS
SELECT
    dt7.werk_nr,
    dt7.werk_name,
    dt2.mandant_id,
    dt2.auftrag_id,
    dt2.halb_flw_art_id AS halb_in_art_id,
    dt9.flw_art_nr AS halb_in_art_nr,
    dt2.flw_art_id AS in_art_id,
    dt2.typ,
    dt2.basismenge_einh_id,
    dt2.flw_art_nr AS in_art_nr,
    dt2.artikelart_id,
    dt2.werk_id,
    dt2.dat_start,
    dt2.output_menge_ist_bme AS menge_lagerbew_menge_bme,
    dt2.input_menge_ist,
    dt2.input_menge_soll,
    CASE
        WHEN dt2.basismenge_einh_id = 'ST' THEN CAST(
            dt2.output_menge_ist_bme * v600.umrech_faktor AS DECIMAL(18, 6)
        )
    END AS menge_kg,
    dt8.wrg_id,
    dt8.gld,
    dt8.preis_faktor,
    dt8.preis_steuer_kz,
    dt8.standard_preis,
    v100.default_wrg,
    v600.umrech_faktor
FROM
    (
        --dt2
        --oberer Teil, im Feinkonzept fuer die View der Abschnitt 2
        SELECT
            v01.mandant_id AS mandant_id,
            v01.auftrag_id AS auftrag_id,
            v07.dat_start AS dat_start,
            v05.flw_art_id AS halb_flw_art_id,
            v06.flw_art_id AS flw_art_id,
            'output' AS typ,
            v66.basismenge_einh_id AS basismenge_einh_id,
            v66.flw_art_nr AS flw_art_nr,
            v66.artikelart_id AS artikelart_id,
            v08.werk_id AS werk_id,
            SUM(v08.menge_lagerbew_bme) AS output_menge_ist_bme,
            CAST(NULL AS DECIMAL(18, 6)) AS input_menge_ist,
            CAST(NULL AS DECIMAL(18, 6)) AS input_menge_soll
        FROM
            dbp_view.v_flw_auftrag_pps_1 v01
            JOIN dbp_view.v_flw_stueckliste_det_1 v05 ON v01.mandant_id = v05.mandant_id
            AND v01.flw_art_id = v05.flw_art_id
            JOIN dbp_view.v_flw_stueckliste_1 v06 ON v05.mandant_id = v06.mandant_id
            AND v05.stueckliste_id = v06.stueckliste_id
            AND v05.stueckliste_typ_id = v06.stueckliste_typ_id
            JOIN dbp_view.v_flw_art_1 v66 ON v06.mandant_id = v66.mandant_id
            AND v06.flw_art_id = v66.flw_art_id
            JOIN dbp_view.v_flw_auftrag_pps_1 v07 ON v06.mandant_id = v07.mandant_id
            AND v06.flw_art_id = v07.flw_art_id
            AND v01.dat_start = v07.dat_start -- Fuer Menge der ZFER Materialien
            JOIN dbp_view.v_flw_lagerbew_det_1 v08 ON v07.mandant_id = v08.mandant_id
            AND v07.auftrag_id = v08.auftrag_id
        WHERE
            v08.lager_bewart_id IN ('101', '102')
            AND v05.komponentenmenge > 0.001
            AND v01.mandant_id IN (1, 2)
        GROUP BY
            v01.mandant_id --, v01.system_id
,
            v01.auftrag_id,
            v05.komponentenmenge -- notwendige Menge HALB um Fertigerzeugnis ZFER zu erzeugen
,
            v05.stueckliste_id -- Stueckliste_1 des Halb Erzeugnisses
,
            v05.stueckliste_typ_id,
            v05.flw_art_id,
            v06.flw_art_id,
            v66.basismenge_einh_id,
            v66.flw_art_nr,
            v66.artikelart_id,
            v08.werk_id,
            v07.dat_start,
            v06.menge_basis -- Hier werden fuer den Bericht zwei unterschiedliche Tabellen
            -- untereinander gelegegt.
            -- Um gleiche Anzahl Spalten zu erreichen, werden Spalten mit NULL
            -- angelegt
        UNION
        ALL --unterer Teil links, im Feinkonzept fuer die View der Abschnitt 1 (Input Menge ist)
        SELECT
            v01.mandant_id AS mandant_id,
            v01.auftrag_id AS auftrag_id,
            v01.dat_start AS dat_start,
            v01.flw_art_id AS halb_flw_art_id,
            v03.flw_art_id AS flw_art_id,
            'input' AS typ,
            v04.basismenge_einh_id AS basismenge_einh_id,
            v04.flw_art_nr AS flw_art_nr,
            v04.artikelart_id AS artikelart_id,
            v03.werk_id AS werk_id,
            CAST(NULL AS DECIMAL(18, 6)) AS output_menge_ist_bme,
            SUM(v03.menge_lagerbew_bme) AS input_menge_ist,
            CAST(NULL AS DECIMAL(18, 6)) AS input_menge_soll
        FROM
            dbp_view.v_flw_auftrag_pps_1 v01
            JOIN dbp_view.v_flw_art_1 v02 ON v01.mandant_id = v02.mandant_id
            AND v01.flw_art_id = v02.flw_art_id -- ZERL-Materialien, die ein HALB erzeugen (input fuer HALB sind)
            -- mit eingrenzung auf  Materialart ZERL
            JOIN dbp_view.v_flw_lagerbew_det_1 v03 ON v01.mandant_id = v03.mandant_id
            AND v01.auftrag_id = v03.auftrag_id
            JOIN dbp_view.v_flw_art_1 v04 ON v03.mandant_id = v04.mandant_id
            AND v03.flw_art_id = v04.flw_art_id
        WHERE
            v03.lager_bewart_id IN ('261', '262')
            AND v02.artikelart_id = 'HALB'
            AND v02.mandant_id IN (1, 2)
        GROUP BY
            v01.mandant_id --, v01.system_id
,
            v01.flw_art_id,
            v04.basismenge_einh_id,
            v04.flw_art_nr,
            v04.artikelart_id,
            v01.auftrag_id,
            v01.dat_start,
            v03.werk_id,
            v03.flw_art_id,
            v03.kj -- Zwei separat berechnete Zwischenschritte werden nebeneinander gelegt
        UNION
        ALL --dt3
        --unterer Teil rechts, im Feinkonzept fuer die View der Abschnitt 3 (Input Menge soll)
        SELECT
            dt5.mandant_id AS mandant_id,
            dt5.auftrag_id AS auftrag_id,
            dt5.dat_start AS dat_start,
            dt5.halb_flw_art_id AS halb_flw_art_id,
            dt5.flw_art_id AS flw_art_id,
            'input' AS typ,
            dt5.basismenge_einh_id AS basismenge_einh_id,
            dt5.flw_art_nr AS flw_art_nr,
            dt5.artikelart_id AS artikelart_id,
            dt4.werk_id AS werk_id,
            CAST(NULL AS DECIMAL(18, 6)) AS inp_menge_lagerbew_bme,
            CAST(NULL AS DECIMAL(18, 6)) AS output_menge_ist_bme,
            MAX(dt4.benoetigtes_halb_sum) * MAX(dt5.komponentenmenge) / MAX(dt5.menge_basis) AS input_menge_soll
        FROM
            (
                --dt4 GESAMTSUMME fuer benoetigtes HALB ueber die jeweilige halb_flw_art_id
                --    Im Beispiel sind das die 31288,285 KG
                SELECT
                    dt4_1.mandant_id,
                    dt4_1.auftrag_id,
                    dt4_1.dat_start,
                    dt4_1.basismenge_einh_id,
                    dt4_1.flw_art_nr,
                    dt4_1.artikelart_id,
                    dt4_1.werk_id,
                    dt4_1.halb_flw_art_id,
                    dt4_1.flw_art_id,
                    dt4_1.komponentenmenge,
                    dt4_1.menge_basis,
                    SUM(benoetigtes_halb) OVER (
                        PARTITION BY dt4_1.mandant_id --, dt4_1.system_id
,
                        dt4_1.auftrag_id,
                        dt4_1.dat_start,
                        dt4_1.basismenge_einh_id,
                        dt4_1.artikelart_id,
                        dt4_1.werk_id,
                        dt4_1.halb_flw_art_id
                    ) AS benoetigtes_halb_sum
                FROM
                    (
                        -- dt4_1
                        -- Zusammenstellen der Teilmenge fuer GESAMTSUMME HALB, im Feinkonzept fuer die View der Abschnitt 4
                        SELECT
                            v01.mandant_id,
                            v01.auftrag_id,
                            v01.dat_start,
                            v02.basismenge_einh_id,
                            v02.flw_art_nr AS flw_art_nr,
                            v02.artikelart_id,
                            v08.werk_id,
                            v05.flw_art_id AS halb_flw_art_id,
                            v06.flw_art_id AS flw_art_id,
                            v05.komponentenmenge,
                            v06.menge_basis,
                            SUM(v08.menge_lagerbew_bme) AS menge_lagerbew_bme,
                            SUM(v08.menge_lagerbew_bme) * v05.komponentenmenge / v06.menge_basis AS benoetigtes_halb
                        FROM
                            dbp_view.v_flw_auftrag_pps_1 v01
                            JOIN dbp_view.v_flw_stueckliste_det_1 v05 ON v01.mandant_id = v05.mandant_id
                            AND v01.flw_art_id = v05.flw_art_id
                            JOIN dbp_view.v_flw_stueckliste_1 v06 ON v05.mandant_id = v06.mandant_id
                            AND v05.stueckliste_id = v06.stueckliste_id
                            AND v05.stueckliste_typ_id = v06.stueckliste_typ_id
                            JOIN dbp_view.v_flw_art_1 v02 ON v06.mandant_id = v02.mandant_id
                            AND v06.flw_art_id = v02.flw_art_id
                            JOIN dbp_view.v_flw_auftrag_pps_1 v07 ON v06.mandant_id = v07.mandant_id
                            AND v06.flw_art_id = v07.flw_art_id
                            AND v01.dat_start = v07.dat_start -- Fuer Menge der ZFER Materialien
                            JOIN dbp_view.v_flw_lagerbew_det_1 v08 ON v07.mandant_id = v08.mandant_id
                            AND v07.auftrag_id = v08.auftrag_id
                            JOIN dbp_view.v_flw_lagerbew_1 v09 ON v08.mandant_id = v09.mandant_id
                            AND v08.lagerbew_beleg_id = v09.lagerbew_beleg_id
                            AND v08.kj = v09.kj
                        WHERE
                            v08.lager_bewart_id IN ('101', '102')
                            AND v05.komponentenmenge > 0.001
                            AND v02.artikelart_id = 'ZFER'
                            AND v01.mandant_id IN (1, 2)
                        GROUP BY
                            v01.mandant_id --, v01.system_id
,
                            v01.auftrag_id,
                            v01.dat_start,
                            v02.basismenge_einh_id,
                            v02.flw_art_nr,
                            v02.artikelart_id,
                            v08.werk_id,
                            v05.komponentenmenge -- notwendige Menge HALB um Fertigerzeugnis ZFER zu erzeugen
,
                            v05.flw_art_id -- halb_flw_art_id
,
                            v06.flw_art_id -- outp_flw_art_id
,
                            v06.menge_basis
                    ) dt4_1
            ) dt4
            JOIN (
                -- dt5
                -- im Feinkonzept fuer die View der Abschnitt 5
                SELECT
                    v01.mandant_id,
                    v01.flw_art_id AS halb_flw_art_id,
                    v01.auftrag_id,
                    v01.dat_start,
                    v02.basismenge_einh_id,
                    v02.flw_art_nr AS flw_art_nr,
                    v02.artikelart_id,
                    v05.komponentenmenge -- notwendige Menge HALB um Fertigerzeugnis ZFER zu erzeugen
,
                    v05.flw_art_id AS flw_art_id,
                    v06.menge_basis,
                    v06.werk_id -- zu erzeugende Referenz Outputmenge (SOLL Menge)
                FROM
                    dbp_view.v_flw_auftrag_pps_1 v01
                    JOIN dbp_view.v_flw_stueckliste_1 v06 ON v01.mandant_id = v06.mandant_id
                    AND v01.flw_art_id = v06.flw_art_id
                    JOIN dbp_view.v_flw_stueckliste_det_1 v05 ON v05.mandant_id = v06.mandant_id
                    AND v05.stueckliste_id = v06.stueckliste_id
                    AND v05.stueckliste_typ_id = v06.stueckliste_typ_id
                    JOIN dbp_view.v_flw_art_1 v02 ON v05.mandant_id = v02.mandant_id
                    AND v05.flw_art_id = v02.flw_art_id
                WHERE
                    v05.komponentenmenge > 0.001
                    AND v02.artikelart_id = 'ZERL'
                    AND v01.mandant_id IN (1, 2)
                GROUP BY
                    v01.mandant_id --, v01.system_id
,
                    v01.flw_art_id --halb_flw_art_id
,
                    v01.auftrag_id,
                    v01.dat_start,
                    v02.basismenge_einh_id,
                    v02.flw_art_nr,
                    v02.artikelart_id,
                    v05.komponentenmenge -- notwendige Menge HALB um Fertigerzeugnis ZFER zu erzeugen
,
                    v05.flw_art_id -- inp_flw_art_id
,
                    v06.menge_basis,
                    v06.werk_id
            ) dt5 ON dt4.mandant_id = dt5.mandant_id --AND dt4.system_id = dt5.system_id
            AND dt4.halb_flw_art_id = dt5.halb_flw_art_id
            AND dt4.auftrag_id = dt5.auftrag_id
            AND dt4.dat_start = dt5.dat_start
            AND dt4.werk_id = dt5.werk_id
        GROUP BY
            dt5.mandant_id --, dt5.system_id
,
            dt5.auftrag_id,
            dt5.dat_start,
            dt5.basismenge_einh_id,
            dt5.flw_art_nr,
            dt5.artikelart_id,
            dt4.werk_id,
            dt5.halb_flw_art_id,
            dt5.flw_art_id
    ) dt2
    JOIN dbp_view.v_flw_werk_1 dt7 ON dt2.mandant_id = dt7.mandant_id
    AND dt2.werk_id = dt7.werk_id
    LEFT JOIN dbp_view.v_flw_art_bewertungskreis_per_1 dt8 ON dt2.mandant_id = dt8.mandant_id
    AND dt2.flw_art_id = dt8.flw_art_id
    AND dt2.dat_start BETWEEN dt8.dat_von
    AND dt8.dat_bis
    AND dt7.werk_nr = dt8.bewertungskreis_id
    LEFT JOIN dbp_view.v_flw_art_1 dt9 ON dt2.mandant_id = dt9.mandant_id
    AND dt2.halb_flw_art_id = dt9.flw_art_id -- Ermittlung der default Waehrung
    JOIN dbp_view.v_mandant_1 v100 ON dt2.mandant_id = v100.mandant_id 
    LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_1 v600 ON dt2.flw_art_id = v600.flw_art_id
    AND dt2.mandant_id = v600.mandant_id
    AND (
        CASE
            WHEN dt2.basismenge_einh_id = 'ST' THEN 'KG'
            WHEN dt2.basismenge_einh_id = 'KG' THEN 'ST'
        END
    ) = v600.altnv_menge_einh_id;