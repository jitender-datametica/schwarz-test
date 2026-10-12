CREATE OR REPLACE TABLE dbp_etl.ek01_ekpo_2 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek02_ekpo_2 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek03_ekpo_2 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek04_ekpo_2 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek05_ekpo_2 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek06_ekpo_2 (
      art_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek07_ekpo_2 (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek08_ekpo_2 (
      art_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek09_ekpo_2 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek10_ekpo_2 (
      art_id INTEGER NOT NULL,
      gp_id INTEGER NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek11_ekpo_2 (
      art_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      komponentenmenge DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE dbp_etl.ek12_ekpo_2 (
      art_id INTEGER NOT NULL,
      ek_netto_bnk DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      komponentenmenge DECIMAL(18,4)
);

INSERT INTO dbp_etl.ek01_ekpo_2 (art_id
,wup_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,gp_id
,komponentenmenge)
SELECT art_id
,wup_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,gp_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1
;

INSERT INTO dbp_etl.ek02_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,gp_id
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,gp_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE nb_id IN (99, -111 )
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, dat_von, gp_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek03_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,gp_id
,wup_id
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,gp_id
,wup_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, gp_id, wup_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek04_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,gp_id
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,gp_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, gp_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek05_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,wup_id
,komponentenmenge)
SELECT agw5_1.art_id
,ek_netto
,ek_netto_bnk
,CASE WHEN (agw5_1.dat_von > agw5_2.dat_von) THEN agw5_1.dat_von ELSE agw5_2.dat_von END AS dat_von
,CASE WHEN (agw5_1.dat_bis < agw5_2.dat_bis) THEN agw5_1.dat_bis ELSE agw5_2.dat_bis END AS dat_bis
,agw5_1.wup_id
,agw5_1.komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2 agw5_1

JOIN dbp_data.art_gp_zu_per_2 agw5_2
ON agw5_1.art_id=agw5_2.art_id
AND agw5_1.gp_id=agw5_2.gp_id
AND ((agw5_1.dat_von BETWEEN agw5_2.dat_von AND agw5_2.dat_bis) OR (agw5_2.dat_von BETWEEN agw5_1.dat_von AND agw5_1.dat_bis))
AND agw5_1.mandant_id=agw5_2.mandant_id
AND agw5_1.einkaufsorganisation_id=agw5_2.einkaufsorganisation_id

WHERE agw5_1.nb_id IN (99, -111)
AND agw5_1.bezugsweg_id = 4
AND agw5_1.ek_kal_basis > 0
AND agw5_1.mandant_id = 1
;

INSERT INTO dbp_etl.ek06_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,komponentenmenge)
SELECT agw6_1.art_id
,ek_netto
,ek_netto_bnk
,CASE WHEN (agw6_1.dat_von > agw6_2.dat_von) THEN agw6_1.dat_von ELSE agw6_2.dat_von END AS dat_von
,CASE WHEN (agw6_1.dat_bis < agw6_2.dat_bis) THEN agw6_1.dat_bis ELSE agw6_2.dat_bis END AS dat_bis
,agw6_1.komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2 agw6_1

JOIN dbp_data.art_gp_zu_per_2 agw6_2
ON agw6_1.art_id=agw6_2.art_id
AND agw6_1.gp_id = agw6_2.gp_id
AND ((agw6_1.dat_von BETWEEN agw6_2.dat_von AND agw6_2.dat_bis) OR (agw6_2.dat_von BETWEEN agw6_1.dat_von AND agw6_1.dat_bis))
AND agw6_1.mandant_id=agw6_2.mandant_id
AND agw6_1.einkaufsorganisation_id=agw6_2.einkaufsorganisation_id

WHERE agw6_1.nb_id IN (99, -111)
AND agw6_1.bezugsweg_id = 4
AND agw6_1.ek_kal_basis > 0
AND agw6_1.mandant_id = 1
;

INSERT INTO dbp_etl.ek07_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,wup_id
,komponentenmenge)

SELECT art_id
,ek_netto
,ek_netto_bnk
,wup_id
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE nb_id IN(99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id, wup_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek08_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE nb_id IN (99, -111)
AND bezugsweg_id = 4
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek09_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,komponentenmenge
,gp_id)
SELECT art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,komponentenmenge
,gp_id
FROM dbp_data.art_gp_wup_zu_per_2
WHERE (nb_id NOT IN (99,-111) OR nb_id IS NULL)
AND bezugsweg_id = 1
AND ek_kal_basis > 0
AND mandant_id = 1
;

INSERT INTO dbp_etl.ek10_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,komponentenmenge
,gp_id)
SELECT art_id
,ek_netto
,ek_netto_bnk
,komponentenmenge
,gp_id
FROM dbp_data.art_gp_wup_zu_per_2
WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)
AND bezugsweg_id = 1
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id,gp_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

