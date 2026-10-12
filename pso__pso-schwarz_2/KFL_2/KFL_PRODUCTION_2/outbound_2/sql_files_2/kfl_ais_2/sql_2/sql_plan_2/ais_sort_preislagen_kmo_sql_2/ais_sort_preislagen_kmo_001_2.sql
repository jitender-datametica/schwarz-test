CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen_2
WHERE dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _sal_1 AS
SELECT A.mandant_id,
 A.art_id,
 A.kjmo,
 A.wrg_id,
 A.arthiertyp_id,
 A.wg_id,
 A.wug_id,
 A.art_status,
 A.gp_id,
 A.gp_name,
 A.zek_id,
 A.eigenmarke_id,
 A.bio_fg,
 A.vegan_fg,
 A.posten_food,
 A.posten_nonfood,
 A.gluten_fg,
 A.mwst,
 A.disc_pe,
 A.disc_marke,
 A.lactose_fg,
 A.k_listung,
 A.umrech_faktor_best,
 A.umrech_faktor_ausg,
 A.mhd_zeitraum,
 A.mhd_zeitraum_dz,
 A.k1_artbew_menge,
 A.k1_anz_kjwo_wug_absatz,
 A.k2_artbew_menge,
 A.k2_anz_kjwo_wug_absatz,
 A.k3_artbew_menge,
 A.k3_anz_kjwo_wug_absatz,
 A.k4_artbew_menge,
 A.k4_anz_kjwo_wug_absatz,
 A.k5_artbew_menge,
 A.k5_anz_kjwo_wug_absatz,
 A.total_artbew_menge,
 A.total_anz_kjwo_wug_absatz,
 A.total_artbew_menge_vj,
 A.total_artbew_menge_sa,
 A.total_anz_kjwo_wug_absatz_sa,
 A.total_anz_tage_wug_absatz_sa,
 A.total_artbew_menge_af,
 A.total_anz_kjwo_wug_absatz_af,
 A.schnelldreherquote,
 A.prozentual_absatz_sa,
 A.total_rohertrag,
 A.total_rohertrag_vj,
 A.total_rohertrag_af,
 A.total_rohertrag_sa,
 A.rohertrag_einheit,
 A.rohertrag_einheit_af,
 A.rohertrag_einheit_sa,
 A.abschriftbetrag_netto_owerbung,
 A.ek_kb_stamm,
 A.vk_brutto_pk1,
 A.vk_brutto_pk4,
 A.vk_netto_pk1,
 A.vk_netto_pk4,
 A.total_umsatz_netto,
 A.total_umsatz_netto_af,
 A.total_umsatz_netto_sa,
 A.total_anz_markt,
 A.anz_kjwo_wup_listung,
 A.anz_wup_listung,
 A.lager_prozent,
 A.kol_la_bzw,
 A.kol_bst_bzw,
 A.spanne_ek1,
 A.spanne_ek4,
 A.td_update,
 A.td_insert,
 COALESCE(1 + IF(C.mwst = 0, NULL, C.mwst) / 100.0000, 1.19) AS multi_mwst,
 COALESCE(X.ksm_id, '') AS ksm_id
FROM dbp_data.sal_kmo_2 AS A
 INNER JOIN dbp_data.art_2 AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.dat_bis =
   PARSE_DATE('%F', '9999-12-31')
 INNER JOIN dbp_data.mwst_per_2 AS C ON A.mandant_id = C.mandant_id AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND
    C.dat_bis AND B.mwst_id = C.mwst_id
 LEFT JOIN dbp_etl_process.art_sm_vw_zu_per_2 AS X ON A.mandant_id = X.mandant_id AND A.art_id = X.art_id
  AND CURRENT_DATE("Europe/Berlin") BETWEEN X.dat_von AND X.dat_bis
WHERE B.artikeltyp_id <> 12
 AND CASE
   WHEN A.mandant_id = 3 AND TRIM(A.eigenmarke_id) = '' OR A.mandant_id <> 3
   THEN 1
   ELSE 0
   END = 1
 AND A.mandant_id = ${mandant_id}
 AND A.kjmo IN (SELECT MAX(kjmo) AS kjmo
   FROM dbp_data.art_nielsen_fakten_kjmo_2
   WHERE mandant_id = ${mandant_id})
 AND TRIM(A.art_status) NOT IN ('L', 'R');


