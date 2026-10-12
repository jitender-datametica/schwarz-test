CREATE OR REPLACE TABLE DBP_ETL.tag_wa_kalk_final_abs  (
      mandant_id BYTEINT,
      art_id INTEGER,
      bewart_id SMALLINT,
      bewart_det_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      dat DATE,
      wrg_id CHAR(3) COLLATE 'en-ci',
      zek_id VARCHAR(3),
      eigenmarke_fg BYTEINT,
      wup_bereinigt_fg BYTEINT,
      umsatz_netto DECIMAL(18,4),
      umsatz_netto_vj DECIMAL(18,4),
      umsatz_netto_vj_km DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      logkostenzuschlag_vj DECIMAL(18,4),
      logkostenzuschlag_vj_km DECIMAL(18,4),
      betrag_kmep_km FLOAT,
      betrag_kmep_km_vj FLOAT,
      betrag_kmep_kw FLOAT,
      betrag_kmep_kw_vj FLOAT,
      betrag_kmep_ww FLOAT,
      betrag_kmep_ww_vj FLOAT,
      werbe_abschrift_netto DECIMAL(18,4) NOT NULL,
      werbe_abschrift_netto_vj DECIMAL(18,4) NOT NULL,
      werbe_abschrift_netto_vj_km DECIMAL(18,4) NOT NULL,
      preis_abschrift_netto DECIMAL(18,4) NOT NULL,
      preis_abschrift_netto_vj DECIMAL(18,4) NOT NULL,
      preis_abschrift_netto_vj_km DECIMAL(18,4) NOT NULL,
      umrechnungskurs_hist number(38,5)
);

