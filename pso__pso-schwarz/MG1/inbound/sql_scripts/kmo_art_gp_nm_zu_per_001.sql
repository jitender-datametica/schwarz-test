SELECT dat_relevant
FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant;

DELETE FROM DBP_ETL_PROCESS.metadata_kmo_bq_findung
WHERE ende IS NULL;

INSERT INTO DBP_ETL_PROCESS.metadata_kmo_bq_findung (snapshot_datum,
                                                  verdat,
                                                  beginn)
SELECT dat_relevant AS snapshot_datum,
       CURRENT_DATE AS verdat,
       CURRENT_TIMESTAMP AS beginn
FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant;

CREATE  VOLATILE TABLE _zwischen_tabelle (
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
  kreistyp_gruppe_id CHAR(4)
) ;


CREATE  VOLATILE TABLE _kmo_art_gp_wup_zu_2 (
mandant_id         BYTEINT NOT NULL,
art_id             INTEGER NOT NULL,
wup_id             INTEGER NOT NULL,
nb_id              SMALLINT NOT NULL,
dat                DATE NOT NULL,
bezugsweg_id       BYTEINT,
anz_ek_infosatz    SMALLINT,   -- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
bq_gp_id           INTEGER,    -- GP nach Bezugsquellenfindung
bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
regel_gp_id        INTEGER,    -- Regel GP aus Einkaufsinfosatz
regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
ref_wup_id         INTEGER,    -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD
ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD
kreistyp_gruppe_id CHAR(4) COLLATE 'en-ci', -- Kreistyp_gruppe aus Marktstamm.
wg_id              SMALLINT    -- Warengruppe für Zugriff auf vz_wup_wg_zu_per
) ;


CREATE  VOLATILE TABLE _kmo_art_gp_wup_zu_3 (
mandant_id         BYTEINT NOT NULL,
art_id             INTEGER NOT NULL,
wup_id             INTEGER NOT NULL,
nb_id              SMALLINT NOT NULL,
dat                DATE NOT NULL,
bezugsweg_id       BYTEINT,
anz_ek_infosatz    SMALLINT,   -- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
bq_gp_id           INTEGER,    -- GP nach Bezugsquellenfindung
bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
regel_gp_id        INTEGER,    -- Regel GP aus Einkaufsinfosatz
regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
ref_wup_id         INTEGER,    -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD
ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD
kreistyp_gruppe_id CHAR(4) COLLATE 'de-ci', -- Kreistyp_gruppe aus Marktstamm.
wg_id              SMALLINT    -- Warengruppe für Zugriff auf vz_wup_wg_zu_per
) ;

CREATE  VOLATILE TABLE _art_gp_wup_zu_per AS (
SELECT mandant_id,
       art_id,
       gp_id,
       wup_id,
       nb_id,
       einkaufsorganisation_id,
       dat_von,
       dat_bis
FROM DBP_DATA.art_gp_wup_zu_per
WHERE dat_bis >= (SELECT dat_relevant
                  FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant) AND
      mandant_id > 1
);

CREATE  VOLATILE TABLE _vz_wg_wup_zu_per AS (
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
FROM DBP_DATA.vz_wg_wup_zu_per v
INNER JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant d
  ON 1 = 1
-- Kreistyp ist nicht immer gefuellt.
LEFT OUTER JOIN DBP_DATA.l_kreistyp k
  ON v.mandant_id = k.mandant_id AND 
     v.kreistyp_id = k.kreistyp_id
-- Polnischen Dummy Kreistyp Z ignorieren
WHERE (CASE WHEN v.mandant_id = 3 AND v.kreistyp_id = 'Z' THEN 0 ELSE 1 END) = 1 AND
       d.dat_relevant BETWEEN v.dat_von AND v.dat_bis
);

CREATE  VOLATILE TABLE _kmo_art_gp_wup_oh_bzw (
mandant_id         BYTEINT NOT NULL,
art_id             INTEGER NOT NULL,
wup_id             INTEGER NOT NULL,
nb_id              SMALLINT NOT NULL,
dat                DATE NOT NULL,
bezugsweg_id       BYTEINT,
anz_ek_infosatz    SMALLINT,   -- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
anz_ek_orderbuch   SMALLINT,   -- Anzahl Orderbuch gepflegt
bq_gp_id           INTEGER,    -- GP nach Bezugsquellenfindung
bq_ekorg           SMALLINT,   -- Ekorg nach Bezugsquellenfindung
bq_findung_id      BYTEINT,    -- Ausstiegspunkt der Bezugsquellenfindung
regel_gp_id        INTEGER,    -- Regel GP aus Einkaufsinfosatz
regel_ekorg        SMALLINT,   -- Regel Ekorg aus Einkaufsinfosatz
ref_wup_id         INTEGER,    -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD
ref_nb_id          SMALLINT,   -- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA und EORD
kreistyp_gruppe_id CHAR(4) COLLATE 'en-ci', -- Kreistyp_gruppe aus Marktstamm.
wg_id              SMALLINT    -- Warengruppe für Zugriff auf vz_wup_wg_zu_per
) ;


