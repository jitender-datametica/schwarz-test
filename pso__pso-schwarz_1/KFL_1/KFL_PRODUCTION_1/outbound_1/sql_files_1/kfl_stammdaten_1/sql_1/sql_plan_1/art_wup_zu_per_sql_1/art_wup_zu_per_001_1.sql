-- temporary for debug

DROP TABLE IF EXISTS dbp_etl.pisz1_art_wup_zu_per_1;

CREATE TABLE IF NOT EXISTS dbp_etl.pisz1_art_wup_zu_per_1
  CLONE dbp_data.art_wup_zu_per_1;

DROP TABLE IF EXISTS dbp_etl.awp_vk_1;

CREATE TABLE IF NOT EXISTS dbp_etl.awp_vk_1(
  art_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
  vk_brutto NUMERIC(29, 2) NOT NULL);

DROP TABLE IF EXISTS dbp_etl.awp_marc_1;

CREATE TABLE IF NOT EXISTS dbp_etl.awp_marc_1(
  art_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  kdis INTEGER,
  bezugsweg_id INTEGER);

DROP TABLE IF EXISTS dbp_etl.awp_lstg_1;

CREATE TABLE IF NOT EXISTS dbp_etl.awp_lstg_1(
  art_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  listung_id INTEGER);

INSERT INTO dbp_etl.awp_marc_1
  (art_id, mandant_id, wup_id, nb_id, dat, kdis, bezugsweg_id)
    (
      SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        CURRENT_DATE("Europe/Berlin") AS dat,
        kdis,
        bezugsweg_id
      FROM dbp_data.art_wup_status_per_1
      WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND nb_id = 0
    );

INSERT INTO dbp_etl.awp_vk_1
  (art_id, mandant_id, wup_id, nb_id, dat, wrg_id, vk_brutto)
    (
      SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        CURRENT_DATE("Europe/Berlin") AS dat,
        wrg_id,
        vk_brutto
      FROM dbp_data.art_wup_vk_per_1
      WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND nb_id = 0
      GROUP BY
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        dat,
        wrg_id,
        vk_brutto
    );

INSERT INTO dbp_etl.awp_lstg_1
  (art_id, mandant_id, wup_id, nb_id, dat, listung_id)
    (
      SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        CURRENT_DATE("Europe/Berlin") AS dat,
        1 AS listung_id
      FROM dbp_data.art_list_wup_zu_per_1
      WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND nb_id = 0
      GROUP BY
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        dat,
        listung_id
    );

DROP TABLE IF EXISTS dbp_etl.awp_tmp_1;

CREATE TABLE IF NOT EXISTS dbp_etl.awp_tmp_1
  LIKE dbp_data.art_wup_zu_per_1;

CREATE TEMPORARY TABLE IF NOT EXISTS _gather
AS (
  SELECT
    mandant_id,
    art_id,
    wup_id,
    dat,
    nb_id
  FROM dbp_etl.awp_vk_1
  WHERE vk_brutto < 1000000
  GROUP BY
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat
  UNION DISTINCT
  SELECT
    mandant_id,
    art_id,
    wup_id,
    dat,
    nb_id
  FROM dbp_etl.awp_lstg_1
  GROUP BY
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat
)
UNION DISTINCT
SELECT
  mandant_id,
  art_id,
  wup_id,
  dat,
  nb_id
FROM dbp_etl.awp_marc_1
GROUP BY
  art_id,
  mandant_id,
  wup_id,
  nb_id,
  dat;

