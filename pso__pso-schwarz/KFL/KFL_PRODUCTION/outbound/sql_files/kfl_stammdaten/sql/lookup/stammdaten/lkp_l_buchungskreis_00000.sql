SELECT
    mandant_id,
    buchungskreis_id,
    buchungskreis_glob_id
FROM dbp_data.l_buchungskreis
GROUP BY
    mandant_id,
    buchungskreis_id,
    buchungskreis_glob_id
ORDER BY
    mandant_id NULLS LAST,
    buchungskreis_id NULLS LAST;
