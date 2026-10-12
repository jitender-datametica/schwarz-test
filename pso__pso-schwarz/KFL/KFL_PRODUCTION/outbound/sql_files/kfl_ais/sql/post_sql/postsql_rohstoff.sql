-- Befuellung LUs


INSERT INTO dbp_data.l_rohstoff_blend (
    rohstoff_blend_kfl_cd, rohstoff_blend_kfl_name
)
(
    SELECT
        COALESCE(rohstoff_blend_kfl_txt, '') AS rohstoff_blend_kfl_cd,
        COALESCE(rohstoff_blend_kfl_txt, '') AS rohstoff_blend_kfl_name
    FROM dbp_msi_data.ts_rohstoff_monitoring_anzeige
    WHERE
        rohstoff_blend_kfl_txt NOT IN (
            SELECT rohstoff_blend_kfl_name
            FROM dbp_data.l_rohstoff_blend
        )
    GROUP BY
        rohstoff_blend_kfl_cd,
        rohstoff_blend_kfl_name
);


TRUNCATE TABLE dbp_data.l_rohstoff_gruppe_zuordnungstyp;


INSERT INTO dbp_data.l_rohstoff_gruppe_zuordnungstyp (
    rohstoff_gruppe_zuordnungstyp_id,
    rohstoff_gruppe_zuordnungstyp_bez, td_update, td_insert
)
(
    SELECT
        1 AS rohstoff_gruppe_zuordnungstyp_id,
        'KFL Kategorie zu KFL Subkategorie'
            AS rohstoff_gruppe_zuordnungstyp_bez,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
);


INSERT INTO dbp_data.l_rohstoff_gruppe_zuordnungstyp (
    rohstoff_gruppe_zuordnungstyp_id,
    rohstoff_gruppe_zuordnungstyp_bez, td_update, td_insert
)
(
    SELECT
        2 AS rohstoff_gruppe_zuordnungstyp_id,
        'KFL Subkategorie zu KFL Kategorie'
            AS rohstoff_gruppe_zuordnungstyp_bez,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
);


TRUNCATE TABLE dbp_data.rohstoff_gruppe_zuordnung;


INSERT INTO dbp_data.rohstoff_gruppe_zuordnung (
    rohstoff_gruppe_typ_id, rohstoff_gruppe_name,
    zugeordnete_rohstoff_gruppe_typ_id,
    zugeordnete_rohstoff_gruppe_name,
    rohstoff_gruppe_zuordnungstyp_id,
    dat_gueltig_von,
    dat_gueltig_bis, td_update, td_insert
)
(
    SELECT
        2 AS rohstoff_gruppe_typ_id,
        COALESCE(rohstoff_kategorie_kfl_name, '') AS rohstoff_gruppe_name,
        3 AS zugeordnete_rohstoff_gruppe_typ_id,
        COALESCE(rohstoff_subkategorie_kfl_name, '')
            AS zugeordnete_rohstoff_gruppe_name,
        1 AS rohstoff_gruppe_zuordnungstyp_id,
        dat_anzeige_von AS dat_gueltig_von,
        dat_anzeige_bis AS dat_gueltig_bis,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_msi_data.ts_rohstoff_monitoring_anzeige
    GROUP BY
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        zugeordnete_rohstoff_gruppe_typ_id,
        zugeordnete_rohstoff_gruppe_name,
        rohstoff_gruppe_zuordnungstyp_id,
        dat_gueltig_von,
        dat_gueltig_bis,
        td_update,
        td_insert
);


INSERT INTO dbp_data.rohstoff_gruppe_zuordnung
(
    SELECT
        3 AS rohstoff_gruppe_typ_id,
        COALESCE(rohstoff_subkategorie_kfl_name, '') AS rohstoff_gruppe_name,
        2 AS zugeordnete_rohstoff_gruppe_typ_id,
        COALESCE(rohstoff_kategorie_kfl_name, '')
            AS zugeordnete_rohstoff_gruppe_name,
        2 AS rohstoff_gruppe_zuordnungstyp_id,
        dat_anzeige_von AS dat_gueltig_von,
        dat_anzeige_bis AS dat_gueltig_bis,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_msi_data.ts_rohstoff_monitoring_anzeige
    GROUP BY
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        zugeordnete_rohstoff_gruppe_typ_id,
        zugeordnete_rohstoff_gruppe_name,
        rohstoff_gruppe_zuordnungstyp_id,
        dat_gueltig_von,
        dat_gueltig_bis,
        td_update,
        td_insert
);


TRUNCATE TABLE dbp_data.rohstoff_rohstoff_gruppe_zu;


INSERT INTO dbp_data.rohstoff_rohstoff_gruppe_zu (
    rohstoff_nr, rohstoff_gruppe_typ_id,
    rohstoff_gruppe_name,
    rohstoff_blend_kfl_cd,
    rohstoff_cluster_id,
    td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        1 AS rohstoff_gruppe_typ_id,
        COALESCE(B.rohstoff_gruppe_name, '') AS rohstoff_gruppe_name,
        SUBSTR(CAST(NULL AS STRING), 1, 100) AS rohstoff_blend_kfl_cd,
        NULL  AS rohstoff_cluster_id,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_data.rohstoff AS A
    INNER JOIN
        dbp_etl_process.l_rohstoff_gruppe AS B
        ON A.rohstoff_qualitaet_txt = B.rohstoff_kurz_name
    GROUP BY
        A.rohstoff_nr,
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        rohstoff_blend_kfl_cd,
        rohstoff_cluster_id,
        td_update
);


