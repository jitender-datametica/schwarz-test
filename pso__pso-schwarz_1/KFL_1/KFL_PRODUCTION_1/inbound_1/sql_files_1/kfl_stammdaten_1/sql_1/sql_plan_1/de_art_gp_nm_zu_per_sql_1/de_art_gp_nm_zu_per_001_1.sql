CREATE OR REPLACE VOLATILE TABLE _zwischen_tabelle  (
  mandant_id         BYTEINT,
  wup_id             INTEGER,
  nb_id              BYTEINT,
  art_id             INTEGER,
  dat                DATE,
  bezugsweg_id       INTEGER,
  anz_ek_infosatz    INTEGER,
  anz_ek_orderbuch   INTEGER,
  bq_gp_id           INTEGER,
  bq_ekorg           INTEGER,
  bq_findung_id      INTEGER,
  regel_gp_id        INTEGER,
  regel_ekorg        INTEGER,
  ref_wup_id         INTEGER,
  ref_nb_id          INTEGER,
  wg_id              INTEGER,
  kreistyp_gruppe_id VARCHAR(4)
) ;

CREATE OR REPLACE VOLATILE TABLE _kmo_art_gp_wup_zu_2  (
mandant_id         BYTEINT NOT NULL,
art_id             INTEGER NOT NULL,
wup_id             INTEGER NOT NULL,
nb_id              SMALLINT NOT NULL,
dat                DATE NOT NULL,
bezugsweg_id       BYTEINT,
anz_ek_infosatz    SMALLINT,   -- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
bq_gp_id           INTEGER,    -- GP_1 nach Bezugsquellenfindung
bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
regel_gp_id        INTEGER,    -- Regel GP_1 aus Einkaufsinfosatz
regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
ref_wup_id         INTEGER,    -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
kreistyp_gruppe_id VARCHAR(4) COLLATE 'en-ci', -- Kreistyp_gruppe aus Marktstamm.
wg_id              SMALLINT    -- Warengruppe für Zugriff auf vz_wup_wg_zu_per
) ;

CREATE OR REPLACE VOLATILE TABLE _kmo_art_gp_wup_zu_3 cluster by (mandant_id,dat,art_id,wup_id,ref_wup_id) (
mandant_id         BYTEINT NOT NULL,
art_id             INTEGER NOT NULL,
wup_id             INTEGER NOT NULL,
nb_id              SMALLINT NOT NULL,
dat                DATE NOT NULL,
bezugsweg_id       BYTEINT,
anz_ek_infosatz    SMALLINT,   -- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
bq_gp_id           INTEGER,    -- GP_1 nach Bezugsquellenfindung
bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
regel_gp_id        INTEGER,    -- Regel GP_1 aus Einkaufsinfosatz
regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
ref_wup_id         INTEGER,    -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
kreistyp_gruppe_id VARCHAR(4) COLLATE 'en-ci', -- Kreistyp_gruppe aus Marktstamm.
wg_id              SMALLINT    -- Warengruppe für Zugriff auf vz_wup_wg_zu_per
) ;

CREATE OR REPLACE VOLATILE TABLE _art_gp_wup_zu_per AS (
SELECT mandant_id,
       art_id,
       gp_id,
       wup_id,
       nb_id,
       einkaufsorganisation_id,
       dat_von,
       dat_bis
FROM dbp_data.art_gp_wup_zu_per_1
WHERE dat_bis >= (SELECT dat_relevant
                  FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) AND
      mandant_id = 1
);

CREATE OR REPLACE VOLATILE TABLE _vz_wg_wup_zu_per AS (
SELECT v.mandant_id
      ,v.arthiertyp_id
      ,v.wg_hierarchie_ebene_id
      ,v.wg_hierarchie_id
      ,v.wup_id
      ,v.nb_id
      ,v.vz_wup_id
      ,d.dat_relevant AS dat
      ,v.vz_prio_id
      ,COALESCE(v.kreistyp_id, '') AS kreistyp_id
      ,COALESCE(k.vz_prio_id, v.vz_prio_id) AS zek_kreis_vz_prio_id  --Fuehrend Prio aus Zek_kreis
FROM dbp_data.vz_wg_wup_zu_per_1 v
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
  ON 1 = 1
-- Kreistyp ist nicht immer gefuellt.
LEFT OUTER JOIN dbp_data.l_kreistyp_1 k
  ON v.mandant_id = k.mandant_id AND 
     v.kreistyp_id = k.kreistyp_id
-- Polnischen Dummy_1 Kreistyp Z ignorieren
WHERE (CASE WHEN v.mandant_id = 3 AND v.kreistyp_id = 'Z' THEN 0 ELSE 1 END) = 1 AND
       v.mandant_id = 1 AND
       d.dat_relevant BETWEEN v.dat_von AND v.dat_bis
);

CREATE OR REPLACE VOLATILE TABLE _kmo_art_gp_wup_oh_bzw  (
mandant_id         BYTEINT NOT NULL,
art_id             INTEGER NOT NULL,
wup_id             INTEGER NOT NULL,
nb_id              SMALLINT NOT NULL,
dat                DATE NOT NULL,
bezugsweg_id       BYTEINT,
anz_ek_infosatz    SMALLINT,   -- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
bq_gp_id           INTEGER,    -- GP_1 nach Bezugsquellenfindung
bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
regel_gp_id        INTEGER,    -- Regel GP_1 aus Einkaufsinfosatz
regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
ref_wup_id         INTEGER,    -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
kreistyp_gruppe_id VARCHAR(4) COLLATE 'en-ci', -- Kreistyp_gruppe aus Marktstamm.
wg_id              SMALLINT    -- Warengruppe für Zugriff auf vz_wup_wg_zu_per
) ;

CREATE OR REPLACE VOLATILE TABLE _art_gp_nm_zu_per_tmp  (
  mandant_id BYTEINT NOT NULL,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  dat_von DATE NOT NULL,
  gp_id INTEGER NOT NULL,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat_bis DATE NOT NULL,
  bq_findung_id BYTEINT,
  vz_wup_id INTEGER,
  bezugsweg_id BYTEINT
) ;

CREATE OR REPLACE VOLATILE TABLE _art_gp_nm_zu_per_tmp2  (
  mandant_id BYTEINT NOT NULL,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  dat_von DATE NOT NULL,
  gp_id INTEGER NOT NULL,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat_bis DATE NOT NULL,
  bq_findung_id BYTEINT,
  vz_wup_id INTEGER,
  bezugsweg_id BYTEINT
) ;

CREATE OR REPLACE VOLATILE TABLE _kmo_art_gp_wup_zu_3x  (
mandant_id             BYTEINT NOT NULL,
art_id                 INTEGER NOT NULL,
wup_id                 INTEGER NOT NULL,
nb_id                  SMALLINT NOT NULL,
dat                    DATE NOT NULL,
bezugsweg_id           BYTEINT,
anz_ek_infosatz        SMALLINT,
anz_ek_orderbuch       SMALLINT,
bq_gp_id               INTEGER,
bq_ekorg               SMALLINT,
bq_findung_id          BYTEINT,
regel_gp_id            INTEGER,
regel_ekorg            SMALLINT,
ref_wup_id             INTEGER,
ref_nb_id              SMALLINT,
kreistyp_gruppe_id     VARCHAR(4),
wg_id                  SMALLINT
) ;

INSERT INTO _zwischen_tabelle
SELECT b.mandant_id,
       b.wup_id,
       b.nb_id,
       a.art_id,
       x.dat_relevant AS dat,
       COALESCE(d.bezugsweg_id, 0) AS bezugsweg_id,
       0 AS anz_ek_infosatz,
       0 AS anz_ek_orderbuch,
       0 AS bq_gp_id,
       0 AS bq_ekorg,
       0 AS bq_findung_id,
       0 AS regel_gp_id,
       0 AS regel_ekorg,
       0 AS ref_wup_id,
       0 AS ref_nb_id,
       COALESCE(c.wg_id, 0) AS wg_id,
       COALESCE(b.kreistyp_gruppe_id, '') AS kreistyp_gruppe_id