CREATE  VOLATILE TABLE _art_gp_nm_zu_per_tmp (
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

CREATE  VOLATILE TABLE _art_gp_nm_zu_per_tmp2 (
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

CREATE  VOLATILE TABLE _kmo_art_gp_wup_zu_3x (
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
kreistyp_gruppe_id     CHAR(4),
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
FROM (SELECT *
      FROM DBP_DATA.art
      WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
            mandant_id > 1) a
JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant x
  ON 1 = 1
JOIN DBP_DATA.wup b
  ON a.mandant_id = b.mandant_id
JOIN (SELECT *
      FROM DBP_DATA.art_wg_zu_per
      WHERE mandant_id > 1 AND
           (SELECT dat_relevant
            FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant) BETWEEN dat_von AND dat_bis) c
  ON a.mandant_id    = c.mandant_id AND
     a.art_id        = c.art_id     AND 
     c.arthiertyp_id = 2
LEFT JOIN DBP_DATA.art_wup_status_per d
  ON a.mandant_id = d.mandant_id AND 
     a.art_id = d.art_id AND 
     b.wup_id = d.wup_id AND
     (SELECT dat_relevant
       FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant) BETWEEN d.dat_von AND d.dat_bis
WHERE b.mandant_id > 1 AND
      b.wup_id <> 0;


CREATE or replace  VOLATILE TABLE _kmo_ek_infosatz AS (
SELECT e.mandant_id
      ,e.art_id
      ,d.dat_relevant AS dat
      ,ek.wup_id
      ,ek.nb_id
      ,COUNT(e.mandant_id) AS anz_ek_infosatz     /*1:n gültige Infosaetze??*/
      ,MAX(e.gp_id)AS bq_gp_id                    /*falls 1:1, dann dieser Lieferant*/
      ,MAX(e.einkaufsorganisation_id) AS bq_ekorg /*falls 1:1, dann dieser Lieferant*/
      ,MAX(CASE WHEN regel_gp_fg = 1 THEN e.gp_id ELSE 0 END) AS regel_gp_id /*lt. FB gibt es nur einen Regellieferant*/
      ,MAX(CASE WHEN regel_gp_fg = 1 THEN e.einkaufsorganisation_id ELSE 0 END) AS regel_ekorg
      ,1 AS ek_infosatz_art                       /*Kennzeichen Zaehlen aktive Infosaetze inkl. Regel GP*/
      ,CAST(NULL AS BIGINT) AS ek_infosatz_id 
      ,CAST(NULL AS /*INTEGER*/DATE) AS dat_erstellung
FROM DBP_DATA.ek_infosatz e
JOIN DBP_DATA.ek_infosatz_wup_zu ek
  ON e.mandant_id = ek.mandant_id AND 
     e.ek_infosatz_id = ek.ek_infosatz_id AND 
     ek.loesch_fg = 0  /*Ekorg Erweiterung muss auch gueltig sein*/
JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant d
  ON 1 = 1
WHERE e.mandant_id > 1 AND 
      e.loesch_fg  = 0 AND 
     (e.art_id, d.dat_relevant) IN (SELECT art_id,
                                           dat
                                    FROM _zwischen_tabelle) AND
      d.dat_relevant BETWEEN e.dat_von AND e.dat_bis AND
      d.dat_relevant >= e.dat_erstellung
GROUP BY 1,2,3,4,5,11
);

--select get_ddl('table','_kmo_ek_infosatz') 

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
SELECT e.mandant_id
      ,e.art_id
      ,d.dat_relevant AS dat
      ,ek.wup_id
      ,ek.nb_id
      ,1 AS anz_ek_infosatz
      ,e.gp_id AS bq_gp_id
      ,e.einkaufsorganisation_id AS bq_ekorg
      ,0 AS regel_gp_id
      ,0 AS regel_ekorg
      ,2 AS ek_infosatz_art /*Kennzeichen hoechster inaktiver Infosatz*/
      ,e.ek_infosatz_id
      ,e.dat_erstellung
FROM DBP_DATA.ek_infosatz e
JOIN DBP_DATA.ek_infosatz_wup_zu ek
  ON e.mandant_id = ek.mandant_id AND 
     e.ek_infosatz_id = ek.ek_infosatz_id
-- Definition inaktiv:
-- EINA und/oder EINE Loschkennzeichen gesetzt
-- UND/ODER Gültigkeitszeitraum EINA nicht am Stichtag gültig
-- UND es werden nur die Infosätze berücksichtigt die zum
-- Stichtag bereits angelegt waren
JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant d
  ON e.dat_erstellung <= d.dat_relevant AND 
    (e.loesch_fg = 1  OR 
     ek.loesch_fg = 1 OR 
     d.dat_relevant < e.dat_von OR 
     d.dat_relevant > e.dat_bis)
WHERE e.mandant_id > 1
AND (e.art_id, d.dat_relevant) IN (SELECT art_id,
                                          dat
                                   FROM _zwischen_tabelle)
/*
GROUP BY e.mandant_id,e.art_id,ek.wup_id,ek.nb_id
QUALIFY CSUM(1, e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1;
*/                                   
QUALIFY  row_number() OVER (PARTITION BY  e.mandant_id,e.art_id,ek.wup_id,ek.nb_id  order by  e.ek_infosatz_id DESC, e.dat_erstellung DESC  ) = 1;                                   
                                   


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
SELECT e.mandant_id
      ,e.art_id
      ,d.dat_relevant AS dat
      ,ek.wup_id
      ,ek.nb_id
      ,1 AS anz_ek_infosatz
      ,e.gp_id AS bq_gp_id
      ,e.einkaufsorganisation_id AS bq_ekorg
      ,0 AS regel_gp_id
      ,0 AS regel_ekorg
      ,3 AS ek_infosatz_art /*Kennzeichen hoechster inaktiver Infosatz*/
      ,e.ek_infosatz_id
      ,e.dat_erstellung
FROM DBP_DATA.ek_infosatz e
JOIN DBP_DATA.ek_infosatz_wup_zu ek
  ON e.mandant_id = ek.mandant_id AND 
     e.ek_infosatz_id = ek.ek_infosatz_id
-- Definition aktiv:
-- EINA und EINE Loschkennzeichen nicht gesetzt
-- UND/ODER Gültigkeitszeitraum EINA am Stichtag gültig
-- UND es werden nur die Infosätze berücksichtigt die zum
-- Stichtag bereits angelegt waren
JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant d
  ON d.dat_relevant BETWEEN e.dat_von AND e.dat_bis AND 
     d.dat_relevant >= e.dat_erstellung
WHERE e.mandant_id > 1 AND 
      e.loesch_fg  = 0 AND 
      ek.loesch_fg = 0 AND 
     (e.art_id, d.dat_relevant) IN (SELECT art_id,
                                           dat
                                    FROM _zwischen_tabelle)
/*GROUP BY e.mandant_id,e.art_id,dat,ek.wup_id,ek.nb_id,e.gp_id,e.einkaufsorganisation_id
QUALIFY CSUM(1, e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1;*/
QUALIFY  row_number() OVER (PARTITION BY  e.mandant_id,e.art_id,dat,ek.wup_id,ek.nb_id,e.gp_id,e.einkaufsorganisation_id   order by e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1;

CREATE  VOLATILE TABLE _kmo_art_kreistyp_gruppe AS (
SELECT a.art_id,
       a.mandant_id,
       a.kreistyp_id,
       TRIM(a.kreistyp_gruppe_id) kreistyp_gruppe_id,
       d.dat_relevant AS dat,
       k.vz_prio_id
FROM DBP_DATA.art_kreistyp_gruppe_zu_per a
JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant d
  ON 1 = 1
LEFT JOIN DBP_DATA.l_kreistyp k
  ON a.mandant_id  = k.mandant_id AND 
     a.kreistyp_id = k.kreistyp_id
WHERE a.kreistyp_id <> 'Z' AND 
      a.mandant_id > 1 AND
      d.dat_relevant BETWEEN a.dat_von AND a.dat_bis
);

UPDATE _zwischen_tabelle SET bezugsweg_id = 4
WHERE nb_id = -111 AND 
      bezugsweg_id NOT IN (1,4)
;

MERGE INTO _zwischen_tabelle a
USING (SELECT aws.mandant_id,
              aws.art_id,
              x.dat_relevant AS dat,
              MAX(aws.bezugsweg_id) AS bezugsweg_id_
       FROM (SELECT mandant_id,
                    art_id,
                    dat_von,
                    dat_bis,
                    bezugsweg_id
             FROM DBP_DATA.art_wup_status_per a
             JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant d
               ON 1 = 1
             WHERE (a.art_id) IN (SELECT art_id
                                  FROM _zwischen_tabelle
                                  WHERE bezugsweg_id NOT IN (1,4)) AND 
                    a.mandant_id > 1 AND 
                    a.bezugsweg_id IN (1,4) AND
                    a.dat_bis >= d.dat_relevant) aws
       JOIN DBP_ETL.art_gp_nm_zu_per_dat_relevant x
         ON 1 = 1
       WHERE x.dat_relevant BETWEEN aws.dat_von AND aws.dat_bis
       GROUP BY 1,2,3) b

  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.dat        = b.dat        AND
     a.bezugsweg_id NOT IN (1,4)
     
WHEN MATCHED THEN UPDATE SET bezugsweg_id = b.bezugsweg_id_;


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
       0 AS bq_findung_id /*keine BQ Findung moeglich*/,
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
             bezugsweg_id,
             COALESCE(ak.kreistyp_id, akk.kreistyp_id) AS kreistyp_id_,
             CASE 
               WHEN TRIM(agw.kreistyp_gruppe_id) = ''
               THEN -1
               ELSE COALESCE(ak.vz_prio_id, akk.vz_prio_id, -1)
             END AS vz_prio_id_,
             COALESCE(wwwg.vz_wup_id, wwup.vz_wup_id, vzwg.vz_wup_id, vzwup.vz_wup_id) AS vz_wup_id_,
             -111 AS vz_nb_id_  /*Bezugsweg 4 immer VZ*/,
             agw.kreistyp_gruppe_id,
             wg_id
      FROM _zwischen_tabelle agw
      
      /*Zugriff auf Artikel Kreistyp Zuordnung mit Region aus Markt*/
      LEFT JOIN _kmo_art_kreistyp_gruppe ak
        ON agw.mandant_id = ak.mandant_id AND 
           agw.art_id = ak.art_id         AND 
           agw.kreistyp_gruppe_id = ak.kreistyp_gruppe_id AND 
           agw.dat = ak.dat
           
      /*Zugriff ohne Region (Kreisgruppe)*/
      LEFT JOIN _kmo_art_kreistyp_gruppe akk
        ON agw.mandant_id = akk.mandant_id AND 
           agw.art_id = akk.art_id         AND 
           TRIM(akk.kreistyp_gruppe_id) = '' AND 
           agw.dat = akk.dat
           
      /*Zugriff mit Kreistyp auf VZ Zuordnung auf Markt - Warengruppenebene*/
      LEFT JOIN _vz_wg_wup_zu_per wwwg
        ON agw.mandant_id = wwwg.mandant_id  AND 
           agw.wup_id = wwwg.wup_id          AND 
           agw.nb_id = wwwg.nb_id            AND 
           agw.wg_id = wwwg.wg_hierarchie_id AND 
           wwwg.arthiertyp_id = 6            AND -- zweistufige SAP Warengruppenhierarchie
           wwwg.wg_hierarchie_ebene_id = 4   AND -- Hierarchiestufe Warengruppe
           wwwg.kreistyp_id = /*kreistyp_id_*/COALESCE(ak.kreistyp_id, akk.kreistyp_id)   AND -- hier Zugriff mit kreistyp auf WRF3
           agw.dat = wwwg.dat
           
      /*Zugriff mit Kreistyp auf VZ Zuordnung auf Marktebene*/
      LEFT JOIN _vz_wg_wup_zu_per wwup
        ON agw.mandant_id = wwup.mandant_id AND 
           agw.wup_id = wwup.wup_id         AND 
           agw.nb_id = wwup.nb_id           AND 
           wwup.kreistyp_id = /*kreistyp_id_*/ COALESCE(ak.kreistyp_id, akk.kreistyp_id)  AND -- hier Zugriff mit kreistyp auf WRF3
           wwup.wg_hierarchie_id = -1       AND -- ohne WG Bezug
           agw.dat = wwup.dat
           
      /*Zugriff ohne Kreistyp mit nöchstniedrigerer Proritaet auf VZ Zuordnung auf Markt - Warengruppenebene*/
      LEFT JOIN _vz_wg_wup_zu_per vzwg
        ON agw.mandant_id = vzwg.mandant_id  AND 
           agw.wup_id = vzwg.wup_id          AND 
           agw.nb_id = vzwg.nb_id            AND 
           agw.wg_id = vzwg.wg_hierarchie_id AND 
           vzwg.arthiertyp_id = 6            AND -- zweistufige SAP Warengruppenhierarchie
           vzwg.wg_hierarchie_ebene_id = 4   AND -- Hierarchiestufe Warengruppe
      -- Wenn oben nichts gefunden wurde oder kreistyp_region_id = leer
      -- dann ist der naechstpassende Eintrag besser als keiner
           vzwg.zek_kreis_vz_prio_id > /*vz_prio_id_*/ 
           CASE 
               WHEN TRIM(agw.kreistyp_gruppe_id) = ''
               THEN -1
               ELSE COALESCE(ak.vz_prio_id, akk.vz_prio_id, -1)
             END AND 
           agw.dat = vzwg.dat
           
      /*Zugriff ohne Kreistyp mit nöchstniedrigerer Proritaet auf VZ Zuordnung auf Marktebene*/
      LEFT JOIN _vz_wg_wup_zu_per vzwup
        ON agw.mandant_id = vzwup.mandant_id AND 
           agw.wup_id = vzwup.wup_id         AND 
           agw.nb_id = vzwup.nb_id           AND
      -- Wenn oben nichts gefunden wurde oder kreistyp_region_id = leer
      -- dann ist naechstpassende Eintrag besser als keiner
           vzwup.zek_kreis_vz_prio_id > /*vz_prio_id_*/ 
             CASE 
               WHEN TRIM(agw.kreistyp_gruppe_id) = ''
               THEN -1
               ELSE COALESCE(ak.vz_prio_id, akk.vz_prio_id, -1)
             END AND
           vzwup.wg_hierarchie_id = -1  AND -- ohne WG Bezug
           agw.dat = vzwup.dat
           
      WHERE agw.bezugsweg_id = 4 AND 
            agw.mandant_id IN (2,3,4,7) AND
            agw.nb_id <> -111
      /*GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat
       Folgende Zugriffsreihenfolge:
      - Zugriff mit Region, Kreistyp, Warengruppe und Markt
      - Zugriff mit Region, Kreistyp und Markt ohne Warengruppe
      - Zugriff ohne Region und ohne Kreistyp mit Warengruppe und mit Markt
      - Zugriff ohne Region und ohne Kreistyp und ohne Warengruppe und mit Markt */
      /*QUALIFY CSUM (1,
      COALESCE(wwwg.zek_kreis_vz_prio_id, wwup.zek_kreis_vz_prio_id) ASC,
      COALESCE(vzwg.zek_kreis_vz_prio_id, vzwup.zek_kreis_vz_prio_id) ASC,
      COALESCE(vzwg.vz_prio_id, vzwup.vz_prio_id) ASC) = 1) a;*/
      QUALIFY  row_number() OVER (PARTITION BY  agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat
                                    order by COALESCE(wwwg.zek_kreis_vz_prio_id, wwup.zek_kreis_vz_prio_id) asc,
                                  COALESCE(vzwg.zek_kreis_vz_prio_id, vzwup.zek_kreis_vz_prio_id) asc,
                                  COALESCE(vzwg.vz_prio_id, vzwup.vz_prio_id) asc) = 1) a;


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
       '' AS kreistyp_gruppe_id,
       a.wg_id
FROM (SELECT agw.mandant_id,
             agw.art_id,
             agw.wup_id,
             agw.nb_id,
             agw.dat,
             agw.bezugsweg_id,
             agw.wg_id,
             COALESCE(e.vz_wup_id, wwwg.vz_wup_id, wwup.vz_wup_id) AS vz_wup_id_,
             -111 AS vz_nb_id_
      FROM (SELECT *
            FROM _zwischen_tabelle
            WHERE nb_id <> -111) agw
      LEFT JOIN DBP_DATA.ek_orderbuch e
        ON agw.mandant_id    = e.mandant_id AND 
           agw.art_id     = e.art_id        AND 
           agw.wup_id     = e.wup_id        AND 
           e.gesperrt_fg  = 0               AND 
           e.vz_wup_id IS NOT NULL          AND 
           agw.dat BETWEEN e.dat_von AND e.dat_bis
      LEFT JOIN _vz_wg_wup_zu_per wwwg
        ON agw.mandant_id = wwwg.mandant_id    AND 
           agw.wup_id  = wwwg.wup_id           AND 
           agw.nb_id   = wwwg.nb_id            AND 
           agw.wg_id   = wwwg.wg_hierarchie_id AND 
           wwwg.arthiertyp_id = 6              AND -- zweistufige SAP Warengruppenhierarchie
           wwwg.wg_hierarchie_ebene_id = 4     AND -- Hierarchiestufe Warengruppe
           agw.dat = wwwg.dat
      /*Zugriff auf VZ Zuordnung auf Marktebene*/
      LEFT JOIN _vz_wg_wup_zu_per wwup
        ON agw.mandant_id = wwup.mandant_id AND 
           agw.wup_id  = wwup.wup_id        AND 
           agw.nb_id   = wwup.nb_id         AND 
           wwup.wg_hierarchie_id = -1       AND -- ohne WG Bezug
           agw.dat = wwup.dat
      WHERE agw.bezugsweg_id = 4 AND 
            agw.mandant_id IN (5,6,8)
      --GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat
      -- Orderbuch mit Kennzeichen fixer Lieferant fuehrend
      -- WRF3 mit Markt/WG Referenz fuerend vor WRF3 mit Markt Referenz
      -- Orderbuch mit Kennzeichen fixer Lieferant fuehrend
      -- WRF3 mit Markt/WG Referenz fuerend vor WRF3 mit Markt Referenz
     /*QUALIFY CSUM(1,
                  COALESCE(fix_gp_fg, 0) DESC,
                  COALESCE(wwwg.wg_hierarchie_id, wwup.wg_hierarchie_id) DESC,
                  COALESCE(wwwg.vz_prio_id, wwup.vz_prio_id) ASC) = 1)*/ 
      QUALIFY  row_number() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat
                                  order by  COALESCE(fix_gp_fg, 0) DESC,
                                            COALESCE(wwwg.wg_hierarchie_id, wwup.wg_hierarchie_id) DESC,
                                            COALESCE(wwwg.vz_prio_id, wwup.vz_prio_id) ASC ) = 1) a;


INSERT INTO _kmo_art_gp_wup_zu_3
SELECT mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat,
       bezugsweg_id,
       anz_ek_infosatz_ /*Wichtig: Anz. Infosaetze aus Coalesce (s.u.)*/,
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
               WHEN anz_ek_infosatz_ = 1 /*es ist ein gueltiger oder mindestens ein ungueltiger Infosatz vorhanden*/
               THEN CASE 
                      WHEN COALESCE(e.mandant_id, eo.mandant_id) IS NOT NULL /*führend gueltige Infosätze*/
                      THEN 1
                      ELSE 3
                    END
               ELSE 0 /*Kein Infosatz oder Anzahl Infosätze > 1*/
             END AS bq_findung_id_,
             COALESCE(e.regel_gp_id, eo.regel_gp_id, 0) AS regel_gp_id_,
             COALESCE(e.regel_ekorg, eo.regel_ekorg, 0) AS regel_ekorg_,
             agw.ref_wup_id,
             agw.ref_nb_id,
             agw.kreistyp_gruppe_id,
             agw.wg_id
      FROM _kmo_art_gp_wup_zu_2 agw
      
      -- 1. Zugriff Ermittlung gültige Infosätze mit VZ/Markt Bezug
      LEFT JOIN _kmo_ek_infosatz e 
        ON agw.mandant_id       = e.mandant_id AND 
           agw.ref_wup_id    = e.wup_id        AND 
           agw.art_id        = e.art_id        AND 
           agw.dat           = e.dat           AND 
           e.ek_infosatz_art = 1 /*Zaehlen aktive Infosaetze mit Regel GP betriebsspezifisch*/
           
      -- 2. Zugriff Ermittlung gültige Infosätze ohne Markt/VZ Referenz
      LEFT JOIN _kmo_ek_infosatz eo 
        ON agw.mandant_id        = eo.mandant_id AND 
           eo.wup_id          = 0                AND 
           agw.art_id         = eo.art_id        AND 
           agw.dat            = eo.dat           AND 
           eo.ek_infosatz_art = 1 /*Zaehlen aktive Infosaetze mit Regel GP betriebsuebergreifend*/
           
      -- 3. Zugriff: Ermittlung des hoechsten inaktiven Infosatzes Zugriff
      --    zuerst mit Marktbezug danach den betriebsuebrgreifenden Eintrag
      --    (fuehrend ist der betriebsspezifische Datensatz, s.o.)
      LEFT JOIN _kmo_ek_infosatz ek 
        ON agw.mandant_id        = ek.mandant_id AND 
           agw.ref_wup_id     = ek.wup_id        AND 
           agw.art_id         = ek.art_id        AND 
           agw.dat            = ek.dat           AND 
           ek.ek_infosatz_art = 2 /*hoechster inaktiver Infosatz betriebsspezifisch*/

      LEFT JOIN _kmo_ek_infosatz ekk 
        ON agw.mandant_id         = ekk.mandant_id AND 
           ekk.wup_id          = 0 AND 
           agw.art_id          = ekk.art_id AND 
           agw.dat             = ekk.dat AND 
           ekk.ek_infosatz_art = 2 /*hoechster inaktiver Infosatz betriebsuebergreifend*/) a;

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT agw.mandant_id,
              agw.art_id,
              agw.wup_id,
              agw.nb_id,
              agw.dat,
              COUNT(e.mandant_id) AS anz_ek_orderbuch,
              MAX(e.gp_id) AS bq_gp_id                    /*Falls Zurordnung Orderbuch eindeutig dann dieseen GP*/,
              MAX(e.einkaufsorganisation_id) AS bq_ekorg  /*Falls Zurordnung Orderbuch eindeutig dann dieseen GP*/,
              MAX(CASE WHEN fix_gp_fg = 1 THEN e.gp_id ELSE 0 END) AS fix_gp_id /*Fixer Lieferant*/,
              MAX(CASE WHEN fix_gp_fg = 1 THEN e.einkaufsorganisation_id ELSE 0 END) AS fix_ekorg /*Fixer Lieferant*/
       FROM _kmo_art_gp_wup_zu_3 agw
       JOIN DBP_DATA.ek_orderbuch e
         ON agw.mandant_id    = e.mandant_id AND 
            agw.art_id     = e.art_id        AND 
            agw.ref_wup_id = e.wup_id        AND 
            e.gesperrt_fg  = 0               AND 
            agw.dat BETWEEN e.dat_von AND e.dat_bis
       WHERE anz_ek_infosatz   > 1 /*1:n Zuordnung Einkaufsinfosatz */ AND 
             agw.bq_findung_id = 0
       GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat) b

  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.anz_ek_infosatz > 1