CREATE OR REPLACE TEMPORARY TABLE _sal_2 AS
SELECT A.mandant_id,
 A.kjmo,
 B.art_matching_id,
 A.art_id,
 TRIM(A.k_listung) AS k_listung,
 TRIM(A.ksm_id) AS ksm_id,
 A.vk_brutto_pk1 AS vk_pk_1,
 0 AS kl_art_kat_id,
 B.kl_wg_id,
 B.kl_owg_id,
 B.kl_uwg_id,
  COALESCE(A.total_umsatz_netto, 0) * A.multi_mwst AS umsatz_brutto,
  COALESCE(A.total_umsatz_netto_af, 0) * A.multi_mwst AS umsatz_brutto_af,
  COALESCE(A.total_umsatz_netto_sa, 0) * A.multi_mwst AS umsatz_brutto_sa,
 COALESCE(A.total_artbew_menge, 0) AS menge,
 COALESCE(A.total_artbew_menge_af, 0) AS menge_af,
 COALESCE(A.total_artbew_menge_sa, 0) AS menge_sa,
 COUNT(A.art_id) OVER (PARTITION BY B.art_matching_id ORDER BY A.art_id IS NULL, A.art_id RANGE BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_artikel
FROM `_sal_1` AS A
 INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_2 AS B ON A.art_id = B.art_id AND A.mandant_id = B.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_3 AS
SELECT mandant_id,
 kjmo,
 art_matching_id,
 MAX(kl_art_kat_id) AS kl_art_kat_id,
 MAX(kl_wg_id) AS kl_wg_id,
 MAX(kl_owg_id) AS kl_owg_id,
 MAX(kl_uwg_id) AS kl_uwg_id,
 MAX(CASE
   WHEN k_listung = 'N/A'
   THEN ''
   ELSE k_listung
   END) AS k_listung,
 MAX(ksm_id) AS ksm_id,
 AVG(vk_pk_1) AS vk_pk_1,
 SUM(umsatz_brutto) AS umsatz_brutto,
 SUM(umsatz_brutto_af) AS umsatz_brutto_af,
 SUM(umsatz_brutto_sa) AS umsatz_brutto_sa,
 SUM(menge) AS menge,
 SUM(menge_af) AS menge_af,
 SUM(menge_sa) AS menge_sa,
 MAX(anz_artikel) AS anz_artikel
FROM `_sal_2`
GROUP BY mandant_id,
 kjmo,
 art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _chk AS
SELECT 1 AS k;


INSERT INTO `_chk` (k)
VALUES (2);


INSERT INTO `_chk` (k)
VALUES (3);


INSERT INTO `_chk` (k)
VALUES (4);


INSERT INTO `_chk` (k)
VALUES (5);


CREATE OR REPLACE TEMPORARY TABLE _chk2 AS
SELECT 1 AS k;


INSERT INTO `_chk2` (k)
VALUES (2);


INSERT INTO `_chk2` (k)
VALUES (3);


INSERT INTO `_chk2` (k)
VALUES (4);


INSERT INTO `_chk2` (k)
VALUES (5);


INSERT INTO `_chk2` (k)
VALUES (6);


INSERT INTO `_chk2` (k)
VALUES (7);


INSERT INTO `_chk2` (k)
VALUES (8);


INSERT INTO `_chk2` (k)
VALUES (9);


DELETE FROM dbp_data.art_kl_preislage_zu_per_2
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT kjwo
   FROM dbp_data.woche_2
   WHERE akt_wo = 1);


