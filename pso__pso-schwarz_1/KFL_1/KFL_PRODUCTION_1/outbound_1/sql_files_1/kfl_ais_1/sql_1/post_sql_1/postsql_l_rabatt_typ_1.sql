INSERT INTO dbp_data.rabatt_typ_spr_zu_1
(
    SELECT
        A.mandant_id,
        22,
        A.rabatt_typ_id,
        'keine Information verfügbar',
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.l_rabatt_typ_1 AS A
    LEFT JOIN
        dbp_data.rabatt_typ_spr_zu_1 AS B
        ON A.mandant_id = B.mandant_id AND A.rabatt_typ_id = B.rabatt_typ_id

    WHERE B.mandant_id IS NULL
);
