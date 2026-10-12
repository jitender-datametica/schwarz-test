-- rag picker for de/kmo for updating mara with gtin!


UPDATE dbp_data.art AS art0 SET
    gtin_id = b.gtin_id FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.gtin_id
    FROM dbp_data.art_gtin_zu AS A
    INNER JOIN (SELECT
        mandant_id,
        art_id,
        basismenge_einh_id
    FROM dbp_data.art) AS b
        ON
            A.mandant_id = b.mandant_id
            AND A.art_id = b.art_id
            AND COALESCE(
                A.altnv_menge_einh_id,
                ''
            ) = COALESCE(b.basismenge_einh_id, ''
            ) AND A.haupt_gtin_fg = 1
    QUALIFY
        (
            ROW_NUMBER()
                OVER (
                    PARTITION BY A.mandant_id, A.art_id
                    ORDER BY A.lfd_nr IS NULL DESC, A.lfd_nr DESC
                )
        )
        = 1
)
    AS b
WHERE art0.mandant_id = b.mandant_id AND art0.art_id = b.art_id;