INSERT INTO dbp_data.art_kl_preislage_zu_per_2 (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
 sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT A.mandant_id,
  A.art_matching_id,
  A.kjmo,
  Z.kjwo AS kjwo_update,
  B.default_wrg AS wrg_id,
   CASE
   WHEN A.k_listung = ''
   THEN 'N/A'
   ELSE A.k_listung
   END AS sm_id,
  A.ksm_id,
  A.kl_wg_id AS owg_id,
  A.kl_owg_id AS wg_id,
  A.kl_uwg_id AS wug_id,
  A.vk_pk_1 AS vk_brutto_pk_1,
   CASE
   WHEN A.umsatz_brutto_af > 0 AND A.menge_af <> 0
   THEN A.umsatz_brutto_af / IF(A.menge_af = 0, NULL, A.menge_af)
   WHEN A.umsatz_brutto_af = 0 AND A.umsatz_brutto_sa > 0 AND A.menge_sa <> 0
   THEN A.umsatz_brutto_sa / IF(A.menge_sa = 0, NULL, A.menge_sa)
   ELSE IFNULL(A.umsatz_brutto / IF(A.menge = 0, NULL, A.menge), 0)
   END AS durchschnitt_preis_kasse,
  CAST(A.umsatz_brutto AS NUMERIC) AS umsatz_brutto,
  CAST(A.umsatz_brutto_af AS NUMERIC) AS umsatz_brutto_af,
  CAST(A.umsatz_brutto_sa AS NUMERIC) AS umsatz_brutto_sa,
  A.menge,
  A.menge_af,
  A.menge_sa
 FROM `_sal_3` AS A
  INNER JOIN dbp_data.mandant_2 AS B ON A.mandant_id = B.mandant_id
  INNER JOIN dbp_data.woche_2 AS Z ON TRUE
 WHERE A.umsatz_brutto > 0
  AND A.menge > 0
  AND Z.akt_wo = 1);


INSERT INTO dbp_data.art_kl_preislage_zu_per_2 (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
 sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT A.mandant_id,
  A.art_matching_id,
  A.kjmo,
  A.kjwo_update,
  A.wrg_id,
  CAST(B.k AS STRING) AS sm_id,
  A.ksm_id,
  A.owg_id,
  A.wg_id,
  A.wug_id,
  A.vk_brutto_pk_1,
  A.durchschnitt_preis_kasse,
  A.umsatz_brutto,
  A.umsatz_brutto_af,
  A.umsatz_brutto_sa,
  A.menge,
  A.menge_af,
  A.menge_sa
 FROM dbp_data.art_kl_preislage_zu_per_2 AS A
  INNER JOIN `_chk` AS B ON ROUND(CAST(A.sm_id AS BIGNUMERIC), 0) < B.k
 WHERE A.mandant_id = ${mandant_id}
  AND A.sm_id NOT IN ('N/A', '-1')
  AND (A.mandant_id, A.art_matching_id, A.kjmo, CAST(B.k AS BIGNUMERIC), A.kjwo_update) NOT IN (SELECT (mandant_id,
      art_matching_id, kjmo, ROUND(CAST(sm_id AS BIGNUMERIC), 0), kjwo_update)
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = ${mandant_id}
     AND sm_id NOT IN ('N/A', '-1')));


INSERT INTO dbp_data.art_kl_preislage_zu_per_2 (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
 sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT A.mandant_id,
  A.art_matching_id,
  A.kjmo,
  A.kjwo_update,
  A.wrg_id,
  A.sm_id,
   'K' || CAST(B.k AS STRING) AS ksm_id,
  A.owg_id,
  A.wg_id,
  A.wug_id,
  A.vk_brutto_pk_1,
  A.durchschnitt_preis_kasse,
  A.umsatz_brutto,
  A.umsatz_brutto_af,
  A.umsatz_brutto_sa,
  A.menge,
  A.menge_af,
  A.menge_sa
 FROM dbp_data.art_kl_preislage_zu_per_2 AS A
  INNER JOIN `_chk2` AS B ON ROUND(CAST(SUBSTR(A.ksm_id, 2, 1) AS BIGNUMERIC), 0) < B.k
 WHERE A.mandant_id = ${mandant_id}
  AND A.sm_id NOT IN ('N/A', '-1')
  AND (A.mandant_id, A.art_matching_id, A.kjmo, CAST(B.k AS BIGNUMERIC), A.kjwo_update) NOT IN (SELECT (mandant_id,
      art_matching_id, kjmo, ROUND(SAFE_CAST(SUBSTR(ksm_id, 2, 1) AS BIGNUMERIC), 0), kjwo_update)
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE ksm_id IS NOT NULL
     AND mandant_id = ${mandant_id}));


