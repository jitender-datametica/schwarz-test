--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_bewertungskreis_tag_2 (
    mandant_id, bewertungskreis_id, art_id, dat_gld,
    preis_steuer_kz,
    wrg_id,
    gld,
    standard_preis,
    menge_bestand_bme,
    wert_bestand,
    vk_wert,
    zeit_extrakt
)
(
    SELECT
        ABT.mandant_id,
        ABT.bewertungskreis_id,
        ABT.art_id,
        T.dat,
        ABT.preis_steuer_kz,
        ABT.wrg_id,
        ABT.gld,
        ABT.standard_preis,
        ABT.menge_bestand_bme,
        ABT.wert_bestand,
        ABT.vk_wert,
        ABT.zeit_extrakt
    FROM dbp_data.art_bewertungskreis_tag_2 AS ABT_2
    INNER JOIN dbp_data.tag_2 AS T ON TRUE
    WHERE
        (
            ABT.mandant_id, ABT.bewertungskreis_id, ABT.art_id, ABT.dat_gld
        ) IN (SELECT (
            mandant_id, bewertungskreis_id,
            art_id, MAX(dat_gld)
        )
        FROM dbp_data.art_bewertungskreis_tag_2
        WHERE mandant_id = 1
        GROUP BY mandant_id,
        bewertungskreis_id,
        art_id)
        AND T.dat BETWEEN DATE_ADD(ABT.dat_gld, INTERVAL 1 DAY) AND (
            DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        )
        AND (
            ABT.mandant_id, ABT.bewertungskreis_id, ABT.art_id, T.dat
        ) NOT IN (
            SELECT (
                mandant_id, bewertungskreis_id, art_id,
                dat_gld
            )
            FROM dbp_data.art_bewertungskreis_tag_2
            WHERE mandant_id = 1
        )
    GROUP BY
        ABT.mandant_id,
        ABT.bewertungskreis_id,
        ABT.art_id,
        ABT.preis_steuer_kz,
        ABT.wrg_id,
        ABT.gld,
        ABT.standard_preis,
        ABT.menge_bestand_bme,
        ABT.wert_bestand,
        ABT.vk_wert,
        ABT.zeit_extrakt,
        T.dat
);
