CREATE OR REPLACE TABLE dbp_etl.wg_per_tmp LIKE dbp_data.wg_per;


CREATE OR REPLACE TABLE dbp_etl.owg_per_tmp LIKE dbp_data.owg_per;


CREATE OR REPLACE TABLE dbp_etl.hwg_per_tmp LIKE dbp_data.hwg_per;


CREATE OR REPLACE TABLE dbp_etl.abt_per_tmp LIKE dbp_data.abt_per;


CREATE OR REPLACE TABLE dbp_etl.wg_per_init (
mandant_id INTEGER,
wg_id INTEGER,
owg_id INTEGER,
hwg_id INTEGER,
abt_id INTEGER,
dat_von DATE,
dat_bis DATE
);


INSERT INTO dbp_etl.wg_per_init (mandant_id, wg_id, owg_id, hwg_id, abt_id, dat_von, dat_bis)
(SELECT WG.mandant_id,
  WG.wg_hierarchie_id AS wg_id,
  OWG.wg_hierarchie_id AS owg_id,
  HWG.wg_hierarchie_id AS hwg_id,
  ABT.wg_hierarchie_id AS abt_id,
  WG.dat_von,
  WG.dat_bis
 FROM dbp_data.wg_hierarchie_zu_per AS WG
  INNER JOIN dbp_data.wg_hierarchie_zu_per AS OWG ON WG.mandant_id = OWG.mandant_id AND WG.wg_hierarchie_mutter_id
        = OWG.wg_hierarchie_id AND WG.arthiertyp_id = OWG.arthiertyp_id AND OWG.wg_hierarchie_ebene_id = 4
     -- Oberwarengruppe
 AND OWG.dat_bis = PARSE_DATE('%F', '9999-12-31')
  INNER JOIN dbp_data.wg_hierarchie_zu_per AS HWG ON OWG.mandant_id = HWG.mandant_id AND OWG.wg_hierarchie_mutter_id
        = HWG.wg_hierarchie_id AND OWG.arthiertyp_id = HWG.arthiertyp_id AND HWG.wg_hierarchie_ebene_id = 3
     -- Hauptwarengruppe
 AND HWG.dat_bis = PARSE_DATE('%F', '9999-12-31')
  INNER JOIN dbp_data.wg_hierarchie_zu_per AS ABT ON HWG.mandant_id = ABT.mandant_id AND HWG.wg_hierarchie_mutter_id
        = ABT.wg_hierarchie_id AND HWG.arthiertyp_id = ABT.arthiertyp_id AND ABT.wg_hierarchie_ebene_id = 2
     -- Abteilung
 AND ABT.dat_bis = PARSE_DATE('%F', '9999-12-31')
 WHERE WG.arthiertyp_id = 10
  AND WG.wg_hierarchie_ebene_id = 5 -- Warengruppe

  AND WG.dat_bis = PARSE_DATE('%F', '9999-12-31'));


-- Falls Anzahl fuer verschiedenen MWST Saetze identisch,
 -- Ermittlung Lead Mwst ID

-- dann wird die maximale MWST genommen.
 INSERT INTO dbp_etl.wg_per_tmp (mandant_id, wg_id,
 arthiertyp_id, dat_von, lead_mwst_id, abt_id, dat_bis, owg_id)
(SELECT A.mandant_id,
  A.wg_id,
  2 AS arthiertyp_id,
  A.dat_von,
  COALESCE(l.lead_mwst_id, 0) AS lead_mwst_id,
  A.abt_id,
  A.dat_bis,
  A.owg_id
 FROM dbp_etl.wg_per_init AS A
  LEFT JOIN (SELECT A0.mandant_id,
    W.wg_id,
    A0.mwst_id AS lead_mwst_id,
    COUNT(*) AS zaehler_mwst,
    RANK() OVER (PARTITION BY A0.mandant_id, W.wg_id ORDER BY COUNT(*) IS NULL DESC, COUNT(*) DESC, A0.mwst_id IS NULL
       DESC, A0.mwst_id DESC) AS ranking
   FROM dbp_data.art AS A0
    INNER JOIN dbp_data.art_wg_zu_per AS W ON A0.mandant_id = W.mandant_id AND A0.art_id = W.art_id AND
       CURRENT_DATE("Europe/Berlin") BETWEEN W.dat_von AND W.dat_bis AND W.arthiertyp_id = 2
   GROUP BY A0.mandant_id,
    W.wg_id,
    lead_mwst_id
   QUALIFY (RANK() OVER (PARTITION BY A0.mandant_id, W.wg_id ORDER BY COUNT(*) IS NULL DESC, COUNT(*) DESC, A0.mwst_id
         IS NULL DESC, A0.mwst_id DESC)) = 1) AS l ON A.mandant_id = l.mandant_id AND A.wg_id = l.wg_id);


