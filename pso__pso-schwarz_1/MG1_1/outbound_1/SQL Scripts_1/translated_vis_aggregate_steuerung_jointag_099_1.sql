
/*
#----------------------------------------------------------------------------
# 1) Ladetabelle anlegen
#----------------------------------------------------------------------------
*/




DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1;


/*
Die Tabelle DBP_ETL.dat_vj_vergleich_tmp_1 ist als Join- und Berechnungstabelle
für die spätere Beladung der DBP_DATA.artbew_tag_wg_wup_sum benötigt
Erklärung im create

*/


-- a) Diese Datum wird mit der DBP_DATA.artbew_tag_wg_wup_sum gejoint


-- b) Auf dieses Datum werden die Daten aggregiert


-- c) 1 wenn join_dat=dat, dann ist dies der aktuelle Tageswert


-- d) 1 wenn join_dat=dat-1 Jahr (z.B. dat=1.3.2007 --> join_dat=1.3.2006)


--   wird für die Kummulierung der Vorjahre gebraucht


-- e) siehe d) nur für das Vorvorjahr


-- f) 1 wenn join_dat=dat-364 (Wochentagsvergleich (Mi=Mi Vorjahr)


-- g) 1 wenn join_dat=dat-728 (Wochentagsvergleich (Mi=Mi Vorjahr)


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 (
JOIN_DAT DATE NOT NULL,
DAT DATE NOT NULL,
GJ BIGNUMERIC NOT NULL,
KJWO INTEGER NOT NULL,
KJMO INTEGER NOT NULL,
MO_KJ BIGNUMERIC NOT NULL,
AKT_GJ BIGNUMERIC NOT NULL,
AKT_MO BIGNUMERIC NOT NULL,
AKT_WO BIGNUMERIC NOT NULL,
AKT_TAG BIGNUMERIC NOT NULL,
WTAG_ID BIGNUMERIC NOT NULL,
AKT_GJ_FG BIGNUMERIC NOT NULL,
VJ_1_FG BIGNUMERIC NOT NULL,
VJ_2_FG BIGNUMERIC NOT NULL,
VJ_WT_1_FG BIGNUMERIC NOT NULL,
VJ_WT_2_FG BIGNUMERIC NOT NULL
);


DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_1;


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_1 (
MANDANT_ID BIGNUMERIC,
WUP_ID INTEGER NOT NULL,
NB_ID BIGNUMERIC,
JOIN_DAT DATE NOT NULL,
DAT DATE NOT NULL,
GJ BIGNUMERIC NOT NULL,
KJWO INTEGER NOT NULL,
KJMO INTEGER NOT NULL,
MO_KJ BIGNUMERIC NOT NULL,
AKT_GJ BIGNUMERIC NOT NULL,
AKT_MO BIGNUMERIC NOT NULL,
AKT_WO BIGNUMERIC NOT NULL,
AKT_TAG BIGNUMERIC NOT NULL,
WTAG_ID BIGNUMERIC NOT NULL,
AKT_GJ_FG BIGNUMERIC NOT NULL,
VJ_1_FG BIGNUMERIC NOT NULL,
VJ_2_FG BIGNUMERIC NOT NULL,
VJ_WT_1_FG BIGNUMERIC NOT NULL,
VJ_WT_2_FG BIGNUMERIC NOT NULL
);


/*
#----------------------------------------------------------------------------
# 2) tmp Tabelle mit Join-Logik beladen
#----------------------------------------------------------------------------
*/


-- Einfügen der Kalendertagsvergleichswerte des aktuellen GJ, wobei der 29.02. eines Vorjahres auf den 28.02. des GJ gebucht wird


-- für gj, gj-1 und gj-2



INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 (JOIN_DAT, DAT, GJ, KJWO, KJMO, MO_KJ, AKT_GJ, AKT_MO, AKT_WO,
 AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT t1.DAT AS JOIN_DAT,
  COALESCE(t2.DAT, dt1.DAT) AS DAT,
  CAST(COALESCE(t2.GJ, dt1.GJ) AS INT64) AS GJ,
  CAST(COALESCE(t2.KJWO, dt1.KJWO) AS INTEGER) AS KJWO,
  CAST(COALESCE(t2.KJMO, dt1.KJMO) AS INTEGER) AS KJMO,
  COALESCE(t2.MO_KJ, dt1.MO_KJ) AS MO_KJ,
  COALESCE(t2.AKT_GJ, dt1.AKT_GJ) AS AKT_GJ,
  COALESCE(t2.AKT_MO, dt1.AKT_MO) AS AKT_MO,
  COALESCE(t2.AKT_WO, dt1.AKT_WO) AS AKT_WO,
  COALESCE(t2.AKT_TAG, dt1.AKT_TAG) AS AKT_TAG,
  COALESCE(t2.WTAG_ID, dt1.WTAG_ID) AS WTAG_ID,
   CASE
   WHEN t1.GJ = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS AKT_GJ_FG,
   CASE
   WHEN t1.GJ + 1 = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS VJ_1_FG,
   CASE
   WHEN t1.GJ + 2 = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS VJ_2_FG,
  0 AS VJ_WT_1_FG,
  0 AS VJ_WT_2_FG
 FROM (SELECT DAT,
    GJ
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1
   WHERE AKT_GJ IN (0, - 1, - 2, 1)) AS t1_1
  FULL JOIN (SELECT DAT,
    GJ,
    KJWO,
    KJMO,
    MO_KJ,
    AKT_GJ,
    AKT_MO,
    AKT_WO,
    AKT_TAG,
    WTAG_ID
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1
   WHERE AKT_GJ IN (0, 1)) AS t2 ON EXTRACT(DAY FROM t1.DAT) = EXTRACT(DAY FROM t2.DAT) AND EXTRACT(MONTH FROM t1.DAT) =
    EXTRACT(MONTH FROM t2.DAT)
  INNER JOIN (SELECT DAT,
    GJ,
    KJWO,
    KJMO,
    MO_KJ,
    AKT_GJ,
    AKT_MO,
    AKT_WO,
    AKT_TAG,
    WTAG_ID
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1 AS T3
   WHERE AKT_GJ IN (0)
    AND EXTRACT(DAY FROM DAT) = 28
    AND EXTRACT(MONTH FROM DAT) = 2) AS dt1 ON TRUE);



-- Einfügen der Kalendertagsvergleichswerte des vorherigen GJ, wobei der 29.02. eines Vorjahres auf den 28.02. des GJ gebucht wird


-- für gj-1, gj-2 und gj-3


--CAST(t3.dat AS INTEGER) MOD 10000 = 228) dt1



INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 (JOIN_DAT, DAT, GJ, KJWO, KJMO, MO_KJ, AKT_GJ, AKT_MO, AKT_WO,
 AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT t1.DAT AS JOIN_DAT,
  COALESCE(t2.DAT, dt1.DAT) AS DAT,
  CAST(COALESCE(t2.GJ, dt1.GJ) AS INT64) AS GJ,
  CAST(COALESCE(t2.KJWO, dt1.KJWO) AS INTEGER) AS KJWO,
  CAST(COALESCE(t2.KJMO, dt1.KJMO) AS INTEGER) AS KJMO,
  COALESCE(t2.MO_KJ, dt1.MO_KJ) AS MO_KJ,
  COALESCE(t2.AKT_GJ, dt1.AKT_GJ) AS AKT_GJ,
  COALESCE(t2.AKT_MO, dt1.AKT_MO) AS AKT_MO,
  COALESCE(t2.AKT_WO, dt1.AKT_WO) AS AKT_WO,
  COALESCE(t2.AKT_TAG, dt1.AKT_TAG) AS AKT_TAG,
  COALESCE(t2.WTAG_ID, dt1.WTAG_ID) AS WTAG_ID,
   CASE
   WHEN t1.GJ = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS AKT_GJ_FG,
   CASE
   WHEN t1.GJ + 1 = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS VJ_1_FG,
   CASE
   WHEN t1.GJ + 2 = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS VJ_2_FG,
  0 AS VJ_WT_1_FG,
  0 AS VJ_WT_2_FG
 FROM (SELECT DAT,
    GJ
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1
   WHERE AKT_GJ IN (- 1, - 2, - 3)) AS t1_1
  FULL JOIN (SELECT DAT,
    GJ,
    KJWO,
    KJMO,
    MO_KJ,
    AKT_GJ,
    AKT_MO,
    AKT_WO,
    AKT_TAG,
    WTAG_ID
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1
   WHERE AKT_GJ IN (- 1)) AS t2 ON EXTRACT(DAY FROM t1.DAT) = EXTRACT(DAY FROM t2.DAT) AND EXTRACT(MONTH FROM t1.DAT) =
    EXTRACT(MONTH FROM t2.DAT)
  INNER JOIN (SELECT DAT,
    GJ,
    KJWO,
    KJMO,
    MO_KJ,
    AKT_GJ,
    AKT_MO,
    AKT_WO,
    AKT_TAG,
    WTAG_ID
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1 AS T3
   WHERE AKT_GJ IN (- 1)
    AND EXTRACT(DAY FROM DAT) = 28
    AND EXTRACT(MONTH FROM DAT) = 2) AS dt1 ON TRUE);


-- Einfügen der Kalendertagsvergleichswerte des vorherigen GJ, wobei der 29.02. eines Vorjahres auf den 28.02. des GJ gebucht wird