CREATE OR REPLACE TRANSIENT TABLE _ekc_preis_abschriften AS (
SELECT a.mandant_id,
       a.art_id,
       Coalesce(b.bewart_id,1002) AS bewart_id,
       Coalesce(b.bewart_det_id,100210) AS bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       Round(Sum(Cast(a.abschriftbetrag_netto AS FLOAT)*Coalesce(Cast(b.anteil AS FLOAT),Cast(1.0000 AS FLOAT))),2) AS preis_abschrift_netto
FROM DBP_DATA.marktabschriften a
JOIN DBP_ETL_PROCESS.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
LEFT JOIN DBP_ETL_PROCESS.ekc_artbew_flagging b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat
WHERE a.mandant_id = 1 AND
      CASE 
        WHEN a.dat BETWEEN '2022-03-01' AND '2024-02-29' THEN a.abschriftart_id IN (5,7,26,30) 
        WHEN a.dat BETWEEN '2024-03-01' AND '9999-12-31' THEN a.abschriftart_id IN (5,7,26,27,30)
        ELSE a.abschriftart_id IN (5,7,26)
      END and
      a.dat >= (select min(dat)-400 FROM dbp_etl.zeitraum_fww_kmo_gld)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
UNION ALL
SELECT a.mandant_id,
       a.art_id,
       Coalesce(b.bewart_id,1002) AS bewart_id,
       Coalesce(b.bewart_det_id,100210) AS bewart_det_id,       
       a.wup_id,
       a.nb_id,
       a.dat_umbew AS dat,
       a.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       ROUND(SUM(CASE
             WHEN a.mandant_id IN (2,5) AND a.preis_aend_grund_id IN (7,10,26)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             WHEN a.mandant_id IN (6) AND a.preis_aend_grund_id IN (2,26)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             WHEN a.mandant_id IN (3) AND a.preis_aend_grund_id IN (11,26)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             WHEN a.mandant_id IN (4,7,8) AND a.preis_aend_grund_id IN (7,26)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             ELSE 0
           END),2) AS preis_abschrift_netto
FROM DBP_DATA.art_umbewertung a
JOIN DBP_ETL_PROCESS.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
LEFT JOIN DBP_ETL_PROCESS.ekc_artbew_flagging b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat_umbew = b.dat
WHERE a.mandant_id > 1 and
      a.dat_umbew >= (select min(dat)-400 FROM dbp_etl.zeitraum_fww_kmo_gld)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

CREATE OR REPLACE TRANSIENT TABLE _ekc_werbe_abschriften AS (
SELECT a.mandant_id,
       a.art_id,
       1002 AS bewart_id,
       100210 AS bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       SUM(a.abschriftbetrag_netto) AS werbe_abschrift_netto
FROM dbp_data.marktabschriften a
JOIN dbp_etl_process.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.abschriftart_id = -1 AND
      a.mandant_id = 1 AND
      CASE WHEN a.dat >= '2020-12-01' THEN a.wv_grund_id IN (0,2,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67) ELSE 1=1 END and
      a.dat >= (select min(dat)-400 FROM dbp_etl.zeitraum_fww_kmo_gld)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
UNION ALL
SELECT x.mandant_id,
       x.art_id,
       x.bewart_id,
       x.bewart_det_id,
       x.wup_id,
       x.nb_id,
       x.dat,
       x.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       SUM(x.abschriftbetrag_netto) AS werbe_abschrift_netto
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             1002 AS bewart_id,
             100210 AS bewart_det_id,
             a.dat,
             a.wrg_id,
             SUM(a.abschriftbetrag_netto) AS abschriftbetrag_netto
      FROM dbp_data.marktabschriften_kmo_aktion a
      JOIN dbp_data.art_wg_zu_per b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           b.arthiertyp_id = 2 AND
           b.dat_bis = '9999-12-31'
      WHERE CASE WHEN a.dat < '2020-03-01' THEN a.mandant_id > 1
            ELSE CASE WHEN a.dat >= '2020-03-01' AND a.dat < '2020-10-01' THEN a.mandant_id IN (3,5,6,8)
            ELSE CASE WHEN a.dat >= '2020-10-01' AND a.dat < '2021-01-01' THEN a.mandant_id IN (3,5,8)
            ELSE CASE WHEN a.dat >= '2021-01-01' AND a.dat < '2021-09-01' THEN a.mandant_id IN (3,8)
            ELSE CASE WHEN a.dat >= '2021-09-01' AND a.dat < '2022-04-01' THEN a.mandant_id IN (3)
            ELSE 1<>1 END END END END END AND
            a.aktion_relevant_fg = 1 AND
           (b.mandant_id, b.wg_id) NOT IN (SELECT mandant_id, wg_id FROM dbp_data.wg_filter_zu WHERE arthiertyp_id = 2 AND wg_filter_id = 2) and
            a.dat >= (select min(dat)-400 FROM dbp_etl.zeitraum_fww_kmo_gld)
      GROUP BY 1,2,3,4,5,6,7,8
      UNION ALL
      SELECT a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             1002 AS bewart_id,
             100210 AS bewart_det_id,
             a.dat_umbew AS dat,
             a.wrg_id,
             SUM((-1)*a.diff_wert_bestand_netto) AS abschriftbetrag_netto
      FROM dbp_data.art_umbewertung a
      JOIN dbp_data.art_wg_zu_per b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           b.arthiertyp_id = 2 AND
           b.dat_bis = '9999-12-31'
      WHERE CASE WHEN a.dat_umbew < '2020-03-01' THEN a.mandant_id > 1
            ELSE CASE WHEN a.dat_umbew >= '2020-03-01' AND a.dat_umbew < '2020-10-01' THEN a.mandant_id IN (3,5,6,8)
            ELSE CASE WHEN a.dat_umbew >= '2020-10-01' AND a.dat_umbew < '2021-01-01' THEN a.mandant_id IN (3,5,8)
            ELSE CASE WHEN a.dat_umbew >= '2021-01-01' AND a.dat_umbew < '2021-09-01' THEN a.mandant_id IN (3,8)
            ELSE CASE WHEN a.dat_umbew >= '2021-09-01' AND a.dat_umbew < '2022-04-01' THEN a.mandant_id IN (3) 
            ELSE 1<>1 END END END END END AND
            a.preis_aend_grund_id = 6 AND
           (b.mandant_id, b.wg_id) NOT IN (SELECT mandant_id, wg_id FROM dbp_data.wg_filter_zu WHERE arthiertyp_id = 2 AND wg_filter_id = 2) and
            a.dat_umbew >= (select min(dat)-400 FROM dbp_etl.zeitraum_fww_kmo_gld)
      GROUP BY 1,2,3,4,5,6,7,8
      UNION ALL
      SELECT a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             1002 AS bewart_id,
             100210 AS bewart_det_id,
             a.dat,
             a.wrg,
             SUM((-1)*(a.PV_AKTION+a.PV_BBY+a.PV_KDN_BBY+a.PV_KDP_BBY+a.PV_AKTION_BBY+a.PV_AKTION_KDN_BBY+a.PV_AKTION_KDP_BBY+a.PV_BONRABATT_BBY)) AS abschriftbetrag_netto
      FROM dbp_data.artbew a
      WHERE CASE WHEN a.dat >= '2020-03-01' AND a.dat < '2020-10-01' THEN a.mandant_id IN (2,4,7)
            ELSE CASE WHEN a.dat >= '2020-10-01' AND a.dat < '2021-01-01' THEN a.mandant_id IN (2,4,6,7)
            ELSE CASE WHEN a.dat >= '2021-01-01' AND a.dat < '2021-09-01' THEN a.mandant_id IN (2,4,5,6,7)
            ELSE CASE WHEN a.dat >= '2021-09-01' AND a.dat < '2022-04-01' THEN a.mandant_id IN (2,4,5,6,7,8) 
            ELSE a.mandant_id IN (2,3,4,5,6,7,8) END END END END and
            a.dat >= (select min(dat)-400 FROM dbp_etl.zeitraum_fww_kmo_gld)
      GROUP BY 1,2,3,4,5,6,7,8) x
JOIN dbp_etl_process.ekc_zek c
  ON x.mandant_id = c.mandant_id AND
     x.art_id = c.art_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

CREATE OR REPLACE TRANSIENT TABLE _wabs AS (
SELECT mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,dat
      ,wrg_id
      ,zek_id
      ,eigenmarke_fg
      ,wup_bereinigt_fg
      ,werbe_abschrift_netto
      ,CAST(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj
      ,CAST(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj_km
FROM _ekc_werbe_abschriften
WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_etl.zeitraum_fww_kmo_gld) AND (SELECT MAX(dat) FROM dbp_etl.zeitraum_fww_kmo_gld)
);

CREATE OR REPLACE TRANSIENT TABLE _wabs_vj AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+364 AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.werbe_abschrift_netto AS werbe_abschrift_netto_vj
FROM _ekc_werbe_abschriften a
WHERE dat BETWEEN (SELECT MIN(dat)-364 FROM dbp_etl.zeitraum_fww_kmo_gld) AND (SELECT MAX(dat)-364 FROM dbp_etl.zeitraum_fww_kmo_gld)
);

CREATE OR REPLACE TRANSIENT TABLE _wabs_vj_km AS (
SELECT x.mandant_id
      ,x.art_id
      ,x.bewart_id
      ,x.bewart_det_id
      ,x.wup_id
      ,x.nb_id
      ,x.dat
      ,x.wrg_id
      ,x.zek_id
      ,x.eigenmarke_fg
      ,x.wup_bereinigt_fg
      ,SUM(x.werbe_abschrift_netto) AS werbe_abschrift_netto_vj_km
FROM (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+x.days_back AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.werbe_abschrift_netto
FROM _ekc_werbe_abschriften a
JOIN dbp_etl.zeitraum_fww_kmo_gld x
  ON a.dat = x.dat-x.days_back
WHERE a.dat+x.days_back NOT IN (SELECT dat FROM dbp_etl.zeitraum_fww_kmo_gld WHERE sj = 1)
UNION ALL
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+x.days_back-1 AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.werbe_abschrift_netto
FROM _ekc_werbe_abschriften a
JOIN dbp_etl.zeitraum_fww_kmo_gld x
  ON a.dat = x.dat-x.days_back+1 AND
     x.sj = -1) x
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

MERGE INTO _wabs a USING (SELECT *
                          FROM _wabs_vj) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.bewart_det_id =  b.bewart_det_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET werbe_abschrift_netto_vj = b.werbe_abschrift_netto_vj

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              bewart_det_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              werbe_abschrift_netto,
                              werbe_abschrift_netto_vj,
                              werbe_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.bewart_det_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              b.werbe_abschrift_netto_vj,
                              0)
;

MERGE INTO _wabs a USING (SELECT *
                          FROM _wabs_vj_km) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.bewart_det_id = b.bewart_det_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET werbe_abschrift_netto_vj_km = b.werbe_abschrift_netto_vj_km

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              bewart_det_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              werbe_abschrift_netto,
                              werbe_abschrift_netto_vj,
                              werbe_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.bewart_det_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              0,
                              b.werbe_abschrift_netto_vj_km)