-- wenn nur ein gueltiger Orderbucheintrag vorhanden ist, GP uebernehmen
-- Sollte ein fixer Lieferant gepflegt sein, so hat dieser Vorrang und
-- die Zuordnung zum Orderbuch wird als eindeutig betrachtet, egal ob
-- mehrere Einträge vorhanden sind
-- (es gibt lt. Aussage von EKSAP nur einen fixen Lieferant pro Zeitpunkt)
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
       JOIN DBP_DATA.ek_orderbuch e
         ON agw.mandant_id    = e.mandant_id AND 
            agw.art_id     = e.art_id        AND 
            agw.ref_wup_id = e.wup_id        AND 
            e.gesperrt_fg  = 0               AND 
            agw.dat BETWEEN e.dat_von AND e.dat_bis
       /*hoechster aktiver Infosatz betriebsspezifisch*/
       LEFT JOIN _kmo_ek_infosatz ek
         ON agw.mandant_id        = ek.mandant_id AND 
            agw.ref_wup_id     = ek.wup_id        AND 
            agw.art_id         = ek.art_id        AND 
            e.gp_id            = ek.bq_gp_id      AND 
            agw.dat            = ek.dat           AND 
            ek.ek_infosatz_art = 3 /*hoechster aktiver Infosatz betriebsspezifisch*/
       /*hoechster aktiver Infosatz betriebsuebergreifend*/
       LEFT JOIN _kmo_ek_infosatz ekk
         ON agw.mandant_id         = ekk.mandant_id AND 
            ekk.wup_id          = 0                 AND 
            agw.art_id          = ekk.art_id        AND 
            e.gp_id             = ekk.bq_gp_id      AND 
            agw.dat             = ekk.dat           AND 
            ekk.ek_infosatz_art = 3 /*hoechster aktiver Infosatz betriebsuebergreifend*/
       WHERE agw.anz_ek_infosatz   > 1  /*1:n Zuordnung Einkaufsinfosatz */ AND 
             agw.anz_ek_orderbuch  > 1  /*1:n Zuordnung Orderbuch im vorigen Schritt ermittelt */ AND 
             agw.bq_findung_id     = 0  /*kein Fixer Lieferant (s.o.) */ AND 
            (ek.mandant_id IS NOT NULL OR ekk.mandant_id IS NOT NULL)
       --GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat                                  
       -- maximale Infosatz ID ermitteln
       --QUALIFY CSUM(1, COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC) = 1) b
         QUALIFY  row_number() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat  order by COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) desc ) = 1) b 
 ON a.mandant_id = b.mandant_id  AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.bq_findung_id = 0