INSERT INTO dbp_etl.ek11_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,dat_von
,dat_bis
,komponentenmenge)
SELECT agw11_1.art_id
,ek_netto
,ek_netto_bnk
,CASE WHEN (agw11_1.dat_von > agw11_2.dat_von) THEN agw11_1.dat_von ELSE agw11_2.dat_von END AS dat_von
,CASE WHEN (agw11_1.dat_bis < agw11_2.dat_bis) THEN agw11_1.dat_bis ELSE agw11_2.dat_bis END AS dat_bis
,agw11_1.komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2 agw11_1

JOIN dbp_data.art_gp_zu_per_2 agw11_2
ON agw11_1.art_id=agw11_2.art_id
AND agw11_1.gp_id=agw11_2.gp_id
AND ((agw11_1.dat_von BETWEEN agw11_2.dat_von AND agw11_2.dat_bis) OR (agw11_2.dat_von BETWEEN agw11_1.dat_von AND agw11_1.dat_bis))
AND agw11_1.mandant_id=agw11_2.mandant_id
AND agw11_1.einkaufsorganisation_id=agw11_2.einkaufsorganisation_id

WHERE (agw11_1.nb_id NOT IN ( 99, -111 ) OR agw11_1.nb_id IS NULL )
AND agw11_1.bezugsweg_id = 1
AND agw11_1.ek_kal_basis > 0
AND agw11_1.mandant_id = 1
;

INSERT INTO dbp_etl.ek12_ekpo_2 (art_id
,ek_netto
,ek_netto_bnk
,komponentenmenge)
SELECT art_id
,ek_netto
,ek_netto_bnk
,komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2

WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)
AND bezugsweg_id = 1
AND ek_kal_basis > 0
AND mandant_id = 1

QUALIFY ROW_NUMBER() OVER (PARTITION BY art_id ORDER BY dat_von DESC,ek_brutto DESC,gp_id,ek_mep DESC,ek_kal_basis DESC) = 1
;

DROP TABLE IF EXISTS DBP_ETL.besch_best_det_tmp_2;

CREATE TABLE DBP_ETL.besch_best_det_tmp_2  (
    mandant_id                BYTEINT NOT NULL,
    best_beleg_id             DECIMAL(18,0) NOT NULL,
    best_beleg_pos_id         INTEGER NOT NULL,
    art_id                    INTEGER,
    wup_id                    INTEGER,
    nb_id                     SMALLINT,
    lagerort_id               CHAR(4) ,
    loesch_fg                 BYTEINT,
    menge_best_bme            DECIMAL(18,3),
    selbstabhol_fg            BYTEINT,
    best_preis_menge_einh_id  CHAR(3) ,
    best_menge_einh_id        CHAR(3) ,
    menge_best_kolli          DECIMAL(18,3),
    menge_best_palette        DECIMAL(18,3),
    endlief_fg                BYTEINT,
    dat_aenderung             DATE,
    kunde_id                  VARCHAR(10),
    dat_best_beleg            DATE,
    wg_verkett_id             SMALLINT,
    fremd_lagerort_id         CHAR(4),
    ean_id                    DECIMAL(26,0),
    betrag_kond_zw_sum2       DECIMAL(18,4),
    pos_kostenlos_fg          BYTEINT, 
    betrag_pos_netto          DECIMAL(18,4),
    betrag_pos_netto_best_wrg DECIMAL(18,4),
    wrg_id                    CHAR(3) ,
    betrag_best               DECIMAL(18,4),
    gp_id                     INTEGER,
    ek_netto_bnk              DECIMAL(18,4),
    ek_netto                  DECIMAL(18,4),
    komponentenmenge          DECIMAL(18,4), 
    kopf_wup_id               INTEGER,
    gp_teilsortiment_id       VARCHAR(10) COLLATE 'en-ci',
    zentral_best_fg           BYTEINT  ,
    dat_best_beleg_orig       DATE,
    anforderer_name           VARCHAR(20) COLLATE 'en-ci',
    bedarfsnummer             VARCHAR(10) COLLATE 'en-ci'
    
  )
