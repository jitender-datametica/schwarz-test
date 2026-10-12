delete from dbp_etl.de_zekp_1
where datab > current_date
;

UPDATE DBP_ETL.de_zekp_1 SET werks = -1
WHERE werks = 0
;

UPDATE DBP_ETL.de_zekp_1 SET zollba = 99999.9999
WHERE zollba/100 > 99999.9999
;

UPDATE DBP_ETL.de_zekp_1 SET zollba = -9999.9999
WHERE zollba/100 < -9999.9999
;

CREATE OR REPLACE VOLATILE TABLE _dup_check AS (
SELECT matnr   
      ,lifnr   
      ,werks   
      ,datab   
      ,MAX(abrut) AS abrut
      ,MAX(abrna) AS abrna
      ,MAX(abonba) AS abonba
      ,MAX(aknet) AS aknet
      ,MAX(aknb) AS aknb
      ,MAX(aknbs) AS aknbs
      ,MAX(aknne) AS aknne
      ,MAX(ekkba) AS ekkba
      ,MAX(mepre) AS mepre
      ,MAX(lsein) AS lsein
      ,MAX(lokau) AS lokau
      ,MAX(bnk) AS bnk
      ,MAX(zollba) AS zollba
      ,MAX(konwa) AS konwa
      ,MAX(kompmeng) AS kompmeng
FROM DBP_ETL.de_zekp_1
WHERE (matnr, lifnr, werks, datab) IN (SELECT matnr
                                             ,lifnr
                                             ,werks
                                             ,datab
                                       FROM DBP_ETL.de_zekp_1
                                       GROUP BY 1,2,3,4
                                       HAVING COUNT(*) > 1)
GROUP BY 1,2,3,4
);

DELETE FROM DBP_ETL.de_zekp_1
WHERE (matnr,lifnr,werks,datab) IN (SELECT matnr,lifnr,werks,datab FROM _dup_check)
;

INSERT INTO DBP_ETL.de_zekp_1 (
                            matnr
                           ,lifnr
                           ,werks
                           ,datab
                           ,abrut
                           ,abrna
                           ,abonba
                           ,aknet
                           ,aknb
                           ,aknbs
                           ,aknne
                           ,ekkba
                           ,mepre
                           ,lsein
                           ,lokau
                           ,bnk
                           ,zollba
                           ,konwa
                           ,kompmeng)
SELECT matnr
      ,lifnr
      ,werks
      ,datab
      ,abrut
      ,abrna
      ,abonba
      ,aknet
      ,aknb
      ,aknbs
      ,aknne
      ,ekkba
      ,mepre
      ,lsein
      ,lokau
      ,bnk
      ,zollba
      ,konwa
      ,kompmeng
FROM _dup_check
;

-- 14.06.2024, -dba-
--
-- Abloesung des ZEKI9074 mit Direktversorgung aus der ZEKP. Dafuer brauchen wir die Umrechnung
-- der Displays auf den Stueckwert. Spaeter erfolgt das Update der EK-Werte.

update dbp_etl.de_zekp_1 from (select a.mandant_id
                                   ,a.kl_art_id
                                   ,sum(c.komponentenmenge) as komponentenmenge
                             from dbp_data.art_1 a
                             join (select mandant_id,
                                          art_id,
                                          max(stueckliste_id) as stueckliste_id
                                   from dbp_data.stueckliste_1
                                   where stueckliste_verwendung_id = 3 and
                                         dat_bis = '9999-12-31'
                                   group by 1,2) b
                               on a.mandant_id = b.mandant_id and
                                  a.art_id = b.art_id
                             join dbp_data.stueckliste_det_1 c
                               on b.mandant_id = c.mandant_id and
                                  b.stueckliste_id = c.stueckliste_id and
                                  c.stueckliste_typ_id = 'M' and
                                  c.komponentenmenge_einh_id = 'ST' and
                                  c.dat_bis = '9999-12-31'
                             where a.artikeltyp_id = 12 and
                                   a.display_id in (1,2)
                             group by 1,2) b
                             
set kompmeng = b.komponentenmenge

where dbp_etl.de_zekp.matnr = b.kl_art_id
;

CREATE OR REPLACE TABLE DBP_ETL.art_herst_tmp_1  (
   art_id               INTEGER NOT NULL
  ,herst_id             INTEGER
  ,mhd_zeitraum_dz      SMALLINT
  ,gp_art_id            VARCHAR(40) COLLATE 'en-ci' 
)
;

