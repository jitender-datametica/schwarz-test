--update latest entry in art_auslieferungsgruppe_per by setting valid-until-date to day before, 
--in case the article no longer exists in sap table zlf_auslfel, thus marking it as no longer being valid


UPDATE dbp_data.art_auslieferungsgruppe_per AS A SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
FROM (
    SELECT
        A1.mandant_id,
        A1.art_id,
        A1.auslieferungsgruppe_id,
        A1.dat_von,
        A1.dat_bis,
        A1.td_update,
        A1.td_insert
    FROM dbp_data.art_auslieferungsgruppe_per AS A1
    LEFT JOIN
        dbp_etl.debug_prod_stammdaten_zusatz_art_auslieferungsgruppe_per AS D1
        USING (
            mandant_id,
            art_id
        )
    WHERE
        D1.art_id IS NULL
        AND A1.dat_bis >= CURRENT_DATE("Europe/Berlin")
    QUALIFY
        (
            RANK()
                OVER (
                    PARTITION BY A1.mandant_id, A1.art_id
                    ORDER BY A1.td_update IS NULL DESC, A1.td_update DESC
                )
        )
        = 1
) AS upd
WHERE
    A.mandant_id = upd.mandant_id AND A.art_id = upd.art_id AND A.dat_von = upd.dat_von AND A.dat_bis = upd.dat_bis;