;

CREATE OR REPLACE TRANSIENT TABLE _pabs AS (
SELECT mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,dat
      ,wrg_id
      ,zek_id
      ,eigenmarke_fg
      ,wup_bereinigt_fg
      ,CASE
         WHEN mandant_id = 1 
         THEN (-1) * preis_abschrift_netto
         ELSE preis_abschrift_netto
       END AS preis_abschrift_netto
      ,CAST(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj
      ,CAST(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj_km
FROM _ekc_preis_abschriften
WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_etl.zeitraum_fww_kmo_gld) AND (SELECT MAX(dat) FROM dbp_etl.zeitraum_fww_kmo_gld)
);

CREATE OR REPLACE TRANSIENT TABLE _pabs_vj AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+364 AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,CASE
         WHEN a.mandant_id = 1 
         THEN (-1) * a.preis_abschrift_netto
         ELSE a.preis_abschrift_netto
       END AS preis_abschrift_netto_vj
FROM _ekc_preis_abschriften a
WHERE a.dat BETWEEN (SELECT MIN(dat)-364 FROM dbp_etl.zeitraum_fww_kmo_gld) AND (SELECT MAX(dat)-364 FROM dbp_etl.zeitraum_fww_kmo_gld)
);

CREATE OR REPLACE TRANSIENT TABLE _pabs_vj_km AS (
SELECT x.mandant_id
      ,x.art_id
      ,x.bewart_id
      ,x.bewart_det_id
      ,x.wup_id
      ,x.nb_id
      ,x.dat
      ,x.wrg_id
      ,x.zek_id
      ,x.eigenmarke_fg
      ,x.wup_bereinigt_fg
      ,SUM(x.preis_abschrift_netto_vj_km) AS preis_abschrift_netto_vj_km
FROM (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+x.days_back AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,CASE
         WHEN a.mandant_id = 1 
         THEN (-1) * a.preis_abschrift_netto
         ELSE a.preis_abschrift_netto
       END AS preis_abschrift_netto_vj_km
FROM _ekc_preis_abschriften a
JOIN dbp_etl.zeitraum_fww_kmo_gld x
  ON a.dat = x.dat-x.days_back
WHERE a.dat+x.days_back NOT IN (SELECT dat FROM dbp_etl.zeitraum_fww_kmo_gld WHERE sj = 1)
UNION ALL
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+x.days_back-1 AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,CASE
         WHEN a.mandant_id = 1 
         THEN (-1) * a.preis_abschrift_netto
         ELSE a.preis_abschrift_netto
       END AS preis_abschrift_netto_vj_km
FROM _ekc_preis_abschriften a
JOIN dbp_etl.zeitraum_fww_kmo_gld x
  ON a.dat = x.dat-x.days_back+1 AND
     x.sj = -1) x
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

MERGE INTO _pabs a USING (SELECT *
                          FROM _pabs_vj) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.bewart_det_id = b.bewart_det_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET preis_abschrift_netto_vj = b.preis_abschrift_netto_vj

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              bewart_det_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              preis_abschrift_netto,
                              preis_abschrift_netto_vj,
                              preis_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.bewart_det_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              b.preis_abschrift_netto_vj,
                              0)
