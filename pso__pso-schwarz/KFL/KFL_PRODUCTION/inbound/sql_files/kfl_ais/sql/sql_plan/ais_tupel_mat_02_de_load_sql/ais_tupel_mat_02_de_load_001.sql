CREATE OR REPLACE TABLE dbp_etl.art_matching_nielsen_per_de_xxx AS (
SELECT *
FROM dbp_etl.art_matching_nielsen_per
);

DELETE FROM dbp_etl.art_matching_nielsen_per_de_xxx
WHERE (art_matching_id) IN (SELECT matching_id 
                            FROM dbp_data.sortiment_leistung
                            WHERE kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1) AND
                                  mandant_id = 1 AND
                                  art_id IS NULL)
;

DELETE FROM dbp_etl_process.tupel_mat_step1
WHERE mandant_id = 1 AND
      A500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

INSERT INTO dbp_etl_process.tupel_mat_step1 (mandant_id
                                      ,A500_kjwo_update
                                      ,matching_id
                                      ,A425_kjmo
                                      ,wrg_id
                                      ,A5_owg_id
                                      ,A7_wg_id
                                      ,wug_id
                                      ,art_id
                                      ,kl_art_id
                                      ,art_bez_land
                                      ,art_bez_deutsch
                                      ,A14_art_status_de
                                      ,nielsen_art_bez
                                      ,nielsen_gtin
                                      ,A58_rang_umsatz_owg
                                      ,A2_rang_umsatz_wg
                                      ,A59_rang_absatz_wg
                                      ,A16_akt_lieferant_id
                                      ,A419_hersteller_id
                                      ,A418_lieferant_bez_land
                                      ,A446_lieferant_bez_latein
                                      ,A420_hersteller_bez_land
                                      ,A447_hersteller_bez_latein
                                      ,lieferant_nielsen
                                      ,A389_zek_id
                                      ,A391_disc_pe
                                      ,A392_disc_ohne_etikett
                                      ,A400_lcf
                                      ,A393_vegan
                                      ,A394_gluten
                                      ,A395_bio
                                      ,A396_eigenmarke
                                      ,A397_tierwohl
                                      ,A398_posten_food
                                      ,A399_posten_nonfood
                                      ,A339_umsatzsteuer
                                      ,A36_gewichtete_distribution
                                      ,A60_muki_vk_kz
                                      ,A61_muki_vk_kl_art_id_verkettung
                                      ,A510_muki_ek_kz
                                      ,A511_muki_ek_kl_art_id_verkettung
                                      ,A512_muki_wb_kz
                                      ,A513_muki_wb_kl_art_id_verkettung)
SELECT DISTINCT
       a.mandant_id
      ,a.kjwo_update
      ,a.matching_id
      ,a.kjmo
      ,a.wrg_id
      ,a.owg_id
      ,a.wg_id
      ,a.wug_id
      ,a.art_id
      ,a.kl_art_id
      ,a.art_bez
      ,a.art_bez 
      ,a.art_status
      ,a.nielsen_art_bez
      ,a.gtin
      ,a.rang_umsatz_wg
      ,a.rang_umsatz_uwg
      ,a.rang_absatz_uwg
      ,b.akt_gp_id
      ,'' AS hersteller_id
      ,b.akt_gp_id
      ,b.akt_gp_id
      ,'' AS A420_hersteller_bez_land
      ,'' AS A447_hersteller_bez_latein
      ,'' AS lieferant_nielsen
      ,a.zek_id
      ,a.disc_pe
      ,a.disc_marke
      ,a.lcf
      ,a.vegan
      ,a.gluten
      ,a.bio
      ,a.eigenmarke
      ,a.tierwohl
      ,a.posten_food
      ,a.posten_nonfood
      ,a.mwst
      ,a.gewichtete_distribution
      ,a.muki_vk_kz
      ,a.muki_vk_kl_art_id_verkettung
      ,a.muki_ek_kz                  
      ,a.muki_ek_kl_art_id_verkettung
      ,a.muki_wb_kz                  
      ,a.muki_wb_kl_art_id_verkettung
FROM dbp_data.sortiment_leistung a
LEFT JOIN (SELECT mandant_id,
                  art_id,
                  MAX(akt_gp_id) AS akt_gp_id
           FROM dbp_msi_view2.mv_art_gp_nm_zu_aktuell
           GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
WHERE a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_de (
      mandant_id BYTEINT,
      dat DATE,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      bewart_id SMALLINT,
      menge DECIMAL(18,3),
      umsatz_netto DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      ek_mep DECIMAL(18,4))
;

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4),
      dat DATE,
      absatz DECIMAL(18,3),
      absatz_sa DECIMAL(18,3),
      absatz_af DECIMAL(18,3),
      umsatz DECIMAL(18,4),
      umsatz_sa DECIMAL(18,4),
      umsatz_af DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      umsatz_brutto_af DECIMAL(18,4),
      umsatz_brutto_sa DECIMAL(18,4),
      ertrag DECIMAL(18,4),
      ertrag_sa DECIMAL(18,4),
      ertrag_af DECIMAL(18,4),
      anzahl_wochen_mit_absatz INTEGER,
      anzahl_wochen_mit_absatz_sa INTEGER,
      anzahl_wochen_mit_absatz_af INTEGER)
;

INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_de
SELECT a.mandant_id,
       a.dat,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge*d.umrech_faktor,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep
FROM dbp_data.artbew a
JOIN dbp_data.tag c
  ON a.dat = c.dat
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT mandant_id,
             art_id,
             MAX(umrech_faktor) AS umrech_faktor
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE mandant_id = 1 AND
            art_id <> -1
      GROUP BY 1,2) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE (a.mandant_id,c.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                               FROM (SELECT b.mandant_id,
                                            c.kjwo,
                                            Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                     FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                     JOIN (SELECT mandant_id,
                                                  Max(kjmo) AS kjmo
                                           FROM dbp_data.sortiment_leistung
                                           WHERE mandant_id = 1
                                           GROUP BY 1) b
                                       ON a.kjmo_sort = b.kjmo
                                     JOIN dbp_data.woche c
                                       ON c.kjwo <= a.kjwo_bis) x
                               WHERE x.akt_wo BETWEEN -52 AND -1
                               GROUP BY 1,2) AND
      a.mandant_id = 1
;