;

INSERT INTO DBP_ETL.besch_best_det_tmp_2
(
  mandant_id
, best_beleg_id
, best_beleg_pos_id
, art_id
, wup_id
, nb_id
, lagerort_id
, loesch_fg
, menge_best_bme
, selbstabhol_fg
, best_preis_menge_einh_id
, best_menge_einh_id
, menge_best_kolli
, menge_best_palette
, endlief_fg
, dat_aenderung
, kunde_id
, dat_best_beleg
, wg_verkett_id
, fremd_lagerort_id
, ean_id
, betrag_kond_zw_sum2
, pos_kostenlos_fg
, betrag_pos_netto
, betrag_pos_netto_best_wrg
, wrg_id
, betrag_best
, gp_id
, ek_netto_bnk
, ek_netto
, komponentenmenge
, kopf_wup_id
, gp_teilsortiment_id
, zentral_best_fg
, dat_best_beleg_orig
, anforderer_name
, bedarfsnummer

)
SELECT
  ekpo.mandant_id
, ekpo.best_beleg_id
, ekpo.best_beleg_pos_id
, ekpo.art_id
, ekpo.wup_id
, ekpo.nb_id
, ekpo.lagerort_id
, ekpo.loesch_fg
, ekpo.menge_best_bme
, ekpo.selbstabhol_fg
, ekpo.best_preis_menge_einh_id
, ekpo.best_menge_einh_id
, ekpo.menge_best_kolli
, ekpo.menge_best_palette
, ekpo.endlief_fg
, ekpo.dat_aenderung
, ekpo.kunde_id
, ekpo.dat_best_beleg
, ekpo.wg_verkett_id
, ekpo.fremd_lagerort_id
, ekpo.ean_id
, ekpo.betrag_kond_zw_sum2
, ekpo.pos_kostenlos_fg
, ekpo.betrag_pos_netto
, ekpo.betrag_pos_netto_best_wrg 
, ekpo.wrg_id
, ekpo.betrag_best
, gp.gp_id
 ,CASE WHEN (ekpo.nb_id_ber IN(99, -111))
         THEN /* zentral */
           COALESCE(agw.ek_netto_bnk,
                     agw2.ek_netto_bnk,
                     agw3.ek_netto_bnk,
                     agw4.ek_netto_bnk,
                     agw5.ek_netto_bnk,
                     agw6.ek_netto_bnk,
                     agw7.ek_netto_bnk,
                     agw8.ek_netto_bnk,
                     agw9.ek_netto_bnk,
                     agw10.ek_netto_bnk,
                     agw11.ek_netto_bnk,
                     agw12.ek_netto_bnk,
                     --0)
		     (0 )
           )
         ELSE /* dezentral (Lager kann nicht richtig sein) */
           COALESCE(agw9.ek_netto_bnk,
                     agw10.ek_netto_bnk,
                     agw11.ek_netto_bnk,
                     agw12.ek_netto_bnk,
                     agw2.ek_netto_bnk,
                     agw4.ek_netto_bnk,
                     agw6.ek_netto_bnk,
                     agw8.ek_netto_bnk,
                     --0)
		     (0 )
          )
   END AS ek_netto_bnk_   
   
  ,CASE WHEN (ekpo.nb_id_ber IN (99, -111))
         THEN /* zentral */
           COALESCE(agw.ek_netto,
                     agw2.ek_netto,
                     agw3.ek_netto,
                     agw4.ek_netto,
                     agw5.ek_netto,
                     agw6.ek_netto,
                     agw7.ek_netto,
                     agw8.ek_netto,
                     agw9.ek_netto,
                     agw10.ek_netto,
                     agw11.ek_netto,
                     agw12.ek_netto,
                     --0)
		     (0 ) 
           )
         ELSE /* dezentral (Lager kann nicht richtig sein) */
           COALESCE(agw9.ek_netto,
                     agw10.ek_netto,
                     agw11.ek_netto,
                     agw12.ek_netto,
                     agw2.ek_netto,
                     agw4.ek_netto,
                     agw6.ek_netto,
                     agw8.ek_netto,
                    -- 0)
		     (0 ) 
           )
   END AS ek_netto_   
   
  ,CASE WHEN (ekpo.nb_id_ber  IN(99,-111))
       THEN /* zentral */
         COALESCE(agw.komponentenmenge,
                   agw2.komponentenmenge,
                   agw3.komponentenmenge,
                   agw4.komponentenmenge,
                   agw5.komponentenmenge,
                   agw6.komponentenmenge,
                   agw7.komponentenmenge,
                   agw8.komponentenmenge,
                   agw9.komponentenmenge,
                   agw10.komponentenmenge,
                   agw11.komponentenmenge,
                   agw12.komponentenmenge,
                   1
         )
       ELSE /* dezentral (Lager kann nicht richtig sein) */
         COALESCE(agw9.komponentenmenge,
                   agw10.komponentenmenge,
                   agw11.komponentenmenge,
                   agw12.komponentenmenge,
                   agw2.komponentenmenge,
                   agw4.komponentenmenge,
                   agw6.komponentenmenge,
                   agw8.komponentenmenge,
                   1
         )
   END	 AS komponentenmenge_
