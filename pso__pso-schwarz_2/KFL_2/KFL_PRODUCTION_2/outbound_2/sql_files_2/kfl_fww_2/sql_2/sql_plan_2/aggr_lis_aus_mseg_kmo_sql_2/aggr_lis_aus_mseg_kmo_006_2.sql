DELETE FROM dbp_etl.zeitraum_mseg_2
WHERE (
    mandant_id, ranking) IN (
    SELECT (mandant_id, ranking)
    FROM dbp_etl.zeitraum_mseg_anr_2
);