-- für gj-2, gj-3 und gj-4


--CAST(t3.dat AS INTEGER) MOD 10000 = 228) dt1


INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 (JOIN_DAT, DAT, GJ, KJWO, KJMO, MO_KJ, AKT_GJ, AKT_MO, AKT_WO,
 AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT t1.DAT AS JOIN_DAT,
  COALESCE(t2.DAT, dt1.DAT) AS DAT,
  CAST(COALESCE(t2.GJ, dt1.GJ)AS INT64) AS GJ,
  CAST(COALESCE(t2.KJWO, dt1.KJWO) AS INTEGER) AS KJWO,
  CAST(COALESCE(t2.KJMO, dt1.KJMO) AS INTEGER) AS KJMO,
  COALESCE(t2.MO_KJ, dt1.MO_KJ) AS MO_KJ,
  COALESCE(t2.AKT_GJ, dt1.AKT_GJ) AS AKT_GJ,
  COALESCE(t2.AKT_MO, dt1.AKT_MO) AS AKT_MO,
  COALESCE(t2.AKT_WO, dt1.AKT_WO) AS AKT_WO,
  COALESCE(t2.AKT_TAG, dt1.AKT_TAG) AS AKT_TAG,
  COALESCE(t2.WTAG_ID, dt1.WTAG_ID) AS WTAG_ID,
   CASE
   WHEN t1.GJ = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS AKT_GJ_FG,
   CASE
   WHEN t1.GJ + 1 = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS VJ_1_FG,
   CASE
   WHEN t1.GJ + 2 = COALESCE(t2.GJ, dt1.GJ)
   THEN 1
   ELSE 0
   END AS VJ_2_FG,
  0 AS VJ_WT_1_FG,
  0 AS VJ_WT_2_FG
 FROM (SELECT DAT,
    GJ
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1
   WHERE AKT_GJ IN (- 2, - 3, - 4)) AS t1_1
  FULL JOIN (SELECT DAT,
    GJ,
    KJWO,
    KJMO,
    MO_KJ,
    AKT_GJ,
    AKT_MO,
    AKT_WO,
    AKT_TAG,
    WTAG_ID
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1
   WHERE AKT_GJ IN (- 2)) AS t2 ON EXTRACT(DAY FROM t1.DAT) = EXTRACT(DAY FROM t2.DAT) AND EXTRACT(MONTH FROM t1.DAT) =
    EXTRACT(MONTH FROM t2.DAT)
  INNER JOIN (SELECT DAT,
    GJ,
    KJWO,
    KJMO,
    MO_KJ,
    AKT_GJ,
    AKT_MO,
    AKT_WO,
    AKT_TAG,
    WTAG_ID
   FROM KFL_PRODUCTION_DBP_DATA.TAG_1 AS T3
   WHERE AKT_GJ IN (- 2)
    AND EXTRACT(DAY FROM DAT) = 28
    AND EXTRACT(MONTH FROM DAT) = 2) AS dt1 ON TRUE);


-- Einfügen der Wochentagsvergleichswerte des aktuellen GJs mit Vorjahr


INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 (JOIN_DAT, DAT, GJ, KJWO, KJMO, MO_KJ, AKT_GJ, AKT_MO, AKT_WO,
 AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT DATE_SUB(DAT, INTERVAL 364 DAY),
  DAT,
  CAST(GJ AS INT64) AS GJ,
  CAST(KJWO AS INTEGER) AS KJWO,
  CAST(KJMO AS INTEGER) AS KJMO,
  MO_KJ,
  AKT_GJ,
  AKT_MO,
  AKT_WO,
  AKT_TAG,
  WTAG_ID,
  0 AS AKT_GJ_FG,
  0 AS VJ_1_FG,
  0 AS VJ_2_FG,
  1 AS VJ_WT_1_FG,
  0 AS VJ_WT_2_FG
 FROM KFL_PRODUCTION_DBP_DATA.TAG_1
 WHERE AKT_GJ IN (0, - 1, - 2, 1));


-- Einfügen der Wochentagsvergleichswerte des vorherigen GJs mit Vorvorjahr



INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 (JOIN_DAT, DAT, GJ, KJWO, KJMO, MO_KJ, AKT_GJ, AKT_MO, AKT_WO,
 AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT DATE_SUB(DAT, INTERVAL 728 DAY),
  DAT,
  CAST(GJ AS INT64) AS GJ,
  CAST(KJWO AS INTEGER) AS KJWO,
  CAST(KJMO AS INTEGER) AS KJMO,
  MO_KJ,
  AKT_GJ,
  AKT_MO,
  AKT_WO,
  AKT_TAG,
  WTAG_ID,
  0 AS AKT_GJ_FG,
  0 AS VJ_1_FG,
  0 AS VJ_2_FG,
  0 AS VJ_WT_1_FG,
  1 AS VJ_WT_2_FG
 FROM KFL_PRODUCTION_DBP_DATA.TAG_1
 WHERE AKT_GJ IN (0, - 1, - 2, 1));