DELETE FROM dbp_data.art_kl_preislage_zu_per_neu_2
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT kjwo
   FROM dbp_data.woche_2
   WHERE akt_wo = 1);


INSERT INTO dbp_data.art_kl_preislage_zu_per_neu_2 (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id
 , sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT mandant_id,
  art_matching_id,
  kjmo,
  kjwo_update,
  wrg_id,
  sm_id,
  ksm_id,
  owg_id,
  wg_id,
  wug_id,
  vk_brutto_pk_1,
  durchschnitt_preis_kasse,
  umsatz_brutto,
  umsatz_brutto_af,
  umsatz_brutto_sa,
  menge,
  menge_af,
  menge_sa
 FROM dbp_data.art_kl_preislage_zu_per_2
 WHERE (mandant_id, kjmo) IN (SELECT (mandant_id, kjmo)
    FROM `_sal_3`)
  AND mandant_id = ${mandant_id}
  AND kjwo_update IN (SELECT kjwo
    FROM dbp_data.woche_2
    WHERE akt_wo = 1));


CREATE OR REPLACE TEMPORARY TABLE _nielsen_preise_1 AS
SELECT A.mandant_id,
 C.art_matching_id,
 MAX(0) AS kl_art_kat_id,
 MAX(C.kl_wg_id) AS kl_wg_id,
 MAX(C.kl_owg_id) AS kl_owg_id,
 MAX(C.kl_uwg_id) AS kl_uwg_id,
 SUM(A.menge) AS menge,
 SUM(A.menge_af) AS menge_af,
 SUM(A.menge_sa) AS menge_sa,
 SUM(A.umsatz_brutto) AS umsatz_brutto,
 SUM(A.umsatz_brutto_af) AS umsatz_brutto_af,
 SUM(A.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM dbp_data.art_nielsen_fakten_kjmo_2 AS A
 INNER JOIN `_art_nielsen` AS B ON A.art_nielsen_id = B.art_nielsen_id AND A.mandant_id = B.mandant_id
 INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_2 AS C ON B.art_nielsen_id = C.art_nielsen_id AND B.mandant_id
    = C.mandant_id
 INNER JOIN dbp_data.nielsen_market_2 AS D ON A.mandant_id = D.mandant_id AND A.nielsen_market_id = D.nielsen_market_id
   
WHERE A.kjmo IN (SELECT kjmo
   FROM dbp_data.art_nielsen_fakten_kjmo_2
   WHERE mandant_id = ${mandant_id}
   GROUP BY kjmo
   QUALIFY ((RANK() OVER (ORDER BY kjmo IS NULL DESC, kjmo DESC)) * - 1) BETWEEN - 12 AND (- 1))
 AND A.mandant_id = ${mandant_id}
 AND D.nielsen_market_cluster_id = 1
GROUP BY A.mandant_id,
 C.art_matching_id;


DELETE FROM dbp_data.art_nielsen_preislage_zu_per_2
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
   FROM dbp_data.art_nielsen_fakten_kjmo_2
   WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id};