FROM (SELECT mandant_id,
             art_id
      FROM dbp_data.artbew_1
      WHERE mandant_id = 1 AND
            dat >= (select min(dat) from dbp_data.tag_1 where akt_kj = -1)  AND
            art_id > 0
      GROUP BY 1,2
      UNION
      SELECT mandant_id,
             art_id
      FROM dbp_data.lagerbew_det_1
      WHERE mandant_id = 1 AND
            dat_buch >= (select min(dat) from dbp_data.tag_1 where akt_kj = -1)  AND
            art_id > 0
      GROUP BY 1,2
      UNION
      SELECT mandant_id,
             art_id
      FROM dbp_data.art_gp_nm_zu_per_1
      WHERE mandant_id = 1 AND
            art_id > 0
      GROUP BY 1,2
      UNION
      SELECT mandant_id,
             art_id
      FROM dbp_data.besch_best_det_1
      WHERE mandant_id = 1 AND
            art_id > 0 AND
            dat_best_beleg >= (select min(dat) from dbp_data.tag_1 where akt_kj = -1)
      GROUP BY 1,2
      UNION
      SELECT mandant_id,
             art_id
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1
      GROUP BY 1,2
      UNION
      SELECT mandant_id,
             art_id
      FROM dbp_data.art_list_wup_zu_per_1
      WHERE mandant_id = 1 and
            dat_bis >= (select min(dat) from dbp_data.tag_1 where akt_gj = 0)
      GROUP BY 1,2) a
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 x
  ON 1 = 1
