CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_art_gp_wup_zu_2 (
  mandant_id            BYTEINT NOT NULL,
  lagerbew_beleg_id     DECIMAL(18,0) NOT NULL,
  lagerbew_beleg_pos_id INTEGER NOT NULL,
  kj                    SMALLINT NOT NULL,
  art_id                INTEGER NOT NULL,
  wup_id                INTEGER NOT NULL,
  nb_id                 SMALLINT NOT NULL,
  dat_buch              DATE NOT NULL,
  anz_ek_infosatz       SMALLINT,
  anz_ek_orderbuch      SMALLINT,
  bq_gp_id              INTEGER,
  bq_ekorg              SMALLINT,
  bq_findung_id         BYTEINT,
  regel_gp_id           INTEGER,
  regel_ekorg           SMALLINT
);

INSERT INTO DBP_ETL.kmo_mseg_art_gp_wup_zu_2
(
 mandant_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,kj
,wup_id
,nb_id
,art_id
,dat_buch
,anz_ek_infosatz
,anz_ek_orderbuch
,bq_gp_id
,bq_ekorg
,bq_findung_id
,regel_gp_id
,regel_ekorg
)
SELECT
 a.mandant_id
,a.lagerbew_beleg_id
,a.lagerbew_beleg_pos_id
,a.kj
,CASE WHEN a.nb_id = -111   THEN a.wup_id
      ELSE w.wup_id END 	AS wup_id_
,-111 AS nb_id_
,a.art_id
,a.dat_buch
,0 AS anz_ek_infosatz
,0 AS anz_ek_orderbuch
,0 AS bq_gp_id
,0 AS bq_ekorg
,0 AS bq_findung_id
,0 AS regel_gp_id
,0 AS regel_ekorg
FROM DBP_DATA.lagerbew_det_delta_2 a

JOIN DBP_DATA.wup_2 w
  ON a.mandant_id 	= w.mandant_id
 AND a.empfaenger_id 	= w.wup_id

WHERE (a.nb_id = -111 OR w.nb_id = -111) 
  AND a.mandant_id > 1
  AND a.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
  AND (a.mandant_id, a.lagerbew_beleg_id, a.lagerbew_beleg_pos_id, a.kj) NOT IN
	(SELECT
		 mandant_id
		,lagerbew_beleg_id
		,lagerbew_beleg_pos_id
		,kj
	FROM DBP_ETL.kmo_mseg_art_gp_wup_zu_2
        )
;

DROP TABLE IF EXISTS DBP_ETL.kmo_mkpfmseg_dat_2;
CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mkpfmseg_dat_2 (
  dat_buch DATE
);

INSERT INTO DBP_ETL.kmo_mkpfmseg_dat_2 (dat_buch)
SELECT dat_buch
FROM DBP_ETL.kmo_mseg_art_gp_wup_zu_2
GROUP BY 1
;

DROP TABLE IF EXISTS DBP_ETL.kmo_mkpfmseg_dat_min_2;
CREATE TABLE DBP_ETL.kmo_mkpfmseg_dat_min_2 (
  dat_buch DATE
);

INSERT INTO DBP_ETL.kmo_mkpfmseg_dat_min_2 (dat_buch)
SELECT MIN(dat_buch) AS dat_buch
FROM DBP_ETL.kmo_mseg_art_gp_wup_zu_2
;

DROP TABLE IF EXISTS DBP_ETL.kmo_mkpfmseg_anr_2;
CREATE TABLE DBP_ETL.kmo_mkpfmseg_anr_2 (
  mandant_id              BYTEINT NOT NULL,
  lagerbew_beleg_id       DECIMAL(18,0) NOT NULL,
  lagerbew_beleg_pos_id   INTEGER NOT NULL,
  kj                      SMALLINT NOT NULL,
  dat_buch                DATE NOT NULL,
  gp_id_zl                INTEGER NOT NULL,
  einkaufsorganisation_id SMALLINT,
  bq_findung_id           BYTEINT NOT NULL,
  betrag_einstandspreis   DECIMAL(18,4)
);

DROP TABLE IF EXISTS DBP_ETL._vol_art_gp_wup_zu_per;
CREATE TRANSIENT TABLE DBP_ETL._vol_art_gp_wup_zu_per (
mandant_id              BYTEINT NOT NULL,
art_id                  INTEGER NOT NULL,
gp_id                   INTEGER NOT NULL,
wup_id                  INTEGER NOT NULL,
nb_id                   SMALLINT,
einkaufsorganisation_id SMALLINT NOT NULL,
dat                     DATE NOT NULL,
einstandspreis          DECIMAL(18,4)
);

INSERT INTO DBP_ETL._vol_art_gp_wup_zu_per
(
         mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,gp_id
        ,einkaufsorganisation_id
        ,dat
        ,einstandspreis
)
SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,gp_id
        ,einkaufsorganisation_id
        ,dat_buch
        ,einstandspreis
FROM
        ( SELECT
                 mandant_id
                ,wup_id
                ,nb_id
                ,art_id
                ,gp_id
                ,einkaufsorganisation_id
                ,dat_von
                ,dat_bis
                ,wrg_id
                ,CAST(einstandspreis AS DECIMAL(18,4)) AS einstandspreis
          FROM DBP_DATA.art_gp_wup_zu_per_2 a

          INNER JOIN DBP_ETL.kmo_mkpfmseg_dat_min_2 m
                  ON a.dat_bis >= m.dat_buch

          WHERE a.mandant_id > 1
            AND (mandant_id, art_id) IN /*nicht ueber Wup_2 einschraenken*/
                (SELECT mandant_id,art_id
                 FROM DBP_ETL.kmo_mseg_art_gp_wup_zu_2
                )
	) a

	INNER JOIN DBP_ETL.kmo_mkpfmseg_dat_2 d
        ON 	d.dat_buch BETWEEN a.dat_von AND a.dat_bis
