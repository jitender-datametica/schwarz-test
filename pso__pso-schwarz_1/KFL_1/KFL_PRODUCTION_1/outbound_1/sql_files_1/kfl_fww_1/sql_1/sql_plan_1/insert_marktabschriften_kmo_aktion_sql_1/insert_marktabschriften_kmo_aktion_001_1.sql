/* AW check 2021-05-17*/

DROP TABLE IF EXISTS dbp_etl.marktabschrift_aktion_tmp_1;

CREATE TABLE IF NOT EXISTS dbp_etl.marktabschrift_aktion_tmp_1(
  wup_id INTEGER,
  nb_id INTEGER,
  aktion_id STRING(10) COLLATE 'und:ci',
  mandant_id INTEGER,
  dat DATE,
  art_id INTEGER,
  menge_abschrift NUMERIC(29, 3),
  vk_aktion_brutto NUMERIC(29, 3),
  vk_vor_aktion_brutto NUMERIC(29, 2),
  mwst_id INTEGER,
  abschriftbetrag_netto NUMERIC(29, 4),
  abschriftbetrag_brutto NUMERIC(29, 2),
  wrg_id STRING(3) COLLATE 'und:ci',
  vk_aktion_netto NUMERIC(29, 4),
  vk_vor_aktion_netto NUMERIC(29, 4),
  aktion_relevant_fg INTEGER);

INSERT INTO dbp_etl.marktabschrift_aktion_tmp_1
  (
    wup_id,
    nb_id,
    aktion_id,
    mandant_id,
    dat,
    art_id,
    menge_abschrift,
    vk_aktion_brutto,
    vk_vor_aktion_brutto,
    mwst_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto,
    wrg_id,
    vk_aktion_netto,
    vk_vor_aktion_netto,
    aktion_relevant_fg)
    (
      SELECT
        A.wup_id,
        A.nb_id,
        B.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        SUM(A.menge) AS menge_abschrift,
        B.vk_aktion_brutto,
        B.vk_vor_aktion_brutto,
        C.mwst_id,
        0 AS abschriftbetrag_netto,
        0 AS abschriftbetrag_brutto,
        A.wrg_1 AS wrg_id,
        0 AS vk_aktion_netto,
        0 AS vk_vor_aktion_netto,
        B.aktion_relevant_fg
      FROM dbp_data.artbew_1 AS A
      INNER JOIN dbp_etl_process.marktabschriften_stamm_1 AS B
        ON
          A.mandant_id = B.mandant_id
          AND A.wup_id = B.wup_id
          AND A.nb_id = B.nb_id
          AND A.art_id = B.art_id
          AND A.dat = B.dat
      INNER JOIN dbp_data.art_1 AS C
        ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
      WHERE
        A.mandant_id > 1
        AND A.dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY)
          AND (CURRENT_DATE("Europe/Berlin"))
        AND A.bewart_id = 1002
      GROUP BY
        A.wup_id,
        A.nb_id,
        B.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        B.vk_aktion_brutto,
        B.vk_vor_aktion_brutto,
        C.mwst_id,
        abschriftbetrag_netto,
        abschriftbetrag_brutto,
        wrg_id,
        B.aktion_relevant_fg
    );

UPDATE dbp_etl.marktabschrift_aktion_tmp_1
SET
  abschriftbetrag_brutto = CAST(
    (
      marktabschrift_aktion_tmp.vk_vor_aktion_brutto
      - marktabschrift_aktion_tmp.vk_aktion_brutto)
    * marktabschrift_aktion_tmp.menge_abschrift
    AS NUMERIC)
WHERE TRUE;

UPDATE dbp_etl.marktabschrift_aktion_tmp_1
SET
  abschriftbetrag_netto = CAST(
    (
      CAST(
        marktabschrift_aktion_tmp.vk_vor_aktion_brutto
        / (1.00 + dt1.mwst_ / 100.00)
        AS NUMERIC)
      - CAST(
        marktabschrift_aktion_tmp.vk_aktion_brutto
        / (1.00 + dt1.mwst_ / 100.00)
        AS NUMERIC))
    * marktabschrift_aktion_tmp.menge_abschrift
    AS NUMERIC),
  vk_aktion_netto = marktabschrift_aktion_tmp.vk_aktion_brutto
    / (1.00 + dt1.mwst_ / 100.00),
  vk_vor_aktion_netto = marktabschrift_aktion_tmp.vk_vor_aktion_brutto
    / (1.00 + dt1.mwst_ / 100.00)
FROM
  (
    SELECT
      mandant_id AS mandant_id_,
      mwst_id AS mwst_id_,
      dat_von AS dat_von_,
      mwst AS mwst_,
      dat_bis AS dat_bis_
    FROM dbp_data.mwst_per_1
    WHERE mandant_id > 1
  ) AS dt1
