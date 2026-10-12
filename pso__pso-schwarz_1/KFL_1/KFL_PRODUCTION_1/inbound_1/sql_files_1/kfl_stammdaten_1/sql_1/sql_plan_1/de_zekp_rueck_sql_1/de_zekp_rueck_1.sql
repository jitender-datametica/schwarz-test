-- Sichern der ZEKP.

delete from dbp_etl_process.zekp_rueck_1;
insert into dbp_etl_process.zekp_rueck_1
select *
from dbp_data.art_gp_wup_zu_per_1
;

delete from dbp_etl.de_zekp_1
where datab > current_date
;

UPDATE dbp_etl.de_zekp_1 SET werks = -1
WHERE werks = 0
;

UPDATE dbp_etl.de_zekp_1 SET zollba = 99999.9999
WHERE ABS(zollba/100) > 99999.9999
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

CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_tmp_1 (
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
  wrg_id                    VARCHAR(3),
  komponentenmenge          DECIMAL(18,4),
  ek_brutto_nrfb_rab        DECIMAL(18,4),
  bonusbasis                DECIMAL(18,4),
  bezugsnebenkosten         DECIMAL(18,4),
  zollwert                  DECIMAL(9,4),
  ek_netto_bnk              DECIMAL(18,4),
  ek_netto_bnk_sachk        DECIMAL(18,4),
  cycle_id                  INTEGER
);

INSERT INTO dbp_etl.art_gp_wup_zu_per_tmp_1
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
    ,CAST (datab AS DATE ) AS  dat_von
    ,CAST('9999-12-31' AS DATE) AS dat_bis
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
FROM (SELECT 1 AS cycle_id
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
      FROM dbp_etl.de_zekp_1
      QUALIFY row_number() over (partition by matnr,lifnr,werks,datab order by 1) = 1) zk
JOIN (SELECT kl_art_id
            ,art_id
            ,mandant_id
      FROM dbp_data.art_1
      WHERE mandant_id = 1
      QUALIFY row_number() over (partition by kl_art_id order by art_id DESC) = 1) a
  ON zk.matnr = a.kl_art_id AND 
     a.mandant_id = 1
JOIN (SELECT gp_id
            ,einkaufsorganisation_id
            ,mandant_id
      FROM dbp_data.gp_1
      QUALIFY row_number() over (partition by gp_id order by einkaufsorganisation_id ASC) = 1) gp_1
  ON zk.lifnr = gp.gp_id AND 
     gp.mandant_id = 1
LEFT JOIN (SELECT wup_id
                 ,mandant_id
                 ,nb_id
           FROM dbp_data.wup_1) wp
  ON zk.werks = wp.wup_id AND 
     wp.mandant_id = 1) a
;

CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 LIKE dbp_etl.art_gp_wup_zu_per_tmp_1;

INSERT INTO dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
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
SELECT cycle_id
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
FROM dbp_etl.art_gp_wup_zu_per_tmp_1
;

-- 14.06.2024, -dba-
--
-- Abloesung des ZEKI9074 mit Direktversorgung aus der ZEKP. Dafuer brauchen wir die Umrechnung
-- der Displays auf den Stueckwert. Hier erfolgt nun das Update der EK-Werte.

update dbp_etl.art_gp_wup_zu_per_tmp_xxx_1

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

DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
WHERE ek_brutto = 0
;

UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx_1

SET dat_bis = dt1.dat_bis

FROM (SELECT l.mandant_id
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
      FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 l
      WHERE mandant_id = 1
      GROUP BY 1,2,3,4,5,6,7,8) dt1

WHERE dbp_etl.art_gp_wup_zu_per_tmp_xxx.mandant_id  = dt1.mandant_id
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.wup_id  = dt1.wup_id
  AND COALESCE(dbp_etl.art_gp_wup_zu_per_tmp_xxx.nb_id, -999) = COALESCE(dt1.nb_id, -999)
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.art_id  = dt1.art_id
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.dat_von = dt1.dat_von
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.gp_id = dt1.gp_id
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.einkaufsorganisation_id = dt1.einkaufsorganisation_id
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.bezugsweg_id = dt1.bezugsweg_id
  AND dbp_etl.art_gp_wup_zu_per_tmp_xxx.dat_bis <> dt1.dat_bis
;

DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
WHERE dat_bis < '2021-09-25'
;

UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 FROM (SELECT mandant_id,
                                                      wup_id,
                                                      art_id,
                                                      gp_id,
                                                      MIN(dat_von) AS dat_von
                                               FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
                                               WHERE '2021-09-25' BETWEEN dat_von AND dat_bis
                                               GROUP BY 1,2,3,4) b

SET dat_von = '2021-09-25'

WHERE dbp_etl.art_gp_wup_zu_per_tmp_xxx.mandant_id = b.mandant_id AND
      dbp_etl.art_gp_wup_zu_per_tmp_xxx.wup_id = b.wup_id AND
      dbp_etl.art_gp_wup_zu_per_tmp_xxx.art_id = b.art_id AND
      dbp_etl.art_gp_wup_zu_per_tmp_xxx.gp_id = b.gp_id AND
      dbp_etl.art_gp_wup_zu_per_tmp_xxx.dat_von = b.dat_von
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

  INNER JOIN DBP_ETL.art_gp_wup_zu_per_tmp_xxx_1 ag
  ON agp.mandant_id = ag.mandant_id AND agp.art_id = ag.art_id AND agp.gp_id = ag.gp_id AND agp.wup_id = ag.wup_id
    AND agp.einkaufsorganisation_id = ag.einkaufsorganisation_id AND COALESCE(agp.nb_id,-999) = COALESCE(ag.nb_id,-999)
    AND agp.bezugsweg_id = ag.bezugsweg_id AND  agp.dat_von >= ag.dat_von

  AND agp.mandant_id = 1
  GROUP BY 1,2,3,4,5,6,7,8
)
AND mandant_id = 1
;

INSERT INTO dbp_data.art_gp_wup_zu_per_1
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
FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
WHERE dat_von >= '2021-09-25' AND
      dat_von <= dat_bis
;

UPDATE dbp_data.art_gp_wup_zu_per_1

SET dat_bis = dt1.dat_bis

FROM (SELECT l.mandant_id
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
      GROUP BY 1,2,3,4,5,6,7,8) dt1

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
