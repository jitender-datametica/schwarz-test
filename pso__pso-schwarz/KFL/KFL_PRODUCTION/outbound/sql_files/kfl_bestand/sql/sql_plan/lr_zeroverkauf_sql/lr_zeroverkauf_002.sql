SELECT COUNT(*) FROM (
    SELECT *
    FROM dbp_etl.akt_zeitfenster_ ${TRANSIENT_TABLE_SUFFIX}
);