CREATE OR REPLACE TABLE DBP_ETL.art_muki_tmp_1  (
   art_id   INTEGER NOT NULL
  ,gp_id INTEGER
  ,mutter_ek_id INTEGER
);

CREATE OR REPLACE TABLE DBP_ETL.art_gp_zu_per_tmp_1  (
   art_id                       INTEGER NOT NULL
  ,mandant_id                   BYTEINT NOT NULL
  ,gp_id                        INTEGER NOT NULL
  ,dat_von                      DATE
  ,herst_id                     INTEGER
  ,einkaufsorganisation_id      SMALLINT NOT NULL
  ,gp_art_id                    VARCHAR(6) COLLATE 'en-ci'
  ,mhd_zeitraum_dz              SMALLINT
  ,dat_bis                      DATE
);

CREATE OR REPLACE TABLE DBP_ETL.art_gp_wup_zu_per_tmp_1  (
  mandant_id                BYTEINT NOT NULL,
  art_id                    INTEGER NOT NULL,
  gp_id                     INTEGER NOT NULL,
  wup_id                    INTEGER NOT NULL,
  nb_id                     SMALLINT,
  einkaufsorganisation_id   SMALLINT NOT NULL,
  dat_von                   DATE NOT NULL,
  dat_bis                   DATE,
  ek_brutto                 DECIMAL(18,4),
  ek_netto                  DECIMAL(18,4),
  ek_nettonetto             DECIMAL(18,4),
  ek_kal_basis              DECIMAL(18,4),
  ek_mep                    DECIMAL(18,4),
  einstandspreis            DECIMAL(18,4),
  logistikkostenzuschlag    DECIMAL(18,4),
  bezugsweg_id              BYTEINT,
  wrg_id                    CHAR(3) COLLATE 'en-cs',
  komponentenmenge          DECIMAL(18,4),
  ek_brutto_nrfb_rab        DECIMAL(18,4),
  bonusbasis                DECIMAL(18,4),
  bezugsnebenkosten         DECIMAL(18,4),
  zollwert                  DECIMAL(9,4),
  ek_netto_bnk              DECIMAL(18,4),
  ek_netto_bnk_sachk        DECIMAL(18,4),
  cycle_id                  INTEGER
);