JOIN (SELECT mandant_id,
             wup_id,
             nb_id,
             kreistyp_gruppe_id
      FROM dbp_data.wup_1
      WHERE nb_id = 0 AND
            mandant_id = 1
      GROUP BY 1,2,3,4
      UNION
      SELECT mandant_id,
             wup_id,
             nb_id,
             kreistyp_gruppe_id
      FROM dbp_data.wup_1
      WHERE nb_id = -111 AND
            mandant_id = 1
      GROUp BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id
JOIN (SELECT *
      FROM dbp_data.art_wg_zu_per_1
      WHERE mandant_id = 1 AND
           (SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis) c
  ON a.mandant_id    = c.mandant_id AND
     a.art_id        = c.art_id     AND 
     c.arthiertyp_id = 2 AND
     c.dat_bis = '9999-12-31'
LEFT JOIN dbp_data.art_wup_status_per_1 d
  ON a.mandant_id = d.mandant_id AND 
     a.art_id = d.art_id AND 
     b.wup_id = d.wup_id AND
     (SELECT dat_relevant
       FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN d.dat_von AND d.dat_bis
;

CREATE OR REPLACE VOLATILE TABLE _kmo_ek_infosatz AS (
SELECT DISTINCT
       xxx.mandant_id,
       xxx.art_id,
       xxx.dat,
       xxx.wup_id,
       xxx.nb_id,
       xxx.anz_ek_infosatz,
       xxx.bq_gp_id,
       xxx.bq_ekorg,
       xxx.regel_gp_id,
       xxx.regel_ekorg,
       xxx.ek_infosatz_art,
       xxx.ek_infosatz_id,
       xxx.dat_erstellung
FROM (
SELECT e.mandant_id
      ,e.art_id
      ,d.dat_relevant AS dat
      ,CASE WHEN ek.nb_id IN (-111,99) THEN 0 ELSE ek.wup_id END AS wup_id
      ,CASE WHEN ek.nb_id IN (-111,99) THEN 0 ELSE ek.nb_id END AS nb_id
      ,COUNT(e.mandant_id) AS anz_ek_infosatz 
      ,MAX(e.gp_id)AS bq_gp_id
      ,MAX(e.einkaufsorganisation_id) AS bq_ekorg
      ,MAX(CASE WHEN regel_gp_fg = 1 THEN e.gp_id ELSE 0 END) AS regel_gp_id
      ,MAX(CASE WHEN regel_gp_fg = 1 THEN e.einkaufsorganisation_id ELSE 0 END) AS regel_ekorg
      ,1 AS ek_infosatz_art
      ,CAST(NULL AS BIGINT) AS ek_infosatz_id 
      ,CAST(NULL AS DATE) AS dat_erstellung
FROM dbp_data.ek_infosatz_1 e
JOIN dbp_data.ek_infosatz_wup_zu_1 ek
  ON e.mandant_id = ek.mandant_id AND 
     e.ek_infosatz_id = ek.ek_infosatz_id AND 
     ek.loesch_fg = 0
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
  ON 1 = 1
WHERE e.mandant_id = 1 AND 
      e.loesch_fg  = 0 AND 
     (e.art_id, d.dat_relevant) IN (SELECT art_id,
                                           dat
                                    FROM _zwischen_tabelle) AND
      d.dat_relevant BETWEEN e.dat_von AND e.dat_bis AND
      d.dat_relevant >= e.dat_erstellung
GROUP BY 1,2,3,4,5,11) xxx_1
);

INSERT INTO _kmo_ek_infosatz (mandant_id,
                              art_id,
                              dat,
                              wup_id,
                              nb_id,
                              anz_ek_infosatz,
                              bq_gp_id,
                              bq_ekorg,
                              regel_gp_id,
                              regel_ekorg,
                              ek_infosatz_art,
                              ek_infosatz_id,
                              dat_erstellung)
SELECT DISTINCT
       xxx.mandant_id,
       xxx.art_id,
       xxx.dat,
       xxx.wup_id,
       xxx.nb_id,
       xxx.anz_ek_infosatz,
       xxx.bq_gp_id,
       xxx.bq_ekorg,
       xxx.regel_gp_id,
       xxx.regel_ekorg,
       xxx.ek_infosatz_art,
       xxx.ek_infosatz_id,
       xxx.dat_erstellung
FROM (
SELECT e.mandant_id
      ,e.art_id
      ,d.dat_relevant AS dat
      ,CASE WHEN ek.nb_id IN (-111,99) THEN 0 ELSE ek.wup_id END AS wup_id
      ,CASE WHEN ek.nb_id IN (-111,99) THEN 0 ELSE ek.nb_id END AS nb_id
      ,1 AS anz_ek_infosatz
      ,e.gp_id AS bq_gp_id
      ,e.einkaufsorganisation_id AS bq_ekorg
      ,0 AS regel_gp_id
      ,0 AS regel_ekorg
      ,2 AS ek_infosatz_art
      ,e.ek_infosatz_id
      ,e.dat_erstellung
FROM dbp_data.ek_infosatz_1 e
JOIN dbp_data.ek_infosatz_wup_zu_1 ek
  ON e.mandant_id = ek.mandant_id AND 
     e.ek_infosatz_id = ek.ek_infosatz_id
-- Definition inaktiv:
-- EINA_1 und/oder EINE_1 Loschkennzeichen gesetzt
-- UND/ODER Gültigkeitszeitraum EINA_1 nicht am Stichtag gültig
-- UND es werden nur die Infosätze berücksichtigt die zum
-- Stichtag bereits angelegt waren
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
  ON e.dat_erstellung <= d.dat_relevant AND 
    (e.loesch_fg = 1  OR 
     ek.loesch_fg = 1 OR 
     d.dat_relevant < e.dat_von OR 
     d.dat_relevant > e.dat_bis)
WHERE e.mandant_id = 1
AND (e.art_id, d.dat_relevant) IN (SELECT art_id,
                                          dat
                                   FROM _zwischen_tabelle)
QUALIFY ROW_NUMBER() OVER (PARTITION BY e.mandant_id,e.art_id,ek.wup_id,ek.nb_id ORDER BY e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1) xxx_1
;

INSERT INTO _kmo_ek_infosatz (mandant_id,
                              art_id,
                              dat,
                              wup_id,
                              nb_id,
                              anz_ek_infosatz,
                              bq_gp_id,
                              bq_ekorg,
                              regel_gp_id,
                              regel_ekorg,
                              ek_infosatz_art,
                              ek_infosatz_id,
                              dat_erstellung)
SELECT DISTINCT
       xxx.mandant_id,
       xxx.art_id,
       xxx.dat,
       xxx.wup_id,
       xxx.nb_id,
       xxx.anz_ek_infosatz,
       xxx.bq_gp_id,
       xxx.bq_ekorg,
       xxx.regel_gp_id,
       xxx.regel_ekorg,
       xxx.ek_infosatz_art,
       xxx.ek_infosatz_id,
       xxx.dat_erstellung
FROM (
SELECT e.mandant_id
      ,e.art_id
      ,d.dat_relevant AS dat
      ,CASE WHEN ek.nb_id IN (-111,99) THEN 0 ELSE ek.wup_id END AS wup_id
      ,CASE WHEN ek.nb_id IN (-111,99) THEN 0 ELSE ek.nb_id END AS nb_id
      ,1 AS anz_ek_infosatz
      ,e.gp_id AS bq_gp_id
      ,e.einkaufsorganisation_id AS bq_ekorg
      ,0 AS regel_gp_id
      ,0 AS regel_ekorg
      ,3 AS ek_infosatz_art
      ,e.ek_infosatz_id
      ,e.dat_erstellung
FROM dbp_data.ek_infosatz_1 e
JOIN dbp_data.ek_infosatz_wup_zu_1 ek
  ON e.mandant_id = ek.mandant_id AND 
     e.ek_infosatz_id = ek.ek_infosatz_id
-- Definition aktiv:
-- EINA_1 und EINE_1 Loschkennzeichen nicht gesetzt
-- UND/ODER Gültigkeitszeitraum EINA_1 am Stichtag gültig
-- UND es werden nur die Infosätze berücksichtigt die zum
-- Stichtag bereits angelegt waren
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
  ON d.dat_relevant BETWEEN e.dat_von AND e.dat_bis AND 
     d.dat_relevant >= e.dat_erstellung
WHERE e.mandant_id = 1 AND 
      e.loesch_fg  = 0 AND 
      ek.loesch_fg = 0 AND 
     (e.art_id, d.dat_relevant) IN (SELECT art_id,
                                           dat
                                    FROM _zwischen_tabelle)
QUALIFY ROW_NUMBER() OVER (PARTITION BY e.mandant_id,e.art_id,dat,ek.wup_id,ek.nb_id,e.gp_id,e.einkaufsorganisation_id ORDER BY e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1) xxx_1
;

CREATE OR REPLACE VOLATILE TABLE _kmo_art_kreistyp_gruppe AS (
SELECT a.art_id,
       a.mandant_id,
       a.kreistyp_id,
       TRIM(a.kreistyp_gruppe_id) kreistyp_gruppe_id,
       d.dat_relevant AS dat,
       k.vz_prio_id
FROM dbp_data.art_kreistyp_gruppe_zu_per_1 a
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
  ON 1 = 1
LEFT JOIN dbp_data.l_kreistyp_1 k
  ON a.mandant_id  = k.mandant_id AND 
     a.kreistyp_id = k.kreistyp_id
WHERE a.kreistyp_id <> 'Z' AND 
      a.mandant_id = 1 AND
      d.dat_relevant BETWEEN a.dat_von AND a.dat_bis
);

UPDATE _zwischen_tabelle SET bezugsweg_id = 4
WHERE nb_id = -111 AND 
      bezugsweg_id NOT IN (1,4)
;

merge into _zwischen_tabelle a
using (select a.mandant_id,
              a.art_id,
              a.wup_id,
              d.dat_relevant as dat,
              min(cast(a.bezugsquelle_kz as int)) as bezugsweg_id_
       from dbp_data.art_wup_ordersatz_1 a
       join dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
         on d.dat_relevant between a.dat_von and a.dat_bis
       where (a.mandant_id,a.wup_id,a.art_id) in (select mandant_id,wup_id,art_id
                                                  from _zwischen_tabelle
                                                  where bezugsweg_id not in (1,4)) and 
             a.mandant_id = 1 and 
             a.bezugsquelle_kz in ('1','4')
       group by 1,2,3,4) b

  on a.mandant_id = b.mandant_id and
     a.art_id     = b.art_id     and
     a.wup_id     = b.wup_id     and
     a.dat        = b.dat        and
     a.bezugsweg_id not in (1,4)
     
when matched then update set bezugsweg_id = b.bezugsweg_id_
;

merge into _zwischen_tabelle a
using (select y.mandant_id,
              y.art_id,
              y.dat,
              y.bezugsweg_id as bezugsweg_id_
       from (select aws.mandant_id,
                    aws.art_id,
                    x.dat_relevant as dat,
                    aws.bezugsweg_id,
                    count(*) as anzahl
             from (select mandant_id,
                          art_id,
                          dat_von,
                          dat_bis,
                          bezugsweg_id
                   from dbp_data.art_wup_status_per_1 a
                   join dbp_etl.art_gp_nm_zu_per_dat_relevant_1 d
                     on 1 = 1
                   where a.art_id in (select art_id
                                      from _zwischen_tabelle
                                      where bezugsweg_id not in (1,4)) and 
                         a.mandant_id = 1 and 
                         a.bezugsweg_id in (1,4) and
                         a.dat_bis >= d.dat_relevant) aws
             join dbp_etl.art_gp_nm_zu_per_dat_relevant_1 x
               on 1 = 1
             where x.dat_relevant between aws.dat_von and aws.dat_bis
             group by 1,2,3,4) y
       qualify row_number() over (partition by y.mandant_id,y.art_id,dat,y.dat order by y.anzahl desc) = 1) b

  on a.mandant_id = b.mandant_id and
     a.art_id     = b.art_id     and
     a.dat        = b.dat        and
     a.bezugsweg_id not in (1,4)
     
when matched then update set bezugsweg_id = b.bezugsweg_id_
;

INSERT INTO _kmo_art_gp_wup_oh_bzw
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat,
       bezugsweg_id,
       anz_ek_infosatz,
       anz_ek_orderbuch,
       0 AS bq_gp_id,
       0 AS bq_ekorg,
       0 AS bq_findung_id,
       regel_gp_id,
       regel_ekorg,
       ref_wup_id,
       ref_nb_id,
       kreistyp_gruppe_id,
       wg_id
FROM _zwischen_tabelle
WHERE bezugsweg_id NOT IN (1,4);

DELETE FROM _zwischen_tabelle
WHERE bezugsweg_id NOT IN (1,4);

INSERT INTO _kmo_art_gp_wup_zu_2
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.bezugsweg_id,
       0 AS anz_ek_infosatz,
       0 AS anz_ek_orderbuch,
       0 AS bq_gp_id,
       0 AS bq_ekorg,
       0 AS bq_findung_id,
       0 AS regel_gp_id,
       0 AS regel_ekorg,
       a.vz_wup_id_ AS ref_wup_id,
       a.vz_nb_id_ AS ref_nb_id,
       a.kreistyp_gruppe_id,
       a.wg_id
FROM (SELECT agw.mandant_id,
             agw.art_id,
             agw.wup_id,
             agw.nb_id,
             agw.dat,
             agw.kreistyp_gruppe_id,
             COALESCE(ak.kreistyp_id, akk.kreistyp_id) AS kreistyp_id_,
             CASE 
               WHEN TRIM(agw.kreistyp_gruppe_id) = ''
               THEN -1
               ELSE COALESCE(ak.vz_prio_id, akk.vz_prio_id, -1)
             END AS vz_prio_id_,
             COALESCE(wwwg.vz_wup_id, wwup.vz_wup_id, vzwg.vz_wup_id, vzwup.vz_wup_id) AS vz_wup_id_,
             -111 AS vz_nb_id_ ,
             bezugsweg_id,
             wg_id
      FROM _zwischen_tabelle agw
      
      LEFT JOIN _kmo_art_kreistyp_gruppe ak
        ON agw.mandant_id = ak.mandant_id AND 
           agw.art_id = ak.art_id         AND 
           agw.kreistyp_gruppe_id = ak.kreistyp_gruppe_id AND 
           agw.dat = ak.dat
           
      LEFT JOIN _kmo_art_kreistyp_gruppe akk
        ON agw.mandant_id = akk.mandant_id AND 
           agw.art_id = akk.art_id         AND 
           TRIM(akk.kreistyp_gruppe_id) = '' AND 
           agw.dat = akk.dat
           
      LEFT JOIN _vz_wg_wup_zu_per wwwg
        ON agw.mandant_id = wwwg.mandant_id  AND 
           agw.wup_id = wwwg.wup_id          AND 
           agw.nb_id = wwwg.nb_id            AND 
           agw.wg_id = wwwg.wg_hierarchie_id AND 
           wwwg.arthiertyp_id = 6            AND 
           wwwg.wg_hierarchie_ebene_id = 5   AND 
           wwwg.kreistyp_id = COALESCE(ak.kreistyp_id, akk.kreistyp_id) AND
           agw.dat = wwwg.dat

      LEFT JOIN _vz_wg_wup_zu_per wwup
        ON agw.mandant_id = wwup.mandant_id AND 
           agw.wup_id = wwup.wup_id         AND 
           agw.nb_id = wwup.nb_id           AND 
           wwup.kreistyp_id = COALESCE(ak.kreistyp_id, akk.kreistyp_id)  AND 
           wwup.wg_hierarchie_id = -1       AND
           agw.dat = wwup.dat
           
      LEFT JOIN _vz_wg_wup_zu_per vzwg
        ON agw.mandant_id = vzwg.mandant_id  AND 
           agw.wup_id = vzwg.wup_id          AND 
           agw.nb_id = vzwg.nb_id            AND 
           agw.wg_id = vzwg.wg_hierarchie_id AND 
           vzwg.arthiertyp_id = 6            AND
           vzwg.wg_hierarchie_ebene_id = 5   AND
           vzwg.zek_kreis_vz_prio_id > CASE 
               WHEN TRIM(agw.kreistyp_gruppe_id) = ''
               THEN -1
               ELSE COALESCE(ak.vz_prio_id, akk.vz_prio_id, -1)
             END AND 
           agw.dat = vzwg.dat

      LEFT JOIN _vz_wg_wup_zu_per vzwup
        ON agw.mandant_id = vzwup.mandant_id AND 
           agw.wup_id = vzwup.wup_id         AND 
           agw.nb_id = vzwup.nb_id           AND
           vzwup.zek_kreis_vz_prio_id > CASE 
               WHEN TRIM(agw.kreistyp_gruppe_id) = ''
               THEN -1
               ELSE COALESCE(ak.vz_prio_id, akk.vz_prio_id, -1)
             END AND
           vzwup.wg_hierarchie_id = -1  AND
           agw.dat = vzwup.dat
           
      WHERE agw.bezugsweg_id = 4 AND 
            agw.mandant_id = 1 AND
            agw.nb_id <> -111
      QUALIFY ROW_NUMBER() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat
                                 ORDER BY COALESCE(wwwg.zek_kreis_vz_prio_id, wwup.zek_kreis_vz_prio_id) ASC,
                                          COALESCE(vzwg.zek_kreis_vz_prio_id, vzwup.zek_kreis_vz_prio_id) ASC,
                                          COALESCE(vzwg.vz_prio_id, vzwup.vz_prio_id) ASC) = 1) a
;

INSERT INTO _kmo_art_gp_wup_zu_2
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat,
       bezugsweg_id,
       anz_ek_infosatz,
       anz_ek_orderbuch,
       0 AS bq_gp_id,
       0 AS bq_ekorg,
       bq_findung_id,
       regel_gp_id,
       regel_ekorg,
       wup_id AS ref_wup_id,
       nb_id AS ref_nb_id,
       kreistyp_gruppe_id,
       wg_id
FROM _zwischen_tabelle
WHERE bezugsweg_id = 1 OR
      nb_id = -111;


DELETE FROM _kmo_art_gp_wup_zu_3;
INSERT INTO _kmo_art_gp_wup_zu_3
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat,
       bezugsweg_id,
       anz_ek_infosatz_,
       anz_ek_orderbuch,
       bq_gp_id_,
       bq_ekorg_,
       bq_findung_id_,
       regel_gp_id_,
       regel_ekorg_,
       COALESCE(ref_wup_id, -1) AS ref_wup_id,
       ref_nb_id,
       kreistyp_gruppe_id,
       wg_id
FROM (SELECT agw.mandant_id,
             agw.art_id,
             agw.wup_id,
             agw.nb_id,
             agw.dat,
             agw.bezugsweg_id,
             agw.anz_ek_orderbuch,
             COALESCE(e.anz_ek_infosatz, eo.anz_ek_infosatz, ek.anz_ek_infosatz, ekk.anz_ek_infosatz, 0) AS anz_ek_infosatz_,
             CASE 
               WHEN anz_ek_infosatz_ = 1
               THEN COALESCE(e.bq_gp_id, eo.bq_gp_id, ek.bq_gp_id, ekk.bq_gp_id, 0) 
               ELSE 0 
             END AS bq_gp_id_,
             CASE 
               WHEN anz_ek_infosatz_ = 1
               THEN COALESCE(e.bq_ekorg, eo.bq_ekorg, ek.bq_ekorg, ekk.bq_ekorg, 0) 
               ELSE 0 
             END AS bq_ekorg_,
             CASE 
               WHEN anz_ek_infosatz_ = 1 
               THEN CASE 
                      WHEN COALESCE(e.mandant_id, eo.mandant_id) IS NOT NULL 
                      THEN 1
                      ELSE 3
                    END
               ELSE 0 
             END AS bq_findung_id_,
             COALESCE(e.regel_gp_id, eo.regel_gp_id, 0) AS regel_gp_id_,
             COALESCE(e.regel_ekorg, eo.regel_ekorg, 0) AS regel_ekorg_,
             agw.ref_wup_id,
             agw.ref_nb_id,
             agw.kreistyp_gruppe_id,
             agw.wg_id
      FROM _kmo_art_gp_wup_zu_2 agw
      LEFT JOIN _kmo_ek_infosatz e 
        ON agw.mandant_id       = e.mandant_id AND 
           agw.ref_wup_id    = e.wup_id        AND 
           agw.art_id        = e.art_id        AND 
           agw.dat           = e.dat           AND 
           e.ek_infosatz_art = 1 
      LEFT JOIN _kmo_ek_infosatz eo 
        ON agw.mandant_id        = eo.mandant_id AND 
           eo.wup_id          = 0                AND 
           agw.art_id         = eo.art_id        AND 
           agw.dat            = eo.dat           AND 
           eo.ek_infosatz_art = 1 
      LEFT JOIN _kmo_ek_infosatz ek 
        ON agw.mandant_id        = ek.mandant_id AND 
           agw.ref_wup_id     = ek.wup_id        AND 
           agw.art_id         = ek.art_id        AND 
           agw.dat            = ek.dat           AND 
           ek.ek_infosatz_art = 2 

      LEFT JOIN _kmo_ek_infosatz ekk 
        ON agw.mandant_id         = ekk.mandant_id AND 
           ekk.wup_id          = 0 AND 
           agw.art_id          = ekk.art_id AND 
           agw.dat             = ekk.dat AND 
           ekk.ek_infosatz_art = 2) a;

-- Jetzt der erste Lauf, begrenzt auf VZs!

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT agw.mandant_id,
              agw.art_id,
              agw.wup_id,
              agw.nb_id,
              agw.dat,
              agw.bezugsweg_id,
              COALESCE(ek.bq_gp_id, ekk.bq_gp_id) AS bq_gp_id_,
              COALESCE(ek.bq_ekorg, ekk.bq_ekorg) AS bq_ekorg_
       FROM _kmo_art_gp_wup_zu_3 agw
       LEFT JOIN _kmo_ek_infosatz ek 
         ON agw.mandant_id        = ek.mandant_id AND 
            agw.ref_wup_id     = ek.wup_id        AND 
            agw.art_id         = ek.art_id        AND 
            agw.dat            = ek.dat           AND 
            ek.ek_infosatz_art = 3 AND
            LENGTH(CAST(ek.bq_gp_id AS VARCHAR(10))) = 4
       LEFT JOIN _kmo_ek_infosatz ekk
         ON agw.mandant_id       = ekk.mandant_id AND 
            ekk.wup_id           = 0              AND 
            agw.art_id          = ekk.art_id      AND 
            agw.dat             = ekk.dat         AND 
            ekk.ek_infosatz_art = 3 AND
            LENGTH(CAST(ekk.bq_gp_id AS VARCHAR(10))) = 4
       WHERE agw.anz_ek_infosatz   > 1 AND 
            (agw.bq_findung_id     = 0 OR 
             LENGTH(CAST(agw.bq_gp_id AS VARCHAR(10))) = 4) AND 
             agw.anz_ek_orderbuch <> 1
       QUALIFY ROW_NUMBER() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat,agw.bezugsweg_id ORDER BY COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC, COALESCE(ek.dat_erstellung, ekk.dat_erstellung) DESC) = 1) b
                     
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.anz_ek_infosatz   > 1     AND
    (a.bq_findung_id     = 0 OR 
     LENGTH(CAST(a.bq_gp_id AS VARCHAR(10))) = 4) AND
     a.anz_ek_orderbuch <> 1 AND
     LENGTH(CAST(b.bq_gp_id_ AS VARCHAR(10))) = 4
     
WHEN MATCHED THEN UPDATE SET bq_gp_id      = CASE 
                                               WHEN anz_ek_orderbuch > 1 OR 
                                                    regel_gp_id = 0
                                               THEN b.bq_gp_id_
                                               ELSE regel_gp_id
                                             END,
                             bq_ekorg      = CASE 
                                               WHEN anz_ek_orderbuch > 1 OR 
                                                    regel_ekorg = 0
                                               THEN b.bq_ekorg_
                                               ELSE regel_ekorg
                                             END,
                            bq_findung_id = CASE 
                                              WHEN anz_ek_orderbuch = 0 AND 
                                                   regel_gp_id = 0 
                                              THEN 9
                                              WHEN anz_ek_orderbuch = 0 AND 
                                                   regel_gp_id > 0 
                                              THEN 11
                                              WHEN anz_ek_orderbuch > 0 
                                              THEN 5 
                                            END;
                                            
UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET bq_gp_id = b.gp_id,
    --neu (01.10.2021)
    ref_wup_id = b.vz_wup_id

FROM (SELECT *
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis AND
            vz_wup_id IS NOT NULL) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.ref_wup_id = b.wup_id AND
      LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;

UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET bq_gp_id = b.gp_id,
    --neu (01.10.2021)
    ref_wup_id = b.vz_wup_id

FROM (SELECT *
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis AND
            vz_wup_id IS NOT NULL) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.wup_id = b.wup_id AND
      LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;

UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET bq_gp_id = b.gp_id

FROM (SELECT *
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.bq_gp_id = b.wup_id AND
      LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;

-- Zuruecksetzen, damit alles andere regulaer gefunden werden kann.

UPDATE _kmo_art_gp_wup_zu_3 SET bq_gp_id = 0,
                                bq_findung_id = 0,
                                bq_ekorg = 0
WHERE LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;
  
-- Jetzt der zweite Lauf!

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT agw.mandant_id,
              agw.art_id,
              agw.wup_id,
              agw.nb_id,
              agw.dat,
              COUNT(e.mandant_id) AS anz_ek_orderbuch,
              MAX(e.gp_id) AS bq_gp_id                    ,
              MAX(e.einkaufsorganisation_id) AS bq_ekorg  ,
              MAX(CASE WHEN fix_gp_fg = 1 THEN e.gp_id ELSE 0 END) AS fix_gp_id ,
              MAX(CASE WHEN fix_gp_fg = 1 THEN e.einkaufsorganisation_id ELSE 0 END) AS fix_ekorg 
       FROM _kmo_art_gp_wup_zu_3 agw
       JOIN dbp_data.ek_orderbuch_1 e
         ON agw.mandant_id    = e.mandant_id AND 
            agw.art_id     = e.art_id        AND 
           (agw.ref_wup_id = e.wup_id OR
            agw.wup_id = e.wup_id) AND  
            e.gesperrt_fg  = 0 AND 
            agw.dat BETWEEN e.dat_von AND e.dat_bis
       WHERE anz_ek_infosatz   > 1  AND 
             agw.bq_findung_id     = 0
       GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat) b

  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.anz_ek_infosatz > 1       AND
     LENGTH(CAST(b.fix_gp_id AS VARCHAR(10))) <> 4

WHEN MATCHED THEN UPDATE SET anz_ek_orderbuch  = CASE 
                                                   WHEN fix_gp_id > 0
                                                   THEN 1
                                                   ELSE b.anz_ek_orderbuch
                                                 END,
                             bq_gp_id          = CASE 
                                                   WHEN fix_gp_id > 0
                                                   THEN fix_gp_id
                                                   ELSE CASE 
                                                          WHEN b.anz_ek_orderbuch = 1
                                                          THEN b.bq_gp_id
                                                          ELSE 0
                                                        END
                                                 END,
                             bq_ekorg          = CASE 
                                                   WHEN fix_gp_id > 0
                                                   THEN fix_ekorg
                                                   ELSE CASE 
                                                          WHEN b.anz_ek_orderbuch = 1
                                                          THEN b.bq_ekorg
                                                          ELSE 0
                                                        END
                                                 END,
                             bq_findung_id     = CASE 
                                                   WHEN b.anz_ek_orderbuch = 1 OR 
                                                        fix_gp_id > 0
                                                   THEN 7
                                                   ELSE 0
                                                 END;

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT agw.mandant_id,
              agw.art_id,
              agw.wup_id,
              agw.nb_id,
              agw.dat,
              COALESCE(ek.bq_gp_id, ekk.bq_gp_id) AS bq_gp_id_,
              COALESCE(ek.bq_ekorg, ekk.bq_ekorg) AS bq_ekorg_
       FROM _kmo_art_gp_wup_zu_3 agw
       JOIN dbp_data.ek_orderbuch_1 e
         ON agw.mandant_id    = e.mandant_id AND 
            agw.art_id     = e.art_id        AND 
           (agw.ref_wup_id = e.wup_id OR
            agw.wup_id = e.wup_id) AND 
            e.gesperrt_fg  = 0               AND 
            agw.dat BETWEEN e.dat_von AND e.dat_bis
       LEFT JOIN _kmo_ek_infosatz ek
         ON agw.mandant_id        = ek.mandant_id AND 
            agw.ref_wup_id     = ek.wup_id        AND 
            agw.art_id         = ek.art_id        AND 
            e.gp_id            = ek.bq_gp_id      AND 
            agw.dat            = ek.dat           AND 
            ek.ek_infosatz_art = 3 
       LEFT JOIN _kmo_ek_infosatz ekk
         ON agw.mandant_id         = ekk.mandant_id AND 
            ekk.wup_id          = 0                 AND 
            agw.art_id          = ekk.art_id        AND 
            e.gp_id             = ekk.bq_gp_id      AND 
            agw.dat             = ekk.dat           AND 
            ekk.ek_infosatz_art = 3 
       WHERE agw.anz_ek_infosatz   > 1   AND 
             agw.anz_ek_orderbuch  > 1   AND 
             agw.bq_findung_id     = 0   AND 
            (ek.mandant_id IS NOT NULL OR ekk.mandant_id IS NOT NULL)
       QUALIFY ROW_NUMBER() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat ORDER BY COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC) = 1) b

  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.bq_findung_id = 0

