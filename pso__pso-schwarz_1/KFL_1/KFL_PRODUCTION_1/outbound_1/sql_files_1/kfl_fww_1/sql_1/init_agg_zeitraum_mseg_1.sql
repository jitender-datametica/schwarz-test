/*
###########################################################################
#   1.) Erstellen der temporaeren Tabellen
#       Vor dem Löschen wird geprüft ob die Tabelle vorhanden ist
###########################################################################
*/

CREATE TABLE IF NOT EXISTS ${KFL_SNFLK_COMMON_DBP_LOAD}.zeitraum_mseg_1(
  mandant_id INTEGER,
  min_dat DATE,
  max_dat DATE,
  ranking INTEGER);

/*
###########################################################################
#   2.) Beladung Rankingtabelle
###########################################################################
*/

INSERT INTO ${KFL_SNFLK_COMMON_DBP_LOAD}.zeitraum_mseg_1(
  mandant_id, min_dat, max_dat, ranking)
  (
    SELECT
      t1.mandant_id,
      t1.min_dat,
      t1.max_dat,
      RANK()
        OVER (
          PARTITION BY t1.mandant_id
          ORDER BY t1.min_dat IS NULL DESC, t1.min_dat DESC
        ) AS ranking
    FROM
      (
        SELECT
          C.mandant_id,
          B.min_dat,
          B.max_dat
        FROM ${KFL_SNFLK_COMMON_DBP_DATA}.tag_1 AS A
        INNER JOIN ${KFL_SNFLK_COMMON_DBP_DATA}.monat_1 AS B
          ON A.kjmo = B.kjmo
        INNER JOIN ${KFL_SNFLK_COMMON_DBP_DATA}.mandant_1 AS C
          ON TRUE
        WHERE
          A.dat BETWEEN DATE ${DAT_START} AND (CURRENT_DATE("Europe/Berlin"))
          AND C.mandant_id IN (${MANDANT_1})
        GROUP BY
          B.min_dat,
          B.max_dat,
          C.mandant_id
      ) AS t1_1
    QUALIFY
      (
        RANK()
          OVER (
            PARTITION BY t1.mandant_id
            ORDER BY t1.min_dat IS NULL DESC, t1.min_dat DESC
          ))
      <= ${ZEITRAUM}
  );