INSERT INTO dbp_etl.awp_tmp_1
  (
    mandant_id,
    wup_id,
    nb_id,
    dat_von,
    art_id,
    bezugsweg_id,
    listung_id,
    vk_brutto,
    dat_bis,
    kdis,
    wrg_id,
    td_update,
    td_insert)
    (
      SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.dat AS dat_von,
        T1.art_id,
        COALESCE(T3.bezugsweg_id, 4) AS bezugsweg_id,
        COALESCE(T4.listung_id, 0) AS listung_id,
        COALESCE(t2.vk_brutto, 0) AS vk_brutto,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        COALESCE(T3.kdis, 0) AS kdis,
        COALESCE(t2.wrg_id, X.default_wrg) AS wrg_id,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
      FROM `_gather` AS T1_1
      INNER JOIN dbp_data.mandant_1 AS X
        ON T1.mandant_id = X.mandant_id
      LEFT JOIN dbp_etl.awp_lstg_1 AS T4
        ON
          T1.art_id = T4.art_id
          AND T1.wup_id = T4.wup_id
          AND T1.mandant_id = T4.mandant_id
          AND T1.dat = T4.dat
      LEFT JOIN (SELECT * FROM dbp_etl.awp_vk_1 WHERE vk_brutto < 1000000) AS t2
        ON
          T1.art_id = t2.art_id
          AND T1.wup_id = t2.wup_id
          AND T1.mandant_id = t2.mandant_id
          AND T1.dat = t2.dat
      LEFT JOIN
        dbp_etl.awp_marc_1
          AS T3
        ON
          T1.art_id = T3.art_id
          AND T1.wup_id = T3.wup_id
          AND T1.mandant_id = T3.mandant_id
          AND T1.dat = T3.dat
    );

INSERT INTO dbp_etl.awp_tmp_1
  (
    SELECT *
    FROM dbp_data.art_wup_zu_per_1
    WHERE
      dat_bis >= CURRENT_DATE("Europe/Berlin")
      AND dat_von < CURRENT_DATE("Europe/Berlin")
  );

DELETE FROM dbp_etl.awp_tmp_1 AS T1_1
WHERE
  EXISTS(
    SELECT *
    FROM dbp_etl.awp_tmp_1 AS T2
    WHERE
      T1.wup_id = wup_id
      AND T1.art_id = art_id
      AND T1.mandant_id = mandant_id
      AND DATE_SUB(T1.dat_von, INTERVAL 1 DAY) = dat_von
      AND T1.listung_id = listung_id
      AND T1.bezugsweg_id = bezugsweg_id
      AND T1.kdis = kdis
      AND T1.vk_brutto = vk_brutto
      AND T1.wrg_id = wrg_id
  );

DELETE FROM dbp_etl.awp_tmp_1 AS T1_1
WHERE
  EXISTS(
    SELECT *
    FROM dbp_etl.awp_tmp_1 AS T2
    WHERE
      T1.wup_id = wup_id
      AND T1.art_id = art_id
      AND T1.mandant_id = mandant_id
      AND T1.listung_id = listung_id
      AND T1.bezugsweg_id = bezugsweg_id
      AND T1.kdis = kdis
      AND T1.vk_brutto = vk_brutto
      AND T1.wrg_id = wrg_id
      AND dat_von < CURRENT_DATE("Europe/Berlin")
  )
  AND dat_von = CURRENT_DATE("Europe/Berlin")("Europe/Berlin");

UPDATE dbp_etl.awp_tmp_1
SET
  dat_bis = dt1.`_dat_bis`
FROM
  (
    SELECT
      mandant_id AS `_mandant_id`,
      art_id AS `_art_id`,
      dat_von AS `_dat_von`,
      wup_id AS `_wup_id`,
      nb_id AS `_nb_id`,
      DATE_ADD(
        LEAD(dat_von, 1, PARSE_DATE('%F', '9999-01-01'))
          OVER (
            PARTITION BY mandant_id, art_id, wup_id, nb_id  -- PE-Review
            ORDER BY dat_von IS NULL, dat_von
          ),
        INTERVAL -1 DAY) AS `_dat_bis`
    FROM dbp_etl.awp_tmp_1 AS T1_1
  ) AS dt1
WHERE
  awp_tmp.art_id = dt1.`_art_id`
  AND awp_tmp.wup_id = dt1.`_wup_id`
  AND awp_tmp.dat_von = dt1.`_dat_von`
  AND awp_tmp.mandant_id = dt1.`_mandant_id`
  AND awp_tmp.dat_bis <> dt1.`_dat_bis`;

DELETE FROM dbp_data.art_wup_zu_per_1
WHERE dat_bis >= CURRENT_DATE("Europe/Berlin");

INSERT INTO dbp_data.art_wup_zu_per_1
  (
    SELECT *
    FROM dbp_etl.awp_tmp_1
  );

DROP TABLE IF EXISTS dbp_etl.pisz2_art_wup_zu_per_1;

CREATE TABLE IF NOT EXISTS dbp_etl.pisz2_art_wup_zu_per_1
  CLONE dbp_data.art_wup_zu_per_1;