WHEN MATCHED THEN UPDATE SET bq_gp_id      = b.bq_gp_id_, 
                             bq_ekorg      = b.bq_ekorg_, 
                             bq_findung_id = 5;
  
-- Orderbuch = 0
                             
MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT agw.mandant_id,
              agw.art_id,
              agw.wup_id,
              agw.nb_id,
              agw.dat,
              COALESCE(ek.bq_gp_id, ekk.bq_gp_id) AS bq_gp_id_,
              COALESCE(ek.bq_ekorg, ekk.bq_ekorg) AS bq_ekorg_
       FROM _kmo_art_gp_wup_zu_3 agw
       JOIN dbp_data.ek_orderbuch_1 e
         ON agw.mandant_id    = e.mandant_id AND 
            agw.art_id     = e.art_id        AND 
           (agw.ref_wup_id = e.wup_id OR
            agw.wup_id = e.wup_id) AND 
            e.gesperrt_fg  = 0               AND 
            agw.dat BETWEEN e.dat_von AND e.dat_bis
       LEFT JOIN _kmo_ek_infosatz ek
         ON agw.mandant_id        = ek.mandant_id AND 
            agw.ref_wup_id     = ek.wup_id        AND 
            agw.art_id         = ek.art_id        AND 
            e.gp_id            = ek.bq_gp_id      AND 
            agw.dat            = ek.dat           AND 
            ek.ek_infosatz_art = 3 
       LEFT JOIN _kmo_ek_infosatz ekk
         ON agw.mandant_id         = ekk.mandant_id AND 
            ekk.wup_id          = 0                 AND 
            agw.art_id          = ekk.art_id        AND 
            CASE
              WHEN LENGTH(CAST(e.gp_id AS VARCHAR(10))) = 4
              THEN 1
              ELSE e.gp_id
            END = CASE
              WHEN LENGTH(CAST(e.gp_id AS VARCHAR(10))) = 4
              THEN 1
              ELSE ekk.bq_gp_id
              END AND 
            agw.dat             = ekk.dat           AND 
            ekk.ek_infosatz_art = 3 
       WHERE agw.anz_ek_infosatz   > 1   AND 
             agw.anz_ek_orderbuch  = 0   AND 
             agw.bq_findung_id     = 0   AND 
            (ek.mandant_id IS NOT NULL OR ekk.mandant_id IS NOT NULL)
       QUALIFY ROW_NUMBER() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat ORDER BY COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC) = 1) b

  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.bq_findung_id = 0

