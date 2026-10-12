SELECT
    'KFL' AS firma,
    TRIM(werbe_kat_bez) AS werbe_kat_bez,
    mandant_id,
    MIN(werbe_kat_id) AS werbe_kat_id
FROM dbp_data.werbekat_spr_zu
WHERE spr_id = 22
GROUP BY
    firma,
    werbe_kat_bez,
    mandant_id;