INSERT INTO DBP_ETL.art_gp_wup_zu_per_tmp_1
(
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT 
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id_
  ,wup_id_
  ,nb_id_
  ,einkaufsorganisation_id_
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
FROM (SELECT zk.cycle_id
    ,a.mandant_id
    ,a.art_id
    ,lifnr AS gp_id_
    ,CASE WHEN werks IS NULL THEN -1 ELSE werks END AS wup_id_
    ,CASE WHEN werks IS NULL OR werks = -1 THEN NULL ELSE wp.nb_id END AS nb_id_
    ,COALESCE(gp.einkaufsorganisation_id,1000) AS einkaufsorganisation_id_
    ,CAST (datab AS DATE) AS  dat_von
    ,to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
    ,abrut/100 AS ek_brutto
    ,aknet/100 AS ek_netto
    ,aknne/100 AS ek_nettonetto
    ,ekkba/100 AS ek_kal_basis
    ,mepre/100 AS ek_mep
    ,lsein/100 AS einstandspreis
    ,COALESCE(CASE 
                WHEN wup_id_ = -1 OR 
                    (abrut = 0 AND aknet = 0 AND aknne = 0 AND ekkba= 0 AND mepre = 0 AND lsein = 0)
                THEN 0
                ELSE lokau/100
              END, 0) AS logistikkostenzuschlag
    ,CASE WHEN wup_id_ = -1
          THEN 1
          ELSE 4
     END AS bezugsweg_id  /* 1 fuer dezentral  4 fuer zentral */
    ,konwa AS wrg_id
    ,kompmeng AS komponentenmenge
    ,abrna/100 AS ek_brutto_nrfb_rab
    ,abonba/100 AS bonusbasis
    ,bnk/100 AS bezugsnebenkosten
    ,zollba/100 AS zollwert
    ,aknb/100 AS ek_netto_bnk
    ,aknbs/100 AS ek_netto_bnk_sachk
FROM (SELECT 2 AS cycle_id
            ,matnr
            ,lifnr
            ,werks
            ,datab
            ,abrut
            ,aknet
            ,aknne
            ,ekkba
            ,mepre
            ,lsein
            ,konwa
            ,CASE 
               WHEN (kompmeng IS NULL OR kompmeng = 0)
               THEN 1
               ELSE kompmeng
             END AS kompmeng
            ,lokau
            ,abrna  
            ,abonba
            ,bnk
            ,zollba
            ,aknb  
            ,aknbs 
      FROM DBP_ETL.de_zekp_1
      QUALIFY ROW_NUMBER() OVER (PARTITION BY matnr,lifnr,werks,datab ORDER BY 1) = 1) zk
JOIN (SELECT kl_art_id
            ,art_id
            ,mandant_id
      FROM DBP_DATA.art_1
      WHERE mandant_id = 1
      QUALIFY ROW_NUMBER() OVER (PARTITION BY kl_art_id ORDER BY art_id DESC) = 1) a
  ON zk.matnr = a.kl_art_id AND 
     a.mandant_id = 1
JOIN (SELECT gp_id
            ,einkaufsorganisation_id
            ,mandant_id
      FROM DBP_DATA.gp_1
      QUALIFY ROW_NUMBER() OVER (PARTITION BY gp_id ORDER BY einkaufsorganisation_id ASC) = 1) gp_1
  ON zk.lifnr = gp.gp_id AND 
     gp.mandant_id = 1
LEFT JOIN (SELECT wup_id
                 ,mandant_id
                 ,nb_id
           FROM DBP_DATA.wup_1) wp
  ON zk.werks = wp.wup_id AND 
     wp.mandant_id = 1) a
;

-- 14.06.2024, -dba-
--
-- Abloesung des ZEKI9074 mit Direktversorgung aus der ZEKP. Dafuer brauchen wir die Umrechnung
-- der Displays auf den Stueckwert. Hier erfolgt nun das Update der EK-Werte.

update dbp_etl.art_gp_wup_zu_per_tmp_1

set ek_brutto              = ek_brutto/komponentenmenge
   ,ek_netto               = ek_netto/komponentenmenge
   ,ek_nettonetto          = ek_nettonetto/komponentenmenge
   ,ek_kal_basis           = ek_kal_basis/komponentenmenge
   ,ek_mep                 = ek_mep/komponentenmenge
   ,einstandspreis         = einstandspreis/komponentenmenge
   ,logistikkostenzuschlag = logistikkostenzuschlag/komponentenmenge
   ,ek_brutto_nrfb_rab     = ek_brutto_nrfb_rab/komponentenmenge
   ,bonusbasis             = bonusbasis/komponentenmenge
   ,bezugsnebenkosten      = bezugsnebenkosten/komponentenmenge
   ,zollwert               = zollwert/komponentenmenge
   ,ek_netto_bnk           = ek_netto_bnk/komponentenmenge
   ,ek_netto_bnk_sachk     = ek_netto_bnk_sachk/komponentenmenge
where komponentenmenge > 1
;

DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_1
WHERE ek_brutto = 0
;

UPDATE dbp_etl.art_gp_wup_zu_per_tmp_1
SET   dat_bis = dt1.dat_bis

FROM
(
SELECT
     l.mandant_id
    ,l.wup_id
    ,l.nb_id
    ,l.art_id
    ,l.dat_von
    ,l.gp_id
    ,l.bezugsweg_id
    ,l.einkaufsorganisation_id
    ,CASE
       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD'))) = 0 
       THEN to_date('9999-12-31','YYYY-MM_1-DD')
       ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
     END AS dat_bis
  FROM dbp_etl.art_gp_wup_zu_per_tmp_1 l
  WHERE mandant_id = 1
  GROUP BY 1,2,3,4,5,6,7,8
) dt1
WHERE dbp_etl.art_gp_wup_zu_per_tmp.mandant_id  = dt1.mandant_id
  AND dbp_etl.art_gp_wup_zu_per_tmp.wup_id  = dt1.wup_id
  AND COALESCE(dbp_etl.art_gp_wup_zu_per_tmp.nb_id, -999) = COALESCE(dt1.nb_id, -999)
  AND dbp_etl.art_gp_wup_zu_per_tmp.art_id  = dt1.art_id
  AND dbp_etl.art_gp_wup_zu_per_tmp.dat_von = dt1.dat_von
  AND dbp_etl.art_gp_wup_zu_per_tmp.gp_id = dt1.gp_id
  AND dbp_etl.art_gp_wup_zu_per_tmp.einkaufsorganisation_id = dt1.einkaufsorganisation_id
  AND dbp_etl.art_gp_wup_zu_per_tmp.bezugsweg_id = dt1.bezugsweg_id
  AND dbp_etl.art_gp_wup_zu_per_tmp.dat_bis <> dt1.dat_bis
;

DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_1
WHERE dat_bis < '2021-09-25'
;

UPDATE dbp_etl.art_gp_wup_zu_per_tmp_1 FROM (SELECT mandant_id,
                                                  wup_id,
                                                  art_id,
                                                  gp_id,
                                                  Min(dat_von) AS dat_von
                                           FROM dbp_etl.art_gp_wup_zu_per_tmp_1
                                           WHERE '2021-09-25' BETWEEN dat_von AND dat_bis
                                           GROUP BY 1,2,3,4) b

SET dat_von = '2021-09-25'

WHERE dbp_etl.art_gp_wup_zu_per_tmp.mandant_id = b.mandant_id AND
      dbp_etl.art_gp_wup_zu_per_tmp.wup_id = b.wup_id AND
      dbp_etl.art_gp_wup_zu_per_tmp.art_id = b.art_id AND
      dbp_etl.art_gp_wup_zu_per_tmp.gp_id = b.gp_id AND
      dbp_etl.art_gp_wup_zu_per_tmp.dat_von = b.dat_von
;

DELETE FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE (mandant_id, art_id, gp_id, wup_id, einkaufsorganisation_id, dat_von, COALESCE(nb_id,-999), bezugsweg_id) IN
(
  SELECT
     agp.mandant_id
    ,agp.art_id
    ,agp.gp_id
    ,agp.wup_id
    ,agp.einkaufsorganisation_id
    ,agp.dat_von
    ,COALESCE(agp.nb_id,-999)
    ,agp.bezugsweg_id
  FROM DBP_DATA.art_gp_wup_zu_per_1 agp

  INNER JOIN DBP_ETL.art_gp_wup_zu_per_tmp_1 ag
  ON agp.mandant_id = ag.mandant_id AND agp.art_id = ag.art_id AND agp.gp_id = ag.gp_id AND agp.wup_id = ag.wup_id
    AND agp.einkaufsorganisation_id = ag.einkaufsorganisation_id AND COALESCE(agp.nb_id,-999) = COALESCE(ag.nb_id,-999)
    AND agp.bezugsweg_id = ag.bezugsweg_id AND  agp.dat_von >= ag.dat_von

  AND agp.mandant_id = 1
  GROUP BY 1,2,3,4,5,6,7,8
)
AND mandant_id = 1
;

INSERT INTO DBP_DATA.art_gp_wup_zu_per_1
(
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,td_insert
  ,td_update
)
SELECT
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep as ek_mep_vor_fwu
  ,CURRENT_TIMESTAMP
  ,CURRENT_TIMESTAMP
FROM DBP_ETL.art_gp_wup_zu_per_tmp_1
;

UPDATE dbp_data.art_gp_wup_zu_per_1
SET   dat_bis = dt1.dat_bis
     ,td_update = CURRENT_TIMESTAMP

FROM
(
SELECT
     l.mandant_id
    ,l.wup_id
    ,l.nb_id
    ,l.art_id
    ,l.dat_von
    ,l.gp_id
    ,l.bezugsweg_id
    ,l.einkaufsorganisation_id
    ,CASE
       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD'))) = 0 
       THEN to_date('9999-12-31','YYYY-MM_1-DD')
       ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
     END AS dat_bis
  FROM dbp_data.art_gp_wup_zu_per_1 l
  WHERE mandant_id = 1
  GROUP BY 1,2,3,4,5,6,7,8
) dt1
WHERE dbp_data.art_gp_wup_zu_per.mandant_id  = dt1.mandant_id
  AND dbp_data.art_gp_wup_zu_per.wup_id  = dt1.wup_id
  AND COALESCE(dbp_data.art_gp_wup_zu_per.nb_id, -999) = COALESCE(dt1.nb_id, -999)
  AND dbp_data.art_gp_wup_zu_per.art_id  = dt1.art_id
  AND dbp_data.art_gp_wup_zu_per.dat_von = dt1.dat_von
  AND dbp_data.art_gp_wup_zu_per.gp_id = dt1.gp_id
  AND dbp_data.art_gp_wup_zu_per.einkaufsorganisation_id = dt1.einkaufsorganisation_id
  AND dbp_data.art_gp_wup_zu_per.bezugsweg_id = dt1.bezugsweg_id
  AND dbp_data.art_gp_wup_zu_per.dat_bis <> dt1.dat_bis
;

INSERT INTO DBP_ETL.art_herst_tmp_1
(
   art_id
  ,herst_id
  ,gp_art_id
  ,mhd_zeitraum_dz
)
SELECT
   art_id
  ,CASE
     WHEN (herst_id=0)
     THEN '-2'
     ELSE herst_id
   END AS _herst_id
  ,gp_art_id
  ,mhd_zeitraum_dz
FROM DBP_DATA.art_gp_zu_per_1
WHERE mandant_id = 1
  AND (herst_id IS NOT NULL OR gp_art_id IS NOT NULL OR mhd_zeitraum_dz IS NOT NULL)
  -- nur die aktuellen Saetze
  AND dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id ORDER BY art_id) = 1
