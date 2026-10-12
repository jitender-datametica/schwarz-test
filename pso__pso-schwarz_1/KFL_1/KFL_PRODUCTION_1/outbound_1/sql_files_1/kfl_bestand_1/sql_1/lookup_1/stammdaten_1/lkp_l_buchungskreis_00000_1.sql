--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    buchungskreis_id,
    buchungskreis_glob_id
FROM dbp_data.l_buchungskreis_1
GROUP BY
    mandant_id,
    buchungskreis_id,
    buchungskreis_glob_id
ORDER BY
    mandant_id NULLS LAST,
    buchungskreis_id NULLS LAST;