;

INSERT INTO DBP_ETL.kmo_mkpfmseg_anr_2
(
 mandant_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,kj
,einkaufsorganisation_id
,dat_buch
,betrag_einstandspreis
,gp_id_zl
,bq_findung_id
)
SELECT
 mandant_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,kj
,einkaufsorganisation_id
,dat_buch
,einstandspreis_
,gp_id_zl
,bq_findung_id_
FROM
        (
        SELECT
         a.mandant_id
        ,a.lagerbew_beleg_id
        ,a.lagerbew_beleg_pos_id
        ,a.kj
        ,x.einkaufsorganisation_id
        ,a.dat_buch
        ,CASE   WHEN x.bq_findung_id = 25         THEN 0
                ELSE CAST(menge_lagerbew_bme * COALESCE(agw.einstandspreis, agww.einstandspreis) AS DECIMAL(18,4))
                END AS einstandspreis_
        ,x.gp_id AS gp_id_zl
        ,x.bq_findung_id + CASE
                WHEN x.bezugsweg_id = 1 AND x.bq_findung_id NOT IN (25, 26, 27)        THEN 12
                ELSE  0    END AS bq_findung_id_
        FROM DBP_DATA.lagerbew_det_delta_2 a

        INNER JOIN DBP_ETL.kmo_mkpfmseg_dat_2 d
        ON a.dat_buch = d.dat_buch

        INNER JOIN DBP_ETL.kmo_mseg_art_gp_wup_zu_2 z
        ON a.mandant_id               = z.mandant_id
        AND a.lagerbew_beleg_id     = z.lagerbew_beleg_id
        AND a.lagerbew_beleg_pos_id = z.lagerbew_beleg_pos_id
        AND a.kj                    = z.kj
        AND a.dat_buch              = z.dat_buch

        INNER JOIN DBP_DATA.art_gp_nm_zu_per_2 x
        ON a.mandant_id = x.mandant_id                AND
        a.art_id     = x.art_id                    AND
        a.wup_id     = x.wup_id                    AND
        a.dat_buch BETWEEN x.dat_von AND x.dat_bis

        -- Ermittlung betriebsspezifischer ZEKP_2 Satz mit VZ
        LEFT OUTER JOIN DBP_ETL._vol_art_gp_wup_zu_per agw
        ON a.mandant_id                 = agw.mandant_id
        AND z.wup_id                  = agw.wup_id      /*hier Zugriff mit VZ aus BQ Findung!!*/
        AND z.nb_id                   = agw.nb_id
        AND a.art_id                  = agw.art_id
        AND x.gp_id                   = agw.gp_id
        AND x.einkaufsorganisation_id = agw.einkaufsorganisation_id
        AND a.dat_buch                = agw.dat

        -- Betrieb = blank wenn beim ersten Zugriff nichts gefunden wird.
        LEFT OUTER JOIN DBP_ETL._vol_art_gp_wup_zu_per agww
        ON a.mandant_id                 = agww.mandant_id
        AND agww.wup_id               = -1              /*Betrieb = 'blank'*/
        AND a.art_id                  = agww.art_id
        AND x.gp_id                   = agww.gp_id
        AND x.einkaufsorganisation_id = agww.einkaufsorganisation_id
        AND a.dat_buch  = agww.dat

        GROUP BY 1,2,3,4,5,6,7,8,9
        ) a
;

UPDATE DBP_DATA.lagerbew_det_delta_2

SET      gp_id_zl                = a.gp_id_zl
        ,einkaufsorganisation_id = a.einkaufsorganisation_id
        ,bq_findung_id           = a.bq_findung_id
        ,betrag_einstandspreis   = COALESCE(a.betrag_lagerbew,DBP_DATA.lagerbew_det_delta.betrag_lagerbew)

FROM (SELECT mandant_id,
             lagerbew_beleg_id,
             lagerbew_beleg_pos_id,
             kj,
             dat_buch,
             MAX(gp_id_zl) AS gp_id_zl,
             MAX(einkaufsorganisation_id) AS einkaufsorganisation_id,
             MAX(bq_findung_id) AS bq_findung_id,
             MAX(betrag_einstandspreis) AS betrag_lagerbew
      FROM DBP_ETL.kmo_mkpfmseg_anr_2
      GROUP BY 1,2,3,4,5) a


WHERE DBP_DATA.lagerbew_det_delta.mandant_id            = a.mandant_id
  AND DBP_DATA.lagerbew_det_delta.lagerbew_beleg_id     = a.lagerbew_beleg_id
  AND DBP_DATA.lagerbew_det_delta.lagerbew_beleg_pos_id = a.lagerbew_beleg_pos_id
  AND DBP_DATA.lagerbew_det_delta.kj                    = a.kj
  AND DBP_DATA.lagerbew_det_delta.dat_buch              = a.dat_buch
;

DROP TABLE IF EXISTS DBP_ETL._vol_art_gp_wup_zu_per;
DROP TABLE IF EXISTS DBP_ETL.kmo_mkpfmseg_dat_2;
DROP TABLE IF EXISTS DBP_ETL.kmo_mkpfmseg_dat_min_2;
DROP TABLE IF EXISTS DBP_ETL.kmo_mkpfmseg_anr_2;
DELETE FROM DBP_ETL.kmo_mseg_art_gp_wup_zu_2;