;

INSERT INTO DBP_ETL.art_muki_tmp_1
(
   art_id
  ,gp_id
  ,mutter_ek_id
)
SELECT
   art_id
  ,gp_id
  ,mutter_ek_id
FROM DBP_DATA.art_gp_zu_per_1
WHERE mandant_id = 1
  AND mutter_ek_id IS NOT NULL
  -- nur die aktuellen Saetze
  AND dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
;

DELETE FROM DBP_DATA.art_gp_zu_per_1
WHERE dat_von >= '2012-01-01'
  AND mandant_id = 1
;

UPDATE DBP_DATA.art_gp_zu_per_1
SET   dat_bis = dt1.dat_bis
     ,td_update = CURRENT_TIMESTAMP
FROM
(
SELECT
     mandant_id
    ,art_id
    ,dat_von
    ,CASE
       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, art_id ORDER BY dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD'))) = 0 
       THEN to_date('9999-12-31','YYYY-MM_1-DD')
       ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,art_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
     END AS dat_bis
  FROM DBP_DATA.art_gp_zu_per_1
  WHERE mandant_id = 1
  GROUP BY 1,2,3
) dt1
WHERE DBP_DATA.art_gp_zu_per.mandant_id  = dt1.mandant_id
  AND DBP_DATA.art_gp_zu_per.art_id  = dt1.art_id
  AND DBP_DATA.art_gp_zu_per.dat_von = dt1.dat_von
  AND DBP_DATA.art_gp_zu_per.dat_bis <> dt1.dat_bis