, ekpo.kopf_wup_id  
, ekpo.gp_teilsortiment_id
, ekpo.zentral_best_fg
, ekpo.dat_best_beleg_orig
, ekpo.anforderer_name
, ekpo.bedarfsnummer

FROM DBP_ETL.de_ekpo_2lis_02_itm ekpo_2

---EK_PREIS holen

LEFT OUTER JOIN DBP_DATA.art_gp_zu_per_2 gp_2
   ON gp.art_id = ekpo.art_id AND gp.mandant_id = ekpo.mandant_id
  AND ekpo.dat_best_beleg BETWEEN gp.dat_von AND gp.dat_bis

/*
zentral
lager       richtig
datum       richtig
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek01_ekpo_2 agw
   ON ekpo.art_id = agw.art_id
  AND ekpo.dat_best_beleg BETWEEN agw.dat_von AND agw.dat_bis  /* richtiges Datum */
  AND ekpo.werks_ber = agw.wup_id                            /* richtiges Lager */
  AND gp.gp_id = agw.gp_id                             /* richtiger Lieferant */

/*
zentral
lager       falsch
datum       richtig
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek02_ekpo_2 agw2
   ON ekpo.art_id = agw2.art_id
  AND ekpo.dat_best_beleg BETWEEN agw2.dat_von AND agw2.dat_bis  /* richtiges Datum */
  AND gp.gp_id = agw2.gp_id                              /* richtiger Lieferant */

/*
zentral
lager       richtig
datum       falsch
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek03_ekpo_2 agw3
   ON ekpo.art_id = agw3.art_id
  AND ekpo.werks_ber = agw3.wup_id                            /* richtiges Lager */
  AND gp.gp_id = agw3.gp_id                             /* richtiger Lieferant */

/*
zentral
lager       falsch
datum       falsch
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek04_ekpo_2 agw4
   ON ekpo.art_id = agw4.art_id
  AND gp.gp_id = agw4.gp_id                           /* richtiger Lieferant */

/*
zentral
lager       richtig
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek05_ekpo_2 agw5
   ON ekpo.art_id = agw5.art_id
  AND ekpo.dat_best_beleg BETWEEN agw5.dat_von AND agw5.dat_bis  /* richtiges Datum */
  AND ekpo.werks_ber = agw5.wup_id                             /* richtiges Lager */

/*
zentral
lager       falsch
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek06_ekpo_2 agw6
   ON ekpo.art_id = agw6.art_id
  AND ekpo.dat_best_beleg BETWEEN agw6.dat_von AND agw6.dat_bis   /* richtiges Datum */

/*
zentral
lager       richtig
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek07_ekpo_2 agw7
   ON ekpo.art_id = agw7.art_id
  AND ekpo.werks_ber = agw7.wup_id                     /* richtiges Lager */

/*
zentral
lager       falsch
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek08_ekpo_2 agw8
   ON ekpo.art_id = agw8.art_id

/*
dezentral
lager       -1
datum       richtig
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek09_ekpo_2 agw9
   ON ekpo.art_id = agw9.art_id
  AND gp.gp_id = agw9.gp_id                              /* richtiger Lieferant */
  AND ekpo.dat_best_beleg BETWEEN agw9.dat_von AND agw9.dat_bis  /* richtiges Datum */

/*
dezentral
lager       -1
datum       falsch
lieferant   richtig
*/

LEFT OUTER JOIN DBP_ETL.ek10_ekpo_2 agw10
   ON ekpo.art_id = agw10.art_id
  AND gp.gp_id = agw10.gp_id                        /* richtiger Lieferant */