WHEN MATCHED THEN UPDATE SET bq_gp_id      = b.bq_gp_id_, 
                             bq_ekorg      = b.bq_ekorg_, 
                             bq_findung_id = 5;
  
INSERT INTO _kmo_art_gp_wup_zu_3
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat,
       bezugsweg_id,
       anz_ek_infosatz,
       anz_ek_orderbuch,
       bq_gp_id,
       bq_ekorg,
       bq_findung_id,
       regel_gp_id,
       regel_ekorg,
       COALESCE(ref_wup_id, -1) AS ref_wup_id,
       ref_nb_id,
       kreistyp_gruppe_id,
       wg_id
FROM _kmo_art_gp_wup_oh_bzw;
  
UPDATE _kmo_art_gp_wup_zu_3 

SET bq_gp_id = g.gp_id,
    bq_ekorg = g.einkaufsorganisation_id

FROM dbp_data.gp_1 g

WHERE _kmo_art_gp_wup_zu_3.mandant_id = g.mandant_id AND 
      _kmo_art_gp_wup_zu_3.bq_findung_id = 0         AND 
      g.gp_id = -1;

UPDATE _kmo_art_gp_wup_zu_3 SET bq_findung_id = 25 
WHERE bq_findung_id = 0;

CREATE OR REPLACE VOLATILE TABLE _make_it_distinct AS (
SELECT DISTINCT *
FROM _kmo_art_gp_wup_zu_3
);

