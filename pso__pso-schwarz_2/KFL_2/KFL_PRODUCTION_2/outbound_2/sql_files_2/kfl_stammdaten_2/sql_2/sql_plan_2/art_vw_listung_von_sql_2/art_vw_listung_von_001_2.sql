/*
#------------------------------------------------------------------------------
# Skriptname   : erstlistung.btq
# Erstelldatum : 26.05.2009
#------------------------------------------------------------------------------
# Projekt      : STAMM LISTUNG
# Kommentar    : Anlegen und Aktualisieren der Information Erstlistung fuer alle
#                Artikel_2 pro Vertriebsweg.
#
# Datenquellen : dbp_data.wup_2
#                dbp_data.art_list_wup_zu_per_2
#                dbp_data.art_2
#
# Datenziele   : dbp_data.art_vw_listung_von_2
#------------------------------------------------------------------------------
# Historie:
#   26.05.2009    Alexander Alberg  Ersterstellung
#   20.07.2010    Michael Ueding    Integration der KMO Mandanten
#   10.08.2010    Michael Ueding    Vorbelegen der VW ID fuer KMO mit 0
#                                   (kein Vertriebsbeg)
#   06.03.2012    Michael Ueding    Vorbelegen der VW ID fuer KMO mit 10
#                                   (Marktverkauf)
#   09.04.2013    Ulrike Hofmann    VW_ID 0 fuer Zwischentabelle vorbelegt
#   25.09.2016    Dennis Bayraktar  Nach VTL-Aufloesung nur noch "VW_ID = 6" fuer DE!
#   04.12.2019    Dennis Bayraktar  Neue KSM-Logik mit aufgenommen.
#------------------------------------------------------------------------------
# Verarbeitungsschritte
#   1.) Logon auf der Datenbank
#   2.) Temporaere Tabellen erstellen
#   3.) Beladung der tmp-Tabelle mit mandant_id, vw_id, art_id & MIN(dat_von) als
#       dat_erst_listung
#   4.) Beladung der tmp1-Tabelle mit mandant_id, vw_id, art_id & sm_id
#   5.) Bereinigung der durchgaengigen Listungen pro VW und sm_2, die eine_2 hoehere
#       sm_2 haben, die nicht durchgaengig gelistet ist
#   6.) Loeschen aller sm_2 Einträge, die nicht durchgaengig gelistet sind
#   7.) Ermitteln des niedrigsten sm_2-Eintrages und loeschen aller hoeheren
#   8.) Erzeugung der tmp2-Tabelle mit allen moeglichen mandant_id, vw_id,
#       art_id - Kombinationen
#   9.) Einfuegen der neuen/aktualisierten     CURRENT_DATE("Europe/Berlin") Saetze
#       in die Zieltabelle art_vw_listung_von_2
#  11.) Aktualisieren dat_von & sm_id (auf Auslistung) in der Zieltabelle
#       art_vw_listung_von_2, falls Sortimentskategorie nicht verändert wurde
#  12.) Aktualisieren dat_erst_listung in der Zieltabelle art_vw_listung_von_2
#  13.) Bteq beenden
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Temporaere Tabellen erstellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.art_vw_listung_von_tmp_2;


DROP TABLE IF EXISTS dbp_etl.art_vw_listung_von_tmp1_2;


DROP TABLE IF EXISTS dbp_etl.art_vw_listung_von_tmp2_2;


CREATE TABLE IF NOT EXISTS dbp_etl.art_vw_listung_von_tmp_2 (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat_erst_listung DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.art_vw_listung_von_tmp1_2 (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    sm_id INTEGER,
    ksm_id STRING(4),
    durchgaengig_fg INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.art_vw_listung_von_tmp2_2 (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL
);


/*
#------------------------------------------------------------------------------
# 3.) Beladung der tmp-Tabelle mit mandant_id, vw_id, art_id & MIN(dat_von) als
#     dat_erst_listung
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.art_vw_listung_von_tmp_2 (
    mandant_id, vw_id, art_id, dat_erst_listung
)
(
    SELECT
        T1.mandant_id,
        COALESCE(dt2.vw_id, 0) AS dt2_vw_id,
        T1.art_id,
        MIN(T1.dat_von) AS dat_erst_listung
    FROM dbp_data.art_list_wup_zu_per_2 AS T1_2
    INNER JOIN (SELECT
        mandant_id,
        wup_id,
        nb_id,
        vw_id
    FROM dbp_data.wup_2
    WHERE nb_id = 0) AS dt2
        ON
            T1.mandant_id = dt2.mandant_id
            AND T1.wup_id = dt2.wup_id
            AND T1.nb_id = dt2.nb_id
    GROUP BY
        T1.art_id,
        T1.mandant_id,
        dt2.vw_id
);


/*
#------------------------------------------------------------------------------
# 4.) Beladung der tmp1-Tabelle mit mandant_id, vw_id, art_id & sm_id
#------------------------------------------------------------------------------
*/