INSERT INTO dbp_etl.owg_per_tmp (owg_id, arthiertyp_id, mandant_id, dat_von, dat_bis, hwg_id,
 hr_objekt_bereich_id, hr_objekt_bereich_id_de)
(SELECT owg_id,
  2 AS arthiertyp_id,
  mandant_id,
  dat_von,
  dat_bis,
  hwg_id,
  - 1 AS hr_objekt_bereich_id,
  - 1 AS hr_objekt_bereich_id_de
 FROM dbp_etl.wg_per_init AS A
 GROUP BY owg_id,
  arthiertyp_id,
  mandant_id,
  dat_von,
  dat_bis,
  hwg_id,
  hr_objekt_bereich_id,
  hr_objekt_bereich_id_de);


INSERT INTO dbp_etl.hwg_per_tmp (arthiertyp_id, hwg_id, mandant_id, dat_von, dat_bis, abt_id,
 hr_objekt_bereich_id, hr_objekt_bereich_id_de)
(SELECT 2 AS arthiertyp_id,
  hwg_id,
  mandant_id,
  dat_von,
  dat_bis,
  abt_id,
  - 1 AS hr_objekt_bereich_id,
  - 1 AS hr_objekt_bereich_id_de
 FROM dbp_etl.wg_per_init AS A
 GROUP BY hwg_id,
  arthiertyp_id,
  mandant_id,
  dat_von,
  dat_bis,
  abt_id,
  hr_objekt_bereich_id,
  hr_objekt_bereich_id_de);


INSERT INTO dbp_etl.abt_per_tmp (abt_id, arthiertyp_id, mandant_id, dat_von, dat_bis)
(SELECT hwg_id,
  2 AS arthiertyp_id,
  mandant_id,
  dat_von,
  dat_bis
 FROM dbp_etl.wg_per_init AS A
 GROUP BY hwg_id,
  arthiertyp_id,
  mandant_id,
  dat_von,
  dat_bis);


DELETE FROM dbp_etl.wg_per_tmp
WHERE wg_id = 961;


-- WG_PER --


DELETE FROM dbp_etl.wg_per_tmp AS T
WHERE EXISTS (SELECT *
 FROM dbp_data.wg_per
 WHERE T.mandant_id = mandant_id
  AND T.wg_id = wg_id
  AND T.arthiertyp_id = arthiertyp_id
  AND T.dat_von < dat_von);


DELETE FROM dbp_data.wg_per AS P
WHERE EXISTS (SELECT *
 FROM dbp_etl.wg_per_tmp
 WHERE P.mandant_id = mandant_id
  AND P.wg_id = wg_id
  AND P.arthiertyp_id = arthiertyp_id
  AND P.dat_von = dat_von
  AND CASE
    WHEN COALESCE(P.abt_id, 0) <> COALESCE(abt_id, 0) OR COALESCE(P.lead_mwst_id, 0) <> COALESCE(lead_mwst_id, 0) OR
      COALESCE(P.owg_id, 0) <> COALESCE(owg_id, 0)
    THEN 1
    ELSE 0
    END = 1);


/* Update */ /* neuer Fachschluessel */ INSERT INTO dbp_data.wg_per (mandant_id, wg_id, arthiertyp_id,
 dat_von, lead_mwst_id, abt_id, dat_bis, owg_id)
(SELECT T.mandant_id,
  T.wg_id,
  T.arthiertyp_id,
  T.dat_von,
  T.lead_mwst_id,
  T.abt_id,
  T.dat_bis,
  T.owg_id
 FROM dbp_etl.wg_per_tmp AS T
  LEFT JOIN dbp_data.wg_per AS P ON T.mandant_id = P.mandant_id AND T.wg_id = P.wg_id AND T.arthiertyp_id
      = P.arthiertyp_id AND P.dat_bis = PARSE_DATE('%F', '9999-12-31')
 WHERE P.mandant_id IS NULL
  OR CASE
    WHEN P.mandant_id IS NOT NULL AND (COALESCE(T.abt_id, 0) <> COALESCE(P.abt_id, 0) OR COALESCE(T.lead_mwst_id, 0) <>
         COALESCE(P.lead_mwst_id, 0) OR COALESCE(T.owg_id, 0) <> COALESCE(P.owg_id, 0))
    THEN 1
    ELSE 0
    END = 1);


