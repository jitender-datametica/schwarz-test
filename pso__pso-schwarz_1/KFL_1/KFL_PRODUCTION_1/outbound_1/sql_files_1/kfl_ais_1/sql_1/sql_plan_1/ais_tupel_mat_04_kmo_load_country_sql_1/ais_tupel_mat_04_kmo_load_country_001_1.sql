DELETE FROM dbp_etl_process.tupel_mat_step1_1
WHERE mandant_id IN (${MANDANT_ID}) AND (mandant_id, a500_kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
   FROM dbp_data.sortiment_leistung_1
   WHERE mandant_id IN (${MANDANT_ID})
   GROUP BY mandant_id);


INSERT INTO dbp_etl_process.tupel_mat_step1_1 (mandant_id, a500_kjwo_update, matching_id, a425_kjmo, wrg_id
 , a5_owg_id, a7_wg_id, wug_id, art_id, kl_art_id, art_bez_land, art_bez_deutsch, a14_art_status_de, nielsen_art_bez,
 nielsen_gtin, a58_rang_umsatz_owg, a2_rang_umsatz_wg, a59_rang_absatz_wg, a16_akt_lieferant_id, a419_hersteller_id,
 a418_lieferant_bez_land, a446_lieferant_bez_latein, a420_hersteller_bez_land, a447_hersteller_bez_latein,
 lieferant_nielsen, a389_zek_id, a391_disc_pe, a392_disc_ohne_etikett, a400_lcf, a393_vegan, a394_gluten, a395_bio,
 a396_eigenmarke, a397_tierwohl, a398_posten_food, a399_posten_nonfood, a339_umsatzsteuer, a36_gewichtete_distribution,
 a60_muki_vk_kz, a61_muki_vk_kl_art_id_verkettung, a510_muki_ek_kz, a511_muki_ek_kl_art_id_verkettung, a512_muki_wb_kz,
 a513_muki_wb_kl_art_id_verkettung)