;

MERGE INTO _pabs a USING (SELECT *
                          FROM _pabs_vj_km) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.bewart_det_id = b.bewart_det_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET preis_abschrift_netto_vj_km = b.preis_abschrift_netto_vj_km

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              bewart_det_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              preis_abschrift_netto,
                              preis_abschrift_netto_vj,
                              preis_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.bewart_det_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              0,
                              b.preis_abschrift_netto_vj_km)
;

INSERT INTO DBP_ETL.tag_wa_kalk_final_abs (mandant_id
                                          ,art_id
                                          ,bewart_id
                                          ,bewart_det_id
                                          ,wup_id
                                          ,nb_id
                                          ,dat
                                          ,wrg_id
                                          ,wup_bereinigt_fg
                                          ,zek_id
                                          ,eigenmarke_fg
                                          ,umsatz_netto
                                          ,umsatz_netto_vj
                                          ,umsatz_netto_vj_km
                                          ,logkostenzuschlag
                                          ,logkostenzuschlag_vj
                                          ,logkostenzuschlag_vj_km
                                          ,betrag_kmep_km
                                          ,betrag_kmep_km_vj
                                          ,betrag_kmep_kw
                                          ,betrag_kmep_kw_vj
                                          ,betrag_kmep_ww
                                          ,betrag_kmep_ww_vj
                                          ,werbe_abschrift_netto
                                          ,werbe_abschrift_netto_vj
                                          ,werbe_abschrift_netto_vj_km
                                          ,preis_abschrift_netto
                                          ,preis_abschrift_netto_vj
                                          ,preis_abschrift_netto_vj_km
                                          ,umrechnungskurs_hist)
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,0 AS umsatz_netto
      ,0 AS umsatz_netto_vj
      ,0 AS umsatz_netto_vj_km
      ,0 AS logkostenzuschlag
      ,0 AS logkostenzuschlag_vj
      ,0 AS logkostenzuschlag_vj_km
      ,0 AS betrag_kmep_km
      ,0 AS betrag_kmep_km_vj
      ,0 AS betrag_kmep_kw
      ,0 AS betrag_kmep_kw_vj
      ,0 AS betrag_kmep_ww
      ,0 AS betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.werbe_abschrift_netto_vj_km
      ,0 AS preis_abschrift_netto
      ,0 AS preis_abschrift_netto_vj
      ,0 AS preis_abschrift_netto_vj_km
      ,1 as umrechnungskurs_hist
