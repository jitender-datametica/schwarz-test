
SELECT dat_relevant
FROM DBP_ETL.kmo_art_wup_ek_datum_relevant_1;


DELETE FROM DBP_ETL_PROCESS.metadata_kmo_art_wup_ek_1
WHERE ende IS NULL;


INSERT INTO DBP_ETL_PROCESS.metadata_kmo_art_wup_ek_1 (snapshot_datum,
                                                  verdat,
                                                  beginn)
SELECT dat_relevant AS snapshot_datum,
       CURRENT_DATE AS verdat,
       CURRENT_TIMESTAMP AS beginn
FROM DBP_ETL.kmo_art_wup_ek_datum_relevant_1;


CREATE  VOLATILE TABLE _art_wup_ek_zu_per_w (
  art_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  dat_relevant DATE NOT NULL,
  ek_netto DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  komponentenmenge DECIMAL(9,4) NOT NULL,
  wrg_id CHAR(3) NOT NULL,
  ek_nettonetto DECIMAL(18,4),
  /* neue Spalte */
  kein_zekp_fg BYTEINT) 
;

CREATE  VOLATILE TABLE _art_wup_ek_zu_per_x (
  art_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  dat_relevant DATE NOT NULL,
  ek_netto DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  komponentenmenge DECIMAL(9,4) NOT NULL,
  wrg_id CHAR(3) NOT NULL,
  ek_nettonetto DECIMAL(18,4),
  /* neue Spalten */
  kein_zekp_fg BYTEINT) 
;

CREATE  VOLATILE TABLE _art_wup_ek_zu_per_tmp (
  art_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  ek_netto DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  komponentenmenge DECIMAL(9,4) NOT NULL,
  wrg_id CHAR(3) NOT NULL,
  ek_nettonetto DECIMAL(18,4),
  /* neue Spalten */
  kein_zekp_fg BYTEINT) 
;

CREATE  VOLATILE TABLE _art_wup_ek_zu_per_tmp2 (
  art_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  ek_netto DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  komponentenmenge DECIMAL(9,4) NOT NULL,
  wrg_id CHAR(3) NOT NULL,
  ek_nettonetto DECIMAL(18,4),
  /* neue Spalten */
  kein_zekp_fg BYTEINT) 
;


CREATE  VOLATILE TABLE _hauptlieferant (
  dat_relevant DATE NOT NULL,
  mandant_id BYTEINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL
) ;


CREATE  VOLATILE TABLE _mandant_artikel_kombi (
  mandant_id BYTEINT NOT NULL,
  art_id INTEGER NOT NULL
) ;


INSERT INTO _hauptlieferant (dat_relevant,
                             mandant_id,
                             wup_id,
                             nb_id,
                             art_id,
                             gp_id)
SELECT b.dat_relevant,
       a.mandant_id,
       -1 AS wup_id,
       -1 AS nb_id,
       a.art_id,
       MAX(b.gp_id) AS gp_id
FROM DBP_DATA.art_gp_nm_zu_per_1 a
JOIN (SELECT x.dat_relevant,
             x.mandant_id,
             x.art_id,
             x.gp_id
      FROM (SELECT r.dat_relevant,
                   a.mandant_id,
                   a.art_id,
                   a.gp_id,
                   RANK() OVER (PARTITION BY a.mandant_id,a.art_id
                                ORDER BY COUNT(*) DESC) rang
            FROM DBP_DATA.art_gp_nm_zu_per_1 a
            JOIN DBP_ETL.kmo_art_wup_ek_datum_relevant_1 r
              ON 1 = 1
            WHERE a.gp_id <> -1 AND
                  a.mandant_id > 1 AND
                  r.dat_relevant BETWEEN a.dat_von AND a.dat_bis
            GROUP BY 1,2,3,4) x
      WHERE x.rang = 1) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     b.dat_relevant BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2,5
;

INSERT INTO _mandant_artikel_kombi (mandant_id,
                                    art_id)
SELECT a.mandant_id,
       a.art_id
FROM DBP_DATA.art_gp_nm_zu_per_1 a
JOIN DBP_ETL.kmo_art_wup_ek_datum_relevant_1 r
  ON 1 = 1
WHERE a.mandant_id > 1 AND
      r.dat_relevant BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2;