WHEN MATCHED THEN UPDATE SET bq_gp_id      = b.bq_gp_id_, 
                             bq_ekorg      = b.bq_ekorg_, 
                             bq_findung_id = 5;


--select * from _kmo_art_gp_wup_zu_3 where art_id = 97000760 and mandant_id = 3


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
       /*hoechster aktiver Infosatz betriebsspezifisch*/
       LEFT JOIN _kmo_ek_infosatz ek 
         ON agw.mandant_id        = ek.mandant_id AND 
            agw.ref_wup_id     = ek.wup_id        AND 
            agw.art_id         = ek.art_id        AND 
            agw.dat            = ek.dat           AND 
            ek.ek_infosatz_art = 3 /*hoechster aktiver Infosatz betriebsspezifisch*/
       /*hoechster aktiver Infosatz betriebsuebergreifend*/
       LEFT JOIN _kmo_ek_infosatz ekk
         ON agw.mandant_id       = ekk.mandant_id AND 
            ekk.wup_id           = 0              AND 
            agw.art_id          = ekk.art_id      AND 
            agw.dat             = ekk.dat         AND 
            ekk.ek_infosatz_art = 3 /*hoechster aktiver Infosatz betriebsuebergreifend*/
       WHERE agw.anz_ek_infosatz   > 1 AND 
             agw.bq_findung_id     = 0 AND 
             agw.anz_ek_orderbuch <> 1
       --GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat,agw.bezugsweg_id
       /*QUALIFY CSUM(1, COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC
                       , COALESCE(ek.dat_erstellung, ekk.dat_erstellung) DESC) = 1) b*/
       QUALIFY  row_number() OVER (PARTITION BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat,agw.bezugsweg_id  order by COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC
                                                                                                                                , COALESCE(ek.dat_erstellung, ekk.dat_erstellung) DESC ) = 1) b                    
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.dat        = b.dat        AND
     a.anz_ek_infosatz   > 1     AND
     a.bq_findung_id     = 0     AND
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
                                              THEN 5 /*falls oben nicht alle gefunden werden*/
                                            END;


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