FROM _wabs a
;

INSERT INTO DBP_ETL.tag_wa_kalk_final_abs (mandant_id
                                          ,art_id
                                          ,bewart_id
                                          ,bewart_det_id
                                          ,wup_id
                                          ,nb_id
                                          ,dat
                                          ,wrg_id
                                          ,wup_bereinigt_fg
                                          ,zek_id
                                          ,eigenmarke_fg
                                          ,umsatz_netto
                                          ,umsatz_netto_vj
                                          ,umsatz_netto_vj_km
                                          ,logkostenzuschlag
                                          ,logkostenzuschlag_vj
                                          ,logkostenzuschlag_vj_km
                                          ,betrag_kmep_km
                                          ,betrag_kmep_km_vj
                                          ,betrag_kmep_kw
                                          ,betrag_kmep_kw_vj
                                          ,betrag_kmep_ww
                                          ,betrag_kmep_ww_vj
                                          ,werbe_abschrift_netto
                                          ,werbe_abschrift_netto_vj
                                          ,werbe_abschrift_netto_vj_km
                                          ,preis_abschrift_netto
                                          ,preis_abschrift_netto_vj
                                          ,preis_abschrift_netto_vj_km
                                          ,umrechnungskurs_hist)
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,0 AS umsatz_netto
      ,0 AS umsatz_netto_vj
      ,0 AS umsatz_netto_vj_km
      ,0 AS logkostenzuschlag
      ,0 AS logkostenzuschlag_vj
      ,0 AS logkostenzuschlag_vj_km
      ,0 AS betrag_kmep_km
      ,0 AS betrag_kmep_km_vj
      ,0 AS betrag_kmep_kw
      ,0 AS betrag_kmep_kw_vj
      ,0 AS betrag_kmep_ww
      ,0 AS betrag_kmep_ww_vj
      ,0 AS werbe_abschrift_netto
      ,0 AS werbe_abschrift_netto_vj
      ,0 AS werbe_abschrift_netto_vj_km
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.preis_abschrift_netto_vj_km
      ,1 as umrechnungskurs_hist