INSERT INTO _hauptlieferant (dat_relevant,
                             mandant_id,
                             wup_id,
                             nb_id,
                             art_id,
                             gp_id)
SELECT r.dat_relevant,
       a.mandant_id,
       -1 AS wup_id,
       -1 AS nb_id,
       a.art_id,
       -1 AS gp_id
FROM _mandant_artikel_kombi a
JOIN DBP_ETL.kmo_art_wup_ek_datum_relevant_1 r
  ON 1 = 1
LEFT JOIN _hauptlieferant b
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id
WHERE b.mandant_id IS NULL;

INSERT INTO _art_wup_ek_zu_per_w (art_id,
                                  mandant_id,
                                  wup_id,
                                  nb_id,
                                  dat_relevant,
                                  ek_netto,
                                  ek_netto_bnk,
                                  ek_mep,
                                  einstandspreis,
                                  komponentenmenge,
                                  wrg_id,
                                  ek_nettonetto,
                                  kein_zekp_fg)
SELECT a.art_id,
       a.mandant_id,
       -1 AS wup_id,
       -1 AS nb_id,
       a.dat_relevant,
       COALESCE(CAST((b.ek_netto       ) AS DECIMAL (18,4)), 1) AS ek_netto,
       COALESCE(CAST((b.ek_netto_bnk   ) AS DECIMAL (18,4)), 1) AS ek_netto_bnk,
       COALESCE(CAST((b.ek_mep         ) AS DECIMAL (18,4)), 1) AS ek_mep,
       COALESCE(CAST((b.einstandspreis ) AS DECIMAL (18,4)), 1) AS einstandspreis,
       COALESCE(b.komponentenmenge,1) AS komponentenmenge,
       COALESCE(b.wrg_id,c.default_wrg) AS wrg_id,
       COALESCE(CAST((b.ek_nettonetto  ) AS DECIMAL (18,4)), 1) AS ek_nettonetto,
       CASE
         WHEN b.ek_netto IS NULL
         THEN 1
         ELSE 0
       END AS kein_zekp_fg
FROM (SELECT a.dat_relevant,
             a.mandant_id,
             a.art_id,
             a.gp_id
      FROM _hauptlieferant a
      GROUP BY 1,2,3,4) a
JOIN DBP_DATA.mandant_1 c
  ON a.mandant_id = c.mandant_id
LEFT JOIN (SELECT *
           FROM DBP_DATA.art_gp_wup_zu_per_1
           WHERE CAST((ek_netto ) AS DECIMAL(18,4)) > 0) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.gp_id      = b.gp_id      AND
     b.wup_id     = -1           AND
     a.dat_relevant BETWEEN b.dat_von AND b.dat_bis
;

INSERT INTO _art_wup_ek_zu_per_x (art_id,
                                  mandant_id,
                                  wup_id,
                                  nb_id,
                                  dat_relevant,
                                  ek_netto,
                                  ek_netto_bnk,
                                  ek_mep,
                                  einstandspreis,
                                  komponentenmenge,
                                  wrg_id,
                                  ek_nettonetto,
                                  kein_zekp_fg)
SELECT a.art_id,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.dat_relevant,
       a.ek_netto,
       a.ek_netto_bnk,
       a.ek_mep,
       a.einstandspreis,
       a.komponentenmenge,
       a.wrg_id,
       a.ek_nettonetto,
       a.kein_zekp_fg
FROM _art_wup_ek_zu_per_w a
JOIN DBP_DATA.art_wup_ek_zu_per_1 z
  ON a.mandant_id = z.mandant_id AND 
     a.wup_id     = z.wup_id     AND
     a.art_id     = z.art_id     AND
     a.dat_relevant BETWEEN z.dat_von AND z.dat_bis
WHERE a.ek_netto         <> CAST((z.ek_netto       ) AS DECIMAL (18,4)) OR
      a.ek_netto_bnk     <> CAST((z.ek_netto_bnk   ) AS DECIMAL (18,4)) OR
      a.ek_mep           <> CAST((z.ek_mep         ) AS DECIMAL (18,4)) OR
      a.einstandspreis   <> CAST((z.einstandspreis ) AS DECIMAL (18,4)) OR
      a.komponentenmenge <> z.komponentenmenge                                            OR
      a.ek_nettonetto    <> CAST((z.ek_nettonetto  ) AS DECIMAL (18,4))
