--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    buchungskreis_glob_id,
    MIN(buchungskreis_id) AS buchungskreis_id
FROM dbp_data.l_buchungskreis
GROUP BY
    mandant_id,
    buchungskreis_glob_id;