FROM _pabs a
;

INSERT INTO DBP_ETL.tag_wa_kalk_final_abs (mandant_id
                                          ,art_id
                                          ,bewart_id
                                          ,bewart_det_id
                                          ,wup_id
                                          ,nb_id
                                          ,dat
                                          ,wrg_id
                                          ,wup_bereinigt_fg
                                          ,zek_id
                                          ,eigenmarke_fg
                                          ,umsatz_netto
                                          ,umsatz_netto_vj
                                          ,umsatz_netto_vj_km
                                          ,logkostenzuschlag
                                          ,logkostenzuschlag_vj
                                          ,logkostenzuschlag_vj_km
                                          ,betrag_kmep_km
                                          ,betrag_kmep_km_vj
                                          ,betrag_kmep_kw
                                          ,betrag_kmep_kw_vj
                                          ,betrag_kmep_ww
                                          ,betrag_kmep_ww_vj
                                          ,werbe_abschrift_netto
                                          ,werbe_abschrift_netto_vj
                                          ,werbe_abschrift_netto_vj_km
                                          ,preis_abschrift_netto
                                          ,preis_abschrift_netto_vj
                                          ,preis_abschrift_netto_vj_km
                                          ,umrechnungskurs_hist)
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,1 AS wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.umsatz_netto_vj_km
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.logkostenzuschlag_vj_km
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.werbe_abschrift_netto_vj_km
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.preis_abschrift_netto_vj_km
      ,a.umrechnungskurs_hist
FROM DBP_ETL.tag_wa_kalk_final_abs a
JOIN DBP_DATA.tag x1
  ON a.dat = x1.dat
JOIN DBP_DATA.wup x2
  ON a.mandant_id = x2.mandant_id AND 
     a.nb_id = x2.nb_id AND 
     a.wup_id = x2.wup_id
WHERE x1.wo_dat_von >= ADD_MONTHS(x2.dat_von,12) AND
      x1.wo_dat_bis <= x2.dat_bis
;