-- alte sm_2-Logik


INSERT INTO dbp_etl.art_vw_listung_von_tmp1_2 (
    mandant_id, vw_id, art_id, sm_id, ksm_id, durchgaengig_fg
)
(
    SELECT
        dt_1.mandant_id,
        dt_1.vw_id,
        dt_2.art_id,
        dt_1.sm_id,
        'K0' AS ksm_id,
        CASE
            WHEN dt_2.s_lstg = dt_1.wup_anz
                THEN 1
            ELSE 0
        END AS durchgaengig_fg
    FROM (
        SELECT
            DT1_1.mandant_id,
            COUNT(DISTINCT DT1_1.wup_id) AS wup_anz,
            DT1_1.wg_id,
            DT1_1.sm_id,
            DT1_2.vw_id
        FROM dbp_data.sm_wup_wg_zu_per_2 AS DT1_1
        INNER JOIN dbp_data.wup_2 AS DT1_2
            ON
                DT1_1.mandant_id = DT1_2.mandant_id
                AND DT1_1.wup_id = DT1_2.wup_id
                AND DT1_1.nb_id = DT1_2.nb_id
        WHERE
            CURRENT_DATE(
                "Europe/Berlin"
            ) BETWEEN DT1_1.dat_von AND DT1_1.dat_bis
            AND CURRENT_DATE(
                "Europe/Berlin"
            ) BETWEEN DT1_2.dat_von AND DT1_2.dat_bis
            AND DT1_1.nb_id = 0
        GROUP BY
            DT1_1.mandant_id,
            DT1_1.wg_id,
            DT1_1.sm_id,
            DT1_2.vw_id
    ) AS dt_1
    INNER JOIN (
        SELECT
            dt2_1.mandant_id,
            COUNT(dt2_1.wup_id) AS c_wup_id,
            dt2_1.art_id,
            dt2_1.wg_id,
            dt2_2.sm_id,
            dt2_2.vw_id,
            SUM(dt2_1.listung_id) AS s_lstg
        FROM (
            SELECT
                DT2_1_1.mandant_id,
                DT2_1_1.art_id,
                DT2_1_1.wup_id,
                DT2_1_2.wg_id,
                DT2_1_1.listung_id
            FROM dbp_data.art_wup_zu_per_2 AS DT2_1_1
            INNER JOIN dbp_data.art_wg_zu_per_2 AS DT2_1_2
                ON
                    DT2_1_1.art_id = DT2_1_2.art_id AND DT2_1_1.mandant_id
                    = DT2_1_2.mandant_id
            WHERE
                DT2_1_2.arthiertyp_id = 2
                AND CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_1_2.dat_von AND DT2_1_2.dat_bis
                AND CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_1_1.dat_von AND DT2_1_1.dat_bis
            GROUP BY
                DT2_1_1.mandant_id,
                DT2_1_1.wup_id,
                DT2_1_1.art_id,
                DT2_1_1.listung_id,
                DT2_1_2.wg_id
        ) AS dt2_1
        INNER JOIN (
            SELECT
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_1.sm_id,
                DT2_2_2.vw_id
            FROM dbp_data.sm_wup_wg_zu_per_2 AS DT2_2_1
            INNER JOIN dbp_data.wup_2 AS DT2_2_2
                ON
                    DT2_2_1.mandant_id = DT2_2_2.mandant_id
                    AND DT2_2_1.wup_id
                    = DT2_2_2.wup_id AND DT2_2_1.nb_id = DT2_2_2.nb_id
            WHERE
                CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_2_1.dat_von AND DT2_2_1.dat_bis
                AND CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_2_2.dat_von AND DT2_2_2.dat_bis
                AND DT2_2_1.nb_id = 0
            GROUP BY
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                DT2_2_1.sm_id,
                DT2_2_2.vw_id
        ) AS dt2_2
            ON
                dt2_1.mandant_id = dt2_2.mandant_id
                AND dt2_1.wup_id = dt2_2.wup_id
                AND dt2_1.wg_id
                = dt2_2.wg_id
        GROUP BY
            dt2_1.mandant_id,
            dt2_1.art_id,
            dt2_1.wg_id,
            dt2_2.sm_id,
            dt2_2.vw_id
    ) AS dt_2
        ON
            dt_1.mandant_id = dt_2.mandant_id
            AND dt_1.wg_id = dt_2.wg_id
            AND dt_1.sm_id = dt_2.sm_id
            AND dt_1.vw_id = dt_2.vw_id
    WHERE dt_2.sm_id > -1
);