/*
dezentral
lager       -1
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek11_ekpo_2 agw11
   ON ekpo.art_id = agw11.art_id
  AND ekpo.dat_best_beleg BETWEEN agw11.dat_von AND agw11.dat_bis         /* richtiges Datum */


/*
dezentral
lager       -1
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek12_ekpo_2 agw12
   ON ekpo.art_id = agw12.art_id

QUALIFY ROW_NUMBER() OVER (PARTITION BY ekpo.mandant_id,ekpo.best_beleg_id,ekpo.best_beleg_pos_id ORDER BY CAST((ek_netto_bnk_ ) AS DECIMAL(18,4)) DESC, komponentenmenge_ DESC) = 1
;

DROP TABLE IF EXISTS DBP_ETL.fww_perf_tmp1_2;

CREATE TABLE DBP_ETL.fww_perf_tmp1_2 AS (
SELECT DISTINCT
       dat_best_beleg_orig AS dat_best_beleg
FROM DBP_ETL.besch_best_det_tmp_2
);

DELETE FROM DBP_DATA.besch_best_det_2
WHERE dat_best_beleg IN (SELECT dat_best_beleg 
                         FROM DBP_ETL.fww_perf_tmp1_2) 
  AND mandant_id = 1 
  AND (mandant_id, best_beleg_id, best_beleg_pos_id,dat_best_beleg) 
   IN (SELECT mandant_id,
              best_beleg_id,
              best_beleg_pos_id,
              dat_best_beleg_orig
       FROM DBP_ETL.besch_best_det_tmp_2
       WHERE dat_best_beleg_orig IS NOT NULL
       )
;

INSERT INTO DBP_DATA.besch_best_det_2
(
	  mandant_id
	, best_beleg_id
	, best_beleg_pos_id
	, art_id
	, wup_id
	, nb_id
	, lagerort_id
	, loesch_fg
	, menge_best_bme
	, selbstabhol_fg
	, best_preis_menge_einh_id
	, best_menge_einh_id
	, menge_best_kolli
	, menge_best_palette
	, endlief_fg
	, dat_aenderung
	, kunde_id
	, dat_best_beleg
	, ean_id
	, betrag_kond_zw_sum2
	, pos_kostenlos_fg
	, betrag_pos_netto
	, betrag_pos_netto_best_wrg
	, wrg_id
	, betrag_best
	, gp_teilsortiment_id
	, menge_block_bestand
	, flw_fg
	, zentral_best_fg
        , anforderer_name
        , bedarfsnummer
)
SELECT
	  t.mandant_id
	, t.best_beleg_id
	, t.best_beleg_pos_id
	, t.art_id
	, t.wup_id
	, t.nb_id
	, t.lagerort_id
	, t.loesch_fg
	, CAST(t.menge_best_kolli / (COALESCE(aukolli.umrech_faktor , aukolli_alternativ.umrech_faktor, 1))
	  AS DECIMAL(18,3)) AS  menge_best_neu
	, t.selbstabhol_fg
	, t.best_preis_menge_einh_id
	, t.best_menge_einh_id
	, menge_best_kolli 
	,
	      (CASE	
		WHEN	aupalette.umrech_faktor IS NULL
		THEN CAST(menge_best_neu AS DECIMAL(18,3))
		ELSE CAST( ( CAST(menge_best_neu as decimal (18,3)) 
			     *
			     aupalette.umrech_faktor  )
		AS DECIMAL(18,3) )
	       END) AS menge_best_palette
	, t.endlief_fg
	, t.dat_aenderung
	, t.kunde_id
	, t.dat_best_beleg
	, t.ean_id
	, t.betrag_kond_zw_sum2
	, t.pos_kostenlos_fg
        , t.betrag_pos_netto
	, t.betrag_pos_netto_best_wrg
	, t.wrg_id
	, (                                                                         
			CAST(menge_best_neu *                                                                 
			CAST(CAST(  (t.ek_netto_bnk ) AS DECIMAL(18,4))
			  *  t.komponentenmenge  AS FLOAT) AS DECIMAL(18,2) 
			     )                                          
	   )  AS betrag_best    
	  ,t.gp_teilsortiment_id
	  ,0 AS menge_block_bestand
	, CASE WHEN wgfz.wg_id IS NOT NULL THEN 1  ELSE 0 END AS flw_fg
	, zentral_best_fg AS zentral_best_fg
        , t.anforderer_name
        , COALESCE(t.bedarfsnummer,'0') as bedarfsnummer
FROM DBP_ETL.besch_best_det_tmp_2 t

-- Datum ermitteln
INNER JOIN
( SELECT
	best_beleg_id, 
	dat_best_beleg
  FROM DBP_DATA.besch_best_2
  WHERE mandant_id = 1
) la
  ON t.best_beleg_id = la.best_beleg_id
  
LEFT OUTER JOIN DBP_DATA.art_wg_zu_per_2 awzp
   ON   awzp.mandant_id  = 1
  AND awzp.art_id = t.art_id 
  AND awzp.arthiertyp_id= 2
  AND awzp.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') 

-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per_2
  WHERE mandant_id = 1
) aukolli
   ON t.art_id = aukolli.art_id AND t.best_menge_einh_id = aukolli.altnv_menge_einh_id
  AND la.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis
  
-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN
( SELECT
    art_id, paletten_faktor_einh_id, ausg_menge_einh_id, dat_von, dat_bis
  FROM DBP_DATA.art_vorschlagswert_per_2
  WHERE mandant_id = 1
) av
   ON t.art_id = av.art_id
  AND la.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis

-- Umrechnungsfaktor fuer Palettenfaktor holen
LEFT OUTER JOIN
( SELECT
    art_id, umrech_faktor, altnv_menge_einh_id, dat_von, dat_bis
  FROM DBP_DATA.art_umrechnung_faktor_per_2
  WHERE mandant_id = 1
) aupalette
  ON t.art_id = aupalette.art_id AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
     AND la.dat_best_beleg BETWEEN aupalette.dat_von AND aupalette.dat_bis

-- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist 
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per_2
  WHERE mandant_id = 1
) aukolli_alternativ
  ON t.art_id = aukolli_alternativ.art_id AND av.ausg_menge_einh_id = aukolli_alternativ.altnv_menge_einh_id
     AND la.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND aukolli_alternativ.dat_bis

LEFT JOIN DBP_DATA.wg_filter_zu_2 AS wgfz
ON wgfz.wg_id = awzp.wg_id
AND wgfz.mandant_id = awzp.mandant_id
AND wgfz.wg_filter_id = 23
AND wgfz.arthiertyp_id = 2

where t.dat_best_beleg_orig is not null
;

UPDATE DBP_DATA.besch_best_det_2 
SET zentral_best_fg = 1

FROM (SELECT DISTINCT t1.mandant_id,
                                                          t1.best_beleg_id,
	                                                  t1.best_beleg_pos_id,
	                                                  t1.art_id,
	                                                  t1.wup_id,
	                                                  t1.dat_best_beleg
                                                   FROM DBP_DATA.besch_best_det_2 t1_2
                                                   JOIN DBP_ETL.besch_best_det_tmp_2 x
                                                     ON t1.mandant_id = x.mandant_id AND
                                                        t1.best_beleg_id = x.best_beleg_id AND
                                                        t1.best_beleg_pos_id = x.best_beleg_pos_id AND
                                                        t1.wup_id = x.wup_id AND
                                                        t1.dat_best_beleg = x.dat_best_beleg AND
                                                        t1.art_id = x.art_id
                                                   LEFT JOIN DBP_DATA.fur_best_vor_2  t2
                                                     ON t1.mandant_id = t2.mandant_id
                                                    AND t1.wup_id = t2.wup_id
                                                    AND t1.art_id = t2.art_id
                                                    AND t1.dat_best_beleg = t2.dat_dispo 
                                                   WHERE t1.anforderer_name = 'ZFRE0150_INT') b
 WHERE DBP_DATA.besch_best_det.mandant_id = b.mandant_id AND
      DBP_DATA.besch_best_det.best_beleg_id = b.best_beleg_id AND
      DBP_DATA.besch_best_det.best_beleg_pos_id = b.best_beleg_pos_id AND
      DBP_DATA.besch_best_det.art_id = b.art_id AND
      DBP_DATA.besch_best_det.wup_id = b.wup_id AND
      DBP_DATA.besch_best_det.dat_best_beleg = b.dat_best_beleg
;

UPDATE DBP_DATA.besch_best_2

SET  
	empfaenger_wup_id  = bzeile.empfaenger_wup_id,
	anz_pos_aktiv      = bzeile.anz_pos_aktiv,
	anz_pos_offen      = bzeile.anz_pos_offen

FROM (SELECT mandant_id,
             best_beleg_id,
             MAX(wup_id) empfaenger_wup_id,
             COUNT(*) anz_pos_aktiv,
             SUM(CASE WHEN endlief_fg=1 THEN 0 ELSE 1 END) anz_pos_offen
      FROM DBP_DATA.besch_best_det_2
      WHERE loesch_fg = 0 AND
           (mandant_id, best_beleg_id, dat_best_beleg) IN (SELECT mandant_id, best_beleg_id, dat_best_beleg
                                                           FROM DBP_ETL.besch_best_det_tmp_2
                                                           -- Bestellungen an Lieferanten
                                                           WHERE NULLIFZERO(kopf_wup_id) IS NULL) 
      GROUP BY mandant_id,best_beleg_id) bzeile
 
WHERE DBP_DATA.besch_best.mandant_id     = bzeile.mandant_id AND
      DBP_DATA.besch_best.best_beleg_id  = bzeile.best_beleg_id 
;

DROP TABLE IF EXISTS DBP_ETL.lief_eint_tmp_2;

CREATE TABLE DBP_ETL.lief_eint_tmp_2  (
      mandant_id           BYTEINT NOT NULL,
      best_beleg_id        DECIMAL(18,0) NOT NULL,
      best_beleg_pos_id    INTEGER NOT NULL ,
      einteil_id           SMALLINT NOT NULL  ,
      menge_einteil        DECIMAL(18,3) NOT NULL ,
      dat_lief_wunsch      DATE NOT NULL,
      dat_lief_bewertung   DATE,
      mahnung_anz          SMALLINT NOT NULL  ,
      system_id            BYTEINT NOT NULL  ,
      flw_fg               BYTEINT NOT NULL
      )
;

DROP TABLE IF EXISTS DBP_ETL.fww_perf_tmp2_2;

CREATE TABLE DBP_ETL.fww_perf_tmp2_2 AS (
SELECT t1.mandant_id,
       t1.best_beleg_id,
       t1.best_beleg_pos_id,
       t1.flw_fg
FROM DBP_DATA.besch_best_det_2 t1_2

JOIN DBP_ETL.de_ekpo_2lis_02_itm t2
  ON t1.mandant_id        = t2.mandant_id
 AND t1.best_beleg_id     = t2.best_beleg_id
 AND t1.best_beleg_pos_id = t2.best_beleg_pos_id
 AND t1.dat_best_beleg    = t2.dat_best_beleg

JOIN DBP_ETL.fww_perf_tmp1_2 t0
  ON t1.dat_best_beleg = t0.dat_best_beleg 
 AND t1.mandant_id     = 1 
 AND t1.flw_fg         = 1
);

INSERT INTO DBP_ETL.lief_eint_tmp_2
(
 mandant_id         
,best_beleg_id      
,best_beleg_pos_id  
,einteil_id         
,menge_einteil      
,dat_lief_wunsch    
,dat_lief_bewertung 
,mahnung_anz        
,system_id          
,flw_fg             
)
SELECT t2.mandant_id
      ,t2.best_beleg_id
      ,t2.best_beleg_pos_id
      ,t2.einteil_id
      ,t2.menge_einteil
      ,t2.dat_lief_wunsch
      ,t2.dat_lief_bewertung
      ,t2.mahnung_anz
      ,t2.system_id
      ,t1.flw_fg
FROM DBP_ETL.fww_perf_tmp2_2 t1_2
JOIN DBP_DATA.lief_einteilung_2 t2
  ON   t1.mandant_id       = t2.mandant_id
 AND  t1.best_beleg_id     = t2.best_beleg_id
 AND  t1.best_beleg_pos_id = t2.best_beleg_pos_id

WHERE t2.mandant_id = 1
;

DELETE FROM DBP_DATA.lief_einteilung_2
WHERE (mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch)
IN
(SELECT
mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch
FROM DBP_ETL.lief_eint_tmp_2
)
;

INSERT INTO DBP_DATA.lief_einteilung_2
(
	 mandant_id         
	,best_beleg_id      
	,best_beleg_pos_id  
	,einteil_id         
	,menge_einteil      
	,dat_lief_wunsch    
	,dat_lief_bewertung 
	,mahnung_anz        
	,system_id          
	,flw_fg  
)
SELECT 
	 mandant_id         
	,best_beleg_id      
	,best_beleg_pos_id  
	,einteil_id         
	,menge_einteil      
	,dat_lief_wunsch    
	,dat_lief_bewertung 
	,mahnung_anz        
	,system_id          
	,flw_fg 
FROM DBP_ETL.lief_eint_tmp_2
;

CREATE TABLE IF NOT EXISTS DBP_ETL.besch_best_LBS_2  (
         mandant_id BYTEINT NOT NULL,
         best_beleg_id DECIMAL(18,0) NOT NULL,
         best_beleg_pos_id INTEGER NOT NULL,
         art_id INTEGER NOT NULL,
         wup_id INTEGER NOT NULL,
         nb_id SMALLINT NOT NULL,
         lagerort_id CHAR(4) COLLATE 'en-ci',
         menge_best_bme DECIMAL(18,3) NOT NULL,
         endlief_fg BYTEINT NOT NULL ,
         dat_best_beleg DATE NOT NULL,
         wrg_id CHAR(3) COLLATE 'en-ci',
         ek_netto DECIMAL(18,4), /*decimal 18,4*/
         betrag_best_ekn DECIMAL(18,4),
         gp_id INTEGER NOT NULL,
         bestellart_id CHAR(4) COLLATE 'en-ci' NOT NULL,
         komponentenmenge  DECIMAL(18,4),
         menge_best_kolli DECIMAL(18,3),
         loesch_fg BYTEINT,
         selbstabhol_fg BYTEINT
);