INSERT INTO DBP_ETL.tag_wa_kalk_final_abs (mandant_id
                                          ,art_id
                                          ,bewart_id
                                          ,bewart_det_id
                                          ,wup_id
                                          ,nb_id
                                          ,dat
                                          ,wrg_id
                                          ,wup_bereinigt_fg
                                          ,zek_id
                                          ,eigenmarke_fg
                                          ,umsatz_netto
                                          ,umsatz_netto_vj
                                          ,umsatz_netto_vj_km
                                          ,logkostenzuschlag
                                          ,logkostenzuschlag_vj
                                          ,logkostenzuschlag_vj_km
                                          ,betrag_kmep_km
                                          ,betrag_kmep_km_vj
                                          ,betrag_kmep_kw
                                          ,betrag_kmep_kw_vj
                                          ,betrag_kmep_ww
                                          ,betrag_kmep_ww_vj
                                          ,werbe_abschrift_netto
                                          ,werbe_abschrift_netto_vj
                                          ,werbe_abschrift_netto_vj_km
                                          ,preis_abschrift_netto
                                          ,preis_abschrift_netto_vj
                                          ,preis_abschrift_netto_vj_km
                                          ,umrechnungskurs_hist)
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,'EUR' AS wrg_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.umsatz_netto*d1.umrechnungskurs
      ,a.umsatz_netto_vj*d1.umrechnungskurs
      ,a.umsatz_netto_vj_km*d1.umrechnungskurs
      ,a.logkostenzuschlag*d1.umrechnungskurs
      ,a.logkostenzuschlag_vj*d1.umrechnungskurs
      ,a.logkostenzuschlag_vj_km*d1.umrechnungskurs
      ,a.betrag_kmep_km*d1.umrechnungskurs
      ,a.betrag_kmep_km_vj*d1.umrechnungskurs
      ,a.betrag_kmep_kw*d1.umrechnungskurs
      ,a.betrag_kmep_kw_vj*d1.umrechnungskurs
      ,a.betrag_kmep_ww*d1.umrechnungskurs
      ,a.betrag_kmep_ww_vj*d1.umrechnungskurs
      ,a.werbe_abschrift_netto*d1.umrechnungskurs
      ,a.werbe_abschrift_netto_vj*d1.umrechnungskurs
      ,a.werbe_abschrift_netto_vj_km*d1.umrechnungskurs
      ,a.preis_abschrift_netto*d1.umrechnungskurs
      ,a.preis_abschrift_netto_vj*d1.umrechnungskurs
      ,a.preis_abschrift_netto_vj_km*d1.umrechnungskurs
      ,a.umrechnungskurs_hist
FROM DBP_ETL.tag_wa_kalk_final_abs a
JOIN DBP_DATA.kurs d1
  ON a.wrg_id = d1.von_wrg_id AND
     d1.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
     d1.nach_wrg_id = 'EUR' AND
     d1.kurstyp_id = 3
WHERE a.mandant_id IN (2,3,4,7)
;

update dbp_etl.tag_wa_kalk_final_abs from (
select d.mandant_id,
       a.dat,
       'EUR' as wrg_id,
       b.umrechnungskurs/c.umrechnungskurs as umrechnungskurs_hist
from dbp_data.tag a
join dbp_data.mandant d
  on 1 = 1
join dbp_data.kurs b
  on d.default_wrg = b.von_wrg_id and
     a.dat between b.dat_von and b.dat_bis and
     b.nach_wrg_id = 'EUR' and
     b.kurstyp_id = 3
join dbp_data.kurs c
  on d.default_wrg = c.von_wrg_id and
     c.dat_bis = '9999-12-31' and
     c.nach_wrg_id = 'EUR' and
     c.kurstyp_id = 3
where d.mandant_id in (2,3,4,7) and
      a.akt_mo between -13 and 0
group by 1,2,3,4
) b

set umrechnungskurs_hist = b.umrechnungskurs_hist

where dbp_etl.tag_wa_kalk_final_abs.mandant_id = b.mandant_id and
      dbp_etl.tag_wa_kalk_final_abs.dat = b.dat and
      dbp_etl.tag_wa_kalk_final_abs.wrg_id = b.wrg_id
;

DELETE FROM DBP_DATA.artbew_dat_ek_cp_sum
WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_etl.zeitraum_fww_kmo_gld) AND (SELECT MAX(dat) FROM dbp_etl.zeitraum_fww_kmo_gld) AND
      transaktion_typ_id = 1
;