-- neue ksm_id-Logik


INSERT INTO dbp_etl.art_vw_listung_von_tmp1_2 (
    mandant_id, vw_id, art_id, sm_id, ksm_id, durchgaengig_fg
)
(
    SELECT
        dt_1.mandant_id,
        dt_1.vw_id,
        dt_2.art_id,
        -1 AS sm_id,
        'K' || TRIM(CAST(dt_1.ksm_id AS STRING)) AS ksm_id,
        CASE
            WHEN dt_2.s_lstg = dt_1.wup_anz
                THEN 1
            ELSE 0
        END AS durchgaengig_fg
    FROM (
        SELECT
            DT1_1.mandant_id,
            COUNT(DISTINCT DT1_1.wup_id) AS wup_anz,
            DT1_1.wg_id,
            CASE
                WHEN
                    ROUND(CAST(SUBSTR(DT1_1.ksm_id, 2, 1) AS BIGNUMERIC), 0) > 7
                    THEN 7
                ELSE ROUND(CAST(SUBSTR(DT1_1.ksm_id, 2, 1) AS BIGNUMERIC), 0)
            END AS ksm_id,
            DT1_2.vw_id
        FROM dbp_data.sm_wup_wg_zu_per_2 AS DT1_1
        INNER JOIN dbp_data.wup_2 AS DT1_2
            ON
                DT1_1.mandant_id = DT1_2.mandant_id
                AND DT1_1.wup_id = DT1_2.wup_id
                AND DT1_1.nb_id = DT1_2.nb_id
        WHERE
            CURRENT_DATE(
                "Europe/Berlin"
            ) BETWEEN DT1_1.dat_von AND DT1_1.dat_bis
            AND CURRENT_DATE(
                "Europe/Berlin"
            ) BETWEEN DT1_2.dat_von AND DT1_2.dat_bis
            AND DT1_1.nb_id = 0
            AND LENGTH(DT1_1.ksm_id) = 2
            AND SUBSTR(DT1_1.ksm_id, 1, 1) = 'K'
            AND ROUND(
                CAST(SUBSTR(DT1_1.ksm_id, 2, 1) AS BIGNUMERIC), 0
            ) BETWEEN 1 AND 9
        GROUP BY
            DT1_1.mandant_id,
            DT1_1.wg_id,
            ksm_id,
            DT1_2.vw_id
    ) AS dt_1
    INNER JOIN (
        SELECT
            dt2_1.mandant_id,
            COUNT(dt2_1.wup_id) AS c_wup_id,
            dt2_1.art_id,
            dt2_1.wg_id,
            dt2_2.ksm_id,
            dt2_2.vw_id,
            SUM(dt2_1.listung_id) AS s_lstg
        FROM (
            SELECT
                DT2_1_1.mandant_id,
                DT2_1_1.art_id,
                DT2_1_1.wup_id,
                DT2_1_2.wg_id,
                DT2_1_1.listung_id
            FROM dbp_data.art_wup_zu_per_2 AS DT2_1_1
            INNER JOIN dbp_data.art_wg_zu_per_2 AS DT2_1_2
                ON
                    DT2_1_1.art_id = DT2_1_2.art_id AND DT2_1_1.mandant_id
                    = DT2_1_2.mandant_id
            WHERE
                DT2_1_2.arthiertyp_id = 2
                AND CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_1_2.dat_von AND DT2_1_2.dat_bis
                AND CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_1_1.dat_von AND DT2_1_1.dat_bis
            GROUP BY
                DT2_1_1.mandant_id,
                DT2_1_1.wup_id,
                DT2_1_1.art_id,
                DT2_1_1.listung_id,
                DT2_1_2.wg_id
        ) AS dt2_1
        INNER JOIN (
            SELECT
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                CASE
                    WHEN
                        ROUND(
                            CAST(SUBSTR(DT2_2_1.ksm_id, 2, 1) AS BIGNUMERIC), 0
                        )
                        > 7
                        THEN 7
                    ELSE
                        ROUND(
                            CAST(SUBSTR(DT2_2_1.ksm_id, 2, 1) AS BIGNUMERIC), 0
                        )
                END AS ksm_id,
                DT2_2_2.vw_id
            FROM dbp_data.sm_wup_wg_zu_per_2 AS DT2_2_1
            INNER JOIN dbp_data.wup_2 AS DT2_2_2
                ON
                    DT2_2_1.mandant_id = DT2_2_2.mandant_id
                    AND DT2_2_1.wup_id
                    = DT2_2_2.wup_id AND DT2_2_1.nb_id = DT2_2_2.nb_id
            WHERE
                CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_2_1.dat_von AND DT2_2_1.dat_bis
                AND CURRENT_DATE(
                    "Europe/Berlin"
                ) BETWEEN DT2_2_2.dat_von AND DT2_2_2.dat_bis
                AND DT2_2_1.nb_id = 0
                AND LENGTH(DT2_2_1.ksm_id) = 2
                AND SUBSTR(DT2_2_1.ksm_id, 1, 1) = 'K'
                AND ROUND(
                    CAST(SUBSTR(DT2_2_1.ksm_id, 2, 1) AS BIGNUMERIC), 0
                ) BETWEEN 1 AND 9
            GROUP BY
                DT2_2_1.mandant_id,
                DT2_2_1.wup_id,
                DT2_2_1.wg_id,
                ksm_id,
                DT2_2_2.vw_id
        ) AS dt2_2
            ON
                dt2_1.mandant_id = dt2_2.mandant_id
                AND dt2_1.wup_id = dt2_2.wup_id
                AND dt2_1.wg_id
                = dt2_2.wg_id
        GROUP BY
            dt2_1.mandant_id,
            dt2_1.art_id,
            dt2_1.wg_id,
            dt2_2.ksm_id,
            dt2_2.vw_id
    ) AS dt_2
        ON
            dt_1.mandant_id = dt_2.mandant_id
            AND dt_1.wg_id = dt_2.wg_id
            AND COALESCE(ROUND(SAFE_CAST(dt_1.ksm_id AS BIGNUMERIC), 0), 0
            ) = COALESCE(ROUND(SAFE_CAST(dt_2.ksm_id AS BIGNUMERIC), 0), 0
            )
            AND dt_1.vw_id = dt_2.vw_id
);