DELETE FROM _kmo_art_gp_wup_zu_3;
INSERT INTO _kmo_art_gp_wup_zu_3
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat,
       bezugsweg_id,
       MIN(anz_ek_infosatz) AS anz_ek_infosatz,
       MIN(anz_ek_orderbuch) AS anz_ek_orderbuch,
       bq_gp_id,
       bq_ekorg,
       MIN(bq_findung_id) AS bq_findung_id,
       regel_gp_id,
       regel_ekorg,
       ref_wup_id,
       ref_nb_id,
       kreistyp_gruppe_id,
       wg_id
FROM _make_it_distinct
GROUP BY 1,2,3,4,5,6,9,10,12,13,14,15,16,17
;

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT a.mandant_id,
              a.wup_id,
              a.nb_id,
              a.art_id,
              a.dat,
              MIN(a.bq_findung_id + (CASE 
                                   WHEN agw.mandant_id IS NULL 
                                   THEN 1 
                                   ELSE 0 
                                 END) +  (CASE 
                                            WHEN a.bezugsweg_id = 1 
                                            THEN 0 
                                            ELSE 12 
                                          END)) AS bq_findung_id_
       FROM _kmo_art_gp_wup_zu_3 a
       LEFT JOIN _art_gp_wup_zu_per agw 
         ON a.mandant_id      = agw.mandant_id AND 
            a.ref_wup_id   = agw.wup_id  AND 
            --a.ref_nb_id    = agw.nb_id AND 
            a.art_id       = agw.art_id AND 
            a.bq_gp_id     = agw.gp_id AND 
            a.bq_ekorg     = agw.einkaufsorganisation_id AND 
            a.dat          BETWEEN agw.dat_von AND agw.dat_bis
       LEFT JOIN _art_gp_wup_zu_per agww
         ON a.mandant_id      = agww.mandant_id AND 
            agww.wup_id    = -1  AND 
            a.art_id       = agww.art_id AND 
            a.bq_gp_id     = agww.gp_id AND 
            a.bq_ekorg     = agww.einkaufsorganisation_id AND 
            a.dat          BETWEEN agww.dat_von AND agww.dat_bis
       WHERE a.bq_findung_id <> 25
       GROUP BY 1,2,3,4,5) b
       
 ON a.mandant_id = b.mandant_id AND
    a.wup_id     = b.wup_id     AND
    a.art_id     = b.art_id     AND
    a.dat        = b.dat        AND
    a.bq_findung_id <> 25
    
WHEN MATCHED THEN UPDATE SET bq_findung_id = b.bq_findung_id_;

UPDATE _kmo_art_gp_wup_zu_3 FROM (-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren
                                  SELECT ein.mandant_id,
                                         ein.art_id,
                                         a.dat_relevant AS dat,
                                         ein.ek_faktor AS zwgs,
                                         COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                                         COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                                  FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1 a
                                  JOIN dbp_data.art_man_spanne_per_1 ein 
                                    ON ein.konditionsart_id = 'ZWGS' AND 
                                       ein.loesch_fg = 0 AND 
                                       a.dat_relevant BETWEEN ein.dat_von AND ein.dat_bis
                                  LEFT JOIN dbp_data.art_man_spanne_per_1 mep 
                                    ON mep.mandant_id = ein.mandant_id AND 
                                       mep.art_id  = ein.art_id AND 
                                       mep.konditionsart_id = 'ZWGM' AND 
                                       mep.loesch_fg = 0 AND 
                                       a.dat_relevant BETWEEN mep.dat_von AND mep.dat_bis
                                  LEFT JOIN dbp_data.art_man_spanne_per_1 ekbnk 
                                    ON ekbnk.mandant_id = ein.mandant_id AND 
                                       ekbnk.art_id  = ein.art_id AND 
                                       ekbnk.konditionsart_id = 'ZWGE' AND 
                                       ekbnk.loesch_fg = 0 AND 
                                       a.dat_relevant BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
                                  WHERE ein.mandant_id = 1) b

SET bq_findung_id = 27

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id     = b.art_id     AND
      _kmo_art_gp_wup_zu_3.dat        = b.dat;

-- Hier die betriebsspezifischen manuellen Spannenfaktoren
MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren
       SELECT ein.mandant_id,
              ein.wup_id,
              ein.art_id,
              a.dat_relevant AS dat,
              ein.ek_faktor AS zwgs,
              COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
              COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
       FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1 a
       JOIN dbp_data.art_wup_man_spanne_per_1 ein 
         ON ein.konditionsart_id = 'ZWGS' AND 
            ein.loesch_fg = 0 AND 
            a.dat_relevant BETWEEN ein.dat_von AND ein.dat_bis
       LEFT JOIN dbp_data.art_wup_man_spanne_per_1 mep 
         ON mep.mandant_id = ein.mandant_id AND 
            mep.wup_id  = ein.wup_id AND 
            mep.art_id  = ein.art_id AND 
            mep.konditionsart_id = 'ZWGM'  AND 
            mep.loesch_fg = 0 AND 
            a.dat_relevant BETWEEN mep.dat_von AND mep.dat_bis
       LEFT JOIN dbp_data.art_wup_man_spanne_per_1 ekbnk 
         ON ekbnk.mandant_id = ein.mandant_id AND 
            ekbnk.wup_id  = ein.wup_id AND 
            ekbnk.art_id  = ein.art_id AND 
            ekbnk.konditionsart_id = 'ZWGE'  AND 
            ekbnk.loesch_fg = 0 AND 
            a.dat_relevant BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
       WHERE ein.mandant_id = 1) b
       
  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.art_id     = b.art_id     AND
     a.dat        = b.dat
     
WHEN MATCHED THEN UPDATE SET bq_findung_id = 26;

UPDATE _kmo_art_gp_wup_zu_3 

SET bq_findung_id = 2,
    ref_wup_id = -1

FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id
      FROM _kmo_art_gp_wup_zu_3 a
      JOIN _art_gp_wup_zu_per b
        ON a.mandant_id = b.mandant_id AND
           a.ref_wup_id  = b.wup_id AND
           a.bq_gp_id = b.gp_id AND
           a.art_id = b.art_id AND
           a.dat BETWEEN b.dat_von AND b.dat_bis
      LEFT JOIN (SELECT *
                 FROM _kmo_ek_infosatz
                 WHERE ek_infosatz_art=1) c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id AND 
           a.ref_wup_id = c.wup_id
      WHERE a.anz_ek_infosatz = 1 AND
            a.bq_findung_id = 1 AND
            a.bezugsweg_id = 1 AND
            c.wup_id IS NULL
      GROUP BY 1,2,3) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.wup_id = b.wup_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id