INSERT INTO dbp_data.rohstoff_rohstoff_gruppe_zu (
    rohstoff_nr, rohstoff_gruppe_typ_id,
    rohstoff_gruppe_name,
    rohstoff_blend_kfl_cd,
    rohstoff_cluster_id,
    td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        2 AS rohstoff_gruppe_typ_id,
        COALESCE(A.rohstoff_kategorie_kfl_name, '') AS rohstoff_gruppe_name,
        B.rohstoff_blend_kfl_cd,
        A.rohstoff_cluster_id,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_msi_data.ts_rohstoff_monitoring_anzeige AS A
    LEFT JOIN
        dbp_data.l_rohstoff_blend AS B
        ON A.rohstoff_blend_kfl_txt = B.rohstoff_blend_kfl_name
    GROUP BY
        A.rohstoff_nr,
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        B.rohstoff_blend_kfl_cd,
        A.rohstoff_cluster_id,
        td_update
);


INSERT INTO dbp_data.rohstoff_rohstoff_gruppe_zu (
    rohstoff_nr, rohstoff_gruppe_typ_id,
    rohstoff_gruppe_name,
    rohstoff_blend_kfl_cd,
    rohstoff_cluster_id,
    td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        3 AS rohstoff_gruppe_typ_id,
        COALESCE(A.rohstoff_subkategorie_kfl_name, '') AS rohstoff_gruppe_name,
        B.rohstoff_blend_kfl_cd,
        NULL  AS rohstoff_cluster_id,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_msi_data.ts_rohstoff_monitoring_anzeige AS A
    INNER JOIN
        dbp_data.l_rohstoff_blend AS B
        ON A.rohstoff_blend_kfl_txt = B.rohstoff_blend_kfl_name
    GROUP BY
        A.rohstoff_nr,
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        B.rohstoff_blend_kfl_cd,
        rohstoff_cluster_id,
        td_update
);


UPDATE dbp_data.rohstoff SET
    rohstoff_qualitaet_txt = ''
WHERE TRUE;


UPDATE dbp_data.rohstoff SET
    rohstoff_kfl_bez = b.rohstoff_kfl_bez,
    rohstoff_qualitaet_txt = b.rohstoff_qualitaet_txt,
    rohstoff_quell_bez = b.rohstoff_quell_bez FROM (SELECT
    rohstoff_nr,
    MAX(rohstoff_kfl_bez) AS rohstoff_kfl_bez,
    MAX(rohstoff_qualitaet_txt) AS rohstoff_qualitaet_txt,
    MAX(rohstoff_quell_bez) AS rohstoff_quell_bez
FROM dbp_msi_data.ts_rohstoff_monitoring_anzeige
GROUP BY rohstoff_nr) AS b
WHERE rohstoff.rohstoff_nr = b.rohstoff_nr;


TRUNCATE TABLE dbp_data.rohstoff_gruppe;


INSERT INTO dbp_data.rohstoff_gruppe (
    rohstoff_gruppe_typ_id, rohstoff_gruppe_name,
    rohstoff_gruppe_kurz_name, td_update, td_insert
)
(
    SELECT
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        rohstoff_gruppe_name AS rohstoff_gruppe_name2,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.rohstoff_rohstoff_gruppe_zu
    WHERE rohstoff_gruppe_typ_id IN (2, 3)
    GROUP BY
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name
);


INSERT INTO dbp_data.rohstoff_gruppe (
    rohstoff_gruppe_typ_id, rohstoff_gruppe_name,
    rohstoff_gruppe_kurz_name, td_update, td_insert
)
(SELECT
    1 AS rohstoff_gruppe_typ_id,
    rohstoff_gruppe_name,
    rohstoff_kurz_name AS rohstoff_gruppe_kurz_name,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl_process.l_rohstoff_gruppe);


TRUNCATE TABLE dbp_data.rohstoff_gruppe_nachricht;


INSERT INTO dbp_data.rohstoff_gruppe_nachricht (
    rohstoff_gruppe_typ_id, rohstoff_gruppe_name,
    nachricht_typ_id,
    spr_id,
    nachricht_titel_txt,
    nachricht_inhalt_txt,
    trend_typ_id,
    dat_trend_von,
    prognose_halbjahr_typ_id,
    nachricht_link_txt,
    preis_reduzierende_faktoren_txt,
    preis_steigernde_faktoren_txt,
    forecast_txt, dat_gueltig_von, dat_gueltig_bis, td_update, td_insert
)
(SELECT
    2 AS rohstoff_gruppe_typ_id,
    rohstoff_kategorie_kfl_name,
    nachricht_typ_id,
    spr_id,
    nachricht_titel_txt,
    nachricht_inhalt_txt,
    trend_typ_id,
    dat_trend_von,
    prognose_halbjahr_typ_id,
    nachricht_link_txt,
    preis_reduzierende_faktoren_txt,
    preis_steigernde_faktoren_txt,
    forecast_txt,
    dat_gueltig_von,
    dat_gueltig_bis,
    td_update,
    td_insert
FROM dbp_msi_data.ts_rohstoff_monitoring_nachricht);