INSERT INTO dbp_data.art_nielsen_preislage_zu_per_2 (mandant_id, art_matching_id, kjmo, wrg_id,
 kl_art_kat_id, kl_wg_id, kl_owg_id, kl_uwg_id, hwg_id, owg_id, wg_id, wug_id, durchschnitt_preis_kasse, umsatz_brutto,
 umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT A.mandant_id,
  A.art_matching_id,
  x.kjmo,
  C.default_wrg AS wrg_id,
  A.kl_art_kat_id,
  A.kl_wg_id,
  A.kl_owg_id,
  A.kl_uwg_id,
  A.kl_art_kat_id AS hwg_id,
  A.kl_wg_id AS owg_id,
  A.kl_owg_id AS wg_id,
  A.kl_uwg_id AS wug_id,
   A.umsatz_brutto / IF(A.menge = 0, NULL, A.menge) AS durchschnitt_preis_kasse,
  A.umsatz_brutto,
  A.umsatz_brutto_af,
  A.umsatz_brutto_sa,
  A.menge,
  A.menge_af,
  A.menge_sa
 FROM `_nielsen_preise_1` AS A
  INNER JOIN dbp_data.mandant_2 AS C ON A.mandant_id = C.mandant_id
  INNER JOIN (SELECT MAX(kjmo) AS kjmo
   FROM dbp_data.art_nielsen_fakten_kjmo_2
   WHERE mandant_id = ${mandant_id}) AS x ON TRUE
 WHERE A.umsatz_brutto > 0
  AND A.menge > 0);


UPDATE dbp_data.art_kl_preislage_zu_per_2 SET
 sm_id = 'N/A'
WHERE sm_id = '-1';


INSERT INTO dbp_data.art_kl_preislage_zu_per_2 (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id,
 sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT P.mandant_id,
  P.art_matching_id,
  P.kjmo,
  P.kjwo_update,
  k.nach_wrg_id AS wrg_id,
  P.sm_id,
  P.ksm_id,
  P.owg_id,
  P.wg_id,
  P.wug_id,
  CAST(P.vk_brutto_pk_1 * k.umrechnungskurs AS NUMERIC),
   P.durchschnitt_preis_kasse * k.umrechnungskurs,
   P.umsatz_brutto * k.umrechnungskurs,
   P.umsatz_brutto_af * k.umrechnungskurs,
   P.umsatz_brutto_sa * k.umrechnungskurs,
  P.menge,
  P.menge_af,
  P.menge_sa
 FROM dbp_data.art_kl_preislage_zu_per_2 AS P
  INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    MAX(umrechnungskurs) AS umrechnungskurs
   FROM dbp_data.kurs_2
   WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
   GROUP BY von_wrg_id,
    nach_wrg_id) AS k ON P.wrg_id = k.von_wrg_id AND k.nach_wrg_id = 'EUR'
 WHERE P.kjmo IN (SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id})
  AND P.mandant_id = ${mandant_id}
  AND P.mandant_id IN (2, 3, 4, 6, 7, 8)
  AND P.kjwo_update IN (SELECT kjwo
    FROM dbp_data.woche_2
    WHERE akt_wo = 1));


INSERT INTO dbp_data.art_nielsen_preislage_zu_per_2 (mandant_id, art_matching_id, kjmo, wrg_id,
 kl_art_kat_id, kl_wg_id, kl_owg_id, kl_uwg_id, hwg_id, owg_id, wg_id, wug_id, durchschnitt_preis_kasse, umsatz_brutto,
 umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa)
(SELECT P.mandant_id,
  P.art_matching_id,
  P.kjmo,
  k.nach_wrg_id AS wrg_id,
  P.kl_art_kat_id,
  P.kl_wg_id,
  P.kl_owg_id,
  P.kl_uwg_id,
  P.hwg_id,
  P.owg_id,
  P.wg_id,
  P.wug_id,
   P.durchschnitt_preis_kasse * k.umrechnungskurs,
   P.umsatz_brutto * k.umrechnungskurs,
   P.umsatz_brutto_af * k.umrechnungskurs,
   P.umsatz_brutto_sa * k.umrechnungskurs,
  P.menge,
  P.menge_af,
  P.menge_sa
 FROM dbp_data.art_nielsen_preislage_zu_per_2 AS P
  INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    MAX(umrechnungskurs) AS umrechnungskurs
   FROM dbp_data.kurs_2
   WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
   GROUP BY von_wrg_id,
    nach_wrg_id) AS k ON P.wrg_id = k.von_wrg_id AND k.nach_wrg_id = 'EUR'
 WHERE P.kjmo IN (SELECT MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id = ${mandant_id})
  AND P.mandant_id = ${mandant_id}
  AND P.mandant_id IN (2, 3, 4, 6, 7, 8));