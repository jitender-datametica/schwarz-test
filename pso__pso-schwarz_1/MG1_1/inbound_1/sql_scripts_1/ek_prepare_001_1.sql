--AW 2021-04-22 check OK
DROP TABLE IF EXISTS DBP_ETL.ek01_1;

DROP TABLE IF EXISTS DBP_ETL.ek02_1;

DROP TABLE IF EXISTS DBP_ETL.ek03_1;

DROP TABLE IF EXISTS DBP_ETL.ek04_1;

DROP TABLE IF EXISTS DBP_ETL.ek05_1;

DROP TABLE IF EXISTS DBP_ETL.ek06_1;

DROP TABLE IF EXISTS DBP_ETL.ek07_1;

DROP TABLE IF EXISTS DBP_ETL.ek08_1;

DROP TABLE IF EXISTS DBP_ETL.ek09_1;

DROP TABLE IF EXISTS DBP_ETL.ek10_1;

DROP TABLE IF EXISTS DBP_ETL.ek11_1;

DROP TABLE IF EXISTS DBP_ETL.ek12_1;

DROP TABLE IF EXISTS DBP_ETL.ek01_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek02_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek03_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek04_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek05_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek06_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek07_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek08_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek09_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek10_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek11_ekpo_1;

DROP TABLE IF EXISTS DBP_ETL.ek12_ekpo_1;