;


INSERT INTO _art_wup_ek_zu_per_x (art_id,
                                  mandant_id,
                                  wup_id,
                                  nb_id,
                                  dat_relevant,
                                  ek_netto,
                                  ek_netto_bnk,
                                  ek_mep,
                                  einstandspreis,
                                  komponentenmenge,
                                  wrg_id,
                                  ek_nettonetto,
                                  kein_zekp_fg)
SELECT a.art_id,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.dat_relevant,
       a.ek_netto,
       a.ek_netto_bnk,
       a.ek_mep,
       a.einstandspreis,
       a.komponentenmenge,
       a.wrg_id,
       a.ek_nettonetto,
       a.kein_zekp_fg
FROM _art_wup_ek_zu_per_w a
WHERE (mandant_id, wup_id, art_id) NOT IN (SELECT mandant_id,
                                                  wup_id,
                                                  art_id
                                           FROM DBP_DATA.art_wup_ek_zu_per_1)
;

INSERT INTO _art_wup_ek_zu_per_tmp (art_id,
                                    mandant_id,
                                    wup_id,
                                    nb_id,
                                    dat_von,
                                    dat_bis,
                                    ek_netto,
                                    ek_netto_bnk,
                                    ek_mep,
                                    einstandspreis,
                                    komponentenmenge,
                                    wrg_id,
                                    ek_nettonetto,
                                    kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       to_date('99991231','YYYYMMDD') AS dat_bis,
       CAST((ek_netto       ) AS DECIMAL (18,4)),
       CAST((ek_netto_bnk   ) AS DECIMAL (18,4)),
       CAST((ek_mep         ) AS DECIMAL (18,4)),
       CAST((einstandspreis ) AS DECIMAL (18,4)),
       komponentenmenge,
       wrg_id,
       CAST((ek_nettonetto  ) AS DECIMAL (18,4)),
       kein_zekp_fg
FROM DBP_DATA.art_wup_ek_zu_per_1
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,
                                            wup_id,
                                            art_id
                                     FROM _art_wup_ek_zu_per_x) AND
      /* nur die Historie, die nicht neu kommt, übernehmen! */ 
      (mandant_id, wup_id, art_id, dat_von) NOT IN (SELECT mandant_id,
                                                           wup_id,
                                                           art_id,
                                                           dat_relevant
                                                    FROM _art_wup_ek_zu_per_x)
;


