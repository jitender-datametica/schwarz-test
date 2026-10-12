UPDATE dbp_data.wup_2 SET
    wup_standort = a.wup_standort_ FROM (
    SELECT
        mandant_id AS mandant_id_,
        wirtschaftseinheit_id AS wup_id_,
        MIN(wirtschaftseinheit_bez) AS wup_standort_
    FROM dbp_data.immo_wirtschaftseinheit_2
    WHERE dat_we_gueltig_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        mandant_id_,
        wup_id_
) AS a
WHERE wup.mandant_id = a.mandant_id_ AND CAST(wup.wup_id AS STRING) = a.wup_id_;


-- dbay, 23.01.2024


UPDATE dbp_data.wup_2 SET
    wup_standort = 'Waiblingen, RemsPark'
WHERE mandant_id = 1 AND wup_id = 4853;