UPDATE dbp_data.wg_per AS wg_per0 SET
 dat_bis = dt.dat_bis_ FROM (SELECT mandant_id,
   wg_id,
   arthiertyp_id,
   dat_von,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wg_id,
          arthiertyp_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
       , 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wg_id, arthiertyp_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
          )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL - 1 DAY)
    END AS dat_bis_
  FROM dbp_data.wg_per
  WHERE arthiertyp_id = 2
   AND owg_id <> - 1) AS dt
WHERE wg_per0.mandant_id = dt.mandant_id AND wg_per0.wg_id = dt.wg_id AND wg_per0.arthiertyp_id = dt.arthiertyp_id AND
   wg_per0.dat_von = dt.dat_von AND wg_per0.dat_bis <> dt.dat_bis_;


-- OWG_PER --


DELETE FROM dbp_etl.owg_per_tmp AS T
WHERE EXISTS (SELECT *
 FROM dbp_data.owg_per
 WHERE T.mandant_id = mandant_id
  AND T.owg_id = owg_id
  AND T.arthiertyp_id = arthiertyp_id
  AND T.dat_von < dat_von);


INSERT INTO dbp_data.owg_per (owg_id, arthiertyp_id, mandant_id, dat_von, dat_bis, hwg_id,
 hr_objekt_bereich_id, hr_objekt_bereich_id_de)
(SELECT T.owg_id,
  T.arthiertyp_id,
  T.mandant_id,
  CURRENT_DATE("Europe/Berlin") AS dat_von,
  T.dat_bis,
  T.hwg_id,
  T.hr_objekt_bereich_id,
  T.hr_objekt_bereich_id_de
 FROM dbp_etl.owg_per_tmp AS T
  LEFT JOIN dbp_data.owg_per AS P ON T.mandant_id = P.mandant_id AND T.owg_id = P.owg_id AND T.arthiertyp_id
      = P.arthiertyp_id AND P.dat_bis = DATE '9999-12-31'
 WHERE P.mandant_id IS NULL
  OR CASE
    WHEN P.mandant_id IS NOT NULL AND COALESCE(T.hwg_id, 0) <> COALESCE(P.hwg_id, 0)
    THEN 1
    ELSE 0
    END = 1);


UPDATE dbp_data.owg_per AS owg_per0 SET
 dat_bis = dt.dat_bis_ FROM (SELECT mandant_id,
   owg_id,
   arthiertyp_id,
   dat_von,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, owg_id,
          arthiertyp_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
       , 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, owg_id, arthiertyp_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
          )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL - 1 DAY)
    END AS dat_bis_
  FROM dbp_data.owg_per
  WHERE arthiertyp_id = 2
   AND hwg_id <> - 1) AS dt
WHERE owg_per0.mandant_id = dt.mandant_id AND owg_per0.owg_id = dt.owg_id AND owg_per0.arthiertyp_id = dt.arthiertyp_id
  AND owg_per0.dat_von = dt.dat_von AND owg_per0.dat_bis <> dt.dat_bis_;


-- HWG_PER --


DELETE FROM dbp_etl.hwg_per_tmp AS T
WHERE EXISTS (SELECT *
 FROM dbp_data.hwg_per
 WHERE T.mandant_id = mandant_id
  AND T.hwg_id = hwg_id
  AND T.arthiertyp_id = arthiertyp_id
  AND T.dat_von < dat_von);


INSERT INTO dbp_data.hwg_per (arthiertyp_id, hwg_id, mandant_id, dat_von, dat_bis, abt_id,
 hr_objekt_bereich_id, hr_objekt_bereich_id_de)