/*
#------------------------------------------------------------------------------
# 5.) Bereinigung der durchgaengigen Listungen pro VW und sm_2, die eine_2 hoehere
#     sm_2 haben, die nicht durchgaengig gelistet ist
#------------------------------------------------------------------------------
*/

-- alte sm_id-Logik


DELETE FROM dbp_etl.art_vw_listung_von_tmp1_2 AS T1_2
WHERE durchgaengig_fg = 1 AND EXISTS (
    SELECT *
    FROM dbp_etl.art_vw_listung_von_tmp1_2 AS T2
    WHERE
        T1.vw_id = vw_id
        AND T1.mandant_id = mandant_id
        AND T1.art_id = art_id
        AND sm_id > T1.sm_id
        AND durchgaengig_fg = 0
);


-- neue ksm_id-Logik


DELETE FROM dbp_etl.art_vw_listung_von_tmp1_2 AS T1_2
WHERE durchgaengig_fg = 1 AND EXISTS (
    SELECT *
    FROM dbp_etl.art_vw_listung_von_tmp1_2 AS T2
    WHERE
        T1.vw_id = vw_id
        AND T1.mandant_id = mandant_id
        AND T1.art_id = art_id
        AND ksm_id > T1.ksm_id
        AND durchgaengig_fg = 0
);


