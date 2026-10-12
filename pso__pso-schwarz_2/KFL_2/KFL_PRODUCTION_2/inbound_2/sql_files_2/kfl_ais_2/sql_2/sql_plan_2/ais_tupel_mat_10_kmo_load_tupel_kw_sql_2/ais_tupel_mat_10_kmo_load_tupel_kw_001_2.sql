CREATE OR REPLACE VOLATILE TABLE _zeitraum_woche AS (
select 
  kjwo,
  kjwo_vj
from dbp_data.tag_2
where akt_wo between -63 and -1
group by 1,2
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_kmo_2 (
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
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_kmo_2 (
  mandant_id BYTEINT,
  wg_id SMALLINT,
  art_id INTEGER,
  wup_id INTEGER,
  nb_id SMALLINT,
  kreistyp_gruppe_id VARCHAR(4) collate 'en-ci',
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
  anzahl_wochen_mit_absatz_af INTEGER
);

INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_kmo_2
SELECT a.mandant_id,
       a.dat,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep,
       a.einstandspreis
FROM dbp_data.artbew_2 a
JOIN dbp_data.tag_2 c
  ON a.dat = c.dat
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE c.kjwo IN (SELECT kjwo FROM _zeitraum_woche) AND
      a.mandant_id > 1
;

INSERT INTO dbp_etl.bf_listung_markt_tag_kmo_2 (mandant_id
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
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto)) AS umsatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZeroIfNull(Sum(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.einstandspreis)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.dat) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_tag_sum_kmo_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
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
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN Sum(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN Sum(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa
FROM dbp_etl.bf_listung_markt_tag_kmo_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_tag_xxx AS (
SELECT a.mandant_id,
       a.matching_id,
       b.kjwo,
       Sum(a.anz_wo_mit_absatz)/7.0000 AS anz_wo_mit_absatz,
       Sum(a.anz_wo_mit_absatz_af)/7.0000 AS anz_wo_mit_absatz_af,
       Sum(a.anz_wo_mit_absatz_sa)/7.0000 AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre_tag a
JOIN dbp_data.tag_2 b
  ON a.dat = b.dat
GROUP BY 1,2,3
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 (
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
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_kmo_2 (
  mandant_id BYTEINT,
  wg_id SMALLINT,
  art_id INTEGER,
  wup_id INTEGER,
  nb_id SMALLINT,
  kreistyp_gruppe_id VARCHAR(4) collate 'en-ci',
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
  anzahl_wochen_mit_absatz_af INTEGER
);

INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep,
       a.einstandspreis
FROM dbp_data.artbew_wo_sum_2 a
JOIN dbp_data.woche_kj_kl_2 c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE c.kjwo IN (SELECT kjwo FROM _zeitraum_woche) AND
      a.mandant_id > 1
;

INSERT INTO dbp_etl.bf_listung_markt_kw_kmo_2 (mandant_id
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
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.einstandspreis)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
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
FROM dbp_etl.bf_listung_markt_kw_kmo_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_xxx AS (
SELECT mandant_id,
       matching_id,
       kjwo,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung_2 FLOAT
);

INSERT INTO ZZSP08_pre
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung_2
FROM dbp_data.art_wup_listung_kjwo_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE a11.kjwo IN (SELECT kjwo FROM _zeitraum_woche) AND
      a11.mandant_id > 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_xxx AS (
SELECT mandant_id,
       matching_id,
       kjwo,
       Sum(anz_wo_listung_2) AS anz_wo_listung_2
FROM ZZSP08_pre
GROUP BY 1,2,3
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
       kjwo,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM _mm_y
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _mm_z AS (
SELECT b.art_matching_id AS matching_id,
       a11.mandant_id,
       a11.kjwo,
       Sum(a11.umsatz_af)  umsatz_af_mit_listung,
       Sum(a11.umsatz_sa)  umsatz_sa_mit_listung,
       Sum(a11.umsatz_brutto_af)  umsatz_brutto_af_mit_listung,
       Sum(a11.umsatz_brutto_sa)  umsatz_brutto_sa_mit_listung,
       Sum(a11.ertrag_af)  ertrag_af_mit_listung,
       Sum(a11.ertrag_sa)  ertrag_sa_mit_listung,
       Sum(a11.absatz_af)  absatz_af_mit_listung,
       Sum(a11.absatz_sa)  absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_kmo_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id
JOIN _mm_y c
  ON a11.mandant_id = c.mandant_id AND
     b.art_matching_id = c.matching_id AND
     a11.kjwo = c.kjwo AND
     a11.wup_id = c.wup_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _mm_x AS (
SELECT mandant_id,
       matching_id,
       kjwo,
       Sum(anz_wo_listung_2) AS anz_wo_mit_listung_absatz
FROM _mm
GROUP BY 1,2,3
);

INSERT INTO _mm
SELECT kjwo,
       matching_id,
       mandant_id,
       wup_id,
       anz_wo_listung_2,
       0
FROM ZZSP08_pre
WHERE (kjwo,matching_id,mandant_id,wup_id) NOT IN (SELECT kjwo,matching_id,mandant_id,wup_id FROM _mm)
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07 (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  kjwo INTEGER,
  anz_wo_mit_absatz	FLOAT
);

INSERT INTO ZZSP07 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       a11.kjwo,
       Sum(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz
FROM _mm a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08 (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  kjwo INTEGER,
  anz_wo_listung_2 FLOAT
);

INSERT INTO ZZSP08 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       a11.kjwo,
       Sum(a11.anz_wo_listung_2)  anz_wo_listung_2
FROM _mm a11
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE ZZOJ09 (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  kjwo INTEGER
);

INSERT INTO ZZOJ09 
SELECT pa11.matching_id  matching_id,
      pa11.mandant_id  mandant_id,
      pa11.kjwo kjwo
FROM ZZSP07 pa11
GROUP BY 1,2,3
UNION
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       pa11.kjwo kjwo
FROM ZZSP08 pa11
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0A_xxx (
  matching_id INTEGER, 
  mandant_id BYTEINT, 
  kjwo INTEGER,
  WJXBFS1 FLOAT, 
  anz_wo_listung_2 FLOAT, 
  anz_wo_mit_absatz	FLOAT,
  schnelldreherquote FLOAT
);

INSERT INTO ZZMD0A_xxx 
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       pa11.kjwo,
       1.0  WJXBFS1,
       pa13.anz_wo_listung_2  anz_wo_listung_2,
       pa12.anz_wo_mit_absatz  anz_wo_mit_absatz,
       Round((pa12.anz_wo_mit_absatz/NullIfZero(pa13.anz_wo_listung_2))*100,1) AS schnelldreherquote
FROM ZZOJ09 pa11
LEFT JOIN ZZSP07 pa12
  ON pa11.matching_id = pa12.matching_id AND 
     pa11.mandant_id = pa12.mandant_id and pa11.kjwo = pa12.kjwo
LEFT JOIN ZZSP08 pa13
  ON pa11.matching_id = pa13.matching_id AND
     pa11.mandant_id = pa13.mandant_id and pa11.kjwo = pa13.kjwo
;

CREATE OR REPLACE VOLATILE TABLE _anz_wochen AS (
SELECT a.kjwo,
       a.mandant_id,
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
FROM dbp_etl.bf_listung_markt_kw_kmo_2 a
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE a.kjwo IN (SELECT kjwo FROM _zeitraum_woche) AND
      a.mandant_id > 1
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _anz_wochen1 AS (
SELECT mandant_id,
       art_matching_id,
       kjwo,
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
GROUP BY 1,2,3
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_kmo_vj_2 (
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
      ek_mep DECIMAL(18,4),
      einstandspreis DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_kmo_vj_2 (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4) collate 'en-ci',
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
      anzahl_wochen_mit_absatz_af INTEGER
);

INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_kmo_vj_2
SELECT a.mandant_id,
       a.dat,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep,
       a.einstandspreis
FROM dbp_data.artbew_2 a
JOIN dbp_data.tag_2 c
  ON a.dat = c.dat
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE c.kjwo IN (SELECT kjwo_vj FROM _zeitraum_woche) AND
      a.mandant_id > 1
;

INSERT INTO dbp_etl.bf_listung_markt_tag_kmo_vj_2 (mandant_id
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
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto)) AS umsatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZeroIfNull(Sum(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.einstandspreis)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.dat) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.dat end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_tag_sum_kmo_vj_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
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
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN Sum(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN Sum(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa
FROM dbp_etl.bf_listung_markt_tag_kmo_vj_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_tag_vj_xxx AS (
SELECT a.mandant_id,
       a.matching_id,
       b.kjwo,
       Sum(a.anz_wo_mit_absatz)/7.0000 AS anz_wo_mit_absatz,
       Sum(a.anz_wo_mit_absatz_af)/7.0000 AS anz_wo_mit_absatz_af,
       Sum(a.anz_wo_mit_absatz_sa)/7.0000 AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre_tag_vj a
JOIN dbp_data.tag_2 b
  ON a.dat = b.dat
GROUP BY 1,2,3
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_2 (
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
      ek_mep DECIMAL(18,4),
      einstandspreis DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_kmo_vj_2 (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4) collate 'en-ci',
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
      anzahl_wochen_mit_absatz_af INTEGER
);

INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_2
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep,
       a.einstandspreis
FROM dbp_data.artbew_wo_sum_2 a
JOIN dbp_data.woche_kj_kl_2 c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE c.kjwo IN (SELECT kjwo_vj FROM _zeitraum_woche) AND
      a.mandant_id > 1
;

INSERT INTO dbp_etl.bf_listung_markt_kw_kmo_vj_2 (mandant_id
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
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.einstandspreis)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.einstandspreis end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
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
FROM dbp_etl.bf_listung_markt_kw_kmo_vj_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_vj_xxx AS (
SELECT mandant_id,
       matching_id,
       kjwo,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre_vj
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_vj (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung_2 FLOAT
);

INSERT INTO ZZSP08_pre_vj
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung_2
FROM dbp_data.art_wup_listung_kjwo_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE a11.kjwo IN (SELECT kjwo_vj FROM _zeitraum_woche) AND
      a11.mandant_id > 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_vj_xxx AS (
SELECT mandant_id,
       matching_id,
       kjwo,
       Sum(anz_wo_listung_2) AS anz_wo_listung_2
FROM ZZSP08_pre_vj
GROUP BY 1,2,3
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
       a11.kjwo,
       Sum(a11.umsatz_af)  umsatz_af_mit_listung,
       Sum(a11.umsatz_sa)  umsatz_sa_mit_listung,
       Sum(a11.umsatz_brutto_af)  umsatz_brutto_af_mit_listung,
       Sum(a11.umsatz_brutto_sa)  umsatz_brutto_sa_mit_listung,
       Sum(a11.ertrag_af)  ertrag_af_mit_listung,
       Sum(a11.ertrag_sa)  ertrag_sa_mit_listung,
       Sum(a11.absatz_af)  absatz_af_mit_listung,
       Sum(a11.absatz_sa)  absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_kmo_vj_2 a11
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id
JOIN _mm_y_vj c
  ON a11.mandant_id = c.mandant_id AND
     b.art_matching_id = c.matching_id AND
     a11.kjwo = c.kjwo AND
     a11.wup_id = c.wup_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _mm_x_vj AS (
SELECT mandant_id,
       matching_id,
       kjwo,
       Sum(anz_wo_listung_2) AS anz_wo_mit_listung_absatz
FROM _mm_vj
GROUP BY 1,2,3
);

INSERT INTO _mm_vj
SELECT kjwo,
       matching_id,
       mandant_id,
       wup_id,
       anz_wo_listung_2,
       0
FROM ZZSP08_pre_vj
WHERE (kjwo,matching_id,mandant_id,wup_id) NOT IN (SELECT kjwo,matching_id,mandant_id,wup_id FROM _mm_vj)
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  kjwo INTEGER,
  anz_wo_mit_absatz	FLOAT
);

INSERT INTO ZZSP07_vj 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       a11.kjwo,
       Sum(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz
FROM _mm_vj a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  kjwo INTEGER,
  anz_wo_listung_2 FLOAT
);

INSERT INTO ZZSP08_vj
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       a11.kjwo,
       Sum(a11.anz_wo_listung_2)  anz_wo_listung_2
FROM _mm_vj a11
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE ZZOJ09_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  kjwo INTEGER
);

INSERT INTO ZZOJ09_vj
SELECT pa11.matching_id  matching_id,
      pa11.mandant_id  mandant_id,
      pa11.kjwo kjwo
FROM ZZSP07_vj pa11
GROUP BY 1,2,3
UNION
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       pa11.kjwo kjwo 
FROM ZZSP08_vj pa11
GROUP BY 1,2,3
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0A_xxx_vj (
  matching_id INTEGER, 
  mandant_id BYTEINT, 
  kjwo INTEGER,
  WJXBFS1 FLOAT, 
  anz_wo_listung_2 FLOAT, 
  anz_wo_mit_absatz	FLOAT,
  schnelldreherquote FLOAT
);

INSERT INTO ZZMD0A_xxx_vj
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       pa11.kjwo,
       1.0  WJXBFS1,
       pa13.anz_wo_listung_2  anz_wo_listung_2,
       pa12.anz_wo_mit_absatz  anz_wo_mit_absatz,
       Round((pa12.anz_wo_mit_absatz/NullIfZero(pa13.anz_wo_listung_2))*100,1) AS schnelldreherquote
FROM ZZOJ09_vj pa11
LEFT JOIN ZZSP07_vj pa12
  ON pa11.matching_id = pa12.matching_id AND 
     pa11.mandant_id = pa12.mandant_id and pa11.kjwo = pa12.kjwo
LEFT JOIN ZZSP08_vj pa13
  ON pa11.matching_id = pa13.matching_id AND
     pa11.mandant_id = pa13.mandant_id and pa11.kjwo = pa13.kjwo
;

CREATE OR REPLACE VOLATILE TABLE _anz_wochen_vj AS (
SELECT a.kjwo,
       a.mandant_id,
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
FROM dbp_etl.bf_listung_markt_kw_kmo_vj_2 a
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _anz_wochen1_vj AS (
SELECT mandant_id,
       art_matching_id,
       kjwo,
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
GROUP BY 1,2,3
);

CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_kw_kmo_2 (mandant_id
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
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
	 v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
      v03.arthiertyp_id = 2 AND 
	  v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0E (
	art_id	INTEGER, 
	mandant_id	BYTEINT,
        kjwo INTEGER,
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
    
    absatz_ksk1	FLOAT, 
	anz_wo_mit_abs_ksk1	FLOAT, 
	absatz_ksk2	FLOAT, 
	anz_wo_mit_abs_ksk2	FLOAT, 
	absatz_ksk3	FLOAT, 
	anz_wo_mit_abs_ksk3	FLOAT, 
	absatz_ksk4	FLOAT, 
	anz_wo_mit_abs_ksk4	FLOAT, 
	absatz_ksk5	FLOAT, 
	anz_wo_mit_abs_ksk5	FLOAT, 
	absatz_ksk6	FLOAT, 
	anz_wo_mit_abs_ksk6	FLOAT, 
	absatz_ksk7	FLOAT, 
	anz_wo_mit_abs_ksk7	FLOAT,
    
    absatz_af_sk1_bis6	FLOAT,
	absatz_sa_sk1_bis6	FLOAT,
    
    absatz_af_ksk1_bis6	FLOAT,
	absatz_sa_ksk1_bis6	FLOAT
);

INSERT INTO ZZMD0E 
SELECT	a11.art_id  art_id,
	a11.mandant_id  mandant_id,
        t.kjwo kjwo,
	Sum((CASE WHEN (a14.sm_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk1,
	Sum((CASE WHEN (a14.sm_id = 1) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk1,
	Sum((CASE WHEN (a14.sm_id = 2) THEN a11.absatz ELSE NULL end))  absatz_sk2,
	Sum((CASE WHEN (a14.sm_id = 2) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk2,
	Sum((CASE WHEN (a14.sm_id = 3) THEN a11.absatz ELSE NULL end))  absatz_sk3,
	Sum((CASE WHEN (a14.sm_id = 3) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk3,
	Sum((CASE WHEN (a14.sm_id = 4) THEN a11.absatz ELSE NULL end))  absatz_sk4,
	Sum((CASE WHEN (a14.sm_id = 4) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk4,
	Sum((CASE WHEN (a14.sm_id = 5) THEN a11.absatz ELSE NULL end))  absatz_sk5,
	Sum((CASE WHEN (a14.sm_id = 5) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk5,
	Sum((CASE WHEN (a14.sm_id = 6) THEN a11.absatz ELSE NULL end))  absatz_sk6,
        Sum((CASE WHEN (a14.sm_id = 6) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk6,
	Sum((CASE WHEN (a14.sm_id = 7) THEN a11.absatz ELSE NULL end))  absatz_sk7,
	Sum((CASE WHEN (a14.sm_id = 7) THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk7,
    
	Sum((CASE WHEN (a14.ksm_id = 'K1') THEN a11.absatz ELSE NULL end))  absatz_ksk1,
	Sum((CASE WHEN (a14.ksm_id = 'K1') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk1,
	Sum((CASE WHEN (a14.ksm_id = 'K2') THEN a11.absatz ELSE NULL end))  absatz_ksk2,
	Sum((CASE WHEN (a14.ksm_id = 'K2') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk2,
	Sum((CASE WHEN (a14.ksm_id = 'K3') THEN a11.absatz ELSE NULL end))  absatz_ksk3,
	Sum((CASE WHEN (a14.ksm_id = 'K3') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk3,
	Sum((CASE WHEN (a14.ksm_id = 'K4') THEN a11.absatz ELSE NULL end))  absatz_ksk4,
	Sum((CASE WHEN (a14.ksm_id = 'K4') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk4,
	Sum((CASE WHEN (a14.ksm_id = 'K5') THEN a11.absatz ELSE NULL end))  absatz_ksk5,
	Sum((CASE WHEN (a14.ksm_id = 'K5') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk5,
	Sum((CASE WHEN (a14.ksm_id = 'K6') THEN a11.absatz ELSE NULL end))  absatz_ksk6,
        Sum((CASE WHEN (a14.ksm_id = 'K6') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk6,
	Sum((CASE WHEN (a14.ksm_id = 'K7') THEN a11.absatz ELSE NULL end))  absatz_ksk7,
	Sum((CASE WHEN (a14.ksm_id = 'K7') THEN a11.anzahl_wochen_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ksk7,
    
        Sum((CASE WHEN (a14.sm_id IN (1, 2, 3, 4, 5,6,7)) THEN a11.absatz_af ELSE NULL end))  absatz_af_sk1_bis6,
	Sum((CASE WHEN (a14.sm_id IN (1, 2, 3, 4, 5,6,7)) THEN a11.absatz_sa ELSE NULL end))  absatz_sa_sk1_bis6,
    
        Sum((CASE WHEN (a14.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5','K6','K7')) THEN a11.absatz_af ELSE NULL end))  absatz_af_ksk1_bis6,
	Sum((CASE WHEN (a14.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5','K6','K7')) THEN a11.absatz_sa ELSE NULL end))  absatz_sa_ksk1_bis6
    
FROM dbp_etl.bf_listung_markt_tag_kmo_2 a11
JOIN dbp_data.tag_2 t
on a11.dat = t.dat
JOIN dbp_data.sm_wup_wg_zu_per_2 a14
  ON  a11.mandant_id = a14.mandant_id AND 
	a11.nb_id = a14.nb_id AND 
	a11.wg_id = a14.wg_id AND 
	a11.wup_id = a14.wup_id AND
        CURRENT_DATE BETWEEN a14.dat_von AND a14.dat_bis
WHERE a11.mandant_id > 1 AND 
     (a14.sm_id BETWEEN 1 AND 7 OR
      a14.ksm_id IN ('K1','K2','K3','K4','K5','K6','K7'))
GROUP BY a11.art_id,a11.mandant_id,t.kjwo
;

CREATE OR REPLACE VOLATILE TABLE ZZMD0E1 AS (
SELECT b.art_matching_id,
       a.mandant_id,
       a.kjwo,
       Sum(a.absatz_sk1) AS absatz_sk1,
       Sum(a.anz_wo_mit_abs_sk1)/7.0000 AS anz_wo_mit_abs_sk1,
       Sum(a.absatz_sk2) AS absatz_sk2,
       Sum(a.anz_wo_mit_abs_sk2)/7.0000 AS anz_wo_mit_abs_sk2,
       Sum(a.absatz_sk3) AS absatz_sk3,
       Sum(a.anz_wo_mit_abs_sk3)/7.0000 AS anz_wo_mit_abs_sk3,
       Sum(a.absatz_sk4) AS absatz_sk4,
       Sum(a.anz_wo_mit_abs_sk4)/7.0000 AS anz_wo_mit_abs_sk4,
       Sum(a.absatz_sk5) AS absatz_sk5,
       Sum(a.anz_wo_mit_abs_sk5)/7.0000 AS anz_wo_mit_abs_sk5,
       Sum(a.absatz_sk6) AS absatz_sk6,
       Sum(a.anz_wo_mit_abs_sk6)/7.0000 AS anz_wo_mit_abs_sk6,
       Sum(a.absatz_sk7) AS absatz_sk7,
       Sum(a.anz_wo_mit_abs_sk7)/7.0000 AS anz_wo_mit_abs_sk7,
       
       Sum(a.absatz_ksk1) AS absatz_ksk1,
       Sum(a.anz_wo_mit_abs_ksk1)/7.0000 AS anz_wo_mit_abs_ksk1,
       Sum(a.absatz_ksk2) AS absatz_ksk2,
       Sum(a.anz_wo_mit_abs_ksk2)/7.0000 AS anz_wo_mit_abs_ksk2,
       Sum(a.absatz_ksk3) AS absatz_ksk3,
       Sum(a.anz_wo_mit_abs_ksk3)/7.0000 AS anz_wo_mit_abs_ksk3,
       Sum(a.absatz_ksk4) AS absatz_ksk4,
       Sum(a.anz_wo_mit_abs_ksk4)/7.0000 AS anz_wo_mit_abs_ksk4,
       Sum(a.absatz_ksk5) AS absatz_ksk5,
       Sum(a.anz_wo_mit_abs_ksk5)/7.0000 AS anz_wo_mit_abs_ksk5,
       Sum(a.absatz_ksk6) AS absatz_ksk6,
       Sum(a.anz_wo_mit_abs_ksk6)/7.0000 AS anz_wo_mit_abs_ksk6,
       Sum(a.absatz_ksk7) AS absatz_ksk7,
       Sum(a.anz_wo_mit_abs_ksk7)/7.0000 AS anz_wo_mit_abs_ksk7,
       
       Sum(a.absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
       Sum(a.absatz_sa_sk1_bis6) AS absatz_sa_sk1_bis6,
       Sum(a.absatz_af_ksk1_bis6) AS absatz_af_ksk1_bis6,
       Sum(a.absatz_sa_ksk1_bis6) AS absatz_sa_ksk1_bis6
FROM ZZMD0E a
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _vk1 AS (
SELECT b.art_matching_id,
       a.mandant_id,
       c.kjwo_update as kjwo,
       Avg(CASE WHEN a.pm_id = 1  THEN a.vk_brutto END) AS pk1,
       Avg(CASE WHEN a.pm_id = 2  THEN a.vk_brutto END) AS pk2,
       Avg(CASE WHEN a.pm_id = 3  THEN a.vk_brutto END) AS pk3,
       Avg(CASE WHEN a.pm_id = 4  THEN a.vk_brutto END) AS pk4,
       Avg(CASE WHEN a.pm_id = 5  THEN a.vk_brutto END) AS pk5,
       Avg(CASE WHEN a.pm_id = 6  THEN a.vk_brutto END) AS pk6,
       Avg(CASE WHEN a.pm_id = 7  THEN a.vk_brutto END) AS pk7,
       Avg(CASE WHEN a.pm_id = 8  THEN a.vk_brutto END) AS pk8,
       Avg(CASE WHEN a.pm_id = 9  THEN a.vk_brutto END) AS pk9,
       Avg(CASE WHEN a.pm_id = 10 THEN a.vk_brutto END) AS pk10
FROM dbp_data.art_pm_vw_zu_per_2 a
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
JOIN dbp_data.sortiment_leistung_2 c
  ON b.art_matching_id = c.matching_id AND
     a.mandant_id = c.mandant_id
WHERE a.mandant_id > 1 AND
      a.dat_bis = '9999-12-31' AND
      c.kjwo_update IN (SELECT kjwo_vj FROM _zeitraum_woche)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _ek1 AS 
(
SELECT 
A.MANDANT_ID,
C.ART_MATCHING_ID,
B.KJWO,
(ZEROIFNULL(SUM(A.umsatz_netto)) - ZEROIFNULL(SUM(A.einstandspreis))) AS total_rohertrag_olk,
(ZEROIFNULL(SUM(CASE WHEN A.bewart_id = 1001 THEN A.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN A.bewart_id = 1001 THEN A.einstandspreis END))) AS  total_rohertrag_olk_af,
(ZEROIFNULL(SUM(CASE WHEN A.bewart_id = 1002 THEN A.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN A.bewart_id = 1002 THEN A.einstandspreis END)))  AS  total_rohertrag_olk_sa
FROM DBP_DATA.ARTBEW_2 A
JOIN DBP_DATA.TAG_2 B
  ON A.DAT = B.DAT
JOIN (SELECT MANDANT_ID, ART_MATCHING_ID, ART_ID FROM DBP_ETL.ART_MATCHING_NIELSEN_PER_KMO_2 WHERE ART_ID <> -1 GROUP BY 1,2,3) C
  ON A.ART_ID = C.ART_ID AND
     A.MANDANT_ID = C.MANDANT_ID
WHERE B.KJWO in (SELECT KJWO FROM _zeitraum_woche) AND A.MANDANT_ID > 1 
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _abschriften as ( 
SELECT a.mandant_id,
       a.art_id,
	   b.kjwo,
       SUM(a.abschriftbetrag_netto) AS abschriftsbetrag_ohne_werbung_netto
FROM dbp_data.marktabschriften_2 a
JOIN dbp_data.tag_2 b
  ON a.dat = b.dat
JOIN (SELECT mandant_id,
             art_id
      FROM dbp_etl.st_listung_sm_kw_kmo_2
      GROUP BY 1,2) c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.abschriftart_id BETWEEN 905 AND 994 AND a.mandant_id in (2,3,5,6,7,8) AND 
      NOT (a.abschriftart_id = 955 AND a.mandant_id = 2) AND B.KJWO in (SELECT KJWO FROM _zeitraum_woche) AND A.MANDANT_ID > 1 
  GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _abschriften2 as ( 
SELECT
A.MANDANT_ID,
B.ART_MATCHING_ID,
A.KJWO,
A.abschriftsbetrag_ohne_werbung_netto
FROM _abschriften A
JOIN (SELECT MANDANT_ID, ART_MATCHING_ID, ART_ID FROM DBP_ETL.ART_MATCHING_NIELSEN_PER_KMO_2 WHERE ART_ID <> -1 GROUP BY 1,2,3) B
  ON A.ART_ID = B.ART_ID AND
     A.MANDANT_ID = B.MANDANT_ID
);

CREATE OR REPLACE VOLATILE TABLE _ek1_vj AS (
SELECT b.art_matching_id,
       a.mandant_id,
       a.kjwo,
      (ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1001 THEN a.umsatz_netto END)) - ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1001 THEN a.einstandspreis END))) re_mep_af_olk_vj,
	  (ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1002 THEN a.umsatz_netto END)) - ZeroIfNull(Sum(CASE WHEN a.bewart_id = 1002 THEN a.einstandspreis END))) re_mep_sa_olk_vj,
	  (ZeroIfNull(Sum(a.umsatz_netto)) - ZeroIfNull(Sum(a.einstandspreis))) re_mep_tot_olk_vj
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_vj_2 a
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE a.mandant_id > 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _kpi1 AS (
SELECT a.mandant_id,
       a.kjwo,
       c.art_matching_id,
       Sum(a.art_bons_af) AS art_bons_af,
       Sum(a.art_bons_sa) AS art_bons_sa,
       Sum(a.anz_bons) AS anz_bons,
       Sum(a.cp_bons_af) AS cp_bons_af,
       Sum(a.cp_bons_sa) AS cp_bons_sa
FROM dbp_etl.sort_kpi_woche_basis_2 a
JOIN dbp_data.art_2 b
  ON a.mandant_id = b.mandant_id AND
     a.kl_art_id = b.kl_art_id AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) c
  ON b.art_id = c.art_id AND
     b.mandant_id = c.mandant_id
WHERE a.mandant_id > 1 AND
      a.kjwo IN (SELECT kjwo FROM _zeitraum_woche)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _tage_vj AS (
SELECT c.mandant_id,
       a.dat AS dat,
       a.kjwo as kjwo
FROM dbp_data.tag_2 a
JOIN dbp_data.mandant_2 c
  ON 1 = 1
WHERE a.kjwo IN (SELECT kjwo_vj FROM _zeitraum_woche) and c.mandant_id > 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _vj_ek AS (
SELECT a11.art_id,
       a11.mandant_id,
       b.kjwo,
      (ZeroIfNull(Sum(a11.umsatz_netto)) - ZeroIfNull(Sum(a11.einstandspreis - a11.logkostenzuschlag))) re_mep_tot_olk_vj
FROM dbp_data.artbew_2 a11
JOIN _tage_vj b
  ON a11.dat = b.dat AND
     a11.mandant_id = b.mandant_id
WHERE a11.mandant_id > 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _vj_ek1 AS (
SELECT b.art_matching_id,
       a.mandant_id,
       a.kjwo,
       Sum(a.re_mep_tot_olk_vj) AS re_mep_vj
FROM _vj_ek a
JOIN (SELECT mandant_id,
             art_matching_id,
             art_id,
             status_2
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3,4) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _main AS 
(
select 
a.KJWO,
a.MANDANT_ID,
a.ART_ID,
d.art_matching_id as matching_id
from dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 a 
JOIN (SELECT art_matching_id,
             art_id,
             mandant_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2
      WHERE art_id <> -1
      GROUP BY 1,2,3) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
     group by 1,2,3,4
);

DELETE FROM dbp_data.tupel_kw_2
WHERE kjwo IN (SELECT kjwo FROM _zeitraum_woche) AND
      mandant_id > 1
;

INSERT INTO dbp_data.tupel_kw_2 (mandant_id
                               ,kjwo
                               ,matching_id
                               ,wrg_id
                               ,anzahl_markt_wochen_kombis_abverkauf_af
                               ,anzahl_markt_wochen_kombis_abverkauf_sa
                               ,anzahl_markt_wochen_kombis_abverkauf_af_vj
                               ,anzahl_markt_wochen_kombis_abverkauf_sa_vj
                               ,kassenumsatz_kl_absolut_brutto
                               ,kassenumsatz_af_kl_absolut_brutto
                               ,kassenumsatz_sa_kl_absolut_brutto
                               ,kassenumsatz_kl_absolut_brutto_vj
                               ,kassenumsatz_af_kl_absolut_brutto_vj
                               ,kassenumsatz_sa_kl_absolut_brutto_vj
                               ,kassenumsatz_kl_absolut_netto
                               ,kassenumsatz_af_kl_absolut_netto
                               ,kassenumsatz_sa_kl_absolut_netto
                               ,kassenumsatz_kl_absolut_netto_vj
                               ,kassenumsatz_af_kl_absolut_netto_vj
                               ,kassenumsatz_sa_kl_absolut_netto_vj
                               ,absatz_kl
                               ,absatz_af_kl
                               ,absatz_sa_kl
                               ,absatz_kl_vj
                               ,absatz_af_kl_vj
                               ,absatz_sa_kl_vj
                               ,absatz_sst1
                               ,absatz_sst2
                               ,absatz_sst3
                               ,absatz_sst4
                               ,absatz_sst5
                               ,absatz_sst6
                               ,absatz_sst7
                               ,absatz_ksst1
                               ,absatz_ksst2
                               ,absatz_ksst3
                               ,absatz_ksst4
                               ,absatz_ksst5
                               ,absatz_ksst6
                               ,absatz_ksst7
                               ,absatz_ost_basis
                               ,absatz_ost_gross
                               ,absatz_sued_ost
                               ,absatz_sued_west
                               ,absatz_west
                               ,absatz_nord
                               ,markt_wochen_sst1
                               ,markt_wochen_sst2
                               ,markt_wochen_sst3
                               ,markt_wochen_sst4
                               ,markt_wochen_sst5
                               ,markt_wochen_sst6
                               ,markt_wochen_sst7
                               ,markt_wochen_ksst1
                               ,markt_wochen_ksst2
                               ,markt_wochen_ksst3
                               ,markt_wochen_ksst4
                               ,markt_wochen_ksst5
                               ,markt_wochen_ksst6
                               ,markt_wochen_ksst7
                               ,markt_wochen_ost_basis
                               ,markt_wochen_ost_gross
                               ,markt_wochen_sued_ost
                               ,markt_wochen_sued_west
                               ,markt_wochen_west
                               ,markt_wochen_nord
                               ,anzahl_markt_wochen_kombis_abverkauf_mit_listung
                               ,anzahl_markt_wochen_kombis_listung
                               ,rohertrag_ekmep_olk_4n
                               ,anz_bons_af
                               ,anz_bons_sa
                               ,anz_bons_gesamt
                               ,rohertrag_ekmep_olk_4n_vj
                               ,rohertrag_ekmep_olk_4n_af
                               ,rohertrag_ekmep_olk_4n_sa
                               ,rohertrag_ekmep_olk_4n_af_vj
                               ,rohertrag_ekmep_olk_4n_sa_vj
                               ,totalabschriften_wert_netto_absolut
                               ,totalabschriften_wert_netto_absolut_vj
                               ,ANZ_BONS_AF_MARKT_TAG
                               ,ANZ_BONS_SA_MARKT_TAG
                               ,cpq_tupel
                               ,cp_bons_af
                               ,cp_bons_sa
                               ,kassenumsatz_kl_absolut_netto_wg
                               ,anz_bons_tupel
                               ,restbon_summe
                               ,totalabschriften_wert_netto_absolut_wg
                               ,absatz_af_kl_listungswochen
                               ,absatz_af_kl_vj_listungswochen
                               ,absatz_sa_kl_listungswochen
                               ,absatz_sa_kl_vj_listungswochen
                               ,kassenumsatz_af_kl_absolut_netto_listungswochen
                               ,kassenumsatz_af_kl_absolut_netto_vj_listungswochen
                               ,kassenumsatz_sa_kl_absolut_netto_listungswochen
                               ,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
                               ,rohertrag_ekmep_olk_4n_af_listungswochen
                               ,rohertrag_ekmep_olk_4n_af_vj_listungswochen
                               ,rohertrag_ekmep_olk_4n_sa_listungswochen
                               ,rohertrag_ekmep_olk_4n_sa_vj_listungswochen)
SELECT a.mandant_id
      ,a.kjwo AS kjwo_update
      ,a.matching_id
      ,x99.default_wrg
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
      ,d.absatz_ksk1 AS A62_absatz_ksst1
      ,d.absatz_ksk2 AS A64_absatz_ksst2
      ,d.absatz_ksk3 AS A66_absatz_ksst3
      ,d.absatz_ksk4 AS A68_absatz_ksst4
      ,d.absatz_ksk5 AS A70_absatz_ksst5
      ,d.absatz_ksk6 AS A72_absatz_ksst6
      ,d.absatz_ksk7 AS A74_absatz_ksst7
      ,0 AS A90_absatz_ost_basis
      ,0 AS A92_absatz_ost_gross
      ,0 AS A94_absatz_sued_ost
      ,0 AS A96_absatz_sued_west
      ,0 AS A98_absatz_west
      ,0 AS A100_absatz_nord
      ,d.anz_wo_mit_abs_sk1 AS markt_wochen_sst1
      ,d.anz_wo_mit_abs_sk2 AS markt_wochen_sst2
      ,d.anz_wo_mit_abs_sk3 AS markt_wochen_sst3
      ,d.anz_wo_mit_abs_sk4 AS markt_wochen_sst4
      ,d.anz_wo_mit_abs_sk5 AS markt_wochen_sst5
      ,d.anz_wo_mit_abs_sk6 AS markt_wochen_sst6
      ,d.anz_wo_mit_abs_sk7 AS markt_wochen_sst7
      ,d.anz_wo_mit_abs_ksk1 AS markt_wochen_ksst1
      ,d.anz_wo_mit_abs_ksk2 AS markt_wochen_ksst2
      ,d.anz_wo_mit_abs_ksk3 AS markt_wochen_ksst3
      ,d.anz_wo_mit_abs_ksk4 AS markt_wochen_ksst4
      ,d.anz_wo_mit_abs_ksk5 AS markt_wochen_ksst5
      ,d.anz_wo_mit_abs_ksk6 AS markt_wochen_ksst6
      ,d.anz_wo_mit_abs_ksk7 AS markt_wochen_ksst7
      ,0 AS markt_wochen_ost_basis
      ,0 AS markt_wochen_ost_gross
      ,0 AS markt_wochen_sued_ost
      ,0 AS markt_wochen_sued_west
      ,0 AS markt_wochen_west
      ,0 AS markt_wochen_nord
      ,s.anz_wo_mit_absatz AS anzahl_markt_wochen_kombis_abverkauf_mit_listung
      ,r.anz_wo_listung_2 AS anzahl_markt_wochen_kombis_listung
      ,i.total_rohertrag_olk AS A23_rohertrag_ekmep_olk_4n
      ,k.art_bons_af AS anz_bons_af
      ,k.art_bons_sa AS anz_bons_sa
      ,0 AS anz_bons_gesamt
      ,j.re_mep_tot_olk_vj AS rohertrag_ekmep_olk_4n_vj
      ,i.total_rohertrag_olk_af AS rohertrag_ekmep_olk_4n_af
      ,i.total_rohertrag_olk_sa AS rohertrag_ekmep_olk_4n_sa
      ,j.re_mep_af_olk_vj AS rohertrag_ekmep_olk_4n_af_vj
      ,j.re_mep_sa_olk_vj AS rohertrag_ekmep_olk_4n_sa_vj
      ,w.abschriftsbetrag_ohne_werbung_netto AS A27_totalabschriften_wert_netto_absolut
      ,0 AS totalabschriften_wert_netto_absolut_vj
      ,0 AS ANZ_BONS_AF_MARKT_TAG
      ,0 AS ANZ_BONS_SA_MARKT_TAG
      ,k.cp_bons_af+k.cp_bons_sa AS cpq_tupel
      ,k.cp_bons_af AS cp_bons_af
      ,k.cp_bons_sa AS cp_bons_sa
      ,0 AS kassenumsatz_kl_absolut_netto_wg
      ,k.anz_bons AS anz_bons_tupel
      ,0 AS restbon_summe
      ,0 AS totalabschriften_wert_netto_absolut_wg
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
FROM _main a
JOIN dbp_data.mandant_2 x99 
  ON a.mandant_id = x99.mandant_id
JOIN _zeitraum_woche zw
  ON a.kjwo = zw.kjwo
LEFT JOIN _anz_wochen1 b
  ON a.matching_id = b.art_matching_id AND
     a.mandant_id = b.mandant_id AND
     a.kjwo = b.kjwo
LEFT JOIN _anz_wochen1_vj c
  ON a.matching_id = c.art_matching_id AND
     a.mandant_id = c.mandant_id AND
     zw.KJWO_VJ = c.kjwo
LEFT JOIN ZZMD0E1 d
  ON a.matching_id = d.art_matching_id AND
     a.mandant_id = d.mandant_id AND
     a.kjwo = d.kjwo
LEFT JOIN _vk1 h
  ON a.matching_id = h.art_matching_id AND
     a.mandant_id = h.mandant_id and 
     a.kjwo = h.kjwo
LEFT JOIN _ek1 i
  ON a.matching_id = i.art_matching_id AND
     a.mandant_id = i.mandant_id AND
     a.kjwo = i.kjwo
LEFT JOIN _ek1_vj j
  ON a.matching_id = j.art_matching_id AND
     a.mandant_id = j.mandant_id AND
     zw.KJWO_VJ = j.kjwo
LEFT JOIN _kpi1 k
  ON a.matching_id = k.art_matching_id AND
     a.mandant_id = k.mandant_id AND
     a.kjwo = k.kjwo
LEFT JOIN _mm_x n
  ON a.matching_id = n.matching_id AND
     a.mandant_id = n.mandant_id AND
     a.kjwo = n.kjwo
LEFT JOIN _mm_z o
  ON a.matching_id = o.matching_id AND
     a.mandant_id = o.mandant_id AND
     a.kjwo = o.kjwo
LEFT JOIN _mm_z_vj p
  ON a.matching_id = p.matching_id AND
     a.mandant_id = p.mandant_id AND
     zw.KJWO_VJ = p.kjwo
LEFT JOIN ZZSP07_pre_tag_xxx q
  ON a.matching_id = q.matching_id AND
     a.mandant_id = q.mandant_id and 
     a.kjwo = q.kjwo
LEFT JOIN ZZSP08_pre_xxx r
  ON a.matching_id = r.matching_id AND
     a.mandant_id = r.mandant_id and 
     a.kjwo = r.kjwo
LEFT JOIN _mm_y_xxx s
  ON a.matching_id = s.matching_id AND
     a.mandant_id = s.mandant_id and 
     a.kjwo = s.kjwo
LEFT JOIN ZZSP07_pre_tag_vj_xxx t
  ON a.matching_id = t.matching_id AND
     a.mandant_id = t.mandant_id and 
     zw.KJWO_VJ = t.kjwo
LEFT JOIN ZZSP08_pre_xxx u
  ON a.matching_id = u.matching_id AND
     a.mandant_id = u.mandant_id and 
     a.kjwo = u.kjwo
LEFT JOIN _abschriften2 w 
  ON a.matching_id = w.ART_MATCHING_ID AND
     a.mandant_id = w.mandant_id and 
     a.kjwo = w.kjwo
WHERE A273_kassenumsatz_kl_absolut_brutto > 0 AND
      a.mandant_id > 1
;


--restbon + cherrypicker kmo

create or replace volatile table _bons_art_kmo_kw as (
select 
	a.mandant_id,
	b.art_id,
	sum(a.art_ums_af) as art_umsatz_af,
	sum(a.art_ums_sa) as art_umsatz_sa,
	sum(a.bon_ums_af) as bon_umsatz_af,
	sum(a.bon_ums_sa) as bon_umsatz_sa,
	sum(a.restbon_af) as restbon_af,
	sum(a.restbon_sa) as restbon_sa,
	sum(a.restbon_af)+sum(a.restbon_sa) as restbon_summe,
	sum(a.art_bons_af) as anz_bons_af,
	sum(a.art_bons_sa) as anz_bons_sa,
	sum(a.art_bons_af) + sum(a.art_bons_sa) as anz_bons,
        sum(a.cp_bons_sa) as cp_bons_sa
from dbp_etl.bf_bons_sort_sum_2 a
join dbp_data.art_2 b
on   
	a.mandant_id = b.mandant_id and
	a.kl_art_id = b.kl_art_id and
	b.dat_bis = '9999-12-31'
join dbp_data.tag_2 c
	on a.dat=c.dat
where a.mandant_id>1 and
(a.mandant_id,c.kjwo) in (select x.mandant_id,
                                 x.kjwo
                                 from (select 
				       b.mandant_id,
                                       c.kjwo,
                                       rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                       from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 a
                                       join (select mandant_id,
                                             max(kjmo) as kjmo
                                             from dbp_data.sortiment_leistung_2
                                             where mandant_id <> 1
                                             group by 1) b
                                       on a.kjmo_sort = b.kjmo
                                       join dbp_data.woche_2 c
                                       on c.kjwo <= a.kjwo_bis) x
                          where x.akt_wo between -63 and -1
                          group by 1,2)
  group by 1,2
);

create or replace volatile table _bons_matching_kmo_kw as
(
select 
	a.mandant_id,
	b.art_matching_id,
	sum(a.art_umsatz_af) as art_umsatz_af,
	sum(a.art_umsatz_sa) as art_umsatz_sa,
	sum(a.bon_umsatz_af) as bon_umsatz_af,
	sum(a.bon_umsatz_sa) as bon_umsatz_sa,
	sum(a.restbon_af) as restbon_af,
	sum(a.restbon_sa) as restbon_sa,
	sum(a.restbon_summe) as restbon_summe,
	sum(a.anz_bons_af) as anz_bons_af,
	sum(a.anz_bons_sa) as anz_bons_sa,
	sum(a.anz_bons) as anz_bons,
        SUM(a.cp_bons_sa) as cp_bons_sa
	from _bons_art_kmo_kw a
join (
      select distinct mandant_id,art_matching_id,art_id from 
      dbp_etl.art_matching_nielsen_per_kmo_2 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_2) 
	  and art_id <> -1
	  ) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

update dbp_data.tupel_kw_2 from (select * from _bons_matching_kmo_kw) b

set 
restbon_summe = b.restbon_summe,
anz_bons_gesamt = b.anz_bons,
anz_bons_af =  b.anz_bons_af,
anz_bons_sa = b.anz_bons_sa,
cp_bons_sa = b.cp_bons_sa



where dbp_data.tupel_kw.mandant_id = b.mandant_id and
      dbp_data.tupel_kw.matching_id = b.art_matching_id and
      dbp_data.tupel_kw.kjwo = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_2 where mandant_id > 1)
;


---------------------------


--kmo Bonreichweite
create or replace table dbp_etl_process.sort_bon_receipt_agg_kmo_af_kw_2 as
(
select 
        mandant_id,
        art_id,
        sum(total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_kmo_2  a
join  (SELECT dat,kjwo
      FROM dbp_data.tag_2
      GROUP BY 1,2) x
  ON a.BON_DAT = x.dat
where (a.MANDANT_ID,x.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_2 a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung_2
                                                WHERE mandant_id > 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche_2 c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -63 AND -1
                                    GROUP BY 1,2) and anz_bons_af_fg>0
group by 1,2
) ;

create or replace table dbp_etl_process.sort_bon_receipt_agg_kmo_sa_kw_2 as
(
select 
        mandant_id,
        art_id,
        sum(total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_kmo_2  a
join  (SELECT dat,kjwo
      FROM dbp_data.tag_2
      GROUP BY 1,2) x
  ON a.BON_DAT = x.dat
where (a.MANDANT_ID,x.kjwo) IN (SELECT x.mandant_id,
                                           x.kjwo
                                    FROM (SELECT b.mandant_id,
                                                 c.kjwo,
                                                 Rank() Over (PARTITION BY b.mandant_id ORDER BY b.mandant_id,c.kjwo DESC) * (-1) AS akt_wo
                                          FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_2 a
                                          JOIN (SELECT mandant_id,
                                                       Max(kjmo) AS kjmo
                                                FROM dbp_data.sortiment_leistung_2
                                                WHERE mandant_id > 1
                                                GROUP BY 1) b
                                            ON a.kjmo_sort = b.kjmo
                                          JOIN dbp_data.woche_2 c
                                            ON c.kjwo <= a.kjwo_bis) x
                                    WHERE x.akt_wo BETWEEN -63 AND -1
                                    GROUP BY 1,2) and anz_bons_sa_fg>0
group by 1,2
) ;

create or replace volatile table _sort_bon_receipt_agg_kmo_lvl2_af_kw as
(
select 
        a.mandant_id,
        b.art_matching_id,
        sum(a.sum_total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_agg_kmo_af_kw_2 a
join 
(
        select distinct mandant_id,art_matching_id,art_id from 
        dbp_etl.art_matching_nielsen_per_kmo_2 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_2) 
        and art_id <> -1
) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

create or replace volatile table _sort_bon_receipt_agg_kmo_lvl2_sa_kw as
(
select 
        a.mandant_id,
        b.art_matching_id,
        sum(a.sum_total_receipt) as sum_total_receipt
from dbp_etl_process.sort_bon_receipt_agg_kmo_sa_kw_2 a
join 
(
        select distinct mandant_id,art_matching_id,art_id from 
        dbp_etl.art_matching_nielsen_per_kmo_2 where kjwo_update = (select max(kjwo_update) from  dbp_etl.art_matching_nielsen_per_kmo_2) 
        and art_id <> -1
) b
on
	a.mandant_id=b.mandant_id and
	a.art_id = b.art_id
group by 1,2
);

update dbp_data.tupel_kw_2 from (select * from _sort_bon_receipt_agg_kmo_lvl2_af_kw) b

set 
ANZ_BONS_AF_MARKT_TAG = b.sum_total_receipt

where dbp_data.tupel_kw.mandant_id = b.mandant_id and
      dbp_data.tupel_kw.matching_id = b.art_matching_id and
      dbp_data.tupel_kw.kjwo = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_2 where mandant_id > 1)
;

update dbp_data.tupel_kw_2 from (select * from _sort_bon_receipt_agg_kmo_lvl2_sa_kw) b

set 
ANZ_BONS_SA_MARKT_TAG = b.sum_total_receipt

where dbp_data.tupel_kw.mandant_id = b.mandant_id and
      dbp_data.tupel_kw.matching_id = b.art_matching_id and
      dbp_data.tupel_kw.kjwo = (select max(kjwo_update) from dbp_data.art_kl_preislage_zu_per_2 where mandant_id > 1)
;
