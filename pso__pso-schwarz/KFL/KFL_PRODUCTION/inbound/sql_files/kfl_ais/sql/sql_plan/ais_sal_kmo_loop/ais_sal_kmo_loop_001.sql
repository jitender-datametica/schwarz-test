DROP TABLE IF EXISTS DBP_ETL.st_wochen;

CREATE TABLE DBP_ETL.st_wochen AS (
SELECT a.kjmo_sort,
       c.kjwo,
       ROW_NUMBER() OVER (ORDER BY c.kjwo) AS rang
FROM DBP_ETL_PROCESS.sort_monat_woche a
JOIN DBP_DATA.monat b
  ON a.kjmo_sort = b.kjmo
JOIN DBP_DATA.woche c
  ON c.kjwo BETWEEN a.kjwo_sort_von AND a.kjwo_sort_bis
WHERE b.akt_mo = -1 /*${MONAT}*/
);