UPDATE _kmo_art_gp_wup_zu_3 FROM DBP_DATA.gp g

SET bq_gp_id = g.gp_id,
    bq_ekorg = g.einkaufsorganisation_id

WHERE _kmo_art_gp_wup_zu_3.mandant_id = g.mandant_id AND 
      _kmo_art_gp_wup_zu_3.bq_findung_id = 0         AND 
      g.gp_id = -1;


UPDATE _kmo_art_gp_wup_zu_3 SET bq_findung_id = 25 /*Kennzeichen, dass BQ Findung nicht erfolgreich ist*/
WHERE bq_findung_id = 0;

MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (SELECT a.mandant_id,
              a.wup_id,
              a.nb_id,
              a.art_id,
              a.dat,
              a.bq_findung_id + (CASE 
                                   WHEN agw.mandant_id IS NULL 
                                   THEN 1 
                                   ELSE 0 
                                 END) + /*Wenn ZEKP nicht mit Betrieb/VZ gefunden wird +1*/ (CASE 
                                                                                               WHEN a.bezugsweg_id = 1 
                                                                                               THEN 0 
                                                                                               ELSE 12 
                                                                                             END)      /*Nummernkreis für Bezugsweg 4 um 12 versetzt*/ AS bq_findung_id_
       FROM _kmo_art_gp_wup_zu_3 a
       -- Ermittlung betriebsspezifischer ZEKP Satz mit VZ aus
       -- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1
       LEFT JOIN _art_gp_wup_zu_per agw 
         ON a.mandant_id      = agw.mandant_id AND 
            a.ref_wup_id   = agw.wup_id  /*hier Zugriff mit Wup/VZ aus Kreisprozess !!*/ AND 
            a.ref_nb_id    = agw.nb_id AND 
            a.art_id       = agw.art_id AND 
            a.bq_gp_id     = agw.gp_id AND 
            a.bq_ekorg     = agw.einkaufsorganisation_id AND 
            a.dat          BETWEEN agw.dat_von AND agw.dat_bis
       -- Betrieb = blank für Bezugsweg 1 und 4 beim ersten
       -- Zugriff nichts gefunden wird.
       LEFT JOIN _art_gp_wup_zu_per agww
         ON a.mandant_id      = agww.mandant_id AND 
            agww.wup_id    = -1  /*Betrieb = 'blank'*/ AND 
            a.art_id       = agww.art_id AND 
            a.bq_gp_id     = agww.gp_id AND 
            a.bq_ekorg     = agww.einkaufsorganisation_id AND 
            a.dat          BETWEEN agww.dat_von AND agww.dat_bis
       WHERE a.bq_findung_id <> 25) b
       
 ON a.mandant_id = b.mandant_id AND
    a.wup_id     = b.wup_id     AND
    a.art_id     = b.art_id     AND
    a.dat        = b.dat        AND
    a.bq_findung_id <> 25
    