;

INSERT INTO DBP_ETL.art_gp_zu_per_tmp_1
(
   art_id
  ,mandant_id
  ,gp_id
  ,dat_von
  ,herst_id
  ,einkaufsorganisation_id
  ,gp_art_id
  ,mhd_zeitraum_dz
  ,dat_bis
)
SELECT
   art_id
  ,mandant_id
  ,gp_id
  ,_dat_von
  ,herst_id
  ,einkaufsorganisation_id
  ,gp_art_id
  ,mhd_zeitraum_dz
  ,to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
FROM
(
  SELECT
     mandant_id
    ,art_id
    ,gp_id
    -- wenn der Datensatz ein dat_von < 1.1.2004 hat, dat_bis aber >= 1.1.2004 ist,
    -- wird dat_von auf 1.1.2004 gesetzt.
    ,CASE WHEN '2012-01-01' BETWEEN dat_von AND dat_bis THEN '2012-01-01' ELSE dat_von END AS _dat_von
    ,'-2' AS herst_id   -- Defaultwert -2
    ,einkaufsorganisation_id
    ,dat_bis
    ,'-1' AS gp_art_id  -- Defaultwert -1 
    ,'-1' AS mhd_zeitraum_dz -- Defaultwert -1
  FROM DBP_DATA.art_gp_wup_zu_per_1

  WHERE (_dat_von >= '2012-01-01' OR '2012-01-01' BETWEEN _dat_von AND dat_bis)
  -- nur die Datensaetze die in den Zeitraum nach 2003 fallen, werden beruecksichtigt,
  -- dabei darf es pro Artikel_1 und dat_von nur einen geben, dies ist der Satz mit
  -- dem hoeheren ek_brutto.
  AND mandant_id = 1
  QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, _dat_von ORDER BY dat_von DESC, ek_brutto DESC, gp_id) = 1
) dt1
-- Erklaerung: es muessen alle Lieferantenwechsel ermittelt werden. Wenn sich aber nur der
-- EK aendert, so ist das fuer diese Verarbeitung irrelevant.
-- QUALIFY MSUM(...)
QUALIFY SUM(gp_id) OVER (PARTITION BY art_id,mandant_id ORDER BY _dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW  )-2*gp_id <> 0
;