/*
#------------------------------------------------------------------------------
# 6.) Loeschen aller sm_2 Einträge, die nicht durchgaengig gelistet sind
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_etl.art_vw_listung_von_tmp1_2 AS T1_2
WHERE durchgaengig_fg = 0;


/*
#------------------------------------------------------------------------------
# 7.) Ermitteln des niedrigsten sm_2-Eintrages und loeschen aller hoeheren
#------------------------------------------------------------------------------
*/

-- alte sm_id-Logik


DELETE FROM dbp_etl.art_vw_listung_von_tmp1_2
WHERE (
    mandant_id, vw_id, art_id, sm_id) NOT IN (
    SELECT (mandant_id, vw_id, art_id, MIN(sm_id))
    FROM dbp_etl.art_vw_listung_von_tmp1_2
    GROUP BY mandant_id,
    vw_id,
    art_id
);


-- neue ksm_id-Logik


DELETE FROM dbp_etl.art_vw_listung_von_tmp1_2
WHERE (
    mandant_id, vw_id, art_id, ksm_id) NOT IN (
    SELECT (mandant_id, vw_id, art_id, MIN(ksm_id))
    FROM dbp_etl.art_vw_listung_von_tmp1_2
    GROUP BY mandant_id,
    vw_id,
    art_id
);


/*
#------------------------------------------------------------------------------
# 8.) Erzeugung der tmp2-Tabelle mit allen moeglichen mandant_id, vw_id,
#     art_id - Kombinationen
#       - fuer die Vertriebslinien 1, 2 und 3 fuer Deutschland
#       - fuer die Vertriebslinien 0 fuer die KMO Mandanten
#
# 25.09.2016, -dbay-
#
# Neu nach VTL-Aufloesung: Jetzt nur noch VW_ID = 6 fuer DE!!!!

#------------------------------------------------------------------------------
*/

--vw_id = 6 fuer den Mandanten Deutschland


INSERT INTO dbp_etl.art_vw_listung_von_tmp2_2 (mandant_id, vw_id, art_id)
(SELECT
    mandant_id,
    6 AS vw_id,
    art_id
FROM dbp_data.art_2 AS T1_2
WHERE mandant_id = 1);


--vw_id = 10 fuer die KMO Mandanten


INSERT INTO dbp_etl.art_vw_listung_von_tmp2_2 (mandant_id, vw_id, art_id)
(SELECT
    mandant_id,
    10 AS vw_id,
    art_id
FROM dbp_data.art_2 AS T1_2
WHERE mandant_id > 1);


/*
#------------------------------------------------------------------------------
# 9.) Einfuegen der neuen/aktualisierten     CURRENT_DATE("Europe/Berlin") Saetze
#     in die Zieltabelle art_vw_listung_von_2
#------------------------------------------------------------------------------
*/

--* SQL_NAME: INS:dbp_data.art_vw_listung_von_2