DELETE FROM KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1
WHERE AKT_GJ_FG = 0 AND VJ_1_FG = 0 AND VJ_2_FG = 0 AND VJ_WT_1_FG = 0 AND VJ_WT_2_FG = 0;


/*
#----------------------------------------------------------------------------
# 2) Erweiterung der Join-Tabelle mit 2.1) Deltalogik 2.2) Kompletter Aggregation
#----------------------------------------------------------------------------
*/


/*
#----------------------------------------------------------------------------
# 2.1) Kompletter Aggregation 
# Damit werden alle Tage des GJ und GJ-1 eingefügt (komplett-Aggregation)
#----------------------------------------------------------------------------
*/


--t2.dat_eroeffnung > 101) dt1

INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_1 (MANDANT_ID, WUP_ID, NB_ID, JOIN_DAT, DAT, GJ, KJWO, KJMO, MO_KJ,
 AKT_GJ, AKT_MO, AKT_WO, AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT dt1.MANDANT_ID,
  CAST(dt1.WUP_ID AS INTEGER) AS WUP_ID,
  CAST(dt1.NB_ID AS INT64) AS NB_ID,
  T1.JOIN_DAT,
  T1.DAT,
  T1.GJ,
  T1.KJWO,
  T1.KJMO,
  T1.MO_KJ,
  T1.AKT_GJ,
  T1.AKT_MO,
  T1.AKT_WO,
  T1.AKT_TAG,
  T1.WTAG_ID,
  T1.AKT_GJ_FG,
  T1.VJ_1_FG,
  T1.VJ_2_FG,
  T1.VJ_WT_1_FG,
  T1.VJ_WT_2_FG
 FROM KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 AS T1_1
  INNER JOIN (SELECT T2.WUP_ID,
    T2.MANDANT_ID,
    T2.NB_ID
   FROM KFL_PRODUCTION_DBP_DATA.WUP_1 AS T2
    INNER JOIN KFL_PRODUCTION_DBP_ETL.VIS_MANDANT_1 AS T3 ON T2.MANDANT_ID = T3.MANDANT_ID
   WHERE T2.NB_ID IN (- 2, - 1, 0, 2, 7)
    AND T2.DAT_EROEFFNUNG > DATE '1900-01-01') AS dt1 ON TRUE);


-- 02.09.2021, -dbay-


--


-- Raus auf Wunsch des FABs!


--DELETE FROM KFL_PRODUCTION.DBP_ETL.dat_vj_vergleich_tmp_1


--WHERE akt_gj = -2


--;


-- t2.dat_eroeffnung > 101) dt1


INSERT INTO KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGL_ABSCHRIFT_1 (MANDANT_ID, WUP_ID, NB_ID, JOIN_DAT, DAT, GJ, KJWO, KJMO,
 MO_KJ, AKT_GJ, AKT_MO, AKT_WO, AKT_TAG, WTAG_ID, AKT_GJ_FG, VJ_1_FG, VJ_2_FG, VJ_WT_1_FG, VJ_WT_2_FG)
(SELECT dt1.MANDANT_ID,
  CAST(dt1.WUP_ID AS INTEGER) AS WUP_ID,
  CAST(dt1.NB_ID AS SMALLINT) AS NB_ID,
  T1.JOIN_DAT,
  T1.DAT,
  CAST(T1.GJ AS SMALLINT) AS GJ,
  T1.KJWO,
  T1.KJMO,
  T1.MO_KJ,
  CAST(T1.AKT_GJ AS SMALLINT) AS AKT_GJ,
  CAST(T1.AKT_MO AS SMALLINT) AS AKT_MO,
  CAST(T1.AKT_WO AS SMALLINT) AS AKT_WO,
  CAST(T1.AKT_TAG AS SMALLINT) AS AKT_TAG,
  T1.WTAG_ID,
  T1.AKT_GJ_FG,
  T1.VJ_1_FG,
  T1.VJ_2_FG,
  T1.VJ_WT_1_FG,
  T1.VJ_WT_2_FG
 FROM KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_TMP_1 AS T1_1
  INNER JOIN (SELECT WUP_ID,
    MANDANT_ID,
    NB_ID
   FROM KFL_PRODUCTION_DBP_DATA.WUP_1 AS T2
   WHERE NB_ID IN (- 2, - 1, 0, 2, 7)
    AND DAT_EROEFFNUNG > DATE '1900-01-01') AS dt1 ON TRUE);