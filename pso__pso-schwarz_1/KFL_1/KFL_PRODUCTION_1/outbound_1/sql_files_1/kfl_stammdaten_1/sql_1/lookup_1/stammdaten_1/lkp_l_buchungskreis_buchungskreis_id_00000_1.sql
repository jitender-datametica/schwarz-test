SELECT
    mandant_id,
    buchungskreis_id,
    wrg_id
FROM dbp_data.l_buchungskreis_1
GROUP BY
    mandant_id,
    buchungskreis_id,
    wrg_id
ORDER BY
    mandant_id NULLS LAST,
    buchungskreis_id NULLS LAST;
