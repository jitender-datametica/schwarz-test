INSERT INTO dbp_data.transfer_status_spr_zu
(
    SELECT
        A.mandant_id,
        22,
        A.transfer_status_id,
        'keine Information verfügbar',
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.l_transfer_status AS A
    LEFT JOIN dbp_data.transfer_status_spr_zu AS B
        ON
            A.mandant_id = B.mandant_id AND A.transfer_status_id
            = B.transfer_status_id
    WHERE B.mandant_id IS NULL
);