INSERT INTO _art_wup_ek_zu_per_tmp (art_id,
                                    mandant_id,
                                    wup_id,
                                    nb_id,
                                    dat_von,
                                    dat_bis,
                                    ek_netto,
                                    ek_netto_bnk,
                                    ek_mep,
                                    einstandspreis,
                                    komponentenmenge,
                                    wrg_id,
                                    ek_nettonetto,
                                    kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_relevant AS dat_von,
       to_date('99991231','YYYYMMDD') AS dat_bis,
       ek_netto,
       ek_netto_bnk,
       ek_mep,
       einstandspreis,
       komponentenmenge,
       wrg_id,
       ek_nettonetto,
       kein_zekp_fg
FROM _art_wup_ek_zu_per_x
;


INSERT INTO _art_wup_ek_zu_per_tmp (art_id,
                                    mandant_id,
                                    wup_id,
                                    nb_id,
                                    dat_von,
                                    dat_bis,
                                    ek_netto,
                                    ek_netto_bnk,
                                    ek_mep,
                                    einstandspreis,
                                    komponentenmenge,
                                    wrg_id,
                                    ek_nettonetto,
                                    kein_zekp_fg)
SELECT z.art_id,
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       a.dat_relevant+1 AS dat_von_,
       to_date('99991231','YYYYMMDD') AS dat_bis_,
       CAST((z.ek_netto       ) AS DECIMAL (18,4)) ek_netto_,
       CAST((z.ek_netto_bnk   ) AS DECIMAL (18,4)) ek_netto_bnk_,
       CAST((z.ek_mep         ) AS DECIMAL (18,4)) ek_mep_,
       CAST((z.einstandspreis ) AS DECIMAL (18,4)) einstandspreis_,
       z.komponentenmenge,
       z.wrg_id,
       CAST((z.ek_nettonetto  ) AS DECIMAL (18,4)) ek_nettonetto_,
       z.kein_zekp_fg
FROM _art_wup_ek_zu_per_x a
JOIN DBP_DATA.art_wup_ek_zu_per_1 z 
  ON a.mandant_id    = z.mandant_id AND 
     a.wup_id        = z.wup_id     AND 
     a.art_id        = z.art_id     AND 
     a.dat_relevant >= z.dat_von    AND /* innerhalb eines bestehenden Zeitraums */
     a.dat_relevant  < z.dat_bis    AND
     z.dat_bis       <  to_date('99991231','YYYYMMDD')     AND /* letzten Datesatz nicht einfuegen, dieser wird ersetzt */
    (a.ek_netto         <> CAST((z.ek_netto       ) AS DECIMAL (18,4)) OR
     a.ek_netto_bnk     <> CAST((z.ek_netto_bnk   ) AS DECIMAL (18,4)) OR
     a.ek_mep           <> CAST((z.ek_mep         ) AS DECIMAL (18,4)) OR
     a.einstandspreis   <> CAST((z.einstandspreis ) AS DECIMAL (18,4)) OR
     a.komponentenmenge <> z.komponentenmenge                                            OR
     a.ek_nettonetto    <> CAST((z.ek_nettonetto   ) AS DECIMAL (18,4)))
WHERE (z.mandant_id, z.art_id, z.wup_id, dat_von_) NOT IN (SELECT mandant_id,
                                                                  art_id,
                                                                  wup_id,
                                                                  dat_relevant
                                                           FROM _art_wup_ek_zu_per_x)
-- Falls mehrere neue Zuordnungen in ein bestehendes Intervall fallen
GROUP BY z.art_id,z.mandant_id,z.wup_id,z.nb_id,dat_von_,dat_bis_,ek_netto_,ek_netto_bnk_,ek_mep_,
         einstandspreis_,z.komponentenmenge,z.wrg_id,ek_nettonetto_,z.kein_zekp_fg
;


INSERT INTO _art_wup_ek_zu_per_tmp2 (art_id,
                                     mandant_id,
                                     wup_id,
                                     nb_id,
                                     dat_von,
                                     dat_bis,
                                     ek_netto,
                                     ek_netto_bnk,
                                     ek_mep,
                                     einstandspreis,
                                     komponentenmenge,
                                     wrg_id,
                                     ek_nettonetto,
                                     kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       dat_bis,
       ek_netto,
       ek_netto_bnk,
       ek_mep,
       einstandspreis,
       komponentenmenge,
       wrg_id,
       ek_nettonetto,
       kein_zekp_fg
FROM (SELECT art_id,
             mandant_id,
             wup_id,
             nb_id,
             dat_von,
             dat_bis,
             ek_netto,
             ek_netto_bnk,
             ek_mep,
             einstandspreis,
             komponentenmenge,
             wrg_id,
             ek_nettonetto,
             kein_zekp_fg,
             -- Alle Datensätze markieren, die entweder keinen Wechsel haben, weil
             -- kein Vorgänger da ist, oder die einen EK-Wechsel im Vergleich zum 
             -- Vorgänger aufweisen.
             /*COALESCE(MDIFF(ek_netto, 1, dat_von ASC), 1) AS ek_netto_wechsel_fg,
             COALESCE(MDIFF(ek_netto_bnk, 1, dat_von ASC), 1) AS ek_netto_bnk_wechsel_fg,            
             COALESCE(MDIFF(ek_mep, 1, dat_von ASC), 1) AS ek_mep_wechsel_fg,
             COALESCE(MDIFF(einstandspreis, 1, dat_von ASC), 1) AS einstandspreis_wechsel_fg,
             COALESCE(MDIFF(komponentenmenge, 1, dat_von ASC), 1) AS komp_wechsel_fg,  
             COALESCE(MDIFF(ek_nettonetto, 1, dat_von ASC), 1) AS ek_nettonetto_wechsel_fg*/              
             COALESCE( (ek_netto - sum(ek_netto) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS ek_netto_wechsel_fg,
             COALESCE( (ek_netto_bnk - sum(ek_netto_bnk) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS ek_netto_bnk_wechsel_fg,  
             COALESCE( (ek_mep - sum(ek_mep) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS ek_mep_wechsel_fg,            
             COALESCE( (einstandspreis - sum(einstandspreis) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS einstandspreis_wechsel_fg,
             COALESCE( (komponentenmenge - sum(komponentenmenge) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS komp_wechsel_fg,
             COALESCE( (ek_nettonetto - sum(ek_nettonetto) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS ek_nettonetto_wechsel_fg
     FROM _art_wup_ek_zu_per_tmp
      /*GROUP BY mandant_id,art_id,wup_id*/) a
WHERE ek_netto_wechsel_fg       <> 0 OR
      ek_netto_bnk_wechsel_fg   <> 0 OR
      ek_mep_wechsel_fg         <> 0 OR
      einstandspreis_wechsel_fg <> 0 OR
      komp_wechsel_fg           <> 0 OR
      ek_nettonetto_wechsel_fg  <> 0
;


UPDATE _art_wup_ek_zu_per_tmp2 SET dat_bis = dt1.dat_bis_

FROM (SELECT mandant_id,
                                            wup_id,
                                            art_id,
                                            dat_von,
                                            CASE 
                                             WHEN --(MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) = 0
                                                    (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0
                                                    OR
                                                    (LEAD(dat_von, 1, to_date('9999-12-31','YYYY-MM_1-DD')) over (PARTITION BY mandant_id,wup_id,art_id ORDER BY dat_von) = to_date('9999-12-31','YYYY-MM_1-DD'))
                                             THEN to_date('9999-12-31','YYYY-MM_1-DD')
                                             ELSE  dateadd(day, -1, LEAD(dat_von, 1, to_date('9999-12-31','YYYY-MM_1-DD')) over (PARTITION BY mandant_id,wup_id,art_id ORDER BY dat_von))  
                                                  --CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) AS CURRENT_DATE) -1
                                            END AS dat_bis_
                                            /*CASE 
                                              WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) = 0
                                              THEN to_date('9999-12-31','YYYY-MM_1-DD')
                                              ELSE CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) AS CURRENT_DATE) -1
                                            END AS dat_bis_*/
                                     FROM _art_wup_ek_zu_per_tmp2
                                     QUALIFY dat_bis_ <> dat_bis
                                     /*GROUP BY mandant_id,wup_id,art_id*/) dt1

WHERE _art_wup_ek_zu_per_tmp2.mandant_id = dt1.mandant_id AND 
      _art_wup_ek_zu_per_tmp2.wup_id     = dt1.wup_id     AND 
      _art_wup_ek_zu_per_tmp2.art_id     = dt1.art_id     AND 
      _art_wup_ek_zu_per_tmp2.dat_von    = dt1.dat_von    AND 
      _art_wup_ek_zu_per_tmp2.dat_bis   <> dt1.dat_bis_
;


DELETE FROM DBP_DATA.art_wup_ek_zu_per_1 a
WHERE (mandant_id, wup_id, art_id) IN (SELECT mandant_id,
                                              wup_id,
                                              art_id
                                       FROM _art_wup_ek_zu_per_x)
;


INSERT INTO DBP_DATA.art_wup_ek_zu_per_1 (art_id,
                                         mandant_id,
                                         wup_id,
                                         nb_id,
                                         dat_von,
                                         dat_bis,
                                         ek_netto,
                                         ek_netto_bnk,
                                         ek_mep,
                                         einstandspreis,
                                         komponentenmenge,
                                         wrg_id,
                                         ek_nettonetto,
                                         kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       dat_bis,
       (ek_netto       ) AS ek_netto,
       (ek_netto_bnk   ) AS ek_netto_bnk,
       (ek_mep         ) AS ek_mep,
       (einstandspreis ) AS einstandspreis,
       komponentenmenge,
       wrg_id,
       (ek_nettonetto  ) AS ek_nettonetto,
       kein_zekp_fg
FROM _art_wup_ek_zu_per_tmp2
;


UPDATE DBP_ETL_PROCESS.metadata_kmo_art_wup_ek_1 SET ende = CURRENT_TIMESTAMP
WHERE ende IS NULL;