;

-- Der finale Lauf?

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT agw.mandant_id,
              agw.art_id,
              agw.wup_id,
              agw.nb_id,
              agw.dat,
              agw.bezugsweg_id,
              COALESCE(ek.bq_gp_id, ekk.bq_gp_id) AS bq_gp_id_,
              COALESCE(ek.bq_ekorg, ekk.bq_ekorg) AS bq_ekorg_
       FROM _kmo_art_gp_wup_zu_3 agw
       LEFT JOIN _kmo_ek_infosatz ek 
         ON agw.mandant_id        = ek.mandant_id AND 
            agw.ref_wup_id     = ek.wup_id        AND 
            agw.art_id         = ek.art_id        AND 
            agw.dat            = ek.dat           AND 
            ek.ek_infosatz_art = 3
       LEFT JOIN _kmo_ek_infosatz ekk
         ON agw.mandant_id       = ekk.mandant_id AND 
            ekk.wup_id           = 0              AND 
            agw.art_id          = ekk.art_id      AND 
            agw.dat             = ekk.dat         AND 
            ekk.ek_infosatz_art = 3 
       WHERE agw.anz_ek_infosatz   > 1 AND 
            (agw.bq_findung_id     = 25 OR 
             LENGTH(CAST(agw.bq_gp_id AS VARCHAR(10))) = 4) AND 
             agw.anz_ek_orderbuch <> 1
       QUALIFY ROW_NUMBER() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat,agw.bezugsweg_id ORDER BY COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC,COALESCE(ek.dat_erstellung, ekk.dat_erstellung) DESC) = 1) b
                     
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.anz_ek_infosatz   > 1     AND
    (a.bq_findung_id     = 25 OR 
     LENGTH(CAST(a.bq_gp_id AS VARCHAR(10))) = 4) AND
     a.anz_ek_orderbuch <> 1
     
WHEN MATCHED THEN UPDATE SET bq_gp_id      = CASE 
                                               WHEN anz_ek_orderbuch > 1 OR 
                                                    regel_gp_id = 0
                                               THEN b.bq_gp_id_
                                               ELSE regel_gp_id
                                             END,
                             bq_ekorg      = CASE 
                                               WHEN anz_ek_orderbuch > 1 OR 
                                                    regel_ekorg = 0
                                               THEN b.bq_ekorg_
                                               ELSE regel_ekorg
                                             END,
                            bq_findung_id = CASE 
                                              WHEN anz_ek_orderbuch = 0 AND 
                                                   regel_gp_id = 0 
                                              THEN 9
                                              WHEN anz_ek_orderbuch = 0 AND 
                                                   regel_gp_id > 0 
                                              THEN 11
                                              WHEN anz_ek_orderbuch > 0 
                                              THEN 5 
                                            END;

UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET bq_gp_id = b.gp_id

FROM (SELECT *
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis AND
            vz_wup_id IS NOT NULL) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.ref_wup_id = b.wup_id AND
      LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;

UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET bq_gp_id = b.gp_id

FROM (SELECT *
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis AND
            vz_wup_id IS NOT NULL) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.wup_id = b.wup_id AND
      LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;

UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET bq_gp_id = b.gp_id

