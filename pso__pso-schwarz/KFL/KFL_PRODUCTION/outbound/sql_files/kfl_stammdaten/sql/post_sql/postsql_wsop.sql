DELETE FROM dbp_etl.wsop
WHERE skopf = 0;


UPDATE dbp_etl.wsop SET
    stcklst = b.stueckliste_id FROM (
    SELECT
        stueckliste_id,
        art_id,
        dat_von,
        dat_bis
    FROM dbp_data.stueckliste
    WHERE mandant_id = 1
    GROUP BY
        stueckliste_id,
        dat_von,
        dat_bis,
        art_id
) AS b
WHERE
    wsop.sposi = CAST(FLOOR(b.art_id / 100) AS INTEGER) AND wsop.datuv BETWEEN b.dat_von AND b.dat_bis;


UPDATE dbp_etl.wsop SET
    akz = 'D' FROM (
    SELECT *
    FROM dbp_data.art
    WHERE
        mandant_id = 1
        AND artikeltyp_id = 12
) AS b
WHERE wsop.sposi = CAST(FLOOR(b.art_id / 100) AS INTEGER) AND wsop.stcklst <> 0;


UPDATE dbp_etl.wsop SET
    akz = 'K'
WHERE stcklst <> 0 AND akz <> 'D';


DELETE FROM dbp_data.baustein_art_zu_per
WHERE (mandant_id, baustein_id, art_id, dat_bis) IN (
    SELECT (
        MAN.mandant_id, wsop.skopf, art.art_id,
        wsop.datub
    )
    FROM dbp_etl.wsop
    INNER JOIN dbp_data.mandant AS MAN ON wsop.mandt = MAN.mandant_sap_id
    INNER JOIN (
        SELECT
            kl_art_id,
            mandant_id,
            MAX(art_id) AS art_id
        FROM dbp_data.art
        GROUP BY
            mandant_id,
            kl_art_id
    ) AS art
        ON wsop.sposi = art.kl_art_id AND MAN.mandant_id = art.mandant_id
);


INSERT INTO dbp_data.baustein_art_zu_per (
    baustein_id, mandant_id, art_id, dat_bis, stueckliste_id,
    dat_von, akz_id
)
(
    SELECT
        wsop.skopf AS baustein_id,
        MAN.mandant_id,
        CAST(art.art_id AS INTEGER) AS art_id,
        MAX(wsop.datub),
        wsop.stcklst AS stueckliste_id,
        wsop.datuv AS dat_von,
        wsop.akz AS akz_id
    FROM dbp_etl.wsop
    INNER JOIN dbp_data.mandant AS MAN ON wsop.mandt = MAN.mandant_sap_id
    INNER JOIN (
        SELECT
            kl_art_id,
            mandant_id,
            MAX(art_id) AS art_id
        FROM dbp_data.art
        GROUP BY
            mandant_id,
            kl_art_id
    ) AS art
        ON wsop.sposi = art.kl_art_id AND MAN.mandant_id = art.mandant_id
    WHERE wsop.lvorm <> 'X'
    GROUP BY
        MAN.mandant_id,
        baustein_id,
        art.art_id,
        dat_von,
        stueckliste_id,
        akz_id
);