(SELECT T.arthiertyp_id,
  T.hwg_id,
  T.mandant_id,
  CURRENT_DATE("Europe/Berlin") AS dat_von,
  T.dat_bis,
  T.abt_id,
  T.hr_objekt_bereich_id,
  T.hr_objekt_bereich_id_de
 FROM dbp_etl.hwg_per_tmp AS T
  LEFT JOIN dbp_data.hwg_per AS P ON T.mandant_id = P.mandant_id AND T.hwg_id = P.hwg_id AND T.arthiertyp_id
      = P.arthiertyp_id AND P.dat_bis = DATE '9999-12-31'
 WHERE P.mandant_id IS NULL
  OR CASE
    WHEN P.mandant_id IS NOT NULL AND COALESCE(T.abt_id, 0) <> COALESCE(P.abt_id, 0)
    THEN 1
    ELSE 0
    END = 1);


UPDATE dbp_data.hwg_per AS hwg_per0 SET
 dat_bis = dt.dat_bis_ FROM (SELECT mandant_id,
   hwg_id,
   arthiertyp_id,
   dat_von,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, hwg_id,
          arthiertyp_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
       , 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, hwg_id, arthiertyp_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
          )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL - 1 DAY)
    END AS dat_bis_
  FROM dbp_data.hwg_per
  WHERE arthiertyp_id = 2
   AND abt_id <> - 1) AS dt
WHERE hwg_per0.mandant_id = dt.mandant_id AND hwg_per0.hwg_id = dt.hwg_id AND hwg_per0.arthiertyp_id = dt.arthiertyp_id
  AND hwg_per0.dat_von = dt.dat_von AND hwg_per0.dat_bis <> dt.dat_bis_;


INSERT INTO dbp_data.abt (abt_id, arthiertyp_id, mandant_id)
(SELECT wg_hierarchie_id AS abt_id,
  2 AS arthiertyp_id,
  mandant_id
 FROM dbp_data.wg_hierarchie_zu_per
 WHERE arthiertyp_id = 6
  AND wg_hierarchie_ebene_id = 2 /* Abteilung */
  AND dat_bis = PARSE_DATE('%F', '9999-12-31')
  AND wg_hierarchie_id >= 0
  AND (mandant_id, wg_hierarchie_id, 2) NOT IN (SELECT (mandant_id, abt_id, arthiertyp_id)
    FROM dbp_data.abt
    WHERE arthiertyp_id = 2));


DELETE FROM dbp_data.abt_spr_zu
WHERE (mandant_id, abt_id, arthiertyp_id, spr_id) IN (SELECT (A.mandant_id, A.wg_hierarchie_id, 2, A.spr_id)
  FROM dbp_data.wg_hierarchie_spr_zu AS A
   INNER JOIN dbp_data.abt AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.abt_id
  WHERE A.arthiertyp_id = 10
   AND A.wg_hierarchie_ebene_id = 2 /* Abteilung */
   AND A.wg_hierarchie_id >= 0);


INSERT INTO dbp_data.abt_spr_zu (abt_id, arthiertyp_id, spr_id, mandant_id, abt_bez)
(SELECT A.wg_hierarchie_id AS abt_id,
  2 AS arthiertyp_id,
  A.spr_id,
  A.mandant_id,
  A.wg_hierarchie_bez
 FROM dbp_data.wg_hierarchie_spr_zu AS A
  INNER JOIN dbp_data.abt AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.abt_id
 WHERE A.arthiertyp_id = 10
  AND A.wg_hierarchie_ebene_id = 2 /* Abteilung */
  AND A.wg_hierarchie_id >= 0);


UPDATE dbp_data.abt_spr_zu SET
 abt_bez = s.ro_abt_bez,
 td_update = CURRENT_TIMESTAMP() FROM (SELECT A.abt_id,
   A.spr_id,
   A.arthiertyp_id,
   B.abt_bez AS ro_abt_bez
  FROM dbp_data.abt_spr_zu AS A
   INNER JOIN dbp_data.abt_spr_zu AS B ON A.abt_id = B.abt_id AND A.arthiertyp_id = B.arthiertyp_id AND A
     .spr_id = B.spr_id
  WHERE A.mandant_id = 4
   AND A.spr_id <> 22
   AND B.mandant_id = 7
   AND B.spr_id <> 22
   AND A.abt_bez <> B.abt_bez
  GROUP BY A.abt_id,
   A.spr_id,
   A.arthiertyp_id,
   ro_abt_bez) AS s
WHERE abt_spr_zu.mandant_id = 4 AND abt_spr_zu.abt_id = s.abt_id AND abt_spr_zu.arthiertyp_id = s.arthiertyp_id AND
   abt_spr_zu.spr_id = s.spr_id AND abt_spr_zu.abt_bez <> s.ro_abt_bez;