INSERT INTO dbp_etl.bf_listung_markt_tag (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,dat
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,umsatz
                                           ,umsatz_sa
                                           ,umsatz_af
                                           ,umsatz_brutto
                                           ,umsatz_brutto_sa
                                           ,umsatz_brutto_af
                                           ,ertrag
                                           ,ertrag_sa
                                           ,ertrag_af
                                           ,anzahl_wochen_mit_absatz
                                           ,anzahl_wochen_mit_absatz_sa
                                           ,anzahl_wochen_mit_absatz_af)
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.dat
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(SUM(v01.umsatz_netto)) AS umsatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZEROIFNULL(SUM(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZEROIFNULL(SUM(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v01.dat) END) AS anzahl_wochen_mit_absatz
      ,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_tag_sum_de v01
JOIN dbp_data.art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_tag (
    dat DATE,
    matching_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT,
    anz_wo_mit_absatz_af FLOAT,
    anz_wo_mit_absatz_sa FLOAT
);

INSERT INTO ZZSP07_pre_tag
SELECT a11.dat,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       CASE WHEN SUM(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN SUM(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN SUM(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa
FROM dbp_etl.bf_listung_markt_tag a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_tag_xxx AS (
SELECT mandant_id,
       matching_id,
       SUM(anz_wo_mit_absatz)/7.0000 AS anz_wo_mit_absatz,
       SUM(anz_wo_mit_absatz_af)/7.0000 AS anz_wo_mit_absatz_af,
       SUM(anz_wo_mit_absatz_sa)/7.0000 AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre_tag
GROUP BY 1,2
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_de (
      mandant_id BYTEINT,
      kjwo INTEGER,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      bewart_id SMALLINT,
      menge DECIMAL(18,3),
      umsatz_netto DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      ek_mep DECIMAL(18,4))
;

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4),
      kjwo INTEGER,
      absatz DECIMAL(18,3),
      absatz_sa DECIMAL(18,3),
      absatz_af DECIMAL(18,3),
      umsatz DECIMAL(18,4),
      umsatz_sa DECIMAL(18,4),
      umsatz_af DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      umsatz_brutto_af DECIMAL(18,4),
      umsatz_brutto_sa DECIMAL(18,4),
      ertrag DECIMAL(18,4),
      ertrag_sa DECIMAL(18,4),
      ertrag_af DECIMAL(18,4),
      anzahl_wochen_mit_absatz INTEGER,
      anzahl_wochen_mit_absatz_sa INTEGER,
      anzahl_wochen_mit_absatz_af INTEGER)
;

INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_de
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge*d.umrech_faktor,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep
FROM dbp_data.artbew_wo_sum a
JOIN dbp_data.woche_kj_kl c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT mandant_id,
             art_id,
             Max(umrech_faktor) AS umrech_faktor
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE mandant_id = 1 AND
            art_id <> -1
      GROUP BY 1,2) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE (a.mandant_id,c.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                               FROM (SELECT b.mandant_id,
                                            c.kjwo,
                                            Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                     FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                     JOIN (SELECT mandant_id,
                                                  Max(kjmo) AS kjmo
                                           FROM dbp_data.sortiment_leistung
                                           WHERE mandant_id = 1
                                           GROUP BY 1) b
                                       ON a.kjmo_sort = b.kjmo
                                     JOIN dbp_data.woche c
                                       ON c.kjwo <= a.kjwo_bis) x
                               WHERE x.akt_wo BETWEEN -52 AND -1
                               GROUP BY 1,2) AND
      a.mandant_id = 1
;

INSERT INTO dbp_etl.bf_listung_markt_kw (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,kjwo
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,umsatz
                                           ,umsatz_sa
                                           ,umsatz_af
                                           ,umsatz_brutto
                                           ,umsatz_brutto_sa
                                           ,umsatz_brutto_af
                                           ,ertrag
                                           ,ertrag_sa
                                           ,ertrag_af
                                           ,anzahl_wochen_mit_absatz
                                           ,anzahl_wochen_mit_absatz_sa
                                           ,anzahl_wochen_mit_absatz_af)
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto)) AS umsatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZeroIfNull(Sum(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de v01
JOIN dbp_data.art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT,
    anz_wo_mit_absatz_af FLOAT,
    anz_wo_mit_absatz_sa FLOAT
);

INSERT INTO ZZSP07_pre
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN Sum(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN Sum(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa
FROM dbp_etl.bf_listung_markt_kw a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_xxx AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung FLOAT)
;

INSERT INTO ZZSP08_pre
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung
FROM dbp_data.art_wup_listung_kjwo a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE (a11.mandant_id,a11.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung
                                                WHERE mandant_id = 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) AND
      a11.mandant_id = 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_xxx AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_listung) AS anz_wo_listung
FROM ZZSP08_pre
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.matching_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

CREATE OR REPLACE VOLATILE TABLE _mm_y AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.matching_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

DELETE FROM _mm_y
WHERE anz_wo_mit_absatz = 0
;

CREATE OR REPLACE VOLATILE TABLE _mm_y_xxx AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM _mm_y
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm_z AS (
SELECT b.art_matching_id AS matching_id,
       a11.mandant_id,
       Sum(a11.umsatz_af)  umsatz_af_mit_listung,
       Sum(a11.umsatz_sa)  umsatz_sa_mit_listung,
       Sum(a11.umsatz_brutto_af)  umsatz_brutto_af_mit_listung,
       Sum(a11.umsatz_brutto_sa)  umsatz_brutto_sa_mit_listung,
       Sum(a11.ertrag_af)  ertrag_af_mit_listung,
       Sum(a11.ertrag_sa)  ertrag_sa_mit_listung,
       Sum(a11.absatz_af)  absatz_af_mit_listung,
       Sum(a11.absatz_sa)  absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id
JOIN _mm_y c
  ON a11.mandant_id = c.mandant_id AND
     b.art_matching_id = c.matching_id AND
     a11.kjwo = c.kjwo AND
     a11.wup_id = c.wup_id
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm_x AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_listung) AS anz_wo_mit_listung_absatz
FROM _mm
GROUP BY 1,2
);

INSERT INTO _mm
SELECT kjwo,
       matching_id,
       mandant_id,
       wup_id,
       anz_wo_listung,
       0
FROM ZZSP08_pre
WHERE (kjwo,matching_id,mandant_id,wup_id) NOT IN (SELECT kjwo,matching_id,mandant_id,wup_id FROM _mm)
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07 (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_mit_absatz	FLOAT
);

INSERT INTO ZZSP07 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       Sum(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz
FROM _mm a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08 (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_listung FLOAT)
;

INSERT INTO ZZSP08 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       Sum(a11.anz_wo_listung)  anz_wo_listung
FROM _mm a11
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZOJ09 (
  matching_id INTEGER, 
  mandant_id BYTEINT)
;

INSERT INTO ZZOJ09 
SELECT pa11.matching_id  matching_id,
      pa11.mandant_id  mandant_id
FROM ZZSP07 pa11
GROUP BY 1,2
UNION
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id
FROM ZZSP08 pa11
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0A_xxx (
  matching_id INTEGER, 
  mandant_id BYTEINT, 
  WJXBFS1 FLOAT, 
  anz_wo_listung FLOAT, 
  anz_wo_mit_absatz	FLOAT,
  schnelldreherquote FLOAT)
;

INSERT INTO ZZMD0A_xxx 
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       1.0  WJXBFS1,
       pa13.anz_wo_listung  anz_wo_listung,
       pa12.anz_wo_mit_absatz  anz_wo_mit_absatz,
       Round((pa12.anz_wo_mit_absatz/NullIfZero(pa13.anz_wo_listung))*100,1) AS schnelldreherquote
FROM ZZOJ09 pa11
LEFT JOIN ZZSP07 pa12
  ON pa11.matching_id = pa12.matching_id AND 
     pa11.mandant_id = pa12.mandant_id
LEFT JOIN ZZSP08 pa13
  ON pa11.matching_id = pa13.matching_id AND
     pa11.mandant_id = pa13.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _anz_wochen AS (
SELECT a.kjwo,
       b.art_matching_id,
       a.wup_id,
       ZeroIfNull(Sum(a.absatz)) AS absatz_,
       ZeroIfNull(Sum(a.absatz_af)) AS absatz_af_,
       ZeroIfNull(Sum(a.absatz_sa)) AS absatz_sa_,
       ZeroIfNull(Sum(a.umsatz)) AS umsatz_,
       ZeroIfNull(Sum(a.umsatz_af)) AS umsatz_af_,
       ZeroIfNull(Sum(a.umsatz_sa)) AS umsatz_sa_,
       ZeroIfNull(Sum(a.umsatz_brutto)) AS umsatz_brutto_,
       ZeroIfNull(Sum(a.umsatz_brutto_af)) AS umsatz_brutto_af_,
       ZeroIfNull(Sum(a.umsatz_brutto_sa)) AS umsatz_brutto_sa_,
       ZeroIfNull(Sum(a.ertrag)) AS ertrag_,
       ZeroIfNull(Sum(a.ertrag_af)) AS ertrag_af_,
       ZeroIfNull(Sum(a.ertrag_sa)) AS ertrag_sa_,
       ZeroIfNull(CASE WHEN absatz_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz,
       ZeroIfNull(CASE WHEN absatz_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_af,
       ZeroIfNull(CASE WHEN absatz_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_sa,
       ZeroIfNull(CASE WHEN umsatz_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz,
       ZeroIfNull(CASE WHEN umsatz_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_af,
       ZeroIfNull(CASE WHEN umsatz_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_sa,
       ZeroIfNull(CASE WHEN umsatz_brutto_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_brutto,
       ZeroIfNull(CASE WHEN umsatz_brutto_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_brutto_af,
       ZeroIfNull(CASE WHEN umsatz_brutto_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_brutto_sa,
       ZeroIfNull(CASE WHEN ertrag_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag,
       ZeroIfNull(CASE WHEN ertrag_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_af,
       ZeroIfNull(CASE WHEN ertrag_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
WHERE (a.mandant_id,a.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                                FROM (SELECT b.mandant_id,
                                             c.kjwo,
                                             Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                      FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                      JOIN (SELECT mandant_id,
                                                   Max(kjmo) AS kjmo
                                            FROM dbp_data.sortiment_leistung
                                            WHERE mandant_id = 1
                                            GROUP BY 1) b
                                        ON a.kjmo_sort = b.kjmo
                                      JOIN dbp_data.woche c
                                        ON c.kjwo <= a.kjwo_bis) x
                                WHERE x.akt_wo BETWEEN -52 AND -1
                                GROUP BY 1,2)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _anz_wochen1 AS (
SELECT art_matching_id,
       Sum(absatz_) AS absatz,
       Sum(absatz_af_) AS absatz_af,
       Sum(absatz_sa_) AS absatz_sa,
       Sum(umsatz_) AS umsatz,
       Sum(umsatz_af_) AS umsatz_af,
       Sum(umsatz_sa_) AS umsatz_sa,
       Sum(umsatz_brutto_) AS umsatz_brutto,
       Sum(umsatz_brutto_af_) AS umsatz_brutto_af,
       Sum(umsatz_brutto_sa_) AS umsatz_brutto_sa,
       Sum(ertrag_) AS ertrag,
       Sum(ertrag_af_) AS ertrag_af,
       Sum(ertrag_sa_) AS ertrag_sa,
       Sum(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
       Sum(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
       Sum(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
       Sum(anzahl_wochen_mit_umsatz_brutto) AS anzahl_wochen_mit_umsatz_brutto,
       Sum(anzahl_wochen_mit_umsatz_brutto_af) AS anzahl_wochen_mit_umsatz_brutto_af,
       Sum(anzahl_wochen_mit_umsatz_brutto_sa) AS anzahl_wochen_mit_umsatz_brutto_sa,
       Sum(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
       Sum(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
       Sum(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
       Sum(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
       Sum(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
       Sum(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM _anz_wochen
GROUP BY 1
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_de_vj (
      mandant_id BYTEINT,
      dat DATE,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      bewart_id SMALLINT,
      menge DECIMAL(18,3),
      umsatz_netto DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      ek_mep DECIMAL(18,4))
;

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_vj (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4),
      dat DATE,
      absatz DECIMAL(18,3),
      absatz_sa DECIMAL(18,3),
      absatz_af DECIMAL(18,3),
      umsatz DECIMAL(18,4),
      umsatz_sa DECIMAL(18,4),
      umsatz_af DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      umsatz_brutto_af DECIMAL(18,4),
      umsatz_brutto_sa DECIMAL(18,4),
      ertrag DECIMAL(18,4),
      ertrag_sa DECIMAL(18,4),
      ertrag_af DECIMAL(18,4),
      anzahl_wochen_mit_absatz INTEGER,
      anzahl_wochen_mit_absatz_sa INTEGER,
      anzahl_wochen_mit_absatz_af INTEGER)
;

INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_de_vj
SELECT a.mandant_id,
       a.dat,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge*d.umrech_faktor,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep
FROM dbp_data.artbew a
JOIN dbp_data.tag c
  ON a.dat = c.dat
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT mandant_id,
             art_id,
             MAX(umrech_faktor) AS umrech_faktor
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE mandant_id = 1 AND
            art_id <> -1
      GROUP BY 1,2) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE (a.mandant_id,c.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                                FROM (SELECT b.mandant_id,
                                             c.kjwo,
                                             Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                      FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                      JOIN (SELECT mandant_id,
                                                   Max(kjmo) AS kjmo
                                            FROM dbp_data.sortiment_leistung
                                            WHERE mandant_id = 1
                                            GROUP BY 1) b
                                        ON a.kjmo_sort = b.kjmo
                                      JOIN dbp_data.woche c
                                        ON c.kjwo <= a.kjwo_bis) x
                                WHERE x.akt_wo BETWEEN -104 AND -53
                                GROUP BY 1,2) AND
      a.mandant_id = 1
;

INSERT INTO dbp_etl.bf_listung_markt_tag_vj (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,dat
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,umsatz
                                           ,umsatz_sa
                                           ,umsatz_af
                                           ,umsatz_brutto
                                           ,umsatz_brutto_sa
                                           ,umsatz_brutto_af
                                           ,ertrag
                                           ,ertrag_sa
                                           ,ertrag_af
                                           ,anzahl_wochen_mit_absatz
                                           ,anzahl_wochen_mit_absatz_sa
                                           ,anzahl_wochen_mit_absatz_af)
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.dat
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(SUM(v01.umsatz_netto)) AS umsatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZEROIFNULL(SUM(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZEROIFNULL(SUM(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v01.dat) END) AS anzahl_wochen_mit_absatz
      ,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_tag_sum_de_vj v01
JOIN dbp_data.art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_tag_vj (
    dat DATE,
    matching_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT,
    anz_wo_mit_absatz_af FLOAT,
    anz_wo_mit_absatz_sa FLOAT
);

INSERT INTO ZZSP07_pre_tag_vj
SELECT a11.dat,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       CASE WHEN SUM(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN SUM(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN SUM(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa      
FROM dbp_etl.bf_listung_markt_tag_vj a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_tag_vj_xxx AS (
SELECT mandant_id,
       matching_id,
       SUM(anz_wo_mit_absatz)/7.0000 AS anz_wo_mit_absatz,
       SUM(anz_wo_mit_absatz_af)/7.0000 AS anz_wo_mit_absatz_af,
       SUM(anz_wo_mit_absatz_sa)/7.0000 AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre_tag_vj
GROUP BY 1,2
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_de_vj (
      mandant_id BYTEINT,
      kjwo INTEGER,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      bewart_id SMALLINT,
      menge DECIMAL(18,3),
      umsatz_netto DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      ek_mep DECIMAL(18,4))
;

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_vj (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4),
      kjwo INTEGER,
      absatz DECIMAL(18,3),
      absatz_sa DECIMAL(18,3),
      absatz_af DECIMAL(18,3),
      umsatz DECIMAL(18,4),
      umsatz_sa DECIMAL(18,4),
      umsatz_af DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      umsatz_brutto_af DECIMAL(18,4),
      umsatz_brutto_sa DECIMAL(18,4),
      ertrag DECIMAL(18,4),
      ertrag_sa DECIMAL(18,4),
      ertrag_af DECIMAL(18,4),
      anzahl_wochen_mit_absatz INTEGER,
      anzahl_wochen_mit_absatz_sa INTEGER,
      anzahl_wochen_mit_absatz_af INTEGER)
;

INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_de_vj
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge*d.umrech_faktor,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep
FROM dbp_data.artbew_wo_sum a
JOIN dbp_data.woche_kj_kl c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT mandant_id,
             art_id,
             Max(umrech_faktor) AS umrech_faktor
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE mandant_id = 1 AND
            art_id <> -1
      GROUP BY 1,2) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE (a.mandant_id,c.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                                FROM (SELECT b.mandant_id,
                                             c.kjwo,
                                             Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                      FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                      JOIN (SELECT mandant_id,
                                                   Max(kjmo) AS kjmo
                                            FROM dbp_data.sortiment_leistung
                                            WHERE mandant_id = 1
                                            GROUP BY 1) b
                                        ON a.kjmo_sort = b.kjmo
                                      JOIN dbp_data.woche c
                                        ON c.kjwo <= a.kjwo_bis) x
                                WHERE x.akt_wo BETWEEN -104 AND -53
                                GROUP BY 1,2) AND
      a.mandant_id = 1
;

INSERT INTO dbp_etl.bf_listung_markt_kw_vj (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,kjwo
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,umsatz
                                           ,umsatz_sa
                                           ,umsatz_af
                                           ,umsatz_brutto
                                           ,umsatz_brutto_sa
                                           ,umsatz_brutto_af
                                           ,ertrag
                                           ,ertrag_sa
                                           ,ertrag_af
                                           ,anzahl_wochen_mit_absatz
                                           ,anzahl_wochen_mit_absatz_sa
                                           ,anzahl_wochen_mit_absatz_af)
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto)) AS umsatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZeroIfNull(Sum(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_vj v01
JOIN dbp_data.art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_vj (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT,
    anz_wo_mit_absatz_af FLOAT,
    anz_wo_mit_absatz_sa FLOAT
);

INSERT INTO ZZSP07_pre_vj
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN Sum(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN Sum(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa      
FROM dbp_etl.bf_listung_markt_kw_vj a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_vj_xxx AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre_vj
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_vj (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung FLOAT)
;

INSERT INTO ZZSP08_pre_vj
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung
FROM dbp_data.art_wup_listung_kjwo a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE (a11.mandant_id,a11.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung
                                                WHERE mandant_id = 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -104 AND -53
                                    GROUP BY 1,2) AND
      a11.mandant_id = 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_vj_xxx AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_listung) AS anz_wo_listung
FROM ZZSP08_pre_vj
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm_vj AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre_vj a
JOIN ZZSP07_pre_vj b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.matching_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

CREATE OR REPLACE VOLATILE TABLE _mm_y_vj AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre_vj a
JOIN ZZSP07_pre_vj b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.matching_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

DELETE FROM _mm_y_vj
WHERE anz_wo_mit_absatz = 0
;

CREATE OR REPLACE VOLATILE TABLE _mm_z_vj AS (
SELECT b.art_matching_id AS matching_id,
       a11.mandant_id,
       Sum(a11.umsatz_af)  umsatz_af_mit_listung,
       Sum(a11.umsatz_sa)  umsatz_sa_mit_listung,
       Sum(a11.umsatz_brutto_af)  umsatz_brutto_af_mit_listung,
       Sum(a11.umsatz_brutto_sa)  umsatz_brutto_sa_mit_listung,
       Sum(a11.ertrag_af)  ertrag_af_mit_listung,
       Sum(a11.ertrag_sa)  ertrag_sa_mit_listung,
       Sum(a11.absatz_af)  absatz_af_mit_listung,
       Sum(a11.absatz_sa)  absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_vj a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id
JOIN _mm_y_vj c
  ON a11.mandant_id = c.mandant_id AND
     b.art_matching_id = c.matching_id AND
     a11.kjwo = c.kjwo AND
     a11.wup_id = c.wup_id
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm_x_vj AS (
SELECT mandant_id,
       matching_id,
       Sum(anz_wo_listung) AS anz_wo_mit_listung_absatz
FROM _mm_vj
GROUP BY 1,2
);

INSERT INTO _mm_vj
SELECT kjwo,
       matching_id,
       mandant_id,
       wup_id,
       anz_wo_listung,
       0
FROM ZZSP08_pre_vj
WHERE (kjwo,matching_id,mandant_id,wup_id) NOT IN (SELECT kjwo,matching_id,mandant_id,wup_id FROM _mm_vj)
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_mit_absatz	FLOAT
);

INSERT INTO ZZSP07_vj 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       Sum(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz
FROM _mm_vj a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_listung FLOAT)
;

INSERT INTO ZZSP08_vj
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       Sum(a11.anz_wo_listung)  anz_wo_listung
FROM _mm_vj a11
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZOJ09_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT)
;

INSERT INTO ZZOJ09_vj
SELECT pa11.matching_id  matching_id,
      pa11.mandant_id  mandant_id
FROM ZZSP07_vj pa11
GROUP BY 1,2
UNION
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id
FROM ZZSP08_vj pa11
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0A_xxx_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT, 
  WJXBFS1 FLOAT, 
  anz_wo_listung FLOAT, 
  anz_wo_mit_absatz	FLOAT,
  schnelldreherquote FLOAT)
;

INSERT INTO ZZMD0A_xxx_vj
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       1.0  WJXBFS1,
       pa13.anz_wo_listung  anz_wo_listung,
       pa12.anz_wo_mit_absatz  anz_wo_mit_absatz,
       Round((pa12.anz_wo_mit_absatz/NullIfZero(pa13.anz_wo_listung))*100,1) AS schnelldreherquote
FROM ZZOJ09_vj pa11
LEFT JOIN ZZSP07_vj pa12
  ON pa11.matching_id = pa12.matching_id AND 
     pa11.mandant_id = pa12.mandant_id
LEFT JOIN ZZSP08_vj pa13
  ON pa11.matching_id = pa13.matching_id AND
     pa11.mandant_id = pa13.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _anz_wochen_vj AS (
SELECT a.kjwo,
       b.art_matching_id,
       a.wup_id,
       ZeroIfNull(Sum(a.absatz)) AS absatz_,
       ZeroIfNull(Sum(a.absatz_af)) AS absatz_af_,
       ZeroIfNull(Sum(a.absatz_sa)) AS absatz_sa_,
       ZeroIfNull(Sum(a.umsatz)) AS umsatz_,
       ZeroIfNull(Sum(a.umsatz_af)) AS umsatz_af_,
       ZeroIfNull(Sum(a.umsatz_sa)) AS umsatz_sa_,
       ZeroIfNull(Sum(a.umsatz_brutto)) AS umsatz_brutto_,
       ZeroIfNull(Sum(a.umsatz_brutto_af)) AS umsatz_brutto_af_,
       ZeroIfNull(Sum(a.umsatz_brutto_sa)) AS umsatz_brutto_sa_,
       ZeroIfNull(Sum(a.ertrag)) AS ertrag_,
       ZeroIfNull(Sum(a.ertrag_af)) AS ertrag_af_,
       ZeroIfNull(Sum(a.ertrag_sa)) AS ertrag_sa_,
       ZeroIfNull(CASE WHEN absatz_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz,
       ZeroIfNull(CASE WHEN absatz_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_af,
       ZeroIfNull(CASE WHEN absatz_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_sa,
       ZeroIfNull(CASE WHEN umsatz_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz,
       ZeroIfNull(CASE WHEN umsatz_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_af,
       ZeroIfNull(CASE WHEN umsatz_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_sa,
       ZeroIfNull(CASE WHEN umsatz_brutto_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_brutto,
       ZeroIfNull(CASE WHEN umsatz_brutto_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_brutto_af,
       ZeroIfNull(CASE WHEN umsatz_brutto_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_brutto_sa,
       ZeroIfNull(CASE WHEN ertrag_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag,
       ZeroIfNull(CASE WHEN ertrag_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_af,
       ZeroIfNull(CASE WHEN ertrag_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_vj a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
WHERE (a.mandant_id,a.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                                FROM (SELECT b.mandant_id,
                                             c.kjwo,
                                             Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                      FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                      JOIN (SELECT mandant_id,
                                                   Max(kjmo) AS kjmo
                                            FROM dbp_data.sortiment_leistung
                                            WHERE mandant_id = 1
                                            GROUP BY 1) b
                                        ON a.kjmo_sort = b.kjmo
                                      JOIN dbp_data.woche c
                                        ON c.kjwo <= a.kjwo_bis) x
                                WHERE x.akt_wo BETWEEN -104 AND -53
                                GROUP BY 1,2)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _anz_wochen1_vj AS (
SELECT art_matching_id,
       Sum(absatz_) AS absatz,
       Sum(absatz_af_) AS absatz_af,
       Sum(absatz_sa_) AS absatz_sa,
       Sum(umsatz_) AS umsatz,
       Sum(umsatz_af_) AS umsatz_af,
       Sum(umsatz_sa_) AS umsatz_sa,
       Sum(umsatz_brutto_) AS umsatz_brutto,
       Sum(umsatz_brutto_af_) AS umsatz_brutto_af,
       Sum(umsatz_brutto_sa_) AS umsatz_brutto_sa,
       Sum(ertrag_) AS ertrag,
       Sum(ertrag_af_) AS ertrag_af,
       Sum(ertrag_sa_) AS ertrag_sa,
       Sum(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
       Sum(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
       Sum(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
       Sum(anzahl_wochen_mit_umsatz_brutto) AS anzahl_wochen_mit_umsatz_brutto,
       Sum(anzahl_wochen_mit_umsatz_brutto_af) AS anzahl_wochen_mit_umsatz_brutto_af,
       Sum(anzahl_wochen_mit_umsatz_brutto_sa) AS anzahl_wochen_mit_umsatz_brutto_sa,
       Sum(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
       Sum(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
       Sum(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
       Sum(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
       Sum(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
       Sum(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM _anz_wochen_vj
GROUP BY 1
);

CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_kw (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,kjwo
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,anz_wo_mit_absatz
                                           ,anz_wo_mit_absatz_sa
                                           ,anz_wo_mit_absatz_af) AS
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Count(DISTINCT v01.kjwo)) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end)) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end)) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de v01
JOIN dbp_data.art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0E (
	art_id	INTEGER, 
	mandant_id	BYTEINT,
	absatz_sk1	FLOAT, 
	anz_wo_mit_abs_sk1	FLOAT, 
	absatz_sk2	FLOAT, 
	anz_wo_mit_abs_sk2	FLOAT, 
	absatz_sk3	FLOAT, 
	anz_wo_mit_abs_sk3	FLOAT, 
	absatz_sk4	FLOAT, 
	anz_wo_mit_abs_sk4	FLOAT, 
	absatz_sk5	FLOAT, 
	anz_wo_mit_abs_sk5	FLOAT, 
	absatz_sk6	FLOAT, 
	anz_wo_mit_abs_sk6	FLOAT, 
	absatz_sk7	FLOAT, 
	anz_wo_mit_abs_sk7	FLOAT,
    absatz_af_sk1_bis6	FLOAT,
	absatz_sa_sk1_bis6	FLOAT)
;

INSERT INTO ZZMD0E 
SELECT	a11.art_id  art_id,
	a11.mandant_id  mandant_id,
	SUM((CASE WHEN (a14.sm_id = 1 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk1,
	SUM((CASE WHEN (a14.sm_id = 1 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk1,
	SUM((CASE WHEN (a14.sm_id = 2 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk2,
	SUM((CASE WHEN (a14.sm_id = 2 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk2,
	SUM((CASE WHEN (a14.sm_id = 3 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk3,
	SUM((CASE WHEN (a14.sm_id = 3 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk3,
	SUM((CASE WHEN (a14.sm_id = 4 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk4,
	SUM((CASE WHEN (a14.sm_id = 4 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk4,
	SUM((CASE WHEN (a14.sm_id = 5 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk5,
	SUM((CASE WHEN (a14.sm_id = 5 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk5,
	SUM((CASE WHEN (a14.sm_id = 6 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk6,
        SUM((CASE WHEN (a14.sm_id = 6 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk6,
	SUM((CASE WHEN (a14.sm_id = 7 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk7,
	SUM((CASE WHEN (a14.sm_id = 7 AND a14.mandant_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk7,
        SUM((CASE WHEN (a14.mandant_id = 1 AND a14.sm_id IN (1, 2, 3, 4, 5,6,7)) THEN a11.absatz_af ELSE NULL end))  absatz_af_sk1_bis6,
	SUM((CASE WHEN (a14.mandant_id = 1 AND a14.sm_id IN (1, 2, 3, 4, 5,6,7)) THEN a11.absatz_sa ELSE NULL end))  absatz_sa_sk1_bis6
FROM dbp_etl.bf_listung_markt_kw a11
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per a14
  ON (a11.mandant_id = a14.mandant_id AND 
      a11.nb_id = a14.nb_id AND 
      a11.wg_id = a14.wg_id AND 
      a11.wup_id = a14.wup_id)
WHERE ((a14.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE mandant_id = 1 AND wg_filter_id = 11 AND arthiertyp_id = 2)
 AND a11.mandant_id = 1 
 AND ((a14.sm_id = 1 AND a14.mandant_id = 1)
 OR (a14.sm_id = 2 AND a14.mandant_id = 1)
 OR (a14.sm_id = 3 AND a14.mandant_id = 1)
 OR (a14.sm_id = 4 AND a14.mandant_id = 1)
 OR (a14.sm_id = 5 AND a14.mandant_id = 1)
 OR (a14.sm_id = 6 AND a14.mandant_id = 1)
 OR (a14.sm_id = 7 AND a14.mandant_id = 1)
 OR (a14.mandant_id = 1
 AND a14.sm_id IN (1, 2, 3, 4, 5, 6, 7)))))
GROUP BY a11.art_id,a11.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0E1 AS (
SELECT b.art_matching_id,
       Sum(a.absatz_sk1) AS absatz_sk1,
       Sum(a.anz_wo_mit_abs_sk1) AS anz_wo_mit_abs_sk1,
       Sum(a.absatz_sk2) AS absatz_sk2,
       Sum(a.anz_wo_mit_abs_sk2) AS anz_wo_mit_abs_sk2,
       Sum(a.absatz_sk3) AS absatz_sk3,
       Sum(a.anz_wo_mit_abs_sk3) AS anz_wo_mit_abs_sk3,
       Sum(a.absatz_sk4) AS absatz_sk4,
       Sum(a.anz_wo_mit_abs_sk4) AS anz_wo_mit_abs_sk4,
       Sum(a.absatz_sk5) AS absatz_sk5,
       Sum(a.anz_wo_mit_abs_sk5) AS anz_wo_mit_abs_sk5,
       Sum(a.absatz_sk6) AS absatz_sk6,
       Sum(a.anz_wo_mit_abs_sk6) AS anz_wo_mit_abs_sk6,
       Sum(a.absatz_sk7) AS absatz_sk7,
       Sum(a.anz_wo_mit_abs_sk7) AS anz_wo_mit_abs_sk7,
       Sum(a.absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
       Sum(a.absatz_sa_sk1_bis6) AS absatz_sa_sk1_bis6
FROM ZZMD0E a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _regio1 AS (
SELECT b.art_matching_id,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'N' THEN a.absatz END) AS absatz_nord,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'W' THEN a.absatz END) AS absatz_west,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'G' THEN a.absatz END) AS absatz_sued_ost,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'M' THEN a.absatz END) AS absatz_sued_west,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'O' THEN a.absatz END) AS absatz_ost_basis,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'Q' THEN a.absatz END) AS absatz_ost_gross
FROM dbp_etl.bf_listung_markt_kw a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _regio2 AS (
SELECT b.art_matching_id,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'N' THEN a.anzahl_wochen_mit_absatz END) AS anz_wo_mit_abs_nord,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'W' THEN a.anzahl_wochen_mit_absatz END) AS anz_wo_mit_abs_west,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'G' THEN a.anzahl_wochen_mit_absatz END) AS anz_wo_mit_abs_sued_ost,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'M' THEN a.anzahl_wochen_mit_absatz END) AS anz_wo_mit_abs_sued_west,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'O' THEN a.anzahl_wochen_mit_absatz END) AS anz_wo_mit_abs_ost_basis,
       Sum(CASE WHEN a.kreistyp_gruppe_id = 'Q' THEN a.anzahl_wochen_mit_absatz END) AS anz_wo_mit_abs_ost_gross
FROM dbp_etl.bf_listung_markt_kw a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _vk1 AS (
SELECT a.mandant_id,
       a.art_id,
       Max(CASE WHEN a.pm_id = 1  THEN a.vk_brutto END) AS pk1,
       Max(CASE WHEN a.pm_id = 2  THEN a.vk_brutto END) AS pk2,
       Max(CASE WHEN a.pm_id = 3  THEN a.vk_brutto END) AS pk3,
       Max(CASE WHEN a.pm_id = 4  THEN a.vk_brutto END) AS pk4,
       Max(CASE WHEN a.pm_id = 5  THEN a.vk_brutto END) AS pk5,
       Max(CASE WHEN a.pm_id = 6  THEN a.vk_brutto END) AS pk6,
       Max(CASE WHEN a.pm_id = 7  THEN a.vk_brutto END) AS pk7,
       Max(CASE WHEN a.pm_id = 8  THEN a.vk_brutto END) AS pk8,
       Max(CASE WHEN a.pm_id = 9  THEN a.vk_brutto END) AS pk9,
       Max(CASE WHEN a.pm_id = 10 THEN a.vk_brutto END) AS pk10
FROM dbp_data.art_pm_vw_zu_per a
WHERE current_date BETWEEN a.dat_von AND a.dat_bis AND
      a.vw_id in (6,10) and
      a.preistyp_id = 0 and
      a.mandant_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _ek1 AS (
SELECT b.art_matching_id
      ,Sum(a.total_rohertrag) AS total_rohertrag
      ,Sum(a.total_rohertrag_sa) AS total_rohertrag_sa
      ,Sum(a.total_rohertrag_af) AS total_rohertrag_af
      ,Sum(a.total_rohetrag_vj) AS total_rohetrag_vj
      ,Sum(a.total_rohertrag_olk) AS total_rohertrag_olk
      ,Sum(a.total_rohertrag_olk_sa) AS total_rohertrag_olk_sa
      ,Sum(a.total_rohertrag_olk_af) AS total_rohertrag_olk_af
      ,Sum(a.total_rohertrag_olk_vj) AS total_rohertrag_olk_vj
      ,Sum(a.abschriftsbetrag_ohne_werbung_netto) AS abschriftsbetrag_ohne_werbung_netto
FROM dbp_data.sal_int a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
WHERE (a.mandant_id,a.kjwo) IN (SELECT x.mandant_id,
                                       x.kjwo
                                FROM (SELECT b.mandant_id,
                                             c.kjwo,
                                             Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                      FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                      JOIN (SELECT mandant_id,
                                                   Max(kjmo) AS kjmo
                                            FROM dbp_data.sortiment_leistung
                                            WHERE mandant_id = 1
                                            GROUP BY 1) b
                                        ON a.kjmo_sort = b.kjmo
                                      JOIN dbp_data.woche c
                                        ON c.kjwo <= a.kjwo_bis) x
                                WHERE x.akt_wo BETWEEN -52 AND -1
                                GROUP BY 1,2) AND
      a.mandant_id = 1
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _ek1_vj AS (
SELECT b.art_matching_id,
       a.mandant_id,
      (ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto END)) - ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1001 THEN a.ek_mep END))) re_mep_af_olk_vj,
	  (ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto END)) - ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1002 THEN a.ek_mep END))) re_mep_sa_olk_vj,
	  (ZeroIfNull(Sum(a.umsatz_netto)) - ZeroIfNull(Sum(a.ek_mep))) re_mep_tot_olk_vj
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_vj a
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE a.mandant_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _kpi1 AS (
SELECT a.mandant_id,
       c.art_matching_id,
       SUM(a.art_bons_af) AS art_bons_af,
       SUM(a.art_bons_sa) AS art_bons_sa,
       SUM(a.anz_bons) AS anz_bons,
       SUM(a.cp_bons_af) AS cp_bons_af,
       SUM(a.cp_bons_sa) AS cp_bons_sa
FROM dbp_etl.sort_kpi_woche_basis a
JOIN dbp_data.art b
  ON a.mandant_id = b.mandant_id AND
     a.kl_art_id = b.kl_art_id AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) c
  ON b.art_id = c.art_id AND
     b.mandant_id = c.mandant_id
WHERE a.mandant_id = 1 AND
     (a.mandant_id,a.kjwo) IN (SELECT x.mandant_id,
                                      x.kjwo
                               FROM (SELECT b.mandant_id,
                                            c.kjwo,
                                            Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                     FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                     JOIN (SELECT mandant_id,
                                                  Max(kjmo) AS kjmo
                                           FROM dbp_data.sortiment_leistung
                                           WHERE mandant_id = 1
                                           GROUP BY 1) b
                                       ON a.kjmo_sort = b.kjmo
                                     JOIN dbp_data.woche c
                                       ON c.kjwo <= a.kjwo_bis) x
                               WHERE x.akt_wo BETWEEN -52 AND -1
                               GROUP BY 1,2)
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _tage AS (
SELECT a.dat AS dat,
       b.kjmo_sort
FROM dbp_data.tag a
JOIN (SELECT mandant_id,
             Max(kjmo) AS kjmo_sort
      FROM dbp_data.sortiment_leistung
      WHERE mandant_id = 1
      GROUP BY 1) b
  ON 1 = 1
WHERE (a.kjwo) IN (SELECT x.kjwo
                   FROM (SELECT b.mandant_id,
                                c.kjwo,
                                Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                         FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                         JOIN (SELECT mandant_id,
                                      Max(kjmo) AS kjmo
                               FROM dbp_data.sortiment_leistung
                               WHERE mandant_id = 1
                               GROUP BY 1) b
                           ON a.kjmo_sort = b.kjmo
                         JOIN dbp_data.woche c
                           ON c.kjwo <= a.kjwo_bis) x
                   WHERE x.akt_wo BETWEEN -104 AND -53
                   GROUP BY 1)
);

CREATE OR REPLACE VOLATILE TABLE _vj_ek AS (
SELECT b.kjmo_sort,
       a11.art_id,
       a11.mandant_id,
      (ZeroIfNull(Sum(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END)) - ZeroIfNull(Sum(CASE WHEN a11.bewart_id = 1001 THEN a11.ek_mep - a11.logkostenzuschlag END))) re_mep_af_olk_vj,
      (ZeroIfNull(Sum(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END)) - ZeroIfNull(Sum(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep - a11.logkostenzuschlag END))) re_mep_sa_olk_vj,
      (ZeroIfNull(Sum(a11.umsatz_netto)) - ZeroIfNull(Sum(a11.ek_mep - a11.logkostenzuschlag))) re_mep_tot_olk_vj
FROM dbp_data.artbew a11
JOIN _tage b
  ON a11.dat = b.dat
WHERE a11.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _vj_ek1 AS (
SELECT a.kjmo_sort,
       b.art_matching_id,
       a.mandant_id,
       Sum(a.re_mep_af_olk_vj) AS re_mep_af_vj,
       Sum(a.re_mep_sa_olk_vj) AS re_mep_sa_vj,
       Sum(a.re_mep_tot_olk_vj) AS re_mep_vj
FROM _vj_ek a
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3,4) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _vj_abs AS (
SELECT x.kjmo_sort,
       a11.art_id,
       a11.mandant_id,
       SUM(a11.abschriftenbetrag_netto) AS abschr_vk_o_werbung
FROM dbp_msi_view2.mv_marktabschriften a11
JOIN dbp_msi_view2.mv_art_wg_zu_per    a16
  ON a11.art_id = a16.art_id AND
    a11.mandant_id = a16.mandant_id
JOIN dbp_data.tag a14
  ON a11.dat = a14.dat
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per a17
  ON a11.mandant_id = a17.mandant_id AND
     a11.nb_id = a17.nb_id AND
     a11.wup_id = a17.wup_id AND
     a16.mandant_id = a17.mandant_id AND
     a16.wg_id = a17.wg_id
JOIN _tage x
  ON a11.dat = x.dat
WHERE a17.mandant_id = 1 AND
      a11.abschriftenart_id IN (5,7,9,10,23,26,100,101,102,103,104,120,121,122,151,152,153,154,155,156,157,158)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _vj_abs1 AS (
SELECT a.kjmo_sort,
       b.art_matching_id,
       a.mandant_id,
       SUM(a.abschr_vk_o_werbung) AS abschr_vj
FROM _vj_abs a
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id,
             status
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3,4) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

DELETE FROM dbp_etl_process.tupel_mat_step2
WHERE mandant_id = 1 AND
      A500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

INSERT INTO dbp_etl_process.tupel_mat_step2
SELECT DISTINCT
       a.mandant_id
      ,a.kjwo_update
      ,a.matching_id
      ,a.kjmo
      ,q.anz_wo_mit_absatz_af AS anzahl_markt_wochen_kombis_abverkauf_af
      ,q.anz_wo_mit_absatz_sa AS anzahl_markt_wochen_kombis_abverkauf_sa
      ,t.anz_wo_mit_absatz_af AS anzahl_markt_wochen_kombis_abverkauf_af_vj
      ,t.anz_wo_mit_absatz_sa AS anzahl_markt_wochen_kombis_abverkauf_sa_vj
      ,b.umsatz_brutto AS A273_kassenumsatz_kl_absolut_brutto
      ,b.umsatz_brutto_af AS kassenumsatz_af_kl_absolut_brutto
      ,b.umsatz_brutto_sa AS kassenumsatz_sa_kl_absolut_brutto
      ,c.umsatz_brutto AS kassenumsatz_kl_absolut_brutto_vj
      ,c.umsatz_brutto_af AS kassenumsatz_af_kl_absolut_brutto_vj
      ,c.umsatz_brutto_sa AS kassenumsatz_sa_kl_absolut_brutto_vj
      ,b.umsatz AS A21_kassenumsatz_kl_absolut_netto
      ,b.umsatz_af AS kassenumsatz_af_kl_absolut_netto
      ,b.umsatz_sa AS kassenumsatz_sa_kl_absolut_netto
      ,c.umsatz AS kassenumsatz_kl_absolut_netto_vj   
      ,c.umsatz_af AS kassenumsatz_af_kl_absolut_netto_vj
      ,c.umsatz_sa AS kassenumsatz_sa_kl_absolut_netto_vj
      ,b.absatz AS A17_absatz_kl
      ,b.absatz_af AS absatz_af_kl
      ,b.absatz_sa AS absatz_sa_kl
      ,c.absatz AS absatz_kl_vj
      ,c.absatz_af AS absatz_af_kl_vj
      ,c.absatz_sa AS absatz_sa_kl_vj
      ,d.absatz_sk1 AS A76_absatz_sst1
      ,d.absatz_sk2 AS A78_absatz_sst2
      ,d.absatz_sk3 AS A80_absatz_sst3
      ,d.absatz_sk4 AS A82_absatz_sst4
      ,d.absatz_sk5 AS A84_absatz_sst5
      ,d.absatz_sk6 AS A86_absatz_sst6
      ,d.absatz_sk7 AS A88_absatz_sst7
      ,0 AS A62_absatz_ksst1
      ,0 AS A64_absatz_ksst2
      ,0 AS A66_absatz_ksst3
      ,0 AS A68_absatz_ksst4
      ,0 AS A70_absatz_ksst5
      ,0 AS A72_absatz_ksst6
      ,0 AS A74_absatz_ksst7
      ,e.absatz_ost_basis AS A90_absatz_ost_basis
      ,e.absatz_ost_gross AS A92_absatz_ost_gross
      ,e.absatz_sued_ost AS A94_absatz_sued_ost
      ,e.absatz_sued_west AS A96_absatz_sued_west
      ,e.absatz_west AS A98_absatz_west
      ,e.absatz_nord AS A100_absatz_nord
      ,d.anz_wo_mit_abs_sk1 AS markt_wochen_sst1
      ,d.anz_wo_mit_abs_sk2 AS markt_wochen_sst2
      ,d.anz_wo_mit_abs_sk3 AS markt_wochen_sst3
      ,d.anz_wo_mit_abs_sk4 AS markt_wochen_sst4
      ,d.anz_wo_mit_abs_sk5 AS markt_wochen_sst5
      ,d.anz_wo_mit_abs_sk6 AS markt_wochen_sst6
      ,d.anz_wo_mit_abs_sk7 AS markt_wochen_sst7
      ,0 AS markt_wochen_ksst1
      ,0 AS markt_wochen_ksst2
      ,0 AS markt_wochen_ksst3
      ,0 AS markt_wochen_ksst4
      ,0 AS markt_wochen_ksst5
      ,0 AS markt_wochen_ksst6
      ,0 AS markt_wochen_ksst7
      ,f.anz_wo_mit_abs_ost_basis AS markt_wochen_ost_basis
      ,f.anz_wo_mit_abs_ost_gross AS markt_wochen_ost_gross
      ,f.anz_wo_mit_abs_sued_ost AS markt_wochen_sued_ost
      ,f.anz_wo_mit_abs_sued_west AS markt_wochen_sued_west
      ,f.anz_wo_mit_abs_west AS markt_wochen_west
      ,f.anz_wo_mit_abs_nord AS markt_wochen_nord
      ,s.anz_wo_mit_absatz AS anzahl_markt_wochen_kombis_abverkauf_mit_listung
      ,r.anz_wo_listung AS anzahl_markt_wochen_kombis_listung
      ,h.pk1  AS A31_vk_brutto_kl_pk_1
      ,h.pk2  AS A333_vk_brutto_kl_pk_2
      ,h.pk3  AS A54_vk_brutto_kl_pk_3
      ,h.pk4  AS A334_vk_brutto_kl_pk_4
      ,h.pk5  AS A432_vk_brutto_kl_pk_5
      ,h.pk6  AS A433_vk_brutto_kl_pk_6
      ,h.pk7  AS A434_vk_brutto_kl_pk_7
      ,h.pk8  AS A435_vk_brutto_kl_pk_8
      ,h.pk9  AS A436_vk_brutto_kl_pk_9
      ,h.pk10 AS A437_vk_brutto_kl_pk_10
      ,0.0000 AS A30_KB_oLK_EK4NDZ_STAMM
      ,i.total_rohertrag_olk AS A23_rohertrag_ekmep_olk_4n
      ,'' AS A51_listung_sst_pflege
      ,'' AS A52_listung_k_sst_pflege
      ,'' AS A426_ost_basis_pflege
      ,'' AS A427_ost_gross_pflege
      ,'' AS A428_sued_ost_pflege
      ,'' AS A429_sued_west_pflege
      ,'' AS A430_west_pflege
      ,'' AS A431_nord_pflege
      ,'' AS A50_listungsaktion
      ,'' AS A411_stk_rohertrag_pflege
      ,NULL AS A415_kannibalisierungsfaktor
      ,NULL AS A412_umsatz_brutto_hochrechnung
      ,NULL AS A413_absatz_hochrechnung
      ,NULL AS A414_rohertrag_hochrechnung
      ,a.distr_gew AS A36_gewichtete_distribution_nielsen
      ,a.umsatz_anteil_uwg AS A32_umsatz_anteil_wgi_nielsen
      ,a.umsatz_anteil_uwg_kumuliert AS A33_umsatz_anteil_wgi_kumuliert_nielsen
      ,a.durchschnitt_preis AS A34_vk_brutto_durchschnitt_nielsen
      ,a.umsatz_artikel AS A35_umsatz_nielsen
      ,a.anz_wochen AS anz_wochen_de_anz_monate_kmo_nielsen
      ,a.absatz_artikel AS absatz_nielsen
      ,a.kl_markt_anteil_owg AS A376_kl_marktanteil_wg_nielsen
      ,a.marktanteilbewertung AS A380_marktanteilbewertung_nielsen
      ,a.durchschnitt_anz_maerkte AS A377_durchschnitt_anz_maerkte_nielsen
      ,0 AS A382_sales_units_Absatz_verkaufsartikel_in_1000_nielsen
      ,0 AS A383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen
      ,0 AS A384_durchschn_preis_einheit_gl_normiert_nielsen
      ,0 AS A385_numerische_distribution_nielsen
      ,0 AS A386_inhaltsmengen_nielsen
      ,'' AS A387_duft_geschmack_nielsen
      ,'' AS A388_Einheit_nielsen
      ,a.eigenmarke_fg AS eigenmarke_fg_nielsen
      ,a.listung_sst_mvke AS A39_listung_sst_mvke
      ,a.listung_k_sst_mvke AS A38_listung_k_sst_mvke
      ,substr(a.ost_basis,1,1) AS A40_ost_basis
      ,substr(a.ost_gross,1,1) AS A41_ost_gross
      ,substr(a.sued_ost,1,1) AS A42_sued_ost
      ,substr(a.sued_west,1,1) AS A43_sued_west
      ,substr(a.west,1,1) AS A44_west
      ,substr(a.nord,1,1) AS A45_nord
      ,Cast('1900-01-01' AS DATE) AS A37_listung_erster_markt
      ,a.anz_maerkte_sst AS A59_anz_maerkte_sst
      ,a.anz_maerkte_k_sst AS A449_anz_maerkte_k_sst
      ,a.max_anz_maerkte_sst AS A46_max_anz_maerkte_sst
      ,a.max_anz_maerkte_k_sst AS A47_max_anz_maerkte_k_sst
      ,a.anz_maerkte_listung_gesamt AS A53_anz_maerkte_listung_gesamt
      ,a.anz_maerkte_listung_einzel AS A57_anz_maerkte_listung_einzel
      ,a.anz_maerkte_baustein_sonstige AS anz_maerkte_baustein_sonstige
      ,k.art_bons_af AS anz_bons_af
      ,k.art_bons_sa AS anz_bons_sa
      ,CASE WHEN k.anz_bons > 2047483647 THEN 2047483647 ELSE k.anz_bons END AS anz_bons_gesamt
      ,j.re_mep_vj AS rohertrag_ekmep_olk_4n_vj
      ,i.total_rohertrag_olk_af AS rohertrag_ekmep_olk_4n_af
      ,i.total_rohertrag_olk_sa AS rohertrag_ekmep_olk_4n_sa
      ,j.re_mep_af_vj AS rohertrag_ekmep_olk_4n_af_vj
      ,j.re_mep_sa_vj AS rohertrag_ekmep_olk_4n_sa_vj
      ,a.preislagenverteilung AS A381_preislagenverteilung
      ,i.abschriftsbetrag_ohne_werbung_netto AS A27_totalabschriften_wert_netto_absolut
      ,0 AS A313_preisabschriften_preisanderungen_wert_netto_absolut
      ,v.abschr_vj AS totalabschriften_wert_netto_absolut_vj
      ,0 AS preisabschriften_preisanderungen_wert_netto_absolut_vj
      ,g.kol_la_bzw AS A402_kolli_la
      ,g.kol_bst_bzw AS A401_kolli_bst
      ,g.rlz AS A403_restlaufzeit_zl
      ,g.rlz_dz AS A404_restlaufzeit_dz
      ,a1.gewart_id AS A405_basismengeneinheit
      ,Cast('1900-01-01' AS DATE) AS A406_letzte_listungsaenderung_sst_ksst
      ,a1.verhandler_id AS A407_verhandler
      ,'' AS A408_display_Komponente_kz
      ,'' AS A409_kl_art_id_display
      ,'' AS A416_artikelrolle_id
      ,'' AS A417_artikelrolle_bez
      ,0 AS kassenumsatz_kl_absolut_netto_wg
      ,CASE WHEN k.anz_bons > 2047483647 THEN 2047483647 ELSE k.anz_bons END AS anz_bons_tupel
      ,0 AS restbon_summe
      ,0 AS totalabschriften_wert_netto_absolut_wg
      ,0 AS preisabschriften_preisanderungen_wert_netto_absolut_wg
      ,k.art_bons_af AS ANZ_BONS_AF_MARKT_TAG
      ,k.art_bons_sa AS ANZ_BONS_SA_MARKT_TAG
      ,k.cp_bons_af+k.cp_bons_sa AS cpq_tupel
      ,k.cp_bons_af AS cp_bons_af
      ,k.cp_bons_sa AS cp_bons_sa
      ,0 AS umrech_faktor
      ,g.lagerprozent
      ,o.absatz_af_mit_listung AS absatz_af_kl_listungswochen
      ,p.absatz_af_mit_listung AS absatz_af_kl_vj_listungswochen
      ,o.absatz_sa_mit_listung AS absatz_sa_kl_listungswochen
      ,p.absatz_sa_mit_listung AS absatz_sa_kl_vj_listungswochen
      ,o.umsatz_af_mit_listung AS kassenumsatz_af_kl_absolut_netto_listungswochen
      ,p.umsatz_af_mit_listung AS kassenumsatz_af_kl_absolut_netto_vj_listungswochen      
      ,o.umsatz_sa_mit_listung AS kassenumsatz_sa_kl_absolut_netto_listungswochen
      ,p.umsatz_sa_mit_listung AS kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
      ,o.ertrag_af_mit_listung AS rohertrag_ekmep_olk_4n_af_listungswochen
      ,p.ertrag_af_mit_listung AS rohertrag_ekmep_olk_4n_af_vj_listungswochen
      ,o.ertrag_sa_mit_listung AS rohertrag_ekmep_olk_4n_sa_listungswochen
      ,p.ertrag_sa_mit_listung AS rohertrag_ekmep_olk_4n_sa_vj_listungswochen
      ,current_timestamp
      ,current_timestamp
FROM dbp_data.sortiment_leistung a
LEFT JOIN dbp_data.art a1
  ON a.mandant_id = a1.mandant_id AND
     a.art_id = a1.art_id
LEFT JOIN _anz_wochen1 b
  ON a.matching_id = b.art_matching_id
LEFT JOIN _anz_wochen1_vj c
  ON a.matching_id = c.art_matching_id
LEFT JOIN ZZMD0E1 d
  ON a.matching_id = d.art_matching_id
LEFT JOIN _regio1 e
  ON a.matching_id = e.art_matching_id
LEFT JOIN _regio2 f
  ON a.matching_id = f.art_matching_id
LEFT JOIN dbp_etl.sal_snap_final_de g
  ON a.matching_id = g.art_matching_id
LEFT JOIN _vk1 h
  ON a.mandant_id = h.mandant_id and
     a.art_id = h.art_id
LEFT JOIN _ek1 i
  ON a.matching_id = i.art_matching_id
LEFT JOIN _vj_ek1 j
  ON a.matching_id = j.art_matching_id
LEFT JOIN _kpi1 k
  ON a.matching_id = k.art_matching_id AND
     a.mandant_id = k.mandant_id
LEFT JOIN dbp_etl.sal_snap2_de l
  ON a.matching_id = l.art_matching_id
LEFT JOIN dbp_etl.sal_snap2_multis_de m
  ON a.matching_id = m.art_matching_id
LEFT JOIN _mm_x n
  ON a.matching_id = n.matching_id AND
     a.mandant_id = n.mandant_id
LEFT JOIN _mm_z o
  ON a.matching_id = o.matching_id AND
     a.mandant_id = o.mandant_id
LEFT JOIN _mm_z_vj p
  ON a.matching_id = p.matching_id AND
     a.mandant_id = p.mandant_id
LEFT JOIN ZZSP07_pre_tag_xxx q
  ON a.matching_id = q.matching_id AND
     a.mandant_id = q.mandant_id
LEFT JOIN ZZSP08_pre_xxx r
  ON a.matching_id = r.matching_id AND
     a.mandant_id = r.mandant_id
LEFT JOIN _mm_y_xxx s
  ON a.matching_id = s.matching_id AND
     a.mandant_id = s.mandant_id
LEFT JOIN ZZSP07_pre_tag_vj_xxx t
  ON a.matching_id = t.matching_id AND
     a.mandant_id = t.mandant_id
LEFT JOIN ZZSP08_pre_vj_xxx u
  ON a.matching_id = u.matching_id AND
     a.mandant_id = u.mandant_id
LEFT JOIN _vj_abs1 v
  ON a.matching_id = v.art_matching_id AND
     a.mandant_id = v.mandant_id
WHERE a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

-- 10.01.2022, -dbay-
--
-- Neue SDQ.

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre (
    kjwo INTEGER,
    art_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT,
    anz_wo_mit_absatz_af FLOAT,
    anz_wo_mit_absatz_sa FLOAT
);

INSERT INTO ZZSP07_pre
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       a11.wup_id,
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN Sum(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN Sum(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa
FROM dbp_etl.bf_listung_markt_kw a11
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_xxx AS (
SELECT mandant_id,
       kjwo,
       art_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre (
    kjwo INTEGER,
    art_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung FLOAT
);

INSERT INTO ZZSP08_pre
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       a11.wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung
FROM dbp_data.art_wup_listung_kjwo a11
WHERE a11.mandant_id = 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_xxx AS (
SELECT mandant_id,
       kjwo,
       art_id,
       Sum(anz_wo_listung) AS anz_wo_listung
FROM ZZSP08_pre
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_xxx_final AS (
SELECT a11.mandant_id,
       b.art_matching_id AS matching_id,
       Sum(coalesce(a11.anz_wo_listung,0)) AS anz_wo_listung
FROM ZZSP08_pre_xxx a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE (a11.mandant_id,a11.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung
                                                WHERE mandant_id = 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) AND
      a11.mandant_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

CREATE OR REPLACE VOLATILE TABLE _mm_y AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

DELETE FROM _mm_y
WHERE anz_wo_mit_absatz = 0
;

CREATE OR REPLACE VOLATILE TABLE _mm_y_xxx AS (
SELECT mandant_id,
       kjwo,
       art_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM _mm_y
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _mm_y_xxx_final AS (
SELECT a11.mandant_id,
       b.art_matching_id AS matching_id,
       Sum(coalesce(a11.anz_wo_mit_absatz,0)) AS anz_wo_mit_absatz
FROM _mm_y_xxx a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_de_xxx
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE (a11.mandant_id,a11.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung
                                                WHERE mandant_id = 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -52 AND -1
                                    GROUP BY 1,2) AND
      a11.mandant_id = 1
GROUP BY 1,2
);

update dbp_etl_process.tupel_mat_step2 set anzahl_markt_wochen_kombis_listung = 0,
                                           anzahl_markt_wochen_kombis_abverkauf_mit_listung = 0
where mandant_id = 1 and
      a500_kjwo_update in (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

update dbp_etl_process.tupel_mat_step2 from (select *
                                             from ZZSP08_pre_xxx_final) b
                                                
set anzahl_markt_wochen_kombis_listung = b.anz_wo_listung

where dbp_etl_process.tupel_mat_step2.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_step2.matching_id = b.matching_id and
      dbp_etl_process.tupel_mat_step2.a500_kjwo_update in (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

update dbp_etl_process.tupel_mat_step2 from (select *
                                             from _mm_y_xxx_final) b
                                                
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.anz_wo_mit_absatz

where dbp_etl_process.tupel_mat_step2.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_step2.matching_id = b.matching_id and
      dbp_etl_process.tupel_mat_step2.a500_kjwo_update in (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

DELETE FROM dbp_etl_process.tupel_mat
WHERE mandant_id = 1 AND
      A500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;

INSERT INTO dbp_etl_process.tupel_mat
SELECT DISTINCT
       a.mandant_id
      ,a.A500_kjwo_update
      ,a.matching_id
      ,a.A425_kjmo
      ,a.wrg_id
      ,a.A5_owg_id
      ,a.A7_wg_id
      ,a.wug_id
      ,a.art_id
      ,a.kl_art_id
      ,a.art_bez_land
      ,a.art_bez_deutsch
      ,a.A14_art_status_de
      ,a.nielsen_art_bez
      ,a.nielsen_gtin
      ,a.A58_rang_umsatz_owg
      ,a.A2_rang_umsatz_wg
      ,a.A59_rang_absatz_wg
      ,a.A16_akt_lieferant_id
      ,a.A419_hersteller_id
      ,a.A418_lieferant_bez_land
      ,a.A446_lieferant_bez_latein
      ,a.A420_hersteller_bez_land
      ,a.A447_hersteller_bez_latein
      ,a.lieferant_nielsen
      ,a.A389_zek_id
      ,a.A391_disc_pe
      ,a.A392_disc_ohne_etikett
      ,a.A400_lcf
      ,a.A393_vegan
      ,a.A394_gluten
      ,a.A395_bio
      ,a.A396_eigenmarke
      ,a.A397_tierwohl
      ,a.A398_posten_food
      ,a.A399_posten_nonfood
      ,a.A339_umsatzsteuer
      ,a.A36_gewichtete_distribution
      ,a.A60_muki_vk_kz
      ,a.A61_muki_vk_kl_art_id_verkettung
      ,b.anzahl_markt_wochen_kombis_abverkauf_af
      ,b.anzahl_markt_wochen_kombis_abverkauf_sa
      ,b.anzahl_markt_wochen_kombis_abverkauf_af_vj
      ,b.anzahl_markt_wochen_kombis_abverkauf_sa_vj
      ,b.A273_kassenumsatz_kl_absolut_brutto
      ,b.kassenumsatz_af_kl_absolut_brutto
      ,b.kassenumsatz_sa_kl_absolut_brutto
      ,b.kassenumsatz_kl_absolut_brutto_vj
      ,b.kassenumsatz_af_kl_absolut_brutto_vj
      ,b.kassenumsatz_sa_kl_absolut_brutto_vj
      ,b.A21_kassenumsatz_kl_absolut_netto
      ,b.kassenumsatz_af_kl_absolut_netto
      ,b.kassenumsatz_sa_kl_absolut_netto
      ,b.kassenumsatz_kl_absolut_netto_vj
      ,b.kassenumsatz_af_kl_absolut_netto_vj
      ,b.kassenumsatz_sa_kl_absolut_netto_vj
      ,b.A17_absatz_kl
      ,b.absatz_af_kl
      ,b.absatz_sa_kl
      ,b.absatz_kl_vj
      ,b.absatz_af_kl_vj
      ,b.absatz_sa_kl_vj
      ,b.A76_absatz_sst1
      ,b.A78_absatz_sst2
      ,b.A80_absatz_sst3
      ,b.A82_absatz_sst4
      ,b.A84_absatz_sst5
      ,b.A86_absatz_sst6
      ,b.A88_absatz_sst7
      ,b.A62_absatz_ksst1
      ,b.A64_absatz_ksst2
      ,b.A66_absatz_ksst3
      ,b.A68_absatz_ksst4
      ,b.A70_absatz_ksst5
      ,b.A72_absatz_ksst6
      ,b.A74_absatz_ksst7
      ,b.A90_absatz_ost_basis
      ,b.A92_absatz_ost_gross
      ,b.A94_absatz_sued_ost
      ,b.A96_absatz_sued_west
      ,b.A98_absatz_west
      ,b.A100_absatz_nord
      ,b.markt_wochen_sst1
      ,b.markt_wochen_sst2
      ,b.markt_wochen_sst3
      ,b.markt_wochen_sst4
      ,b.markt_wochen_sst5
      ,b.markt_wochen_sst6
      ,b.markt_wochen_sst7
      ,b.markt_wochen_ksst1
      ,b.markt_wochen_ksst2
      ,b.markt_wochen_ksst3
      ,b.markt_wochen_ksst4
      ,b.markt_wochen_ksst5
      ,b.markt_wochen_ksst6
      ,b.markt_wochen_ksst7
      ,b.markt_wochen_ost_basis
      ,b.markt_wochen_ost_gross
      ,b.markt_wochen_sued_ost
      ,b.markt_wochen_sued_west
      ,b.markt_wochen_west
      ,b.markt_wochen_nord
      ,b.anzahl_markt_wochen_kombis_abverkauf_mit_listung
      ,b.anzahl_markt_wochen_kombis_listung
      ,b.A31_vk_brutto_kl_pk_1
      ,b.A333_vk_brutto_kl_pk_2
      ,b.A54_vk_brutto_kl_pk_3
      ,b.A334_vk_brutto_kl_pk_4
      ,b.A432_vk_brutto_kl_pk_5
      ,b.A433_vk_brutto_kl_pk_6
      ,b.A434_vk_brutto_kl_pk_7
      ,b.A435_vk_brutto_kl_pk_8
      ,b.A436_vk_brutto_kl_pk_9
      ,b.A437_vk_brutto_kl_pk_10
      ,b.A30_KB_oLK_EK4NDZ_STAMM
      ,b.A23_rohertrag_ekmep_olk_4n
      ,b.A51_listung_sst_pflege
      ,b.A52_listung_k_sst_pflege
      ,b.A426_ost_basis_pflege
      ,b.A427_ost_gross_pflege
      ,b.A428_sued_ost_pflege
      ,b.A429_sued_west_pflege
      ,b.A430_west_pflege
      ,b.A431_nord_pflege
      ,b.A50_listungsaktion
      ,b.A411_stk_rohertrag_pflege
      ,b.A415_kannibalisierungsfaktor
      ,b.A412_umsatz_brutto_hochrechnung
      ,b.A413_absatz_hochrechnung
      ,b.A414_rohertrag_hochrechnung
      ,b.A36_gewichtete_distribution_nielsen
      ,b.A32_umsatz_anteil_wgi_nielsen
      ,b.A33_umsatz_anteil_wgi_kumuliert_nielsen
      ,b.A34_vk_brutto_durchschnitt_nielsen
      ,b.A35_umsatz_nielsen
      ,b.anz_wochen_de_anz_monate_kmo_nielsen
      ,b.absatz_nielsen
      ,b.A376_kl_marktanteil_wg_nielsen
      ,b.A380_marktanteilbewertung_nielsen
      ,b.A377_durchschnitt_anz_maerkte_nielsen
      ,b.A382_sales_units_Absatz_verkaufsartikel_in_1000_nielsen
      ,b.A383_sales_units_verkaufseinheiten_Gl_in_1000_normiert_nielsen
      ,b.A384_durchschn_preis_einheit_gl_normiert_nielsen
      ,b.A385_numerische_distribution_nielsen
      ,b.A386_inhaltsmengen_nielsen
      ,b.A387_duft_geschmack_nielsen
      ,b.A388_Einheit_nielsen
      ,b.eigenmarke_fg_nielsen
      ,b.A39_listung_sst_mvke
      ,b.A38_listung_k_sst_mvke
      ,b.A40_ost_basis
      ,b.A41_ost_gross
      ,b.A42_sued_ost
      ,b.A43_sued_west
      ,b.A44_west
      ,b.A45_nord
      ,b.A37_listung_erster_markt
      ,b.A59_anz_maerkte_sst
      ,b.A449_anz_maerkte_k_sst
      ,b.A46_max_anz_maerkte_sst
      ,b.A47_max_anz_maerkte_k_sst
      ,b.A53_anz_maerkte_listung_gesamt
      ,b.A57_anz_maerkte_listung_einzel
      ,b.anz_maerkte_baustein_sonstige
      ,b.anz_bons_af
      ,b.anz_bons_sa
      ,b.anz_bons_gesamt
      ,b.rohertrag_ekmep_olk_4n_vj
      ,b.rohertrag_ekmep_olk_4n_af
      ,b.rohertrag_ekmep_olk_4n_sa
      ,b.rohertrag_ekmep_olk_4n_af_vj
      ,b.rohertrag_ekmep_olk_4n_sa_vj
      ,b.A381_preislagenverteilung
      ,b.A27_totalabschriften_wert_netto_absolut
      ,b.A313_preisabschriften_preisanderungen_wert_netto_absolut
      ,b.totalabschriften_wert_netto_absolut_vj
      ,b.preisabschriften_preisanderungen_wert_netto_absolut_vj
      ,b.A402_kolli_la
      ,b.A401_kolli_bst
      ,b.A403_restlaufzeit_zl
      ,b.A404_restlaufzeit_dz
      ,b.A405_basismengeneinheit
      ,b.A406_letzte_listungsanderung_sst_ksst
      ,b.A407_verhandler
      ,b.A408_display_Komponente_kz
      ,b.A409_kl_art_id_display
      ,b.A416_artikelrolle_id
      ,b.A417_artikelrolle_bez
      ,b.kassenumsatz_kl_absolut_netto_wg
      ,b.anz_bons_tupel
      ,b.restbon_summe
      ,b.totalabschriften_wert_netto_absolut_wg
      ,b.preisabschriften_preisanderungen_wert_netto_absolut_wg
      ,b.ANZ_BONS_AF_MARKT_TAG
      ,b.ANZ_BONS_SA_MARKT_TAG
      ,b.cpq_tupel
      ,b.cp_bons_af
      ,b.cp_bons_sa
      ,b.umrech_faktor
      ,b.lagerprozent
      ,b.absatz_af_kl_listungswochen
      ,b.absatz_af_kl_vj_listungswochen
      ,b.absatz_sa_kl_listungswochen
      ,b.absatz_sa_kl_vj_listungswochen
      ,b.kassenumsatz_af_kl_absolut_netto_listungswochen
      ,b.kassenumsatz_af_kl_absolut_netto_vj_listungswochen
      ,b.kassenumsatz_sa_kl_absolut_netto_listungswochen
      ,b.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
      ,b.rohertrag_ekmep_olk_4n_af_listungswochen
      ,b.rohertrag_ekmep_olk_4n_af_vj_listungswochen
      ,b.rohertrag_ekmep_olk_4n_sa_listungswochen
      ,b.rohertrag_ekmep_olk_4n_sa_vj_listungswochen
      ,'' as sustain_concat
      ,0 AS check_fg
      ,current_timestamp
      ,current_timestamp
      ,'' as tupel_typ
      ,'' as a471_marke_nielsen_bez
      ,'' as a515_bio_organic_nielsen_kz
      ,'' as a516_veggy_split_nielsen_kz
      ,'' as a517_laktosefrei_nielsen_kz
      ,'' as a518_glutenfrei_nielsen_kz
      ,a.A510_muki_ek_kz
      ,a.A511_muki_ek_kl_art_id_verkettung
      ,a.A512_muki_wb_kz
      ,a.A513_muki_wb_kl_art_id_verkettung
      ,NULL AS A519_UMSATZ_ANTEIL_WG_NIELSEN
      ,NULL AS A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN
      ,NULL AS a521_Inhalt_menge
FROM dbp_etl_process.tupel_mat_step1 a
JOIN dbp_etl_process.tupel_mat_step2 b
  ON a.mandant_id = b.mandant_id AND
     a.A500_kjwo_update = b.A500_kjwo_update AND
     a.matching_id = b.matching_id AND
     a.A425_kjmo = b.A425_kjmo
WHERE a.mandant_id = 1 AND
      a.A500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung WHERE mandant_id = 1)
;