insert into dbp_data.artbew_dat_ek_cp_sum (mandant_id
                                          ,art_id
                                          ,bewart_id
                                          ,bewart_det_id
                                          ,wup_id
                                          ,nb_id
                                          ,dat
                                          ,wrg_id
                                          ,zek_id
                                          ,eigenmarke_fg
                                          ,wup_bereinigt_fg
                                          ,transaktion_typ_id
                                          ,umsatz_netto
                                          ,umsatz_netto_vj
                                          ,logkostenzuschlag
                                          ,logkostenzuschlag_vj
                                          ,betrag_kmep_kw
                                          ,betrag_kmep_kw_vj
                                          ,betrag_kmep_ww
                                          ,betrag_kmep_ww_vj
                                          ,werbe_abschrift_netto
                                          ,werbe_abschrift_netto_vj
                                          ,preis_abschrift_netto
                                          ,preis_abschrift_netto_vj
                                          ,umrechnungskurs_hist
                                          ,gp_id)
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,1 as transaktion_typ_id
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.umrechnungskurs_hist
      ,coalesce(b.gp_id,-1) as gp_id
from dbp_etl.tag_wa_kalk_final_abs a
left join dbp_etl.art_gp_nm_zu_per_fww b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
where (a.preis_abschrift_netto <> 0 or
       a.preis_abschrift_netto_vj <> 0 or
       a.werbe_abschrift_netto <> 0 or
       a.werbe_abschrift_netto_vj <> 0)
;

DELETE FROM DBP_DATA.artbew_mo_ek_cp_sum
WHERE kjmo BETWEEN (SELECT MIN(kjmo) FROM dbp_etl.zeitraum_fww_kmo_gld) AND (SELECT MAX(kjmo) FROM dbp_etl.zeitraum_fww_kmo_gld) AND
     (preis_abschrift_netto <> 0 OR
      preis_abschrift_netto_vj <> 0 OR
      werbe_abschrift_netto <> 0 OR
      werbe_abschrift_netto_vj <> 0)
;

insert into dbp_data.artbew_mo_ek_cp_sum (mandant_id
                                         ,art_id
                                         ,bewart_id
                                         ,bewart_det_id
                                         ,wup_id
                                         ,nb_id
                                         ,kjmo
                                         ,wrg_id
                                         ,posten_id
                                         ,wup_bereinigt_fg
                                         ,zek_id
                                         ,eigenmarke_fg
                                         ,gp_id
                                         ,umsatz_netto
                                         ,umsatz_netto_vj
                                         ,betrag_kmep
                                         ,betrag_kmep_vj
                                         ,logkostenzuschlag
                                         ,logkostenzuschlag_vj
                                         ,werbe_abschrift_netto
                                         ,werbe_abschrift_netto_vj
                                         ,preis_abschrift_netto
                                         ,preis_abschrift_netto_vj
                                         ,umrechnungskurs_hist)
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,to_number(substring(to_varchar(a.dat, 'yyyymmdd'),1,6)) as kjmo
      ,a.wrg_id
      ,b.posten_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,coalesce(c.gp_id,-1)
      ,sum(a.umsatz_netto)
      ,sum(a.umsatz_netto_vj)
      ,sum(a.betrag_kmep_km)
      ,sum(a.betrag_kmep_km_vj)
      ,sum(a.logkostenzuschlag)
      ,sum(a.logkostenzuschlag_vj)
      ,sum(a.werbe_abschrift_netto)
      ,sum(a.werbe_abschrift_netto_vj_km)
      ,sum(a.preis_abschrift_netto)
      ,sum(a.preis_abschrift_netto_vj_km)
      ,max(a.umrechnungskurs_hist)
from dbp_etl.tag_wa_kalk_final_abs a
join dbp_data.monat x
  on to_number(substring(to_varchar(a.dat, 'yyyymmdd'),1,6)) = x.kjmo
join dbp_data.art_per b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat between b.dat_von and b.dat_bis
left join dbp_etl.art_gp_nm_zu_per_fww c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat = c.dat
where (preis_abschrift_netto <> 0 or
       preis_abschrift_netto_vj_km <> 0 or
       werbe_abschrift_netto <> 0 or
       werbe_abschrift_netto_vj_km <> 0)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
;