DELETE FROM dbp_data.hwg_spr_zu
WHERE (mandant_id, hwg_id, arthiertyp_id, spr_id) IN (SELECT (A.mandant_id, A.wg_hierarchie_id, 2, A.spr_id)
  FROM dbp_data.wg_hierarchie_spr_zu AS A
   INNER JOIN dbp_data.hwg_per AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.hwg_id AND
     B.dat_bis = PARSE_DATE('%F', '9999-12-31')
  WHERE A.arthiertyp_id = 10
   AND A.wg_hierarchie_ebene_id = 3 /* HWG */
   AND A.wg_hierarchie_id >= 0);


INSERT INTO dbp_data.hwg_spr_zu (hwg_id, arthiertyp_id, mandant_id, spr_id, hwg_bez)
(SELECT A.wg_hierarchie_id AS wg_id,
  2 AS arthiertyp_id,
  A.mandant_id,
  A.spr_id,
  A.wg_hierarchie_bez AS hwg_bez
 FROM dbp_data.wg_hierarchie_spr_zu AS A
  INNER JOIN dbp_data.hwg_per AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.hwg_id AND B
    .dat_bis = PARSE_DATE('%F', '9999-12-31')
 WHERE A.arthiertyp_id = 10
  AND A.wg_hierarchie_ebene_id = 3 /* HWG */
  AND A.wg_hierarchie_id >= 0);


UPDATE dbp_data.hwg_spr_zu SET
 hwg_bez = s.ro_hwg_bez,
 td_update = CURRENT_TIMESTAMP() FROM (SELECT A.hwg_id,
   A.spr_id,
   A.arthiertyp_id,
   B.hwg_bez AS ro_hwg_bez
  FROM dbp_data.hwg_spr_zu AS A
   INNER JOIN dbp_data.hwg_spr_zu AS B ON A.hwg_id = B.hwg_id AND A.arthiertyp_id = B.arthiertyp_id AND A
     .spr_id = B.spr_id
  WHERE A.mandant_id = 4
   AND A.spr_id <> 22
   AND B.mandant_id = 7
   AND B.spr_id <> 22
   AND A.hwg_bez <> B.hwg_bez
  GROUP BY A.hwg_id,
   A.spr_id,
   A.arthiertyp_id,
   ro_hwg_bez) AS s
WHERE hwg_spr_zu.mandant_id = 4 AND hwg_spr_zu.hwg_id = s.hwg_id AND hwg_spr_zu.arthiertyp_id = s.arthiertyp_id AND
   hwg_spr_zu.spr_id = s.spr_id AND hwg_spr_zu.hwg_bez <> s.ro_hwg_bez;


DELETE FROM dbp_data.owg_spr_zu
WHERE (mandant_id, owg_id, arthiertyp_id, spr_id) IN (SELECT (A.mandant_id, A.wg_hierarchie_id, 2, A.spr_id)
  FROM dbp_data.wg_hierarchie_spr_zu AS A
   INNER JOIN dbp_data.owg_per AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.owg_id AND
     B.dat_bis = PARSE_DATE('%F', '9999-12-31')
  WHERE A.arthiertyp_id = 10
   AND A.wg_hierarchie_ebene_id = 4 /* OWG */
   AND A.wg_hierarchie_id >= 0);


INSERT INTO dbp_data.owg_spr_zu (owg_id, arthiertyp_id, mandant_id, spr_id, owg_bez)
(SELECT A.wg_hierarchie_id AS owg_id,
  2 AS arthiertyp_id,
  A.mandant_id,
  A.spr_id,
  A.wg_hierarchie_bez AS owg_bez
 FROM dbp_data.wg_hierarchie_spr_zu AS A
  INNER JOIN dbp_data.owg_per AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.owg_id AND B
    .dat_bis = PARSE_DATE('%F', '9999-12-31')
 WHERE A.arthiertyp_id = 10
  AND A.wg_hierarchie_ebene_id = 4 /* OWG */
  AND A.wg_hierarchie_id >= 0);