WHERE
  marktabschrift_aktion_tmp.dat BETWEEN dt1.dat_von_ AND dt1.dat_bis_
  AND marktabschrift_aktion_tmp.mwst_id = dt1.mwst_id_
  AND marktabschrift_aktion_tmp.mandant_id = dt1.mandant_id_;

DELETE FROM dbp_data.marktabschriften_kmo_aktion_1
WHERE
  dat
  BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY)
  AND (CURRENT_DATE("Europe/Berlin"));

INSERT INTO dbp_data.marktabschriften_kmo_aktion_1
  (
    wup_id,
    nb_id,
    aktion_id,
    mandant_id,
    dat,
    art_id,
    menge_abschrift,
    abschriftbetrag_netto,
    abschriftbetrag_brutto,
    wrg_id,
    vk_aktion_netto,
    vk_vor_aktion_netto,
    aktion_relevant_fg)
    (
      SELECT
        wup_id,
        nb_id,
        aktion_id,
        mandant_id,
        dat,
        art_id,
        menge_abschrift,
        abschriftbetrag_netto,
        abschriftbetrag_brutto,
        wrg_id,
        vk_aktion_netto,
        vk_vor_aktion_netto,
        aktion_relevant_fg
      FROM dbp_etl.marktabschrift_aktion_tmp_1
    );

CREATE OR REPLACE TABLE dbp_etl._upd_$_1{TRANSIENT_TABLE_SUFFIX}
AS
SELECT
  A.mandant_id,
  A.wup_id,
  A.art_id,
  A.dat,
  A.menge_abschrift,
  A.vk_aktion_netto,
  b.vk_aktion_netto_faktura,
  A.vk_vor_aktion_netto,
  b.vk_vor_aktion_netto_faktura
FROM dbp_data.marktabschriften_kmo_aktion_1 AS A
INNER JOIN
  (
    SELECT
      t0.mandant_id,
      t0.art_id,
      t0.wup_id,
      t0.dat_faktura_sap,
      ROUND(t0.vk_aktion_brutto / (1.00 + B.mwst / 100.00), 2)
        AS vk_aktion_netto_faktura,
      ROUND(t0.vk_vor_aktion_brutto / (1.00 + B.mwst / 100.00), 2)
        AS vk_vor_aktion_netto_faktura
    FROM
      (
        SELECT
          mandant_id,
          art_id,
          wup_id,
          dat_faktura_sap,
          vk_aktion_brutto,
          vk_vor_aktion_brutto,
          aktion_id,
          MAX(sap_mwst_id) AS sap_mwst_id
        FROM dbp_data.besch_faktura_det_kmo_1
        GROUP BY
          mandant_id,
          dat_faktura_sap,
          art_id,
          wup_id,
          aktion_id,
          vk_aktion_brutto,
          vk_vor_aktion_brutto
      ) AS t0
    INNER JOIN dbp_data.mwst_per_1 AS B
      ON
        t0.mandant_id = B.mandant_id
        AND t0.sap_mwst_id = B.sap_mwst_id
        AND t0.dat_faktura_sap BETWEEN B.dat_von AND B.dat_bis
    WHERE
      t0.aktion_id <> ''
      AND t0.dat_faktura_sap
        BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY)
        AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY
      t0.mandant_id,
      t0.art_id,
      t0.wup_id,
      t0.dat_faktura_sap,
      vk_aktion_netto_faktura,
      vk_vor_aktion_netto_faktura
  ) AS b
  ON
    A.mandant_id = b.mandant_id
    AND A.art_id = b.art_id
    AND A.wup_id = b.wup_id
    AND A.dat = b.dat_faktura_sap
WHERE
  A.dat
    BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY)
    AND (CURRENT_DATE("Europe/Berlin"))
  AND A.aktion_relevant_fg = 1
  AND (
    A.vk_aktion_netto <> b.vk_aktion_netto_faktura
    OR A.vk_vor_aktion_netto <> b.vk_vor_aktion_netto_faktura);

UPDATE dbp_data.marktabschriften_kmo_aktion_1
SET
  vk_aktion_netto = b.vk_aktion_netto_faktura,
  vk_vor_aktion_netto = b.vk_vor_aktion_netto_faktura,
  abschriftbetrag_netto = CAST(
    (b.vk_vor_aktion_netto_faktura - b.vk_aktion_netto_faktura)
    * b.menge_abschrift
    AS NUMERIC)
FROM dbp_etl._upd_$_1{TRANSIENT_TABLE_SUFFIX} AS b
WHERE
  marktabschriften_kmo_aktion.mandant_id = b.mandant_id
  AND marktabschriften_kmo_aktion.wup_id = b.wup_id
  AND marktabschriften_kmo_aktion.art_id = b.art_id
  AND marktabschriften_kmo_aktion.dat = b.dat
  AND marktabschriften_kmo_aktion.aktion_relevant_fg = 1;