(SELECT DISTINCT A.mandant_id,
  A.kjwo_update,
  A.matching_id,
  A.kjmo,
  A.wrg_id,
  A.owg_id,
  A.wg_id,
  A.wug_id,
  A.art_id,
  A.kl_art_id,
  A.art_bez,
  A.art_bez AS art_bez11,
  A.art_status,
  A.nielsen_art_bez,
  A.gtin,
  A.rang_umsatz_wg,
  A.rang_umsatz_uwg,
  A.rang_absatz_uwg,
  A.gp_id,
  '' AS hersteller_id,
  SUBSTR(CAST(b.akt_gp_id AS STRING), 1, 100) AS akt_gp_id,
  SUBSTR(CAST(b.akt_gp_id AS STRING), 1, 100) AS akt_gp_id21,
  '' AS a420_hersteller_bez_land,
  '' AS a447_hersteller_bez_latein,
  '' AS lieferant_nielsen,
  A.zek_id,
  A.disc_pe,
  A.disc_marke,
  A.lcf,
  A.vegan,
  A.gluten,
  A.bio,
  A.eigenmarke,
  A.tierwohl,
  A.posten_food,
  A.posten_nonfood,
  A.mwst,
  A.gewichtete_distribution,
  A.muki_vk_kz,
  A.muki_vk_kl_art_id_verkettung,
  A.muki_ek_kz,
  A.muki_ek_kl_art_id_verkettung,
  A.muki_wb_kz,
  A.muki_wb_kl_art_id_verkettung
 FROM dbp_data.sortiment_leistung_1 AS A
  LEFT JOIN (SELECT mandant_id,
    art_id,
    MAX(akt_gp_id) AS akt_gp_id
   FROM dbp_msi_view_ais_kmo.tbl_mv_art_gp_nm_zu_aktuell_1
   GROUP BY mandant_id,
    art_id) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
 WHERE A.mandant_id IN (${MANDANT_ID})
  AND (A.mandant_id, A.kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id IN (${MANDANT_ID})
    GROUP BY mandant_id));


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_kmo_1 (
mandant_id INTEGER,
dat DATE,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
bewart_id INTEGER,
menge NUMERIC(29,3),
umsatz_netto NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
ek_mep NUMERIC(29,4),
einstandspreis NUMERIC(29,4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_kmo_1 (
mandant_id INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
kreistyp_gruppe_id STRING(4),
dat DATE,
absatz NUMERIC(29,3),
absatz_sa NUMERIC(29,3),
absatz_af NUMERIC(29,3),
umsatz NUMERIC(29,4),
umsatz_sa NUMERIC(29,4),
umsatz_af NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
umsatz_brutto_af NUMERIC(29,4),
umsatz_brutto_sa NUMERIC(29,4),
ertrag NUMERIC(29,4),
ertrag_sa NUMERIC(29,4),
ertrag_af NUMERIC(29,4),
anzahl_wochen_mit_absatz INTEGER,
anzahl_wochen_mit_absatz_sa INTEGER,
anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_kmo_1
(SELECT A.mandant_id,
  A.dat,
  B.wg_id,
  A.art_id,
  A.wup_id,
  A.nb_id,
  A.bewart_id,
  A.menge,
  A.umsatz_netto,
   A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
  A.ek_mep,
  A.einstandspreis
 FROM dbp_data.artbew_1 AS A
  INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
  INNER JOIN dbp_data.art_wg_zu_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
      = 2 AND B.dat_bis = DATE '9999-12-31'
  INNER JOIN (SELECT art_matching_id,
    art_id,
    mandant_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS t1_1 ON A.art_id = t1.art_id AND A.mandant_id = t1.mandant_id
 WHERE (A.mandant_id, C.kjwo) IN (SELECT (mandant_id, kjwo)
    FROM (SELECT b.mandant_id,
       C0.kjwo,
         (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
            DESC)) * - 1 AS akt_wo
      FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
       INNER JOIN (SELECT mandant_id,
         MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id IN (${MANDANT_ID})
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
       INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
      QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC
              , C0.kjwo DESC)) * - 1) BETWEEN - 52 AND (- 1)) AS t5
    GROUP BY mandant_id,
     kjwo)
  AND A.mandant_id IN (${MANDANT_ID}));


INSERT INTO dbp_etl.bf_listung_markt_tag_kmo_1 (mandant_id, wg_id, art_id, wup_id, nb_id,
 kreistyp_gruppe_id, dat, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa,
 anzahl_wochen_mit_absatz_af)
(SELECT V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.dat,
  IFNULL(SUM(V01.menge), 0) AS absatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_af,
  IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_af,
  IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_af,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_sa,
  IFNULL(SUM(V01.umsatz_netto - V01.einstandspreis), 0) AS ertrag,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_af,
  IFNULL(CASE
    WHEN IFNULL(SUM(V01.menge), 0) > 0
    THEN COUNT(DISTINCT V01.dat)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1002
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1002
      THEN V01.dat
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1001
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1001
      THEN V01.dat
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af
 FROM dbp_etl.bf_artbew_wg_art_tag_sum_kmo_1 AS V01
  INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
    
  INNER JOIN dbp_data.wup_1 AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
    = V04.mandant_id
 WHERE V01.mandant_id IN (${MANDANT_ID})
  AND V03.arthiertyp_id = 2
  AND V03.dat_bis = DATE '9999-12-31'
 GROUP BY V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.dat);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag (
dat DATE,
matching_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
anz_wo_mit_absatz FLOAT64,
anz_wo_mit_absatz_af FLOAT64,
anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre_tag
(SELECT A11.dat,
  b.art_matching_id AS matching_id,
  A11.mandant_id,
  A11.wup_id,
  CAST(CASE
    WHEN SUM(A11.absatz) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz,
  CAST(CASE
    WHEN SUM(A11.absatz_af) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_af,
  CAST(CASE
    WHEN SUM(A11.absatz_sa) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_sa
 FROM dbp_etl.bf_listung_markt_tag_kmo_1 AS A11
  INNER JOIN (SELECT mandant_id,
    art_matching_id,
    art_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 GROUP BY A11.dat,
  matching_id,
  A11.mandant_id,
  A11.wup_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag_xxx AS
SELECT mandant_id,
 matching_id,
  SUM(anz_wo_mit_absatz) / 7.0000 AS anz_wo_mit_absatz,
  SUM(anz_wo_mit_absatz_af) / 7.0000 AS anz_wo_mit_absatz_af,
  SUM(anz_wo_mit_absatz_sa) / 7.0000 AS anz_wo_mit_absatz_sa
FROM zzsp07_pre_tag
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1 (
mandant_id INTEGER,
kjwo INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
bewart_id INTEGER,
menge NUMERIC(29,3),
umsatz_netto NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
ek_mep NUMERIC(29,4),
einstandspreis NUMERIC(29,4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_kmo_1 (
mandant_id INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
kreistyp_gruppe_id STRING(4),
kjwo INTEGER,
absatz NUMERIC(29,3),
absatz_sa NUMERIC(29,3),
absatz_af NUMERIC(29,3),
umsatz NUMERIC(29,4),
umsatz_sa NUMERIC(29,4),
umsatz_af NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
umsatz_brutto_af NUMERIC(29,4),
umsatz_brutto_sa NUMERIC(29,4),
ertrag NUMERIC(29,4),
ertrag_sa NUMERIC(29,4),
ertrag_af NUMERIC(29,4),
anzahl_wochen_mit_absatz INTEGER,
anzahl_wochen_mit_absatz_sa INTEGER,
anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1
(SELECT A.mandant_id,
  C.kjwo,
  B.wg_id,
  A.art_id,
  A.wup_id,
  A.nb_id,
  A.bewart_id,
  A.menge,
  A.umsatz_netto,
   A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
  A.ek_mep,
  A.einstandspreis
 FROM dbp_data.artbew_wo_sum_1 AS A
  INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl
  INNER JOIN dbp_data.art_wg_zu_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
      = 2 AND B.dat_bis = DATE '9999-12-31'
  INNER JOIN (SELECT art_matching_id,
    art_id,
    mandant_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS t1_1 ON A.art_id = t1.art_id AND A.mandant_id = t1.mandant_id
 WHERE (A.mandant_id, C.kjwo) IN (SELECT (mandant_id, kjwo)
    FROM (SELECT b.mandant_id,
       C0.kjwo,
         (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
            DESC)) * - 1 AS akt_wo
      FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
       INNER JOIN (SELECT mandant_id,
         MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id IN (${MANDANT_ID})
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
       INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
      QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC
              , C0.kjwo DESC)) * - 1) BETWEEN - 52 AND (- 1)) AS t5
    GROUP BY mandant_id,
     kjwo)
  AND A.mandant_id IN (${MANDANT_ID}));


INSERT INTO dbp_etl.bf_listung_markt_kw_kmo_1 (mandant_id, wg_id, art_id, wup_id, nb_id, kreistyp_gruppe_id
 , kjwo, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa,
 ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa, anzahl_wochen_mit_absatz_af)
(SELECT V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.kjwo,
  IFNULL(SUM(V01.menge), 0) AS absatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_af,
  IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_af,
  IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_af,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_sa,
  IFNULL(SUM(V01.umsatz_netto - V01.einstandspreis), 0) AS ertrag,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_af,
  IFNULL(CASE
    WHEN IFNULL(SUM(V01.menge), 0) > 0
    THEN COUNT(DISTINCT V01.kjwo)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1002
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1002
      THEN V01.kjwo
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1001
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1001
      THEN V01.kjwo
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af
 FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1 AS V01
  INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
    
  INNER JOIN dbp_data.wup_1 AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
    = V04.mandant_id
 WHERE V01.mandant_id IN (${MANDANT_ID})
  AND V03.arthiertyp_id = 2
  AND V03.dat_bis = DATE '9999-12-31'
 GROUP BY V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.kjwo);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre (
kjwo INTEGER,
matching_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
anz_wo_mit_absatz FLOAT64,
anz_wo_mit_absatz_af FLOAT64,
anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre
(SELECT A11.kjwo,
  b.art_matching_id AS matching_id,
  A11.mandant_id,
  A11.wup_id,
  CAST(CASE
    WHEN SUM(A11.absatz) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz,
  CAST(CASE
    WHEN SUM(A11.absatz_af) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_af,
  CAST(CASE
    WHEN SUM(A11.absatz_sa) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_sa
 FROM dbp_etl.bf_listung_markt_kw_kmo_1 AS A11
  INNER JOIN (SELECT mandant_id,
    art_matching_id,
    art_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 GROUP BY A11.kjwo,
  matching_id,
  A11.mandant_id,
  A11.wup_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_xxx AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
 SUM(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
 SUM(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM zzsp07_pre
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre (
kjwo INTEGER,
matching_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_pre
(SELECT A11.kjwo,
  b.art_matching_id AS matching_id,
  A11.mandant_id,
  A11.wup_id,
  CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung_1
 FROM dbp_data.art_wup_listung_kjwo_1 AS A11
  INNER JOIN (SELECT mandant_id,
    art_matching_id,
    art_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 WHERE (A11.mandant_id, A11.kjwo) IN (SELECT (mandant_id, kjwo)
    FROM (SELECT b.mandant_id,
       C.kjwo,
         (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
            DESC)) * - 1 AS akt_wo
      FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A
       INNER JOIN (SELECT mandant_id,
         MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id IN (${MANDANT_ID})
        GROUP BY mandant_id) AS b ON A.kjmo_sort = b.kjmo
       INNER JOIN dbp_data.woche_1 AS C ON A.kjwo_bis >= C.kjwo
      QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC
              , C.kjwo DESC)) * - 1) BETWEEN - 52 AND (- 1)) AS t4
    GROUP BY mandant_id,
     kjwo)
  AND A11.mandant_id IN (${MANDANT_ID})
 GROUP BY A11.kjwo,
  matching_id,
  A11.mandant_id,
  A11.wup_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_xxx AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_listung_1) AS anz_wo_listung_1
FROM zzsp08_pre
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT A.kjwo,
 A.matching_id,
 A.mandant_id,
 A.wup_id,
 A.anz_wo_listung_1,
 B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
 INNER JOIN zzsp07_pre AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id AND
   A.kjwo = B.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_y AS
SELECT A.kjwo,
 A.matching_id,
 A.mandant_id,
 A.wup_id,
 A.anz_wo_listung_1,
 B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
 INNER JOIN zzsp07_pre AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id AND
   A.kjwo = B.kjwo;


DELETE FROM `_mm_y`
WHERE anz_wo_mit_absatz = 0;


CREATE OR REPLACE TEMPORARY TABLE _mm_y_xxx AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM `_mm_y`
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TEMPORARY TABLE _mm_z AS
SELECT b.art_matching_id AS matching_id,
 A11.mandant_id,
 SUM(A11.umsatz_af) AS umsatz_af_mit_listung,
 SUM(A11.umsatz_sa) AS umsatz_sa_mit_listung,
 SUM(A11.umsatz_brutto_af) AS umsatz_brutto_af_mit_listung,
 SUM(A11.umsatz_brutto_sa) AS umsatz_brutto_sa_mit_listung,
 SUM(A11.ertrag_af) AS ertrag_af_mit_listung,
 SUM(A11.ertrag_sa) AS ertrag_sa_mit_listung,
 SUM(A11.absatz_af) AS absatz_af_mit_listung,
 SUM(A11.absatz_sa) AS absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_kmo_1 AS A11
 INNER JOIN (SELECT mandant_id,
   art_matching_id,
   art_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY mandant_id,
   art_matching_id,
   art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 INNER JOIN `_mm_y` AS C ON A11.mandant_id = C.mandant_id AND b.art_matching_id = C.matching_id AND A11.kjwo = C.kjwo
  AND A11.wup_id = C.wup_id
GROUP BY matching_id,
 A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _mm_x AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_listung_1) AS anz_wo_mit_listung_absatz
FROM `_mm`
GROUP BY mandant_id,
 matching_id;


INSERT INTO `_mm`
(SELECT kjwo,
  matching_id,
  mandant_id,
  wup_id,
  anz_wo_listung_1,
  0
 FROM zzsp08_pre
 WHERE (kjwo, matching_id, mandant_id, wup_id) NOT IN (SELECT (kjwo, matching_id, mandant_id, wup_id)
    FROM `_mm`));


CREATE OR REPLACE TEMPORARY TABLE zzsp07 (
matching_id INTEGER,
mandant_id INTEGER,
anz_wo_mit_absatz FLOAT64
);


INSERT INTO zzsp07
(SELECT matching_id,
  mandant_id,
  SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
 FROM `_mm` AS A11
 WHERE anz_wo_mit_absatz <> 0
 GROUP BY matching_id,
  mandant_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp08 (
matching_id INTEGER,
mandant_id INTEGER,
anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08
(SELECT matching_id,
  mandant_id,
  SUM(anz_wo_listung_1) AS anz_wo_listung_1
 FROM `_mm` AS A11
 GROUP BY matching_id,
  mandant_id);


CREATE OR REPLACE TEMPORARY TABLE zzoj09 (
matching_id INTEGER,
mandant_id INTEGER
);


INSERT INTO zzoj09
(SELECT *
 FROM (SELECT matching_id,
     mandant_id
    FROM zzsp07 AS PA11
    GROUP BY matching_id,
     mandant_id
    UNION DISTINCT
    SELECT matching_id,
     mandant_id
    FROM zzsp08 AS PA11
    GROUP BY matching_id,
     mandant_id) AS t1_1);


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx (
matching_id INTEGER,
mandant_id INTEGER,
wjxbfs1 FLOAT64,
anz_wo_listung_1 FLOAT64,
anz_wo_mit_absatz FLOAT64,
schnelldreherquote FLOAT64
);


INSERT INTO zzmd0a_xxx
(SELECT PA11.matching_id,
  PA11.mandant_id,
  1.0 AS wjxbfs1,
  PA13.anz_wo_listung_1,
  PA12.anz_wo_mit_absatz,
  ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung_1 = 0, NULL, PA13.anz_wo_listung_1) * 100, 1) AS schnelldreherquote
 FROM zzoj09 AS PA11
  LEFT JOIN zzsp07 AS PA12 ON PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id
  LEFT JOIN zzsp08 AS PA13 ON PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id);


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen AS
SELECT A.kjwo,
 A.mandant_id,
 b.art_matching_id,
 A.wup_id,
 IFNULL(SUM(A.absatz), 0) AS absatz_,
 IFNULL(SUM(A.absatz_af), 0) AS absatz_af_,
 IFNULL(SUM(A.absatz_sa), 0) AS absatz_sa_,
 IFNULL(SUM(A.umsatz), 0) AS umsatz_,
 IFNULL(SUM(A.umsatz_af), 0) AS umsatz_af_,
 IFNULL(SUM(A.umsatz_sa), 0) AS umsatz_sa_,
 IFNULL(SUM(A.umsatz_brutto), 0) AS umsatz_brutto_,
 IFNULL(SUM(A.umsatz_brutto_af), 0) AS umsatz_brutto_af_,
 IFNULL(SUM(A.umsatz_brutto_sa), 0) AS umsatz_brutto_sa_,
 IFNULL(SUM(A.ertrag), 0) AS ertrag_,
 IFNULL(SUM(A.ertrag_af), 0) AS ertrag_af_,
 IFNULL(SUM(A.ertrag_sa), 0) AS ertrag_sa_,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.absatz), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.absatz_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.absatz_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_brutto), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_brutto,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_brutto_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_brutto_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_brutto_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_brutto_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.ertrag), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_ertrag,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.ertrag_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_ertrag_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.ertrag_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_kmo_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE (A.mandant_id, A.kjwo) IN (SELECT (mandant_id, kjwo)
   FROM (SELECT b.mandant_id,
      C.kjwo,
        (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
           DESC)) * - 1 AS akt_wo
     FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
      INNER JOIN (SELECT mandant_id,
        MAX(kjmo) AS kjmo
       FROM dbp_data.sortiment_leistung_1
       WHERE mandant_id IN (${MANDANT_ID})
       GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
      INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
     QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
             C.kjwo DESC)) * - 1) BETWEEN - 52 AND (- 1)) AS t5
   GROUP BY mandant_id,
    kjwo)
 AND A.mandant_id IN (${MANDANT_ID})
GROUP BY A.kjwo,
 A.mandant_id,
 b.art_matching_id,
 A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen1 AS
SELECT mandant_id,
 art_matching_id,
 SUM(absatz_) AS absatz,
 SUM(absatz_af_) AS absatz_af,
 SUM(absatz_sa_) AS absatz_sa,
 SUM(umsatz_) AS umsatz,
 SUM(umsatz_af_) AS umsatz_af,
 SUM(umsatz_sa_) AS umsatz_sa,
 SUM(umsatz_brutto_) AS umsatz_brutto,
 SUM(umsatz_brutto_af_) AS umsatz_brutto_af,
 SUM(umsatz_brutto_sa_) AS umsatz_brutto_sa,
 SUM(ertrag_) AS ertrag,
 SUM(ertrag_af_) AS ertrag_af,
 SUM(ertrag_sa_) AS ertrag_sa,
 SUM(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
 SUM(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
 SUM(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
 SUM(anzahl_wochen_mit_umsatz_brutto) AS anzahl_wochen_mit_umsatz_brutto,
 SUM(anzahl_wochen_mit_umsatz_brutto_af) AS anzahl_wochen_mit_umsatz_brutto_af,
 SUM(anzahl_wochen_mit_umsatz_brutto_sa) AS anzahl_wochen_mit_umsatz_brutto_sa,
 SUM(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
 SUM(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
 SUM(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
 SUM(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
 SUM(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
 SUM(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM `_anz_wochen`
GROUP BY mandant_id,
 art_matching_id;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_kmo_vj_1 (
mandant_id INTEGER,
dat DATE,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
bewart_id INTEGER,
menge NUMERIC(29,3),
umsatz_netto NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
ek_mep NUMERIC(29,4),
einstandspreis NUMERIC(29,4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_kmo_vj_1 (
mandant_id INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
kreistyp_gruppe_id STRING(4),
dat DATE,
absatz NUMERIC(29,3),
absatz_sa NUMERIC(29,3),
absatz_af NUMERIC(29,3),
umsatz NUMERIC(29,4),
umsatz_sa NUMERIC(29,4),
umsatz_af NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
umsatz_brutto_af NUMERIC(29,4),
umsatz_brutto_sa NUMERIC(29,4),
ertrag NUMERIC(29,4),
ertrag_sa NUMERIC(29,4),
ertrag_af NUMERIC(29,4),
anzahl_wochen_mit_absatz INTEGER,
anzahl_wochen_mit_absatz_sa INTEGER,
anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_kmo_vj_1
(SELECT A.mandant_id,
  A.dat,
  B.wg_id,
  A.art_id,
  A.wup_id,
  A.nb_id,
  A.bewart_id,
  A.menge,
  A.umsatz_netto,
   A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
  A.ek_mep,
  A.einstandspreis
 FROM dbp_data.artbew_1 AS A
  INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
  INNER JOIN dbp_data.art_wg_zu_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
      = 2 AND B.dat_bis = DATE '9999-12-31'
  INNER JOIN (SELECT art_matching_id,
    art_id,
    mandant_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS t1_1 ON A.art_id = t1.art_id AND A.mandant_id = t1.mandant_id
 WHERE (A.mandant_id, C.kjwo) IN (SELECT (mandant_id, kjwo)
    FROM (SELECT b.mandant_id,
       C0.kjwo,
         (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
            DESC)) * - 1 AS akt_wo
      FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
       INNER JOIN (SELECT mandant_id,
         MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id IN (${MANDANT_ID})
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
       INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
      QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC
              , C0.kjwo DESC)) * - 1) BETWEEN - 104 AND (- 53)) AS t5
    GROUP BY mandant_id,
     kjwo)
  AND A.mandant_id IN (${MANDANT_ID}));


INSERT INTO dbp_etl.bf_listung_markt_tag_kmo_vj_1 (mandant_id, wg_id, art_id, wup_id, nb_id,
 kreistyp_gruppe_id, dat, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa,
 anzahl_wochen_mit_absatz_af)
(SELECT V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.dat,
  IFNULL(SUM(V01.menge), 0) AS absatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_af,
  IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_af,
  IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_af,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_sa,
  IFNULL(SUM(V01.umsatz_netto - V01.einstandspreis), 0) AS ertrag,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_af,
  IFNULL(CASE
    WHEN IFNULL(SUM(V01.menge), 0) > 0
    THEN COUNT(DISTINCT V01.dat)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1002
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1002
      THEN V01.dat
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1001
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1001
      THEN V01.dat
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af
 FROM dbp_etl.bf_artbew_wg_art_tag_sum_kmo_vj_1 AS V01
  INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
    
  INNER JOIN dbp_data.wup_1 AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
    = V04.mandant_id
 WHERE V01.mandant_id IN (${MANDANT_ID})
  AND V03.arthiertyp_id = 2
  AND V03.dat_bis = DATE '9999-12-31'
 GROUP BY V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.dat);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag_vj (
kjwo DATE,
matching_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
anz_wo_mit_absatz FLOAT64,
anz_wo_mit_absatz_af FLOAT64,
anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre_tag_vj
(SELECT A11.dat,
  b.art_matching_id AS matching_id,
  A11.mandant_id,
  A11.wup_id,
  CAST(CASE
    WHEN SUM(A11.absatz) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz,
  CAST(CASE
    WHEN SUM(A11.absatz_af) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_af,
  CAST(CASE
    WHEN SUM(A11.absatz_sa) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_sa
 FROM dbp_etl.bf_listung_markt_tag_kmo_vj_1 AS A11
  INNER JOIN (SELECT mandant_id,
    art_matching_id,
    art_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 GROUP BY A11.dat,
  matching_id,
  A11.mandant_id,
  A11.wup_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag_vj_xxx AS
SELECT mandant_id,
 matching_id,
  SUM(anz_wo_mit_absatz) / 7.0000 AS anz_wo_mit_absatz,
  SUM(anz_wo_mit_absatz_af) / 7.0000 AS anz_wo_mit_absatz_af,
  SUM(anz_wo_mit_absatz_sa) / 7.0000 AS anz_wo_mit_absatz_sa
FROM zzsp07_pre_tag_vj
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_1 (
mandant_id INTEGER,
kjwo INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
bewart_id INTEGER,
menge NUMERIC(29,3),
umsatz_netto NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
ek_mep NUMERIC(29,4),
einstandspreis NUMERIC(29,4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_kmo_vj_1 (
mandant_id INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
kreistyp_gruppe_id STRING(4),
kjwo INTEGER,
absatz NUMERIC(29,3),
absatz_sa NUMERIC(29,3),
absatz_af NUMERIC(29,3),
umsatz NUMERIC(29,4),
umsatz_sa NUMERIC(29,4),
umsatz_af NUMERIC(29,4),
umsatz_brutto NUMERIC(29,4),
umsatz_brutto_af NUMERIC(29,4),
umsatz_brutto_sa NUMERIC(29,4),
ertrag NUMERIC(29,4),
ertrag_sa NUMERIC(29,4),
ertrag_af NUMERIC(29,4),
anzahl_wochen_mit_absatz INTEGER,
anzahl_wochen_mit_absatz_sa INTEGER,
anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_1
(SELECT A.mandant_id,
  C.kjwo,
  B.wg_id,
  A.art_id,
  A.wup_id,
  A.nb_id,
  A.bewart_id,
  A.menge,
  A.umsatz_netto,
   A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
  A.ek_mep,
  A.einstandspreis
 FROM dbp_data.artbew_wo_sum_1 AS A
  INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl
  INNER JOIN dbp_data.art_wg_zu_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
      = 2 AND B.dat_bis = DATE '9999-12-31'
  INNER JOIN (SELECT art_matching_id,
    art_id,
    mandant_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS t1_1 ON A.art_id = t1.art_id AND A.mandant_id = t1.mandant_id
 WHERE (A.mandant_id, C.kjwo) IN (SELECT (mandant_id, kjwo)
    FROM (SELECT b.mandant_id,
       C0.kjwo,
         (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
            DESC)) * - 1 AS akt_wo
      FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
       INNER JOIN (SELECT mandant_id,
         MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id IN (${MANDANT_ID})
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
       INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
      QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC
              , C0.kjwo DESC)) * - 1) BETWEEN - 104 AND (- 53)) AS t5
    GROUP BY mandant_id,
     kjwo)
  AND A.mandant_id IN (${MANDANT_ID}));


INSERT INTO dbp_etl.bf_listung_markt_kw_kmo_vj_1 (mandant_id, wg_id, art_id, wup_id, nb_id,
 kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af,
 umsatz_brutto_sa, ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa,
 anzahl_wochen_mit_absatz_af)
(SELECT V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.kjwo,
  IFNULL(SUM(V01.menge), 0) AS absatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.menge
      ELSE NULL
      END), 0) AS NUMERIC) AS absatz_af,
  IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_af,
  IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_af,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_brutto
      ELSE NULL
      END), 0) AS NUMERIC) AS umsatz_brutto_sa,
  IFNULL(SUM(V01.umsatz_netto - V01.einstandspreis), 0) AS ertrag,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1002
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_sa,
  CAST(IFNULL(SUM(CASE
      WHEN V01.bewart_id = 1001
      THEN V01.umsatz_netto - V01.einstandspreis
      ELSE NULL
      END), 0) AS NUMERIC) AS ertrag_af,
  IFNULL(CASE
    WHEN IFNULL(SUM(V01.menge), 0) > 0
    THEN COUNT(DISTINCT V01.kjwo)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1002
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1002
      THEN V01.kjwo
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
  IFNULL(CASE
    WHEN IFNULL(SUM(CASE
         WHEN V01.bewart_id = 1001
         THEN V01.menge
         ELSE NULL
         END), 0) > 0 AND IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
        THEN V01.menge
        ELSE NULL
        END), 0) IS NOT NULL
    THEN COUNT(DISTINCT CASE
      WHEN V01.bewart_id = 1001
      THEN V01.kjwo
      ELSE NULL
      END)
    ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af
 FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_1 AS V01
  INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
    
  INNER JOIN dbp_data.wup_1 AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
    = V04.mandant_id
 WHERE V01.mandant_id IN (${MANDANT_ID})
  AND V03.arthiertyp_id = 2
  AND V03.dat_bis = DATE '9999-12-31'
 GROUP BY V01.mandant_id,
  V01.wg_id,
  V01.art_id,
  V01.wup_id,
  V01.nb_id,
  V04.kreistyp_gruppe_id,
  V01.kjwo);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_vj (
kjwo INTEGER,
matching_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
anz_wo_mit_absatz FLOAT64,
anz_wo_mit_absatz_af FLOAT64,
anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre_vj
(SELECT A11.kjwo,
  b.art_matching_id AS matching_id,
  A11.mandant_id,
  A11.wup_id,
  CAST(CASE
    WHEN SUM(A11.absatz) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz,
  CAST(CASE
    WHEN SUM(A11.absatz_af) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_af,
  CAST(CASE
    WHEN SUM(A11.absatz_sa) > 0
    THEN 1
    ELSE 0
    END AS FLOAT64) AS anz_wo_mit_absatz_sa
 FROM dbp_etl.bf_listung_markt_kw_kmo_vj_1 AS A11
  INNER JOIN (SELECT mandant_id,
    art_matching_id,
    art_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 GROUP BY A11.kjwo,
  matching_id,
  A11.mandant_id,
  A11.wup_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_vj_xxx AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
 SUM(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
 SUM(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM zzsp07_pre_vj
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_vj (
kjwo INTEGER,
matching_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_pre_vj
(SELECT A11.kjwo,
  b.art_matching_id AS matching_id,
  A11.mandant_id,
  A11.wup_id,
  CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung_1
 FROM dbp_data.art_wup_listung_kjwo_1 AS A11
  INNER JOIN (SELECT mandant_id,
    art_matching_id,
    art_id
   FROM dbp_etl.art_matching_nielsen_per_kmo_1
   WHERE art_id <> - 1
   GROUP BY mandant_id,
    art_matching_id,
    art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 WHERE (A11.mandant_id, A11.kjwo) IN (SELECT (mandant_id, kjwo)
    FROM (SELECT b.mandant_id,
       C.kjwo,
         (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
            DESC)) * - 1 AS akt_wo
      FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A
       INNER JOIN (SELECT mandant_id,
         MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id IN (${MANDANT_ID})
        GROUP BY mandant_id) AS b ON A.kjmo_sort = b.kjmo
       INNER JOIN dbp_data.woche_1 AS C ON A.kjwo_bis >= C.kjwo
      QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC
              , C.kjwo DESC)) * - 1) BETWEEN - 104 AND (- 53)) AS t4
    GROUP BY mandant_id,
     kjwo)
  AND A11.mandant_id IN (${MANDANT_ID})
 GROUP BY A11.kjwo,
  matching_id,
  A11.mandant_id,
  A11.wup_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_vj_xxx AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_listung_1) AS anz_wo_listung_1
FROM zzsp08_pre_vj
GROUP BY mandant_id,
 matching_id;


CREATE OR REPLACE TEMPORARY TABLE _mm_vj AS
SELECT A.kjwo,
 A.matching_id,
 A.mandant_id,
 A.wup_id,
 A.anz_wo_listung_1,
 B.anz_wo_mit_absatz
FROM zzsp08_pre_vj AS A
 INNER JOIN zzsp07_pre_vj AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id
  AND A.kjwo = B.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_y_vj AS
SELECT A.kjwo,
 A.matching_id,
 A.mandant_id,
 A.wup_id,
 A.anz_wo_listung_1,
 B.anz_wo_mit_absatz
FROM zzsp08_pre_vj AS A
 INNER JOIN zzsp07_pre_vj AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id
  AND A.kjwo = B.kjwo;


DELETE FROM `_mm_y_vj`
WHERE anz_wo_mit_absatz = 0;


CREATE OR REPLACE TEMPORARY TABLE _mm_z_vj AS
SELECT b.art_matching_id AS matching_id,
 A11.mandant_id,
 SUM(A11.umsatz_af) AS umsatz_af_mit_listung,
 SUM(A11.umsatz_sa) AS umsatz_sa_mit_listung,
 SUM(A11.umsatz_brutto_af) AS umsatz_brutto_af_mit_listung,
 SUM(A11.umsatz_brutto_sa) AS umsatz_brutto_sa_mit_listung,
 SUM(A11.ertrag_af) AS ertrag_af_mit_listung,
 SUM(A11.ertrag_sa) AS ertrag_sa_mit_listung,
 SUM(A11.absatz_af) AS absatz_af_mit_listung,
 SUM(A11.absatz_sa) AS absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_kmo_vj_1 AS A11
 INNER JOIN (SELECT mandant_id,
   art_matching_id,
   art_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY mandant_id,
   art_matching_id,
   art_id) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
 INNER JOIN `_mm_y_vj` AS C ON A11.mandant_id = C.mandant_id AND b.art_matching_id = C.matching_id AND A11.kjwo = C.kjwo
     AND A11.wup_id = C.wup_id
GROUP BY matching_id,
 A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _mm_x_vj AS
SELECT mandant_id,
 matching_id,
 SUM(anz_wo_listung_1) AS anz_wo_mit_listung_absatz
FROM `_mm_vj`
GROUP BY mandant_id,
 matching_id;


INSERT INTO `_mm_vj`
(SELECT kjwo,
  matching_id,
  mandant_id,
  wup_id,
  anz_wo_listung_1,
  0
 FROM zzsp08_pre_vj
 WHERE (kjwo, matching_id, mandant_id, wup_id) NOT IN (SELECT (kjwo, matching_id, mandant_id, wup_id)
    FROM `_mm_vj`));


CREATE OR REPLACE TEMPORARY TABLE zzsp07_vj (
matching_id INTEGER,
mandant_id INTEGER,
anz_wo_mit_absatz FLOAT64
);


INSERT INTO zzsp07_vj
(SELECT matching_id,
  mandant_id,
  SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
 FROM `_mm_vj` AS A11
 WHERE anz_wo_mit_absatz <> 0
 GROUP BY matching_id,
  mandant_id);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_vj (
matching_id INTEGER,
mandant_id INTEGER,
anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_vj
(SELECT matching_id,
  mandant_id,
  SUM(anz_wo_listung_1) AS anz_wo_listung_1
 FROM `_mm_vj` AS A11
 GROUP BY matching_id,
  mandant_id);


CREATE OR REPLACE TEMPORARY TABLE zzoj09_vj (
matching_id INTEGER,
mandant_id INTEGER
);


INSERT INTO zzoj09_vj
(SELECT *
 FROM (SELECT matching_id,
     mandant_id
    FROM zzsp07_vj AS PA11
    GROUP BY matching_id,
     mandant_id
    UNION DISTINCT
    SELECT matching_id,
     mandant_id
    FROM zzsp08_vj AS PA11
    GROUP BY matching_id,
     mandant_id) AS t1_1);


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx_vj (
matching_id INTEGER,
mandant_id INTEGER,
wjxbfs1 FLOAT64,
anz_wo_listung_1 FLOAT64,
anz_wo_mit_absatz FLOAT64,
schnelldreherquote FLOAT64
);


INSERT INTO zzmd0a_xxx_vj
(SELECT PA11.matching_id,
  PA11.mandant_id,
  1.0 AS wjxbfs1,
  PA13.anz_wo_listung_1,
  PA12.anz_wo_mit_absatz,
  ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung_1 = 0, NULL, PA13.anz_wo_listung_1) * 100, 1) AS schnelldreherquote
 FROM zzoj09_vj AS PA11
  LEFT JOIN zzsp07_vj AS PA12 ON PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id
  LEFT JOIN zzsp08_vj AS PA13 ON PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id);


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen_vj AS
SELECT A.kjwo,
 A.mandant_id,
 b.art_matching_id,
 A.wup_id,
 IFNULL(SUM(A.absatz), 0) AS absatz_,
 IFNULL(SUM(A.absatz_af), 0) AS absatz_af_,
 IFNULL(SUM(A.absatz_sa), 0) AS absatz_sa_,
 IFNULL(SUM(A.umsatz), 0) AS umsatz_,
 IFNULL(SUM(A.umsatz_af), 0) AS umsatz_af_,
 IFNULL(SUM(A.umsatz_sa), 0) AS umsatz_sa_,
 IFNULL(SUM(A.umsatz_brutto), 0) AS umsatz_brutto_,
 IFNULL(SUM(A.umsatz_brutto_af), 0) AS umsatz_brutto_af_,
 IFNULL(SUM(A.umsatz_brutto_sa), 0) AS umsatz_brutto_sa_,
 IFNULL(SUM(A.ertrag), 0) AS ertrag_,
 IFNULL(SUM(A.ertrag_af), 0) AS ertrag_af_,
 IFNULL(SUM(A.ertrag_sa), 0) AS ertrag_sa_,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.absatz), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.absatz_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.absatz_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_brutto), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_brutto,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_brutto_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_brutto_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.umsatz_brutto_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_umsatz_brutto_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.ertrag), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_ertrag,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.ertrag_af), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_ertrag_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(A.ertrag_sa), 0) > 0
   THEN COUNT(DISTINCT A.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_kmo_vj_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
GROUP BY A.kjwo,
 A.mandant_id,
 b.art_matching_id,
 A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen1_vj AS
SELECT mandant_id,
 art_matching_id,
 SUM(absatz_) AS absatz,
 SUM(absatz_af_) AS absatz_af,
 SUM(absatz_sa_) AS absatz_sa,
 SUM(umsatz_) AS umsatz,
 SUM(umsatz_af_) AS umsatz_af,
 SUM(umsatz_sa_) AS umsatz_sa,
 SUM(umsatz_brutto_) AS umsatz_brutto,
 SUM(umsatz_brutto_af_) AS umsatz_brutto_af,
 SUM(umsatz_brutto_sa_) AS umsatz_brutto_sa,
 SUM(ertrag_) AS ertrag,
 SUM(ertrag_af_) AS ertrag_af,
 SUM(ertrag_sa_) AS ertrag_sa,
 SUM(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
 SUM(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
 SUM(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
 SUM(anzahl_wochen_mit_umsatz_brutto) AS anzahl_wochen_mit_umsatz_brutto,
 SUM(anzahl_wochen_mit_umsatz_brutto_af) AS anzahl_wochen_mit_umsatz_brutto_af,
 SUM(anzahl_wochen_mit_umsatz_brutto_sa) AS anzahl_wochen_mit_umsatz_brutto_sa,
 SUM(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
 SUM(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
 SUM(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
 SUM(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
 SUM(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
 SUM(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM `_anz_wochen_vj`
GROUP BY mandant_id,
 art_matching_id;


CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_kw_kmo_1 (mandant_id, wg_id, art_id, wup_id, nb_id,
kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, anz_wo_mit_absatz, anz_wo_mit_absatz_sa, anz_wo_mit_absatz_af)
AS SELECT V01.mandant_id,
 V01.wg_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V04.kreistyp_gruppe_id,
 V01.kjwo,
 IFNULL(SUM(V01.menge), 0) AS absatz,
 IFNULL(SUM(CASE
    WHEN V01.bewart_id = 1002
    THEN V01.menge
    ELSE NULL
    END), 0) AS absatz_sa,
 IFNULL(SUM(CASE
    WHEN V01.bewart_id = 1001
    THEN V01.menge
    ELSE NULL
    END), 0) AS absatz_af,
 IFNULL(COUNT(DISTINCT V01.kjwo), 0) AS anzahl_wochen_mit_absatz,
 IFNULL(COUNT(DISTINCT CASE
    WHEN V01.bewart_id = 1002
    THEN V01.kjwo
    ELSE NULL
    END), 0) AS anzahl_wochen_mit_absatz_sa,
 IFNULL(COUNT(DISTINCT CASE
    WHEN V01.bewart_id = 1001
    THEN V01.kjwo
    ELSE NULL
    END), 0) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1 AS V01
 INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
 INNER JOIN dbp_data.wup_1 AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id =
   V04.mandant_id
WHERE V01.mandant_id IN (${MANDANT_ID})
 AND V03.arthiertyp_id = 2
 AND V03.dat_bis = DATE '9999-12-31'
GROUP BY V01.mandant_id,
 V01.wg_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V04.kreistyp_gruppe_id,
 V01.kjwo;


CREATE OR REPLACE TEMPORARY TABLE zzmd0e (
art_id INTEGER,
mandant_id INTEGER,
absatz_sk1 FLOAT64,
anz_wo_mit_abs_sk1 FLOAT64,
absatz_sk2 FLOAT64,
anz_wo_mit_abs_sk2 FLOAT64,
absatz_sk3 FLOAT64,
anz_wo_mit_abs_sk3 FLOAT64,
absatz_sk4 FLOAT64,
anz_wo_mit_abs_sk4 FLOAT64,
absatz_sk5 FLOAT64,
anz_wo_mit_abs_sk5 FLOAT64,
absatz_sk6 FLOAT64,
anz_wo_mit_abs_sk6 FLOAT64,
absatz_sk7 FLOAT64,
anz_wo_mit_abs_sk7 FLOAT64,
absatz_ksk1 FLOAT64,
anz_wo_mit_abs_ksk1 FLOAT64,
absatz_ksk2 FLOAT64,
anz_wo_mit_abs_ksk2 FLOAT64,
absatz_ksk3 FLOAT64,
anz_wo_mit_abs_ksk3 FLOAT64,
absatz_ksk4 FLOAT64,
anz_wo_mit_abs_ksk4 FLOAT64,
absatz_ksk5 FLOAT64,
anz_wo_mit_abs_ksk5 FLOAT64,
absatz_ksk6 FLOAT64,
anz_wo_mit_abs_ksk6 FLOAT64,
absatz_ksk7 FLOAT64,
anz_wo_mit_abs_ksk7 FLOAT64,
absatz_af_sk1_bis6 FLOAT64,
absatz_sa_sk1_bis6 FLOAT64,
absatz_af_ksk1_bis6 FLOAT64,
absatz_sa_ksk1_bis6 FLOAT64
);


INSERT INTO zzmd0e
(SELECT A11.art_id,
  A11.mandant_id,
  CAST(SUM(CASE
     WHEN A14.sm_id = 1
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk1,
  CAST(SUM(CASE
     WHEN A14.sm_id = 1
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk1,
  CAST(SUM(CASE
     WHEN A14.sm_id = 2
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk2,
  CAST(SUM(CASE
     WHEN A14.sm_id = 2
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk2,
  CAST(SUM(CASE
     WHEN A14.sm_id = 3
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk3,
  CAST(SUM(CASE
     WHEN A14.sm_id = 3
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk3,
  CAST(SUM(CASE
     WHEN A14.sm_id = 4
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk4,
  CAST(SUM(CASE
     WHEN A14.sm_id = 4
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk4,
  CAST(SUM(CASE
     WHEN A14.sm_id = 5
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk5,
  CAST(SUM(CASE
     WHEN A14.sm_id = 5
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk5,
  CAST(SUM(CASE
     WHEN A14.sm_id = 6
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk6,
  CAST(SUM(CASE
     WHEN A14.sm_id = 6
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk6,
  CAST(SUM(CASE
     WHEN A14.sm_id = 7
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_sk7,
  CAST(SUM(CASE
     WHEN A14.sm_id = 7
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_sk7,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K1'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk1,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K1'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk1,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K2'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk2,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K2'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk2,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K3'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk3,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K3'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk3,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K4'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk4,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K4'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk4,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K5'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk5,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K5'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk5,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K6'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk6,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K6'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk6,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K7'
     THEN A11.absatz
     ELSE NULL
     END) AS FLOAT64) AS absatz_ksk7,
  CAST(SUM(CASE
     WHEN A14.ksm_id = 'K7'
     THEN A11.anzahl_wochen_mit_absatz
     ELSE NULL
     END) AS FLOAT64) AS anz_wo_mit_abs_ksk7,
  CAST(SUM(CASE
     WHEN A14.sm_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN A11.absatz_af
     ELSE NULL
     END) AS FLOAT64) AS absatz_af_sk1_bis6,
  CAST(SUM(CASE
     WHEN A14.sm_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN A11.absatz_sa
     ELSE NULL
     END) AS FLOAT64) AS absatz_sa_sk1_bis6,
  CAST(SUM(CASE
     WHEN A14.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7')
     THEN A11.absatz_af
     ELSE NULL
     END) AS FLOAT64) AS absatz_af_ksk1_bis6,
  CAST(SUM(CASE
     WHEN A14.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7')
     THEN A11.absatz_sa
     ELSE NULL
     END) AS FLOAT64) AS absatz_sa_ksk1_bis6
 FROM dbp_etl.bf_listung_markt_kw_kmo_1 AS A11
  INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS A14 ON A11.mandant_id = A14.mandant_id AND A11.nb_id = A14.nb_id
        AND A11.wg_id = A14.wg_id AND A11.wup_id = A14.wup_id AND CURRENT_DATE("Europe/Berlin") BETWEEN A14.dat_von AND A14.dat_bis
 WHERE A11.mandant_id IN (${MANDANT_ID})
  AND (A14.sm_id BETWEEN 1 AND 7 OR A14.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7'))
 GROUP BY A11.art_id,
  A11.mandant_id);


CREATE OR REPLACE TEMPORARY TABLE zzmd0e1 AS
SELECT b.art_matching_id,
 A.mandant_id,
 SUM(A.absatz_sk1) AS absatz_sk1,
 SUM(A.anz_wo_mit_abs_sk1) AS anz_wo_mit_abs_sk1,
 SUM(A.absatz_sk2) AS absatz_sk2,
 SUM(A.anz_wo_mit_abs_sk2) AS anz_wo_mit_abs_sk2,
 SUM(A.absatz_sk3) AS absatz_sk3,
 SUM(A.anz_wo_mit_abs_sk3) AS anz_wo_mit_abs_sk3,
 SUM(A.absatz_sk4) AS absatz_sk4,
 SUM(A.anz_wo_mit_abs_sk4) AS anz_wo_mit_abs_sk4,
 SUM(A.absatz_sk5) AS absatz_sk5,
 SUM(A.anz_wo_mit_abs_sk5) AS anz_wo_mit_abs_sk5,
 SUM(A.absatz_sk6) AS absatz_sk6,
 SUM(A.anz_wo_mit_abs_sk6) AS anz_wo_mit_abs_sk6,
 SUM(A.absatz_sk7) AS absatz_sk7,
 SUM(A.anz_wo_mit_abs_sk7) AS anz_wo_mit_abs_sk7,
 SUM(A.absatz_ksk1) AS absatz_ksk1,
 SUM(A.anz_wo_mit_abs_ksk1) AS anz_wo_mit_abs_ksk1,
 SUM(A.absatz_ksk2) AS absatz_ksk2,
 SUM(A.anz_wo_mit_abs_ksk2) AS anz_wo_mit_abs_ksk2,
 SUM(A.absatz_ksk3) AS absatz_ksk3,
 SUM(A.anz_wo_mit_abs_ksk3) AS anz_wo_mit_abs_ksk3,
 SUM(A.absatz_ksk4) AS absatz_ksk4,
 SUM(A.anz_wo_mit_abs_ksk4) AS anz_wo_mit_abs_ksk4,
 SUM(A.absatz_ksk5) AS absatz_ksk5,
 SUM(A.anz_wo_mit_abs_ksk5) AS anz_wo_mit_abs_ksk5,
 SUM(A.absatz_ksk6) AS absatz_ksk6,
 SUM(A.anz_wo_mit_abs_ksk6) AS anz_wo_mit_abs_ksk6,
 SUM(A.absatz_ksk7) AS absatz_ksk7,
 SUM(A.anz_wo_mit_abs_ksk7) AS anz_wo_mit_abs_ksk7,
 SUM(A.absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
 SUM(A.absatz_sa_sk1_bis6) AS absatz_sa_sk1_bis6,
 SUM(A.absatz_af_ksk1_bis6) AS absatz_af_ksk1_bis6,
 SUM(A.absatz_sa_ksk1_bis6) AS absatz_sa_ksk1_bis6
FROM zzmd0e AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
GROUP BY b.art_matching_id,
 A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _vk1 AS
SELECT b.art_matching_id,
 A.mandant_id,
 AVG(CASE
   WHEN A.pm_id = 1
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk1,
 AVG(CASE
   WHEN A.pm_id = 2
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk2,
 AVG(CASE
   WHEN A.pm_id = 3
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk3,
 AVG(CASE
   WHEN A.pm_id = 4
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk4,
 AVG(CASE
   WHEN A.pm_id = 5
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk5,
 AVG(CASE
   WHEN A.pm_id = 6
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk6,
 AVG(CASE
   WHEN A.pm_id = 7
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk7,
 AVG(CASE
   WHEN A.pm_id = 8
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk8,
 AVG(CASE
   WHEN A.pm_id = 9
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk9,
 AVG(CASE
   WHEN A.pm_id = 10
   THEN A.vk_brutto
   ELSE NULL
   END) AS pk10
FROM dbp_data.art_pm_vw_zu_per_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
 INNER JOIN dbp_data.sortiment_leistung_1 AS C ON b.art_matching_id = C.matching_id AND A.mandant_id = C.mandant_id
   
WHERE A.mandant_id IN (${MANDANT_ID})
 AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
 AND A.vw_id = 10
 AND (A.mandant_id, C.kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
   FROM dbp_data.sortiment_leistung_1
   WHERE mandant_id IN (${MANDANT_ID})
   GROUP BY mandant_id)
GROUP BY b.art_matching_id,
 A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _ek1 AS
SELECT b.art_matching_id,
 A.mandant_id,
  SUM(A.umsatz_netto) - SUM(A.ek_mep) AS total_rohertrag,
 SUM(CASE
   WHEN A.bewart_id = 1002
   THEN A.umsatz_netto - A.ek_mep
   ELSE NULL
   END) AS total_rohertrag_sa,
 SUM(CASE
   WHEN A.bewart_id = 1001
   THEN A.umsatz_netto - A.ek_mep
   ELSE NULL
   END) AS total_rohertrag_af,
  SUM(A.umsatz_netto) - SUM(A.ek_mep) AS total_rohertrag_olk,
 SUM(CASE
   WHEN A.bewart_id = 1002
   THEN A.umsatz_netto - A.ek_mep
   ELSE NULL
   END) AS total_rohertrag_olk_sa,
 SUM(CASE
   WHEN A.bewart_id = 1001
   THEN A.umsatz_netto - A.ek_mep
   ELSE NULL
   END) AS total_rohertrag_olk_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE A.mandant_id IN (${MANDANT_ID})
GROUP BY b.art_matching_id,
 A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _ek1_vj AS
SELECT b.art_matching_id,
 A.mandant_id,
  IFNULL(SUM(CASE
     WHEN A.bewart_id = 1001
     THEN A.umsatz_netto
     ELSE NULL
     END), 0) - IFNULL(SUM(CASE
     WHEN A.bewart_id = 1001
     THEN A.einstandspreis
     ELSE NULL
     END), 0) AS re_mep_af_olk_vj,
  IFNULL(SUM(CASE
     WHEN A.bewart_id = 1002
     THEN A.umsatz_netto
     ELSE NULL
     END), 0) - IFNULL(SUM(CASE
     WHEN A.bewart_id = 1002
     THEN A.einstandspreis
     ELSE NULL
     END), 0) AS re_mep_sa_olk_vj,
  IFNULL(SUM(A.umsatz_netto), 0) - IFNULL(SUM(A.einstandspreis), 0) AS re_mep_tot_olk_vj
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE A.mandant_id IN (${MANDANT_ID})
GROUP BY b.art_matching_id,
 A.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _kpi1 AS
SELECT A.mandant_id,
 c.art_matching_id,
 SUM(A.art_bons_af) AS art_bons_af,
 SUM(A.art_bons_sa) AS art_bons_sa,
 SUM(A.anz_bons) AS anz_bons,
 SUM(A.cp_bons_af) AS cp_bons_af,
 SUM(A.cp_bons_sa) AS cp_bons_sa
FROM dbp_etl.sort_kpi_woche_basis_1 AS A
 INNER JOIN dbp_data.art_1 AS B ON A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
   = DATE '9999-12-31'
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS c ON B.art_id = c.art_id AND B.mandant_id = c.mandant_id
WHERE A.mandant_id IN (${MANDANT_ID})
 AND (A.mandant_id, A.kjwo) IN (SELECT (mandant_id, kjwo)
   FROM (SELECT b.mandant_id,
      C.kjwo,
        (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
           DESC)) * - 1 AS akt_wo
     FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
      INNER JOIN (SELECT mandant_id,
        MAX(kjmo) AS kjmo
       FROM dbp_data.sortiment_leistung_1
       WHERE mandant_id IN (${MANDANT_ID})
       GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
      INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
     QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
             C.kjwo DESC)) * - 1) BETWEEN - 52 AND (- 1)) AS t5
   GROUP BY mandant_id,
    kjwo)
GROUP BY A.mandant_id,
 c.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _abs_kmo AS
SELECT A.mandant_id,
 b.art_matching_id,
 SUM(A.abschriftbetrag_netto) AS abschriftbetrag_netto
FROM dbp_data.marktabschriften_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
 INNER JOIN dbp_data.tag_1 AS X ON A.dat = X.dat
WHERE (A.mandant_id, X.kjwo) IN (SELECT (mandant_id, kjwo)
   FROM (SELECT b.mandant_id,
      C.kjwo,
        (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
           DESC)) * - 1 AS akt_wo
     FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
      INNER JOIN (SELECT mandant_id,
        MAX(kjmo) AS kjmo
       FROM dbp_data.sortiment_leistung_1
       WHERE mandant_id IN (${MANDANT_ID})
       GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
      INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
     QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
             C.kjwo DESC)) * - 1) BETWEEN - 52 AND (- 1)) AS t5
   GROUP BY mandant_id,
    kjwo)
 AND A.mandant_id IN (${MANDANT_ID})
 AND A.abschriftart_id BETWEEN 905 AND 994
 AND (A.abschriftart_id <> 955 OR A.mandant_id <> 2)
GROUP BY A.mandant_id,
 b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _abs_kmo_vj AS
SELECT A.mandant_id,
 b.art_matching_id,
 SUM(A.abschriftbetrag_netto) AS abschriftbetrag_netto
FROM dbp_data.marktabschriften_1 AS A
 INNER JOIN (SELECT art_matching_id,
   art_id,
   mandant_id
  FROM dbp_etl.art_matching_nielsen_per_kmo_1
  WHERE art_id <> - 1
  GROUP BY art_matching_id,
   art_id,
   mandant_id) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
 INNER JOIN dbp_data.tag_1 AS X ON A.dat = X.dat
WHERE (A.mandant_id, X.kjwo) IN (SELECT (mandant_id, kjwo)
   FROM (SELECT b.mandant_id,
      C.kjwo,
        (RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
           DESC)) * - 1 AS akt_wo
     FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
      INNER JOIN (SELECT mandant_id,
        MAX(kjmo) AS kjmo
       FROM dbp_data.sortiment_leistung_1
       WHERE mandant_id IN (${MANDANT_ID})
       GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
      INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
     QUALIFY ((RANK() OVER (PARTITION BY b.mandant_id ORDER BY b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
             C.kjwo DESC)) * - 1) BETWEEN - 104 AND (- 53)) AS t5
   GROUP BY mandant_id,
    kjwo)
 AND A.mandant_id IN (${MANDANT_ID})
 AND A.abschriftart_id BETWEEN 905 AND 994
 AND (A.abschriftart_id <> 955 OR A.mandant_id <> 2)
GROUP BY A.mandant_id,
 b.art_matching_id;


DELETE FROM dbp_etl_process.tupel_mat_step2_1
WHERE mandant_id IN (${MANDANT_ID}) AND (mandant_id, a500_kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
   FROM dbp_data.sortiment_leistung_1
   WHERE mandant_id IN (${MANDANT_ID})
   GROUP BY mandant_id);


INSERT INTO dbp_etl_process.tupel_mat_step2_1
(SELECT DISTINCT A.mandant_id,
  A.kjwo_update,
  A.matching_id,
  A.kjmo,
  CAST(Q.anz_wo_mit_absatz_af AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_af,
  CAST(Q.anz_wo_mit_absatz_sa AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_sa,
  CAST(T.anz_wo_mit_absatz_af AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_af_vj,
  CAST(T.anz_wo_mit_absatz_sa AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_sa_vj,
  B.umsatz_brutto AS a273_kassenumsatz_kl_absolut_brutto,
  B.umsatz_brutto_af AS kassenumsatz_af_kl_absolut_brutto,
  B.umsatz_brutto_sa AS kassenumsatz_sa_kl_absolut_brutto,
  C.umsatz_brutto AS kassenumsatz_kl_absolut_brutto_vj,
  C.umsatz_brutto_af AS kassenumsatz_af_kl_absolut_brutto_vj,
  C.umsatz_brutto_sa AS kassenumsatz_sa_kl_absolut_brutto_vj,
  B.umsatz AS a21_kassenumsatz_kl_absolut_netto,
  B.umsatz_af AS kassenumsatz_af_kl_absolut_netto,
  B.umsatz_sa AS kassenumsatz_sa_kl_absolut_netto,
  C.umsatz AS kassenumsatz_kl_absolut_netto_vj,
  C.umsatz_af AS kassenumsatz_af_kl_absolut_netto_vj,
  C.umsatz_sa AS kassenumsatz_sa_kl_absolut_netto_vj,
  B.absatz AS a17_absatz_kl,
  B.absatz_af AS absatz_af_kl,
  B.absatz_sa AS absatz_sa_kl,
  C.absatz AS absatz_kl_vj,
  C.absatz_af AS absatz_af_kl_vj,
  C.absatz_sa AS absatz_sa_kl_vj,
  ROUND(CAST(D.absatz_sk1 AS NUMERIC), 4) AS a76_absatz_sst1,
  ROUND(CAST(D.absatz_sk2 AS NUMERIC), 4) AS a78_absatz_sst2,
  ROUND(CAST(D.absatz_sk3 AS NUMERIC), 4) AS a80_absatz_sst3,
  ROUND(CAST(D.absatz_sk4 AS NUMERIC), 4) AS a82_absatz_sst4,
  ROUND(CAST(D.absatz_sk5 AS NUMERIC), 4) AS a84_absatz_sst5,
  ROUND(CAST(D.absatz_sk6 AS NUMERIC), 4) AS a86_absatz_sst6,
  ROUND(CAST(D.absatz_sk7 AS NUMERIC), 4) AS a88_absatz_sst7,
  ROUND(CAST(D.absatz_ksk1 AS NUMERIC), 4) AS a62_absatz_ksst1,
  ROUND(CAST(D.absatz_ksk2 AS NUMERIC), 4) AS a64_absatz_ksst2,
  ROUND(CAST(D.absatz_ksk3 AS NUMERIC), 4) AS a66_absatz_ksst3,
  ROUND(CAST(D.absatz_ksk4 AS NUMERIC), 4) AS a68_absatz_ksst4,
  ROUND(CAST(D.absatz_ksk5 AS NUMERIC), 4) AS a70_absatz_ksst5,
  ROUND(CAST(D.absatz_ksk6 AS NUMERIC), 4) AS a72_absatz_ksst6,
  ROUND(CAST(D.absatz_ksk7 AS NUMERIC), 4) AS a74_absatz_ksst7,
  0 AS a90_absatz_ost_basis,
  0 AS a92_absatz_ost_gross,
  0 AS a94_absatz_sued_ost,
  0 AS a96_absatz_sued_west,
  0 AS a98_absatz_west,
  0 AS a100_absatz_nord,
  CAST(D.anz_wo_mit_abs_sk1 AS INTEGER) AS markt_wochen_sst1,
  CAST(D.anz_wo_mit_abs_sk2 AS INTEGER) AS markt_wochen_sst2,
  CAST(D.anz_wo_mit_abs_sk3 AS INTEGER) AS markt_wochen_sst3,
  CAST(D.anz_wo_mit_abs_sk4 AS INTEGER) AS markt_wochen_sst4,
  CAST(D.anz_wo_mit_abs_sk5 AS INTEGER) AS markt_wochen_sst5,
  CAST(D.anz_wo_mit_abs_sk6 AS INTEGER) AS markt_wochen_sst6,
  CAST(D.anz_wo_mit_abs_sk7 AS INTEGER) AS markt_wochen_sst7,
  CAST(D.anz_wo_mit_abs_ksk1 AS INTEGER) AS markt_wochen_ksst1,
  CAST(D.anz_wo_mit_abs_ksk2 AS INTEGER) AS markt_wochen_ksst2,
  CAST(D.anz_wo_mit_abs_ksk3 AS INTEGER) AS markt_wochen_ksst3,
  CAST(D.anz_wo_mit_abs_ksk4 AS INTEGER) AS markt_wochen_ksst4,
  CAST(D.anz_wo_mit_abs_ksk5 AS INTEGER) AS markt_wochen_ksst5,
  CAST(D.anz_wo_mit_abs_ksk6 AS INTEGER) AS markt_wochen_ksst6,
  CAST(D.anz_wo_mit_abs_ksk7 AS INTEGER) AS markt_wochen_ksst7,
  0 AS markt_wochen_ost_basis,
  0 AS markt_wochen_ost_gross,
  0 AS markt_wochen_sued_ost,
  0 AS markt_wochen_sued_west,
  0 AS markt_wochen_west,
  0 AS markt_wochen_nord,
  CAST(S.anz_wo_mit_absatz AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_mit_listung,
  CAST(R.anz_wo_listung_1 AS INTEGER) AS anzahl_markt_wochen_kombis_listung,
  H.pk1 AS a31_vk_brutto_kl_pk_1,
  H.pk2 AS a333_vk_brutto_kl_pk_2,
  H.pk3 AS a54_vk_brutto_kl_pk_3,
  H.pk4 AS a334_vk_brutto_kl_pk_4,
  H.pk5 AS a432_vk_brutto_kl_pk_5,
  H.pk6 AS a433_vk_brutto_kl_pk_6,
  H.pk7 AS a434_vk_brutto_kl_pk_7,
  H.pk8 AS a435_vk_brutto_kl_pk_8,
  H.pk9 AS a436_vk_brutto_kl_pk_9,
  H.pk10 AS a437_vk_brutto_kl_pk_10,
  CAST(0.0000 AS NUMERIC) AS a30_kb_olk_ek4ndz_stamm,
  I.total_rohertrag_olk AS a23_rohertrag_ekmep_olk_4n,
  '' AS a51_listung_sst_pflege,
  '' AS a52_listung_k_sst_pflege,
  '' AS a426_ost_basis_pflege,
  '' AS a427_ost_gross_pflege,
  '' AS a428_sued_ost_pflege,
  '' AS a429_sued_west_pflege,
  '' AS a430_west_pflege,
  '' AS a431_nord_pflege,
  '' AS a50_listungsaktion,
  '' AS a411_stk_rohertrag_pflege,
  NULL AS a415_kannibalisierungsfaktor,
  NULL AS a412_umsatz_brutto_hochrechnung,
  NULL AS a413_absatz_hochrechnung,
  NULL AS a414_rohertrag_hochrechnung,
  A.distr_gew AS a36_gewichtete_distribution_nielsen,
  A.umsatz_anteil_uwg AS a32_umsatz_anteil_wgi_nielsen,
  A.umsatz_anteil_uwg_kumuliert AS a33_umsatz_anteil_wgi_kumuliert_nielsen,
  A.durchschnitt_preis AS a34_vk_brutto_durchschnitt_nielsen,
  A.umsatz_artikel AS a35_umsatz_nielsen,
  A.anz_monate AS anz_wochen_de_anz_monate_kmo_nielsen,
  A.absatz_artikel AS absatz_nielsen,
  A.kl_markt_anteil_owg AS a376_kl_marktanteil_wg_nielsen,
  A.marktanteilbewertung AS a380_marktanteilbewertung_nielsen,
  A.durchschnitt_anz_maerkte AS a377_durchschnitt_anz_maerkte_nielsen,
  0 AS a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
  0 AS a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
  0 AS a384_durchschn_preis_einheit_gl_normiert_nielsen,
  0 AS a385_numerische_distribution_nielsen,
  0 AS a386_inhaltsmengen_nielsen,
  '' AS a387_duft_geschmack_nielsen,
  '' AS a388_einheit_nielsen,
  A.eigenmarke_fg AS eigenmarke_fg_nielsen,
  A.listung_sst_mvke AS a39_listung_sst_mvke,
  A.listung_k_sst_mvke AS a38_listung_k_sst_mvke,
  A.ost_basis AS a40_ost_basis,
  A.ost_gross AS a41_ost_gross,
  A.sued_ost AS a42_sued_ost,
  A.sued_west AS a43_sued_west,
  A.west AS a44_west,
  A.nord AS a45_nord,
  DATE('1900-01-01') AS a37_listung_erster_markt,
  A.anz_maerkte_sst AS a59_anz_maerkte_sst,
  A.anz_maerkte_k_sst AS a449_anz_maerkte_k_sst,
  A.max_anz_maerkte_sst AS a46_max_anz_maerkte_sst,
  A.max_anz_maerkte_k_sst AS a47_max_anz_maerkte_k_sst,
  A.anz_maerkte_listung_gesamt AS a53_anz_maerkte_listung_gesamt,
  A.anz_maerkte_listung_einzel AS a57_anz_maerkte_listung_einzel,
  A.anz_maerkte_baustein_sonstige,
  0 AS anz_bons_af,
  0 AS anz_bons_sa,
  0 AS anz_bons_gesamt,
  J.re_mep_tot_olk_vj AS rohertrag_ekmep_olk_4n_vj,
  CAST(I.total_rohertrag_olk_af AS NUMERIC) AS rohertrag_ekmep_olk_4n_af,
  CAST(I.total_rohertrag_olk_sa AS NUMERIC) AS rohertrag_ekmep_olk_4n_sa,
  CAST(J.re_mep_af_olk_vj AS NUMERIC) AS rohertrag_ekmep_olk_4n_af_vj,
  CAST(J.re_mep_sa_olk_vj AS NUMERIC) AS rohertrag_ekmep_olk_4n_sa_vj,
  A.preislagenverteilung AS a381_preislagenverteilung,
  V.abschriftbetrag_netto AS a27_totalabschriften_wert_netto_absolut,
  0 AS a313_preisabschriften_preisanderungen_wert_netto_absolut,
  X.abschriftbetrag_netto AS totalabschriften_wert_netto_absolut_vj,
  0 AS preisabschriften_preisanderungen_wert_netto_absolut_vj,
  SUBSTR(CAST(G.kol_la_bzw AS STRING), 1, 100) AS a402_kolli_la,
  SUBSTR(CAST(G.kol_bst_bzw AS STRING), 1, 100) AS a401_kolli_bst,
  G.rlz AS a403_restlaufzeit_zl,
  G.rlz_dz AS a404_restlaufzeit_dz,
  A1.gewart_id AS a405_basismengeneinheit,
  DATE('1900-01-01') AS a406_letzte_listungsaenderung_sst_ksst,
  A1.verhandler_id AS a407_verhandler,
  '' AS a408_display_komponente_kz,
  '' AS a409_kl_art_id_display,
  '' AS a416_artikelrolle_id,
  '' AS a417_artikelrolle_bez,
  0 AS kassenumsatz_kl_absolut_netto_wg,
   CASE
   WHEN K.anz_bons > 2047483647
   THEN 2047483647
   ELSE K.anz_bons
   END AS anz_bons_tupel,
  0 AS restbon_summe,
  0 AS totalabschriften_wert_netto_absolut_wg,
  0 AS preisabschriften_preisanderungen_wert_netto_absolut_wg,
  0 AS anz_bons_af_markt_tag,
  0 AS anz_bons_sa_markt_tag,
   K.cp_bons_af + K.cp_bons_sa AS cpq_tupel,
  K.cp_bons_af,
  K.cp_bons_sa,
  1 AS umrech_faktor,
  G.lagerprozent,
  O.absatz_af_mit_listung AS absatz_af_kl_listungswochen,
  P.absatz_af_mit_listung AS absatz_af_kl_vj_listungswochen,
  O.absatz_sa_mit_listung AS absatz_sa_kl_listungswochen,
  P.absatz_sa_mit_listung AS absatz_sa_kl_vj_listungswochen,
  O.umsatz_af_mit_listung AS kassenumsatz_af_kl_absolut_netto_listungswochen,
  P.umsatz_af_mit_listung AS kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
  O.umsatz_sa_mit_listung AS kassenumsatz_sa_kl_absolut_netto_listungswochen,
  P.umsatz_sa_mit_listung AS kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
  O.ertrag_af_mit_listung AS rohertrag_ekmep_olk_4n_af_listungswochen,
  P.ertrag_af_mit_listung AS rohertrag_ekmep_olk_4n_af_vj_listungswochen,
  O.ertrag_sa_mit_listung AS rohertrag_ekmep_olk_4n_sa_listungswochen,
  P.ertrag_sa_mit_listung AS rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM dbp_data.sortiment_leistung_1 AS A
  LEFT JOIN dbp_data.art_1 AS A1 ON A.mandant_id = A1.mandant_id AND A.art_id = A1.art_id
  LEFT JOIN `_anz_wochen1` AS B ON A.matching_id = B.art_matching_id AND A.mandant_id = B.mandant_id
  LEFT JOIN `_anz_wochen1_vj` AS C ON A.matching_id = C.art_matching_id AND A.mandant_id = C.mandant_id
  LEFT JOIN zzmd0e1 AS D ON A.matching_id = D.art_matching_id AND A.mandant_id = D.mandant_id
  LEFT JOIN dbp_etl.sal_snap_final_kmo_1 AS G ON A.matching_id = G.art_matching_id AND A.mandant_id = G.mandant_id
    
  LEFT JOIN `_vk1` AS H ON A.matching_id = H.art_matching_id AND A.mandant_id = H.mandant_id
  LEFT JOIN `_ek1` AS I ON A.matching_id = I.art_matching_id AND A.mandant_id = I.mandant_id
  LEFT JOIN `_ek1_vj` AS J ON A.matching_id = J.art_matching_id AND A.mandant_id = J.mandant_id
  LEFT JOIN `_kpi1` AS K ON A.matching_id = K.art_matching_id AND A.mandant_id = K.mandant_id
  LEFT JOIN dbp_etl.sal_snap2_kmo_1 AS L ON A.matching_id = L.art_matching_id AND A.mandant_id = L.mandant_id
    
  LEFT JOIN dbp_etl.sal_snap2_multis_1 AS M ON A.matching_id = M.art_matching_id AND A.mandant_id = M.mandant_id
    
  LEFT JOIN `_mm_x` AS N ON A.matching_id = N.matching_id AND A.mandant_id = N.mandant_id
  LEFT JOIN `_mm_z` AS O ON A.matching_id = O.matching_id AND A.mandant_id = O.mandant_id
  LEFT JOIN `_mm_z_vj` AS P ON A.matching_id = P.matching_id AND A.mandant_id = P.mandant_id
  LEFT JOIN zzsp07_pre_tag_xxx AS Q ON A.matching_id = Q.matching_id AND A.mandant_id = Q.mandant_id
  LEFT JOIN zzsp08_pre_xxx AS R ON A.matching_id = R.matching_id AND A.mandant_id = R.mandant_id
  LEFT JOIN `_mm_y_xxx` AS S ON A.matching_id = S.matching_id AND A.mandant_id = S.mandant_id
  LEFT JOIN zzsp07_pre_tag_vj_xxx AS T ON A.matching_id = T.matching_id AND A.mandant_id = T.mandant_id
  LEFT JOIN zzsp08_pre_xxx AS U ON A.matching_id = U.matching_id AND A.mandant_id = U.mandant_id
  LEFT JOIN `_abs_kmo` AS V ON A.matching_id = V.art_matching_id AND A.mandant_id = V.mandant_id
  LEFT JOIN `_abs_kmo_vj` AS X ON A.matching_id = X.art_matching_id AND A.mandant_id = X.mandant_id
 WHERE A.mandant_id IN (${MANDANT_ID})
  AND (A.mandant_id, A.kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id IN (${MANDANT_ID})
    GROUP BY mandant_id));


DELETE FROM dbp_etl_process.tupel_mat_1
WHERE mandant_id IN (${MANDANT_ID}) AND (mandant_id, a500_kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
   FROM dbp_data.sortiment_leistung_1
   WHERE mandant_id IN (${MANDANT_ID})
   GROUP BY mandant_id);


INSERT INTO dbp_etl_process.tupel_mat_1
(SELECT DISTINCT A.mandant_id,
  A.a500_kjwo_update,
  A.matching_id,
  A.a425_kjmo,
  A.wrg_id,
  A.a5_owg_id,
  A.a7_wg_id,
  A.wug_id,
  A.art_id,
  A.kl_art_id,
  A.art_bez_land,
  A.art_bez_deutsch,
  A.a14_art_status_de,
  A.nielsen_art_bez,
  A.nielsen_gtin,
  A.a58_rang_umsatz_owg,
  A.a2_rang_umsatz_wg,
  A.a59_rang_absatz_wg,
  A.a16_akt_lieferant_id,
  A.a419_hersteller_id,
  A.a418_lieferant_bez_land,
  A.a446_lieferant_bez_latein,
  A.a420_hersteller_bez_land,
  A.a447_hersteller_bez_latein,
  A.lieferant_nielsen,
  A.a389_zek_id,
  A.a391_disc_pe,
  A.a392_disc_ohne_etikett,
  A.a400_lcf,
  A.a393_vegan,
  A.a394_gluten,
  A.a395_bio,
  A.a396_eigenmarke,
  A.a397_tierwohl,
  A.a398_posten_food,
  A.a399_posten_nonfood,
  A.a339_umsatzsteuer,
  A.a36_gewichtete_distribution,
  A.a60_muki_vk_kz,
  A.a61_muki_vk_kl_art_id_verkettung,
  B.anzahl_markt_wochen_kombis_abverkauf_af,
  B.anzahl_markt_wochen_kombis_abverkauf_sa,
  B.anzahl_markt_wochen_kombis_abverkauf_af_vj,
  B.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
  B.a273_kassenumsatz_kl_absolut_brutto,
  B.kassenumsatz_af_kl_absolut_brutto,
  B.kassenumsatz_sa_kl_absolut_brutto,
  B.kassenumsatz_kl_absolut_brutto_vj,
  B.kassenumsatz_af_kl_absolut_brutto_vj,
  B.kassenumsatz_sa_kl_absolut_brutto_vj,
  B.a21_kassenumsatz_kl_absolut_netto,
  B.kassenumsatz_af_kl_absolut_netto,
  B.kassenumsatz_sa_kl_absolut_netto,
  B.kassenumsatz_kl_absolut_netto_vj,
  B.kassenumsatz_af_kl_absolut_netto_vj,
  B.kassenumsatz_sa_kl_absolut_netto_vj,
  B.a17_absatz_kl,
  B.absatz_af_kl,
  B.absatz_sa_kl,
  B.absatz_kl_vj,
  B.absatz_af_kl_vj,
  B.absatz_sa_kl_vj,
  B.a76_absatz_sst1,
  B.a78_absatz_sst2,
  B.a80_absatz_sst3,
  B.a82_absatz_sst4,
  B.a84_absatz_sst5,
  B.a86_absatz_sst6,
  B.a88_absatz_sst7,
  B.a62_absatz_ksst1,
  B.a64_absatz_ksst2,
  B.a66_absatz_ksst3,
  B.a68_absatz_ksst4,
  B.a70_absatz_ksst5,
  B.a72_absatz_ksst6,
  B.a74_absatz_ksst7,
  B.a90_absatz_ost_basis,
  B.a92_absatz_ost_gross,
  B.a94_absatz_sued_ost,
  B.a96_absatz_sued_west,
  B.a98_absatz_west,
  B.a100_absatz_nord,
  B.markt_wochen_sst1,
  B.markt_wochen_sst2,
  B.markt_wochen_sst3,
  B.markt_wochen_sst4,
  B.markt_wochen_sst5,
  B.markt_wochen_sst6,
  B.markt_wochen_sst7,
  B.markt_wochen_ksst1,
  B.markt_wochen_ksst2,
  B.markt_wochen_ksst3,
  B.markt_wochen_ksst4,
  B.markt_wochen_ksst5,
  B.markt_wochen_ksst6,
  B.markt_wochen_ksst7,
  B.markt_wochen_ost_basis,
  B.markt_wochen_ost_gross,
  B.markt_wochen_sued_ost,
  B.markt_wochen_sued_west,
  B.markt_wochen_west,
  B.markt_wochen_nord,
  B.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
  B.anzahl_markt_wochen_kombis_listung,
  B.a31_vk_brutto_kl_pk_1,
  B.a333_vk_brutto_kl_pk_2,
  B.a54_vk_brutto_kl_pk_3,
  B.a334_vk_brutto_kl_pk_4,
  B.a432_vk_brutto_kl_pk_5,
  B.a433_vk_brutto_kl_pk_6,
  B.a434_vk_brutto_kl_pk_7,
  B.a435_vk_brutto_kl_pk_8,
  B.a436_vk_brutto_kl_pk_9,
  B.a437_vk_brutto_kl_pk_10,
  B.a30_kb_olk_ek4ndz_stamm,
  B.a23_rohertrag_ekmep_olk_4n,
  B.a51_listung_sst_pflege,
  B.a52_listung_k_sst_pflege,
  B.a426_ost_basis_pflege,
  B.a427_ost_gross_pflege,
  B.a428_sued_ost_pflege,
  B.a429_sued_west_pflege,
  B.a430_west_pflege,
  B.a431_nord_pflege,
  B.a50_listungsaktion,
  B.a411_stk_rohertrag_pflege,
  B.a415_kannibalisierungsfaktor,
  B.a412_umsatz_brutto_hochrechnung,
  B.a413_absatz_hochrechnung,
  B.a414_rohertrag_hochrechnung,
  B.a36_gewichtete_distribution_nielsen,
  B.a32_umsatz_anteil_wgi_nielsen,
  B.a33_umsatz_anteil_wgi_kumuliert_nielsen,
  B.a34_vk_brutto_durchschnitt_nielsen,
  B.a35_umsatz_nielsen,
  B.anz_wochen_de_anz_monate_kmo_nielsen,
  B.absatz_nielsen,
  B.a376_kl_marktanteil_wg_nielsen,
  B.a380_marktanteilbewertung_nielsen,
  B.a377_durchschnitt_anz_maerkte_nielsen,
  B.a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
  B.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
  B.a384_durchschn_preis_einheit_gl_normiert_nielsen,
  B.a385_numerische_distribution_nielsen,
  B.a386_inhaltsmengen_nielsen,
  B.a387_duft_geschmack_nielsen,
  B.a388_einheit_nielsen,
  B.eigenmarke_fg_nielsen,
  B.a39_listung_sst_mvke,
  B.a38_listung_k_sst_mvke,
  B.a40_ost_basis,
  B.a41_ost_gross,
  B.a42_sued_ost,
  B.a43_sued_west,
  B.a44_west,
  B.a45_nord,
  B.a37_listung_erster_markt,
  B.a59_anz_maerkte_sst,
  B.a449_anz_maerkte_k_sst,
  B.a46_max_anz_maerkte_sst,
  B.a47_max_anz_maerkte_k_sst,
  B.a53_anz_maerkte_listung_gesamt,
  B.a57_anz_maerkte_listung_einzel,
  B.anz_maerkte_baustein_sonstige,
  B.anz_bons_af,
  B.anz_bons_sa,
  B.anz_bons_gesamt,
  B.rohertrag_ekmep_olk_4n_vj,
  B.rohertrag_ekmep_olk_4n_af,
  B.rohertrag_ekmep_olk_4n_sa,
  B.rohertrag_ekmep_olk_4n_af_vj,
  B.rohertrag_ekmep_olk_4n_sa_vj,
  B.a381_preislagenverteilung,
  B.a27_totalabschriften_wert_netto_absolut,
  B.a313_preisabschriften_preisanderungen_wert_netto_absolut,
  B.totalabschriften_wert_netto_absolut_vj,
  B.preisabschriften_preisanderungen_wert_netto_absolut_vj,
  B.a402_kolli_la,
  B.a401_kolli_bst,
  B.a403_restlaufzeit_zl,
  B.a404_restlaufzeit_dz,
  B.a405_basismengeneinheit,
  B.a406_letzte_listungsanderung_sst_ksst,
  B.a407_verhandler,
  B.a408_display_komponente_kz,
  B.a409_kl_art_id_display,
  B.a416_artikelrolle_id,
  B.a417_artikelrolle_bez,
  B.kassenumsatz_kl_absolut_netto_wg,
  B.anz_bons_tupel,
  B.restbon_summe,
  B.totalabschriften_wert_netto_absolut_wg,
  B.preisabschriften_preisanderungen_wert_netto_absolut_wg,
  B.anz_bons_af_markt_tag,
  B.anz_bons_sa_markt_tag,
  B.cpq_tupel,
  B.cp_bons_af,
  B.cp_bons_sa,
  B.umrech_faktor,
  B.lagerprozent,
  B.absatz_af_kl_listungswochen,
  B.absatz_af_kl_vj_listungswochen,
  B.absatz_sa_kl_listungswochen,
  B.absatz_sa_kl_vj_listungswochen,
  B.kassenumsatz_af_kl_absolut_netto_listungswochen,
  B.kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
  B.kassenumsatz_sa_kl_absolut_netto_listungswochen,
  B.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
  B.rohertrag_ekmep_olk_4n_af_listungswochen,
  B.rohertrag_ekmep_olk_4n_af_vj_listungswochen,
  B.rohertrag_ekmep_olk_4n_sa_listungswochen,
  B.rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
  '' AS sustain_concat,
  0 AS check_fg,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  '' AS tupel_typ,
  '' AS a471_marke_nielsen_bez,
  '' AS a515_bio_organic_nielsen_kz,
  '' AS a516_veggy_split_nielsen_kz,
  '' AS a517_laktosefrei_nielsen_kz,
  '' AS a518_glutenfrei_nielsen_kz,
  A.a510_muki_ek_kz,
  A.a511_muki_ek_kl_art_id_verkettung,
  A.a512_muki_wb_kz,
  A.a513_muki_wb_kl_art_id_verkettung,
  NULL AS a519_umsatz_anteil_wg_nielsen,
  NULL AS a520_umsatz_anteil_wg_kumuliert_nielsen,
  NULL AS a521_inhalt_menge
 FROM dbp_etl_process.tupel_mat_step1_1 AS A
  INNER JOIN dbp_etl_process.tupel_mat_step2_1 AS B ON A.mandant_id = B.mandant_id AND A.a500_kjwo_update =
      B.a500_kjwo_update AND A.matching_id = B.matching_id AND A.a425_kjmo = B.a425_kjmo
 WHERE A.mandant_id IN (${MANDANT_ID})
  AND (A.mandant_id, A.a500_kjwo_update) IN (SELECT (mandant_id, MAX(kjwo_update))
    FROM dbp_data.sortiment_leistung_1
    WHERE mandant_id IN (${MANDANT_ID})
    GROUP BY mandant_id));