FROM (SELECT *
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.bq_gp_id = b.wup_id AND
      LENGTH(CAST(_kmo_art_gp_wup_zu_3.bq_gp_id AS VARCHAR(10))) = 4
;

-- neu (01.10.2021)

UPDATE _kmo_art_gp_wup_zu_3 
                                  
SET ref_wup_id = b.vz_wup_id

FROM (SELECT mandant_id,
             wup_id,
             art_id,
             vz_wup_id
      FROM dbp_data.ek_orderbuch_1
      WHERE mandant_id = 1 AND
            gesperrt_fg = 0 AND
            vz_wup_id IS NOT NULL AND
           (SELECT dat_relevant FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_1) BETWEEN dat_von AND dat_bis) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id = b.art_id AND
      _kmo_art_gp_wup_zu_3.wup_id = b.wup_id
;

update _kmo_art_gp_wup_zu_3 from (select *
                                  from dbp_etl_process.bq_findung_korrektur_1) b
                                  
set bq_gp_id = b.gp_id

where _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id and
      _kmo_art_gp_wup_zu_3.wup_id = b.wup_id and
      _kmo_art_gp_wup_zu_3.art_id = b.art_id
;

CREATE OR REPLACE VOLATILE TABLE _snapshot_art_gp AS (
SELECT a.*
FROM dbp_data.art_gp_nm_zu_per_1 a
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_1 b
  ON a.dat_bis >= b.dat_relevant
WHERE a.mandant_id = 1
);
 
INSERT INTO _kmo_art_gp_wup_zu_3x
SELECT a.*
FROM _kmo_art_gp_wup_zu_3 a
JOIN _snapshot_art_gp z
  ON a.mandant_id = z.mandant_id AND 
     a.wup_id = z.wup_id AND 
     a.art_id = z.art_id AND 
     a.dat BETWEEN z.dat_von AND z.dat_bis
WHERE a.bq_gp_id <> z.gp_id OR                             --geaenderter Lieferant
      a.bq_findung_id <> COALESCE(z.bq_findung_id, -1) OR  --geaenderter Ausstiegspunkt
      a.ref_wup_id <> COALESCE(z.vz_wup_id, -1) OR         --geaendertes Liefer VZ
      a.bezugsweg_id <> z.bezugsweg_id                     --geaenderter Bezugsweg
;                    
      
-- Jetzt alle neuen Sachen!

INSERT INTO _kmo_art_gp_wup_zu_3x
SELECT a.*
FROM _kmo_art_gp_wup_zu_3 a
WHERE (mandant_id, wup_id, art_id) NOT IN (SELECT mandant_id,
                                                  wup_id,
                                                  art_id
                                           FROM _snapshot_art_gp);
                                          
INSERT INTO _art_gp_nm_zu_per_tmp (mandant_id,
                                   art_id,
                                   wup_id,
                                   nb_id,
                                   gp_id,
                                   einkaufsorganisation_id,
                                   bq_findung_id,
                                   vz_wup_id,
                                   dat_von,
                                   dat_bis,
                                   bezugsweg_id)
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       gp_id,
       einkaufsorganisation_id,
       COALESCE(bq_findung_id, -1),
       COALESCE(vz_wup_id    , -1),
       dat_von,
       '9999-12-31' AS dat_bis, 
       bezugsweg_id 
FROM dbp_data.art_gp_nm_zu_per_1
WHERE (mandant_id, wup_id, art_id) IN (SELECT mandant_id,
                                              wup_id,
                                              art_id
                                       FROM _kmo_art_gp_wup_zu_3x) AND
      (mandant_id, wup_id, art_id, dat_von) NOT IN (SELECT mandant_id,
                                                           wup_id,
                                                           art_id,
                                                           dat
                                                    FROM _kmo_art_gp_wup_zu_3x) AND
       mandant_id = 1
;

INSERT INTO _art_gp_nm_zu_per_tmp (mandant_id,
                                   art_id,
                                   wup_id,
                                   nb_id,
                                   gp_id,
                                   einkaufsorganisation_id,
                                   bq_findung_id,
                                   vz_wup_id,
                                   dat_von,
                                   dat_bis,
                                   bezugsweg_id)
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       bq_gp_id AS gp_id,
       bq_ekorg AS einkaufsorganisation_id,
       bq_findung_id,
       ref_wup_id,
       dat AS dat_von,
       '9999-12-31' AS dat_bis,
       bezugsweg_id
FROM _kmo_art_gp_wup_zu_3x;

INSERT INTO _art_gp_nm_zu_per_tmp (mandant_id,
                                   art_id,
                                   wup_id,
                                   nb_id,
                                   gp_id,
                                   einkaufsorganisation_id,
                                   bq_findung_id,
                                   vz_wup_id,
                                   dat_von,
                                   dat_bis,
                                   bezugsweg_id)
SELECT z.mandant_id,
       z.art_id,
       z.wup_id,
       z.nb_id,
       z.gp_id,
       z.einkaufsorganisation_id,
       COALESCE(z.bq_findung_id, -1),
       COALESCE(z.vz_wup_id    , -1),
       a.dat+1 AS dat_von_,
       '9999-12-31' AS dat_bis_,
       z.bezugsweg_id
FROM _kmo_art_gp_wup_zu_3x a
JOIN dbp_data.art_gp_nm_zu_per_1 z 
  ON a.mandant_id  = z.mandant_id AND 
     a.wup_id   = z.wup_id   AND 
     a.art_id   = z.art_id   AND 
     a.dat      >= z.dat_von AND 
     a.dat      < z.dat_bis  AND
     z.dat_bis  < '9999-12-31' AND 
    (a.bq_gp_id      <> z.gp_id OR                           
     a.bq_findung_id <> COALESCE(z.bq_findung_id, -1) OR     
     a.ref_wup_id    <> COALESCE(z.vz_wup_id, -1) OR         
     a.bezugsweg_id <> z.bezugsweg_id) 
WHERE  z.mandant_id = 1 AND
      (z.mandant_id, z.art_id, z.wup_id, dat_von_) NOT IN (SELECT mandant_id,
                                                                  art_id,
                                                                  wup_id,
                                                                  dat_von
                                                           FROM _art_gp_nm_zu_per_tmp)
GROUP BY z.mandant_id,z.wup_id,z.nb_id,z.art_id,z.gp_id,z.einkaufsorganisation_id,COALESCE(z.bq_findung_id, -1),COALESCE(z.vz_wup_id    , -1),dat_von_,dat_bis_,z.bezugsweg_id;

INSERT INTO _art_gp_nm_zu_per_tmp2 (mandant_id,
                                    art_id,
                                    wup_id,
                                    nb_id,
                                    gp_id,
                                    einkaufsorganisation_id,
                                    bq_findung_id,
                                    vz_wup_id,
                                    dat_von,
                                    dat_bis,
                                    bezugsweg_id)
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       gp_id,
       einkaufsorganisation_id,
       bq_findung_id,
       vz_wup_id,
       dat_von,
       dat_bis,
       bezugsweg_id
FROM (SELECT mandant_id,
             art_id,
             wup_id,
             nb_id,
             gp_id,
             einkaufsorganisation_id,
             bq_findung_id,
             vz_wup_id,
             dat_von,
             dat_bis,
             bezugsweg_id,
             -- Alle Datensätze markieren, die entweder keinen Wechsel haben, weil
             -- kein Vorgänger da ist, oder die einen Lieferantenwechsel im Vergleich
             -- zum Vorgänger aufweisen.
             --MDIFF(x, w, y) is equivalent to:  x - SUM(x) OVER (ORDER BY y ROWS BETWEEN w PRECEDING AND w PRECEDING)
             COALESCE( (gp_id - sum(gp_id) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS gp_wechsel_fg,
             --COALESCE(MDIFF(gp_id, 1, dat_von ASC), 1) AS gp_wechsel_fg,
             COALESCE( (bq_findung_id - sum(bq_findung_id) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS bq_findung_wechsel_fg,  
             --COALESCE(MDIFF(bq_findung_id, 1, dat_von ASC), 1) AS bq_findung_wechsel_fg,
              COALESCE( (vz_wup_id - sum(vz_wup_id) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS vz_wup_wechsel_fg,
             --COALESCE(MDIFF(vz_wup_id, 1, dat_von ASC), 1) AS vz_wup_wechsel_fg,
              COALESCE( (bezugsweg_id - sum(bezugsweg_id) over (partition by mandant_id,art_id,wup_id order by dat_von asc rows between 1 preceding and 1 preceding)), 1) AS bezugsweg_wechsel_fg
             --COALESCE(MDIFF(bezugsweg_id, 1, dat_von ASC), 1) AS bezugsweg_wechsel_fg
      FROM _art_gp_nm_zu_per_tmp
      /*GROUP BY mandant_id,art_id,wup_id*/) a
-- Nur die Datensätze sind relevant, die einen Wechsel
-- bei Lieferung, Ausstiegspunkt, Liefer VZ aufweisen
WHERE gp_wechsel_fg <> 0 OR 
      bq_findung_wechsel_fg <> 0 OR 
      vz_wup_wechsel_fg <> 0 OR
      bezugsweg_wechsel_fg <> 0;

UPDATE _art_gp_nm_zu_per_tmp2 SET dat_bis = dt1.dat_bis_

FROM (SELECT mandant_id,
             wup_id,
             art_id,
             dat_von,                                          
             CASE
	       WHEN (SUM(to_number(to_char(dat_von,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,wup_id,art_id ORDER BY dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD'))) = 0 
               THEN to_date('9999-12-31','YYYY-MM_1-DD')
	       ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(dat_von,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,wup_id,art_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
             END AS dat_bis_                            
      FROM _art_gp_nm_zu_per_tmp2
      GROUP BY 1,2,3,4) dt1

WHERE _art_gp_nm_zu_per_tmp2.mandant_id = dt1.mandant_id AND 
      _art_gp_nm_zu_per_tmp2.wup_id     = dt1.wup_id     AND 
      _art_gp_nm_zu_per_tmp2.art_id     = dt1.art_id     AND 
      _art_gp_nm_zu_per_tmp2.dat_von    = dt1.dat_von    AND 
      _art_gp_nm_zu_per_tmp2.dat_bis   <> dt1.dat_bis_
;

create or replace volatile table _track_existence as (
select mandant_id,
       wup_id,
       art_id
from dbp_data.art_gp_nm_zu_per_1
where mandant_id = 1
group by 1,2,3
);

update _art_gp_nm_zu_per_tmp2 set dat_von = dat_von-1
where (mandant_id,wup_id,art_id) not in (select mandant_id,wup_id,art_id from _track_existence)
;

-- 22.09.2023, -dba-
--
-- Duplikate, die durch Fehlinformationen in der EINA_1/EINE_1-Kombination
-- entstehen, werden hier bereinigt.

create or replace volatile table _agpn as (
select mandant_id,
       art_id,
       wup_id,
       nb_id,
       min(gp_id) as gp_id,
       einkaufsorganisation_id,
       bq_findung_id,
       vz_wup_id,
       dat_von,
       dat_bis,
       bezugsweg_id,
       current_timestamp as td_insert,
       current_timestamp as td_update   
from _art_gp_nm_zu_per_tmp2
group by 1,2,3,4,6,7,8,9,10,11
);

create or replace volatile table _days as (
select dat
from dbp_data.tag_1
where dat between current_date-30 and current_date
);

create or replace volatile table _dups_agpn as (
select x.mandant_id,
       x.wup_id,
       x.art_id,
       x.max_dat_bis,
       x.min_gp_id,
       x.max_gp_id
from (select dat,
             mandant_id,
             wup_id,
             art_id,
             min(gp_id) as min_gp_id,
             max(gp_id) as max_gp_id,
             max(dat_bis) as max_dat_bis
      from _agpn a
      join _days b
        on 1 = 1
      where dat between dat_von and dat_bis
      group by 1,2,3,4
      having count(*) > 1) x
group by 1,2,3,4,5,6
);

select count(*)
from _dups_agpn
;

delete from _agpn
where (mandant_id,wup_id,art_id,dat_bis,gp_id) in (select mandant_id,wup_id,art_id,max_dat_bis,min_gp_id from _dups_agpn)
;

delete from dbp_data.art_gp_nm_zu_per_1 a
where (mandant_id, wup_id, art_id) in (select mandant_id,
                                              wup_id,
                                              art_id
                                       from _kmo_art_gp_wup_zu_3x)
;

insert into dbp_data.art_gp_nm_zu_per_1 (mandant_id,
                                        art_id,
                                        wup_id,
                                        nb_id,
                                        gp_id,
                                        einkaufsorganisation_id,
                                        bq_findung_id,
                                        vz_wup_id,
                                        dat_von,
                                        dat_bis,
                                        bezugsweg_id,
                                        td_insert,
                                        td_update)
select mandant_id,
       art_id,
       wup_id,
       nb_id,
       gp_id,
       einkaufsorganisation_id,
       bq_findung_id,
       vz_wup_id,
       dat_von,
       dat_bis,
       bezugsweg_id,
       current_timestamp as td_insert,
       current_timestamp as td_update   
from _agpn
group by 1,2,3,4,5,6,7,8,9,10,11
;

UPDATE dbp_etl_process.metadata_kmo_bq_findung_1 SET ende = CURRENT_TIMESTAMP
WHERE ende IS NULL;

