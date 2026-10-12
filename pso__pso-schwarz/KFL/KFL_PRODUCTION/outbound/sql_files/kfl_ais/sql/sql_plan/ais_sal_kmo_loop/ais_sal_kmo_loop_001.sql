DROP TABLE IF EXISTS dbp_etl.st_wochen;


CREATE TABLE IF NOT EXISTS dbp_etl.st_wochen AS
SELECT
    A.kjmo_sort,
    C.kjwo,
    ROW_NUMBER() OVER (ORDER BY C.kjwo IS NULL, C.kjwo) AS rang
FROM dbp_etl_process.sort_monat_woche AS A
INNER JOIN dbp_data.monat AS B ON A.kjmo_sort = B.kjmo
INNER JOIN
    dbp_data.woche AS C
    ON C.kjwo BETWEEN A.kjwo_sort_von AND A.kjwo_sort_bis
WHERE B.akt_mo = -1; /* ${MONAT} */
