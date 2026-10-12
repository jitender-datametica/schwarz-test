INSERT INTO dbp_data.angebot_status_spr_zu_2
(
    SELECT
        A.mandant_id,
        22,
        A.angebot_attribut_id,
        'keine Information verfügbar',
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.l_angebot_attribut_2 AS A
    LEFT JOIN dbp_data.angebot_attribut_spr_zu_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.angebot_attribut_id
            = B.angebot_attribut_id
    WHERE B.mandant_id IS NULL
);