DELETE FROM DBP_ETL.besch_best_LBS_2
WHERE (mandant_id, best_beleg_id, best_beleg_pos_id)
IN
	(SELECT mandant_id, best_beleg_id, best_beleg_pos_id
	 FROM DBP_ETL.besch_best_det_tmp_2
	)
;

INSERT INTO DBP_ETL.besch_best_LBS_2
(
	 mandant_id
	,best_beleg_id
	,best_beleg_pos_id
	,art_id
	,wup_id
	,nb_id
	,lagerort_id
	,menge_best_bme
	,endlief_fg
	,dat_best_beleg
	,wrg_id
	,ek_netto
	,gp_id
	,bestellart_id
	,komponentenmenge
	,menge_best_kolli
	,loesch_fg
	,selbstabhol_fg
)
SELECT
	  t.mandant_id
	, t.best_beleg_id
	, t.best_beleg_pos_id
	, t.art_id
	, t.wup_id
	, t.nb_id
	, t.lagerort_id
	, CAST(t.menge_best_kolli / (COALESCE(aukolli.umrech_faktor , aukolli_alternativ.umrech_faktor , 1))
	  AS DECIMAL(18,3)) AS  menge_best_bme
	, t.endlief_fg
	, t.dat_best_beleg
	, t.wrg_id
	, t.ek_netto  /*in besch_best_det_2 wird fuer LIS der ek_netto_bnk fuer betrag_best gerechnet, in LBS ek_netto */
	,la.gp_id
	,la.bestellart_id
	,t.komponentenmenge
	,t.menge_best_kolli
	,t.loesch_fg
	,t.selbstabhol_fg

