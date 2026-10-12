-- Fehlerhafte Eingaben in der Staging pruefen.


TRUNCATE TABLE dbp_etl_process.rfi_zfi_fil_transfer_2;


-- 1. Pruefung - Bereits vorhandene Maerkte im Marktstamm werden geprueft.


INSERT INTO dbp_etl_process.rfi_zfi_fil_transfer_2
(SELECT mandant_id,
  buchungskreis_id,
  wup_id,
  buchungskreis_id_neu,
  wup_id_neu,
  dat_von,
  dat_bis,
  wup_aenderung_grund_id,
  td_update,
  td_insert,
  'Markt vorhanden in dbp_data.wup_2' AS rfi_bez
 FROM dbp_etl.zfi_fil_transfer_2 AS A
 WHERE mandant_id = 1
  AND wup_id_neu IN (SELECT wup_id
    FROM dbp_data.wup_2
    WHERE mandant_id = 1
     AND dat_von <> DATE '2090-12-31'
     AND (orig_wup_id = aktuell_wup_id OR wup_id = aktuell_wup_id)
     AND wup_aenderung_grund_id IN (0, 1)));


DELETE FROM dbp_etl.zfi_fil_transfer_2
WHERE mandant_id = 1 AND wup_id_neu IN (SELECT wup_id
   FROM dbp_data.wup_2
   WHERE mandant_id = 1
    AND dat_von <> DATE '2090-12-31'
    AND (orig_wup_id = aktuell_wup_id OR wup_id = aktuell_wup_id)
    AND wup_aenderung_grund_id IN (0, 1));


-- 2. Pruefung - Falls es eine_2 Umgliederung ist, muss sich der Buchungskreis aendern.


INSERT INTO dbp_etl_process.rfi_zfi_fil_transfer_2
(SELECT mandant_id,
  buchungskreis_id,
  wup_id,
  buchungskreis_id_neu,
  wup_id_neu,
  dat_von,
  dat_bis,
  wup_aenderung_grund_id,
  td_update,
  td_insert,
  'Buchungskreis identisch bei Umgliederung' AS rfi_bez
 FROM dbp_etl.zfi_fil_transfer_2 AS A
 WHERE mandant_id = 1
  AND wup_aenderung_grund_id IN (3, - 3)
  AND buchungskreis_id = buchungskreis_id_neu);


DELETE FROM dbp_etl.zfi_fil_transfer_2
WHERE mandant_id = 1 AND wup_aenderung_grund_id IN (3, - 3) AND buchungskreis_id = buchungskreis_id_neu;


-- 3. Pruefung - Falls es ein Umzug/Abriss ist, darf sich der Buchungskreis nicht aendern.


INSERT INTO dbp_etl_process.rfi_zfi_fil_transfer_2
(SELECT mandant_id,
  buchungskreis_id,
  wup_id,
  buchungskreis_id_neu,
  wup_id_neu,
  dat_von,
  dat_bis,
  wup_aenderung_grund_id,
  td_update,
  td_insert,
  'Buchungskreis unterschiedlich bei Umzug/Abriss' AS rfi_bez
 FROM dbp_etl.zfi_fil_transfer_2 AS A
 WHERE mandant_id = 1
  AND wup_aenderung_grund_id IN (2, - 2)
  AND buchungskreis_id <> buchungskreis_id_neu);


DELETE FROM dbp_etl.zfi_fil_transfer_2
WHERE mandant_id = 1 AND wup_aenderung_grund_id IN (2, - 2) AND buchungskreis_id <> buchungskreis_id_neu;


-- Pruefung Ende.

-- Falls es zukuenftige Eintraege sind, muss hier der Kehrwert als ID eingetragen werden.


UPDATE dbp_etl.zfi_fil_transfer_2 SET
 wup_aenderung_grund_id = - 1 * zfi_fil_transfer.wup_aenderung_grund_id
WHERE dat_von > CURRENT_DATE("Europe/Berlin");


DELETE FROM dbp_etl_process.wup_transfer_per_2
WHERE (mandant_id, wup_id, dat_von) IN (SELECT (A.mandant_id, A.wup_id, A.dat_von)
  FROM dbp_etl_process.wup_transfer_per_2 AS A
   INNER JOIN dbp_etl.zfi_fil_transfer_2 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A
     .dat_von >= B.dat_von
  GROUP BY A.mandant_id,
   A.wup_id,
   A.dat_von);


INSERT INTO dbp_etl_process.wup_transfer_per_2 (mandant_id, buchungskreis_id, wup_id, buchungskreis_id_neu
 , wup_id_neu, dat_von, dat_bis, wup_aenderung_grund_id, td_update, td_insert)
(SELECT mandant_id,
  buchungskreis_id,
  wup_id,
  buchungskreis_id_neu,
  wup_id_neu,
  dat_von,
  dat_bis,
  wup_aenderung_grund_id,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM dbp_etl.zfi_fil_transfer_2);

UPDATE dbp_etl_process.wup_transfer_per_2 SET
 dat_bis = dt1.dat_bis FROM (SELECT mandant_id,
   wup_id,
   dat_von,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wup_id
        ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
       , 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
         , 0) AS STRING)), INTERVAL - 1 DAY)
    END AS dat_bis
  FROM dbp_etl_process.wup_transfer_per_2 AS L
  WHERE mandant_id = 1
  GROUP BY mandant_id,
   wup_id,
   dat_von) AS dt1
WHERE wup_transfer_per.mandant_id = dt1.mandant_id AND wup_transfer_per.wup_id = dt1.wup_id AND wup_transfer_per.dat_von
    = dt1.dat_von AND wup_transfer_per.dat_bis <> dt1.dat_bis;


-- Falls der Stichtag erreicht worden ist, genau andersrum.


UPDATE dbp_etl_process.wup_transfer_per_2 SET
 wup_aenderung_grund_id = - 1 * wup_transfer_per.wup_aenderung_grund_id
WHERE dat_von <= CURRENT_DATE("Europe/Berlin") AND wup_aenderung_grund_id < 0;