DELETE FROM DBP_ETL.art_gp_zu_per_tmp_1
WHERE (mandant_id, art_id, gp_id) IN
(
  SELECT
     mandant_id
    ,art_id
    ,gp_id
  FROM DBP_DATA.art_gp_zu_per_1
  WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
    AND mandant_id = 1
)
AND (mandant_id, art_id, dat_von) IN
-- es wird nur der aelteste Stand der Zwischentablle DBP_ETL.art_gp_zu_per_tmp_1 
-- beruecksichtigt
(
  SELECT
     mandant_id
    ,art_id
    ,MIN(dat_von)
  FROM DBP_ETL.art_gp_zu_per_tmp_1
  GROUP BY mandant_id, art_id
);

INSERT INTO DBP_DATA.art_gp_zu_per_1
(
   art_id
  ,mandant_id
  ,gp_id
  ,dat_von
  ,herst_id
  ,einkaufsorganisation_id
  ,gp_art_id
  ,mhd_zeitraum_dz
  ,dat_bis
  ,td_insert
  ,td_update
)
SELECT
   art_id
  ,mandant_id
  ,gp_id
  ,dat_von
  ,herst_id
  ,einkaufsorganisation_id
  ,gp_art_id
  ,mhd_zeitraum_dz
  ,dat_bis
  ,CURRENT_TIMESTAMP
  ,CURRENT_TIMESTAMP
FROM DBP_ETL.art_gp_zu_per_tmp_1
;

UPDATE DBP_DATA.art_gp_zu_per_1
SET   dat_bis = dt1.dat_bis
     ,td_update = CURRENT_TIMESTAMP

FROM
(
SELECT
     mandant_id
    ,art_id
    ,dat_von
    ,CASE
       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,art_id ORDER BY dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD'))) = 0 
       THEN to_date('9999-12-31','YYYY-MM_1-DD')
       ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,art_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
     END AS dat_bis
  FROM DBP_DATA.art_gp_zu_per_1
  WHERE mandant_id = 1
  GROUP BY 1,2,3
) dt1
WHERE DBP_DATA.art_gp_zu_per.mandant_id  = dt1.mandant_id
  AND DBP_DATA.art_gp_zu_per.art_id  = dt1.art_id
  AND DBP_DATA.art_gp_zu_per.dat_von = dt1.dat_von
  AND DBP_DATA.art_gp_zu_per.dat_bis <> dt1.dat_bis
;

UPDATE DBP_DATA.art_gp_zu_per_1

SET
   herst_id = dt1._herst_id
  ,mhd_zeitraum_dz = _mhd_zeitraum_dz
  ,gp_art_id = _gp_art_id
  ,td_update = CURRENT_TIMESTAMP

FROM
(
  SELECT
     art_id _art_id
    ,herst_id _herst_id
    ,mhd_zeitraum_dz _mhd_zeitraum_dz
    ,gp_art_id _gp_art_id
  FROM DBP_ETL.art_herst_tmp_1
) dt1 WHERE art_id  = dt1._art_id
  AND mandant_id = 1
;

UPDATE DBP_DATA.art_gp_zu_per_1

SET   mutter_ek_id = dt1._mutter_ek_id
     ,td_update = CURRENT_TIMESTAMP
FROM
(
  SELECT
     art_id _art_id
    ,mutter_ek_id _mutter_ek_id
    ,gp_id _gp_id
  FROM DBP_ETL.art_muki_tmp_1
  GROUP BY 1,2,3
) dt1 WHERE art_id  = dt1._art_id
  AND gp_id=dt1._gp_id
  AND dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
  AND mandant_id = 1
;