INSERT INTO dbp_data.art_vw_listung_von_2 (
    mandant_id, vw_id, art_id, dat_von, sm_id, ksm_id,
    dat_erst_listung
)
(SELECT
    mandant_id,
    vw_id,
    art_id,
    PARSE_DATE('%Y%m%d', '19000101') AS dat_von,
    -1 AS sm_id,
    'K0' AS ksm_id,
    PARSE_DATE('%Y%m%d', '99991231') AS dat_erst_listung
FROM dbp_etl.art_vw_listung_von_tmp2_2
WHERE (
    mandant_id, vw_id, art_id) NOT IN (
    SELECT (mandant_id, vw_id, art_id)
    FROM dbp_data.art_vw_listung_von_2
));


/*
#------------------------------------------------------------------------------
# 10.) Aktualisieren dat_von & sm_id in der Zieltabelle art_vw_listung_von_2,
#      falls Sortimentskategorie veraendert wurde
#------------------------------------------------------------------------------
*/

-- alte sm_id-Logik


UPDATE dbp_data.art_vw_listung_von_2 SET
    sm_id = t1.sm_id_,
    dat_von = CURRENT_DATE("Europe/Berlin") FROM (SELECT
    vw_id AS vw_id_,
    art_id AS art_id_,
    mandant_id AS mandant_id_,
    sm_id AS sm_id_
FROM dbp_etl.art_vw_listung_von_tmp1_2) AS t1_2
WHERE
    art_vw_listung_von.mandant_id = t1.mandant_id_
    AND art_vw_listung_von.vw_id = t1.vw_id_
    AND art_vw_listung_von.art_id
    = t1.art_id_ AND art_vw_listung_von.sm_id <> t1.sm_id_;


-- neue ksm_id-Logik


UPDATE dbp_data.art_vw_listung_von_2 SET
    ksm_id = t1.ksm_id_,
    dat_von = CURRENT_DATE("Europe/Berlin") FROM (SELECT
    vw_id AS vw_id_,
    art_id AS art_id_,
    mandant_id AS mandant_id_,
    ksm_id AS ksm_id_
FROM dbp_etl.art_vw_listung_von_tmp1_2) AS t1_2
WHERE
    art_vw_listung_von.mandant_id = t1.mandant_id_
    AND art_vw_listung_von.vw_id = t1.vw_id_
    AND art_vw_listung_von.art_id
    = t1.art_id_ AND art_vw_listung_von.ksm_id <> t1.ksm_id_;


/*
#------------------------------------------------------------------------------
# 11.) Aktualisieren dat_von & sm_id (auf Auslistung) in der Zieltabelle
#      art_vw_listung_von_2, falls Sortimentskategorie nicht verändert wurde
#------------------------------------------------------------------------------
*/


UPDATE dbp_data.art_vw_listung_von_2 SET
    sm_id = -1,
    dat_von = CURRENT_DATE("Europe/Berlin")
WHERE sm_id <> -1 AND (
    mandant_id, vw_id, art_id) NOT IN (
    SELECT (mandant_id, vw_id, art_id)
    FROM dbp_etl.art_vw_listung_von_tmp1_2
);


UPDATE dbp_data.art_vw_listung_von_2 SET
    ksm_id = 'K0',
    dat_von = CURRENT_DATE("Europe/Berlin")
WHERE ksm_id <> 'K0' AND (
    mandant_id, vw_id, art_id) NOT IN (
    SELECT (mandant_id, vw_id, art_id)
    FROM dbp_etl.art_vw_listung_von_tmp1_2
);


/*
#------------------------------------------------------------------------------
# 12.) Aktualisieren dat_erst_listung in der Zieltabelle art_vw_listung_von_2
#------------------------------------------------------------------------------
*/


UPDATE dbp_data.art_vw_listung_von_2 SET
    dat_erst_listung = t1.dat_erst_listung_ FROM (SELECT
    vw_id AS vw_id_,
    art_id AS art_id_,
    mandant_id AS mandant_id_,
    dat_erst_listung AS dat_erst_listung_
FROM dbp_etl.art_vw_listung_von_tmp_2) AS t1_2
WHERE
    art_vw_listung_von.mandant_id = t1.mandant_id_
    AND art_vw_listung_von.vw_id = t1.vw_id_
    AND art_vw_listung_von.art_id
    = t1.art_id_;