WHEN MATCHED THEN UPDATE SET bq_findung_id = b.bq_findung_id_;

UPDATE _kmo_art_gp_wup_zu_3 SET bq_findung_id = 27

FROM (-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren
                                  SELECT ein.mandant_id,
                                         ein.art_id,
                                         a.dat_relevant AS dat,
                                         ein.ek_faktor AS zwgs,
                                         COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                                         COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                                  FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant a
                                  JOIN DBP_DATA.art_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
                                    ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                                       ein.loesch_fg = 0 AND 
                                       a.dat_relevant BETWEEN ein.dat_von AND ein.dat_bis
                                  LEFT JOIN DBP_DATA.art_man_spanne_per mep /*optional*/
                                    ON mep.mandant_id = ein.mandant_id AND 
                                       mep.art_id  = ein.art_id AND 
                                       mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                                       mep.loesch_fg = 0 AND 
                                       a.dat_relevant BETWEEN mep.dat_von AND mep.dat_bis
                                  LEFT JOIN DBP_DATA.art_man_spanne_per ekbnk /*optional*/
                                    ON ekbnk.mandant_id = ein.mandant_id AND 
                                       ekbnk.art_id  = ein.art_id AND 
                                       ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                                       ekbnk.loesch_fg = 0 AND 
                                       a.dat_relevant BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
                                  WHERE ein.mandant_id > 1) b