UPDATE dbp_data.owg_spr_zu SET
 owg_bez = s.ro_owg_bez,
 td_update = CURRENT_TIMESTAMP() FROM (SELECT A.owg_id,
   A.spr_id,
   A.arthiertyp_id,
   B.owg_bez AS ro_owg_bez
  FROM dbp_data.owg_spr_zu AS A
   INNER JOIN dbp_data.owg_spr_zu AS B ON A.owg_id = B.owg_id AND A.arthiertyp_id = B.arthiertyp_id AND A
     .spr_id = B.spr_id
  WHERE A.mandant_id = 4
   AND A.spr_id <> 22
   AND B.mandant_id = 7
   AND B.spr_id <> 22
   AND A.owg_bez <> B.owg_bez
  GROUP BY A.owg_id,
   A.spr_id,
   A.arthiertyp_id,
   ro_owg_bez) AS s
WHERE owg_spr_zu.mandant_id = 4 AND owg_spr_zu.owg_id = s.owg_id AND owg_spr_zu.arthiertyp_id = s.arthiertyp_id AND
   owg_spr_zu.spr_id = s.spr_id AND owg_spr_zu.owg_bez <> s.ro_owg_bez;


DELETE FROM dbp_data.wg_spr_zu
WHERE (mandant_id, wg_id, arthiertyp_id, spr_id) IN (SELECT (mandant_id, wg_hierarchie_id, 2, spr_id)
  FROM dbp_data.wg_hierarchie_spr_zu
  WHERE arthiertyp_id = 10
   AND wg_hierarchie_ebene_id = 5 /* Warengruppe */
   AND wg_hierarchie_id >= 0);


INSERT INTO dbp_data.wg_spr_zu (wg_id, arthiertyp_id, mandant_id, spr_id, wg_bez)
(SELECT A.wg_hierarchie_id AS wg_id,
  2 AS arthiertyp_id,
  A.mandant_id,
  A.spr_id,
  A.wg_hierarchie_bez AS wg_bez
 FROM dbp_data.wg_hierarchie_spr_zu AS A
  INNER JOIN dbp_data.wg_per AS B ON A.mandant_id = B.mandant_id AND A.wg_hierarchie_id = B.wg_id AND B.dat_bis
     = PARSE_DATE('%F', '9999-12-31')
 WHERE A.arthiertyp_id = 10
  AND A.wg_hierarchie_ebene_id = 5 /* Warengruppe */
  AND A.wg_hierarchie_id >= 0);


UPDATE dbp_data.wg_spr_zu SET
 wg_bez = s.ro_wg_bez,
 td_update = CURRENT_TIMESTAMP() FROM (SELECT A.wg_id,
   A.spr_id,
   A.arthiertyp_id,
   B.wg_bez AS ro_wg_bez
  FROM dbp_data.wg_spr_zu AS A
   INNER JOIN dbp_data.wg_spr_zu AS B ON A.wg_id = B.wg_id AND A.arthiertyp_id = B.arthiertyp_id AND A.spr_id
      = B.spr_id
  WHERE A.mandant_id = 4
   AND A.spr_id <> 22
   AND B.mandant_id = 7
   AND B.spr_id <> 22
   AND A.wg_bez <> B.wg_bez
  GROUP BY A.wg_id,
   A.spr_id,
   A.arthiertyp_id,
   ro_wg_bez) AS s
WHERE wg_spr_zu.mandant_id = 4 AND wg_spr_zu.wg_id = s.wg_id AND wg_spr_zu.arthiertyp_id = s.arthiertyp_id AND wg_spr_zu
   .spr_id = s.spr_id AND wg_spr_zu.wg_bez <> s.ro_wg_bez;


UPDATE dbp_data.wg_spr_zu SET
 wg_bez = b.wg_bez FROM dbp_etl_process.wg_spr_zu_korrektur AS b
WHERE wg_spr_zu.mandant_id = b.mandant_id AND wg_spr_zu.wg_id = b.wg_id AND wg_spr_zu.spr_id = b.spr_id;


UPDATE dbp_data.owg_spr_zu SET
 owg_bez = b.owg_bez FROM dbp_etl_process.owg_spr_zu_korrektur AS b
WHERE owg_spr_zu.mandant_id = b.mandant_id AND owg_spr_zu.owg_id = b.owg_id AND owg_spr_zu.spr_id = b.spr_id;


UPDATE dbp_data.wg_per SET
 dat_bis = DATE('2024-11-30'),
 werbeteam_cd = 'nicht vorhanden'
WHERE wg_id = 961 AND dat_bis = DATE '9999-12-31';