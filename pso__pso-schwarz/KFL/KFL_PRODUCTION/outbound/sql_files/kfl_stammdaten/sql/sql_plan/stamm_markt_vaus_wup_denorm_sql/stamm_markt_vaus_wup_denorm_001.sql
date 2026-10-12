-- begin subquery
SELECT COUNT(*)
FROM dbp_data.wup
INNER JOIN (
    SELECT
        mandant_id AS mandant_id_,
        wirtschaftseinheit_id AS wup_id_,
        MIN(wirtschaftseinheit_bez) AS wup_standort_
    FROM dbp_data.immo_wirtschaftseinheit
    WHERE dat_we_gueltig_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        mandant_id_,
        wup_id_
)
    AS a ON wup.mandant_id = a.mandant_id_ AND CAST(wup.wup_id as STRING
) = a.wup_id_ AND wup.wup_standort <> a
.wup_standort_; -- end subquery
