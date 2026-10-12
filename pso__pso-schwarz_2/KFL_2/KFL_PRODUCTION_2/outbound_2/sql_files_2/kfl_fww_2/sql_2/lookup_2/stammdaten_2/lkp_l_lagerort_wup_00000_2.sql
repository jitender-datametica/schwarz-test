--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    TRIM(lagerort_id) AS lagerort_id,
    nb_id,
    wup_id,
    lagernummer_id
FROM dbp_data.l_lagerort_2;