FROM DBP_ETL.besch_best_det_tmp_2 t

-- Datum ermitteln
INNER JOIN
( SELECT
      best_beleg_id
    , dat_best_beleg
    , gp_id
    , bestellart_id
  FROM DBP_DATA.besch_best_2
  WHERE mandant_id = 1     
    AND einkaufsorganisation_id = 1000
) la
  ON t.best_beleg_id = la.best_beleg_id

-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per_2
  WHERE mandant_id = 1
) aukolli
  ON t.art_id = aukolli.art_id AND t.best_menge_einh_id = aukolli.altnv_menge_einh_id
     AND la.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis

-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN
( SELECT
    art_id, paletten_faktor_einh_id, ausg_menge_einh_id, dat_von, dat_bis
  FROM DBP_DATA.art_vorschlagswert_per_2
  WHERE mandant_id = 1
) av
  ON t.art_id = av.art_id
     AND la.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis


-- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist 
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per_2
  WHERE mandant_id = 1
) aukolli_alternativ
  ON t.art_id = aukolli_alternativ.art_id AND av.ausg_menge_einh_id = aukolli_alternativ.altnv_menge_einh_id
     AND la.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND aukolli_alternativ.dat_bis
;

DELETE FROM DBP_ETL.besch_best_LBS_2 
WHERE nb_id = 99
;