WHERE _kmo_art_gp_wup_zu_3.mandant_id = b.mandant_id AND
      _kmo_art_gp_wup_zu_3.art_id     = b.art_id     AND
      _kmo_art_gp_wup_zu_3.dat        = b.dat;


MERGE INTO _kmo_art_gp_wup_zu_3 a
USING (-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren
       SELECT ein.mandant_id,
              ein.wup_id,
              ein.art_id,
              a.dat_relevant AS dat,
              ein.ek_faktor AS zwgs,
              COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
              COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
       FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant a
       JOIN DBP_DATA.art_wup_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
         ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
            ein.loesch_fg = 0 AND 
            a.dat_relevant BETWEEN ein.dat_von AND ein.dat_bis
       LEFT JOIN DBP_DATA.art_wup_man_spanne_per mep /*optional*/
         ON mep.mandant_id = ein.mandant_id AND 
            mep.wup_id  = ein.wup_id AND 
            mep.art_id  = ein.art_id AND 
            mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
            mep.loesch_fg = 0 AND 
            a.dat_relevant BETWEEN mep.dat_von AND mep.dat_bis
       LEFT JOIN DBP_DATA.art_wup_man_spanne_per ekbnk /*optional*/
         ON ekbnk.mandant_id = ein.mandant_id AND 
            ekbnk.wup_id  = ein.wup_id AND 
            ekbnk.art_id  = ein.art_id AND 
            ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
            ekbnk.loesch_fg = 0 AND 
            a.dat_relevant BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
       WHERE ein.mandant_id > 1) b
       
  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.art_id     = b.art_id     AND
     a.dat        = b.dat
     