CREATE TABLE DBP_ETL.ek01_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek02_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek03_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek04_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek05_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek06_1  (
  art_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek07_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek08_1  (
  art_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek09_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek10_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek11_1  (
  art_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek12_1  (
  art_id INTEGER NOT NULL,
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  komponentenmenge DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek01_ekpo_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek02_ekpo_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek03_ekpo_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek04_ekpo_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek05_ekpo_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek06_ekpo_1  (
  art_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek07_ekpo_1  (
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek08_ekpo_1  (
  art_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek09_ekpo_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek10_ekpo_1  (
  art_id INTEGER NOT NULL,
  gp_id INTEGER NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek11_ekpo_1  (
  art_id INTEGER NOT NULL,
  dat_von DATE NOT NULL,
  dat_bis DATE NOT NULL,
  komponentenmenge DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4)
) ;


CREATE TABLE DBP_ETL.ek12_ekpo_1  (
  art_id INTEGER NOT NULL,
  ek_netto_bnk DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  komponentenmenge DECIMAL(18,4)
) ;


INSERT INTO DBP_ETL.ek01_1 (art_id
                           ,wup_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,dat_von
                           ,dat_bis
                           ,gp_id
                           ,komponentenmenge)
SELECT art_id
      ,wup_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,dat_von
      ,dat_bis
      ,gp_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                           /* Lager */
  AND bezugsweg_id = 4                              /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
;


INSERT INTO DBP_ETL.ek02_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,dat_von
                           ,dat_bis
                           ,gp_id
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,dat_von
      ,dat_bis
      ,gp_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111 )                             /* Lager */
  AND bezugsweg_id = 4                                 /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000

/*
GROUP BY art_id, dat_von, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, dat_von, gp_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek03_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,gp_id
                           ,wup_id
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,gp_id
      ,wup_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                             /* Lager */
  AND bezugsweg_id = 4                                /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
/*
GROUP BY art_id, gp_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, gp_id, wup_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek04_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,gp_id
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,gp_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                           /* Lager */
  AND bezugsweg_id = 4                              /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
/*
GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, gp_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek05_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,dat_von
                           ,dat_bis
                           ,wup_id
                           ,komponentenmenge)
SELECT agw5_1.art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,CASE WHEN (agw5_1.dat_von > agw5_2.dat_von) THEN agw5_1.dat_von ELSE agw5_2.dat_von END AS dat_von
      ,CASE WHEN (agw5_1.dat_bis < agw5_2.dat_bis) THEN agw5_1.dat_bis ELSE agw5_2.dat_bis END AS dat_bis
      ,agw5_1.wup_id
      ,agw5_1.komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1 agw5_1

JOIN DBP_DATA.art_gp_zu_per_1 agw5_2
  ON agw5_1.art_id=agw5_2.art_id
 AND agw5_1.gp_id=agw5_2.gp_id
 AND ((agw5_1.dat_von BETWEEN agw5_2.dat_von AND agw5_2.dat_bis) OR (agw5_2.dat_von BETWEEN agw5_1.dat_von AND agw5_1.dat_bis))
 AND agw5_1.mandant_id=agw5_2.mandant_id
 AND agw5_1.einkaufsorganisation_id=agw5_2.einkaufsorganisation_id

WHERE agw5_1.nb_id IN (99, -111)                       /* Lager */
  AND agw5_1.bezugsweg_id = 4                          /* zentral */
  AND CAST((agw5_1.ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND agw5_1.mandant_id = 1
  AND agw5_1.einkaufsorganisation_id = 1000
;


INSERT INTO DBP_ETL.ek06_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,dat_von
                           ,dat_bis
                           ,komponentenmenge)
SELECT agw6_1.art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,CASE WHEN (agw6_1.dat_von > agw6_2.dat_von) THEN agw6_1.dat_von ELSE agw6_2.dat_von END AS dat_von
      ,CASE WHEN (agw6_1.dat_bis < agw6_2.dat_bis) THEN agw6_1.dat_bis ELSE agw6_2.dat_bis END AS dat_bis
      ,agw6_1.komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1 agw6_1

JOIN DBP_DATA.art_gp_zu_per_1 agw6_2
  ON agw6_1.art_id=agw6_2.art_id
 AND agw6_1.gp_id = agw6_2.gp_id
 AND ((agw6_1.dat_von BETWEEN agw6_2.dat_von AND agw6_2.dat_bis) OR (agw6_2.dat_von BETWEEN agw6_1.dat_von AND agw6_1.dat_bis))
 AND agw6_1.mandant_id=agw6_2.mandant_id
 AND agw6_1.einkaufsorganisation_id=agw6_2.einkaufsorganisation_id

WHERE agw6_1.nb_id IN (99, -111)                        /* Lager */
  AND agw6_1.bezugsweg_id = 4                           /* zentral */
  AND CAST((agw6_1.ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND agw6_1.mandant_id = 1
  AND agw6_1.einkaufsorganisation_id = 1000
;

INSERT INTO DBP_ETL.ek07_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,wup_id
                           ,komponentenmenge)

SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,wup_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN(99, -111)                          /* Lager */
  AND bezugsweg_id = 4                            /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
/*
GROUP BY art_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep    ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, wup_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep    ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek08_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                         /* Lager */
  AND bezugsweg_id = 4                            /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
/*
GROUP BY art_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek09_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,dat_von
                           ,dat_bis
                           ,komponentenmenge
                           ,gp_id)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,dat_von
      ,dat_bis
      ,komponentenmenge
      ,gp_id
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE (nb_id NOT IN (99,-111) OR nb_id IS NULL)       /* kein Lager */
  AND bezugsweg_id = 1                                /* dezentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
;

INSERT INTO DBP_ETL.ek10_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,komponentenmenge
                           ,gp_id)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,komponentenmenge
      ,gp_id
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)  /* kein Lager */
  AND bezugsweg_id = 1                            /* dezentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
/*
GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, gp_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek11_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,dat_von
                           ,dat_bis
                           ,komponentenmenge)
SELECT agw11_1.art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,CASE WHEN (agw11_1.dat_von > agw11_2.dat_von) THEN agw11_1.dat_von ELSE agw11_2.dat_von END AS dat_von
      ,CASE WHEN (agw11_1.dat_bis < agw11_2.dat_bis) THEN agw11_1.dat_bis ELSE agw11_2.dat_bis END AS dat_bis
      ,agw11_1.komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1 agw11_1

JOIN DBP_DATA.art_gp_zu_per_1 agw11_2
  ON agw11_1.art_id=agw11_2.art_id
 AND agw11_1.gp_id=agw11_2.gp_id
 AND ((agw11_1.dat_von BETWEEN agw11_2.dat_von AND agw11_2.dat_bis) OR (agw11_2.dat_von BETWEEN agw11_1.dat_von AND agw11_1.dat_bis))
 AND agw11_1.mandant_id=agw11_2.mandant_id
 AND agw11_1.einkaufsorganisation_id=agw11_2.einkaufsorganisation_id

WHERE (agw11_1.nb_id NOT IN ( 99, -111 ) OR agw11_1.nb_id IS NULL )    /* kein Lager */
   AND agw11_1.bezugsweg_id = 1                                        /* dezentral */
   AND CAST((agw11_1.ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
   AND agw11_1.mandant_id = 1
   AND agw11_1.einkaufsorganisation_id = 1000
;

INSERT INTO DBP_ETL.ek12_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,ek_mep
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,ek_mep
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1

WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)            /* kein Lager */
  AND bezugsweg_id = 1                            /* dezentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0  /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
  AND einkaufsorganisation_id = 1000
/*
GROUP BY art_id
QUALIFY CSUM (1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek01_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                           /* Lager */
  AND bezugsweg_id = 4                              /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
;

INSERT INTO DBP_ETL.ek02_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111 )                             /* Lager */
  AND bezugsweg_id = 4                                 /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id, dat_von, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, dat_von, gp_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;

INSERT INTO DBP_ETL.ek03_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                             /* Lager */
  AND bezugsweg_id = 4                                /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id, gp_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, gp_id, wup_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC, gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;

INSERT INTO DBP_ETL.ek04_ekpo_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,gp_id
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,gp_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                           /* Lager */
  AND bezugsweg_id = 4                              /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, gp_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek05_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1 agw5_1

JOIN DBP_DATA.art_gp_zu_per_1 agw5_2
  ON agw5_1.art_id=agw5_2.art_id
 AND agw5_1.gp_id=agw5_2.gp_id
 AND ((agw5_1.dat_von BETWEEN agw5_2.dat_von AND agw5_2.dat_bis) OR (agw5_2.dat_von BETWEEN agw5_1.dat_von AND agw5_1.dat_bis))
 AND agw5_1.mandant_id=agw5_2.mandant_id
 AND agw5_1.einkaufsorganisation_id=agw5_2.einkaufsorganisation_id

WHERE agw5_1.nb_id IN (99, -111)                       /* Lager */
  AND agw5_1.bezugsweg_id = 4                          /* zentral */
  AND CAST((agw5_1.ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND agw5_1.mandant_id = 1
;


INSERT INTO DBP_ETL.ek06_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1 agw6_1

JOIN DBP_DATA.art_gp_zu_per_1 agw6_2
  ON agw6_1.art_id=agw6_2.art_id
 AND agw6_1.gp_id = agw6_2.gp_id
 AND ((agw6_1.dat_von BETWEEN agw6_2.dat_von AND agw6_2.dat_bis) OR (agw6_2.dat_von BETWEEN agw6_1.dat_von AND agw6_1.dat_bis))
 AND agw6_1.mandant_id=agw6_2.mandant_id
 AND agw6_1.einkaufsorganisation_id=agw6_2.einkaufsorganisation_id

WHERE agw6_1.nb_id IN (99, -111)                        /* Lager */
  AND agw6_1.bezugsweg_id = 4                           /* zentral */
  AND CAST((agw6_1.ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND agw6_1.mandant_id = 1
;

INSERT INTO DBP_ETL.ek07_ekpo_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,wup_id
                           ,komponentenmenge)

SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,wup_id
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN(99, -111)                          /* Lager */
  AND bezugsweg_id = 4                            /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep    ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, wup_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep    ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;

INSERT INTO DBP_ETL.ek08_ekpo_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE nb_id IN (99, -111)                         /* Lager */
  AND bezugsweg_id = 4                            /* zentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek09_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE (nb_id NOT IN (99,-111) OR nb_id IS NULL)       /* kein Lager */
  AND bezugsweg_id = 1                                /* dezentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
;

INSERT INTO DBP_ETL.ek10_ekpo_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,komponentenmenge
                           ,gp_id)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,komponentenmenge
      ,gp_id
FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)  /* kein Lager */
  AND bezugsweg_id = 1                            /* dezentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id, gp_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;


INSERT INTO DBP_ETL.ek11_ekpo_1 (art_id
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
FROM DBP_DATA.art_gp_wup_zu_per_1 agw11_1

JOIN DBP_DATA.art_gp_zu_per_1 agw11_2
  ON agw11_1.art_id=agw11_2.art_id
 AND agw11_1.gp_id=agw11_2.gp_id
 AND ((agw11_1.dat_von BETWEEN agw11_2.dat_von AND agw11_2.dat_bis) OR (agw11_2.dat_von BETWEEN agw11_1.dat_von AND agw11_1.dat_bis))
 AND agw11_1.mandant_id=agw11_2.mandant_id
 AND agw11_1.einkaufsorganisation_id=agw11_2.einkaufsorganisation_id

WHERE (agw11_1.nb_id NOT IN ( 99, -111 ) OR agw11_1.nb_id IS NULL )    /* kein Lager */
   AND agw11_1.bezugsweg_id = 1                                        /* dezentral */
   AND CAST((agw11_1.ek_kal_basis ) AS DECIMAL(18,4)) > 0 /* der ek_kal_basis muss positiv sein */
   AND agw11_1.mandant_id = 1
;

INSERT INTO DBP_ETL.ek12_ekpo_1 (art_id
                           ,ek_netto
                           ,ek_netto_bnk
                           ,komponentenmenge)
SELECT art_id
      ,ek_netto
      ,ek_netto_bnk
      ,komponentenmenge
FROM DBP_DATA.art_gp_wup_zu_per_1

WHERE (nb_id NOT IN (99, -111) OR nb_id IS NULL)            /* kein Lager */
  AND bezugsweg_id = 1                            /* dezentral */
  AND CAST((ek_kal_basis ) AS DECIMAL(18,4)) > 0  /* der ek_kal_basis muss positiv sein */
  AND mandant_id = 1
/*
GROUP BY art_id
QUALIFY CSUM (1, dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
*/
QUALIFY row_number() over (partition by art_id order by dat_von DESC,
             CAST((ek_brutto ) AS DECIMAL(18,4)) DESC,   gp_id,
             CAST((ek_mep ) AS DECIMAL(18,4)) DESC,
             CAST((ek_kal_basis ) AS DECIMAL(18,4)) DESC) = 1
;