WHEN MATCHED THEN UPDATE SET bq_findung_id = 26;


UPDATE _kmo_art_gp_wup_zu_3 SET bq_findung_id = 2,
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

CREATE VOLATILE TABLE _snapshot_art_gp AS (
SELECT a.*
FROM dbp_data.art_gp_nm_zu_per a
JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant b
  ON a.dat_bis >= b.dat_relevant
WHERE a.mandant_id > 1
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
       to_date('99991231','YYYYMMDD') AS dat_bis, /*dat_bis wird spaeter neu geschnitten*/
       bezugsweg_id 
FROM DBP_DATA.art_gp_nm_zu_per
WHERE (mandant_id, wup_id, art_id) IN (SELECT mandant_id,
                                              wup_id,
                                              art_id
                                       FROM _kmo_art_gp_wup_zu_3x) AND
      /*nur die Historie, die nicht neu kommt uebernehmen*/ 
      (mandant_id, wup_id, art_id, dat_von) NOT IN (SELECT mandant_id,
                                                           wup_id,
                                                           art_id,
                                                           dat
                                                    FROM _kmo_art_gp_wup_zu_3x) AND
       mandant_id > 1;


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
       to_date('99991231','YYYYMMDD')  AS dat_bis,
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
       to_date('99991231','YYYYMMDD')  AS dat_bis_,
       z.bezugsweg_id
FROM _kmo_art_gp_wup_zu_3x a
JOIN DBP_DATA.art_gp_nm_zu_per z 
  ON a.mandant_id  = z.mandant_id AND 
     a.wup_id   = z.wup_id   AND 
     a.art_id   = z.art_id   AND 
     a.dat      >= z.dat_von AND /*innerhalb eines bestehenden Zeitraums*/
     a.dat      < z.dat_bis  AND
     z.dat_bis  < to_date('99991231','YYYYMMDD')    AND /*letzten Datesatz nicht einfuegen, dieser wird ersetzt*/
    (a.bq_gp_id      <> z.gp_id OR                           /*geaenderter Lieferant */
     a.bq_findung_id <> COALESCE(z.bq_findung_id, -1) OR     /*geaenderter Ausstiegspunkt */
     a.ref_wup_id    <> COALESCE(z.vz_wup_id, -1) OR         /*geaendertes Liefer VZ  */
     a.bezugsweg_id <> z.bezugsweg_id) 
WHERE z.mandant_id > 1 AND
     (z.mandant_id, z.art_id, z.wup_id, dat_von_) NOT IN (SELECT mandant_id,
                                                                  art_id,
                                                                  wup_id,
                                                                  dat_von
                                                           FROM _art_gp_nm_zu_per_tmp)
-- Falls mehrere neue Zuordnungen in ein bestehendes Intervall fallen
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
               THEN to_date('9999-12-31','YYYY-MM-DD')
	       ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(dat_von,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,wup_id,art_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
             END AS dat_bis_                            
      FROM _art_gp_nm_zu_per_tmp2
      GROUP BY 1,2,3,4) dt1

WHERE _art_gp_nm_zu_per_tmp2.mandant_id = dt1.mandant_id AND 
      _art_gp_nm_zu_per_tmp2.wup_id     = dt1.wup_id     AND 
      _art_gp_nm_zu_per_tmp2.art_id     = dt1.art_id     AND 
      _art_gp_nm_zu_per_tmp2.dat_von    = dt1.dat_von    AND 
      _art_gp_nm_zu_per_tmp2.dat_bis   <> dt1.dat_bis_;

DELETE FROM DBP_DATA.art_gp_nm_zu_per a
WHERE (mandant_id, wup_id, art_id) IN (SELECT mandant_id,
                                              wup_id,
                                              art_id
                                       FROM _kmo_art_gp_wup_zu_3x);

INSERT INTO DBP_DATA.art_gp_nm_zu_per (mandant_id,
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
       bezugsweg_id,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP
FROM _art_gp_nm_zu_per_tmp2;
