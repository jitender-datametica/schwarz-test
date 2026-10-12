CREATE OR REPLACE TABLE DBP_ETL.lagerbest_erp_per_tag_kmo_tmp  (
  wup_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  menge_lgbest_erp_frei_bme DECIMAL(18,3),
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3),
  menge_lgbest_erp_qual_bme DECIMAL(18,3),
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  dat DATE NOT NULL
);

CREATE OR REPLACE TABLE DBP_ETL.lagerbest_erp_per_tag_kmo_tmp2  (
  wup_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  menge_lgbest_erp_frei_bme DECIMAL(18,3),
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3),
  menge_lgbest_erp_qual_bme DECIMAL(18,3),
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  dat DATE NOT NULL,
  vw_id BYTEINT,
  gp_id INTEGER,
  vk_netto DECIMAL(18,4)
);

CREATE OR REPLACE TABLE DBP_ETL.art_bestand_vw_sum_kmo_tmp  (
  mandant_id BYTEINT NOT NULL,
  vw_id BYTEINT NOT NULL,
  bezugsweg_id BYTEINT NOT NULL ,
  lagerbestand_fg BYTEINT NOT NULL ,
  nb_id SMALLINT NOT NULL ,
  art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat DATE NOT NULL,
  gp_id INTEGER NOT NULL,
  relevant_fg BYTEINT NOT NULL ,
  wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
  menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_gesamt_bme DECIMAL(18,3) NOT NULL,
  menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL,
  betrag_vk_netto_frei_bme DECIMAL(18,4),
  betrag_vk_netto_gesamt_bme DECIMAL(18,4),
  betrag_vk_netto_qual_bme DECIMAL(18,4),
  menge_abgang_bme DECIMAL(18,3) ,
  betrag_vk_netto_abgang DECIMAL(18,4)
);

CREATE OR REPLACE TABLE DBP_ETL.lager_process_tag_kmo  (
  mandant_id BYTEINT NOT NULL,
  dat DATE NOT NULL,
  verarbeitet_fg BYTEINT
);

INSERT INTO DBP_ETL.lager_process_tag_kmo
(
  mandant_id,
  dat,
  verarbeitet_fg
)
SELECT
  mandant_id,
  dat,
  1 AS verarbeitet_fg
FROM DBP_DATA.art_bestand_vw_sum
WHERE lagerbestand_fg = 1
  AND mandant_id IN (${MIDKMO})
GROUP BY mandant_id, dat, verarbeitet_fg
;

INSERT INTO DBP_ETL.lagerbest_erp_per_tag_kmo_tmp
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,wrg_id
  ,dat
)
SELECT
   p.mandant_id
  ,p.wup_id
  ,p.nb_id
  ,p.art_id
  ,p.menge_lgbest_erp_frei_bme AS menge_lgbest_erp_frei_bme
  ,(p.menge_lgbest_erp_frei_bme +
    p.menge_lgbest_erp_umlag_bme +
    p.menge_lgbest_erp_qual_bme +
    p.menge_lgbest_erp_nf_charge_bme +
    p.menge_lgbest_erp_gesp_bme +
    p.menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_gesamt_bme
  ,p.menge_lgbest_erp_qual_bme AS menge_lgbest_erp_qual_bme
  ,p.wrg_id
  ,CURRENT_DATE- ${LOOP_ID} as dat
FROM DBP_DATA.lagerbestand_erp_per p

WHERE p.mandant_id IN (${MIDKMO})
  AND p.nb_id IN (99, -111) -- nur echte Laeger
   AND CURRENT_DATE- ${LOOP_ID} BETWEEN p.dat_von AND dat_bis
;

INSERT INTO DBP_ETL.lagerbest_erp_per_tag_kmo_tmp2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,wrg_id
  ,dat
  ,vw_id
  ,gp_id
  ,vk_netto
)
SELECT
   tmp.mandant_id
  ,tmp.wup_id
  ,tmp.nb_id
  ,tmp.art_id
  ,tmp.menge_lgbest_erp_frei_bme
  ,tmp.menge_lgbest_erp_gesamt_bme
  ,tmp.menge_lgbest_erp_qual_bme
  ,tmp.wrg_id
  ,tmp.dat
  ,w.vw_id
  ,COALESCE (agn.gp_id, -1)
  ,CAST(ap._vk_brutto / (COALESCE ( 1+(mwst.mwst/100), 1)) AS DECIMAL(18,4)) AS vk_netto
FROM DBP_ETL.lagerbest_erp_per_tag_kmo_tmp tmp

INNER JOIN DBP_DATA.wup w
   ON w.mandant_id = tmp.mandant_id
  AND tmp.wup_id   = w.wup_id
  AND tmp.nb_id    = w.nb_id

INNER JOIN DBP_DATA.art a
   ON a.mandant_id = tmp.mandant_id
  AND tmp.art_id   = a.art_id

LEFT OUTER JOIN DBP_DATA.mwst_per mwst
   ON mwst.mandant_id = tmp.mandant_id
  AND a.mwst_id       = mwst.mwst_id
  AND tmp.dat BETWEEN mwst.dat_von AND mwst.dat_bis

-- Inhaltlich gleiche Logik wie bei lagerbestand_erp_per fuer KMO (s. kmo_mard.btq)
LEFT OUTER JOIN
  (SELECT
      apv.mandant_id  AS _mandant_id
     ,apv.art_id      AS _art_id
     ,CURRENT_DATE- ${LOOP_ID} as _dat
     ,apv.vk_brutto   AS _vk_brutto
   FROM DBP_DATA.art_pm_vw_zu_per apv
   WHERE apv.preistyp_id = 0
    AND apv.pm_id       = 1
    AND apv.vw_id      IN (10,90)
    AND CURRENT_DATE- ${LOOP_ID} BETWEEN apv.dat_von AND apv.dat_bis
   QUALIFY COUNT(*) OVER (PARTITION BY apv.mandant_id, apv.art_id, CURRENT_DATE- ${LOOP_ID}
                          ORDER BY ABS(apv.vk_brutto) DESC ROWS UNBOUNDED PRECEDING) = 1
  ) ap
   ON ap._art_id      = tmp.art_id
  AND ap._dat         = tmp.dat
  AND ap._mandant_id  = tmp.mandant_id

LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per agn
   ON agn.mandant_id  = tmp.mandant_id
  AND agn.art_id      = tmp.art_id
  AND agn.wup_id      = tmp.wup_id
  AND agn.nb_id       = tmp.nb_id
  AND tmp.dat BETWEEN agn.dat_von AND agn.dat_bis
;

INSERT INTO DBP_ETL.art_bestand_vw_sum_kmo_tmp
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
)
SELECT
   t01.mandant_id
  ,t01.vw_id
  ,t01.bezugsweg_id
  ,t01.lagerbestand_fg
  ,t01.nb_id
  ,t01.art_id
  ,t01.wup_id
  ,t01.dat
  ,t01.gp_id
  ,t01.relevant_fg
  ,t01.wrg_id
  ,t01.menge_lgbest_erp_frei_bme
  ,t01.menge_lgbest_erp_gesamt_bme
  ,t01.menge_lgbest_erp_qual_bme
  ,t01.betrag_vk_netto_frei_bme
  ,t01.betrag_vk_netto_gesamt_bme
  ,t01.betrag_vk_netto_qual_bme
  ,t02.menge_abgang_bme
  ,t02.betrag_vk_netto_abgang
FROM
(
  SELECT
     mandant_id
    ,vw_id
    ,4 AS bezugsweg_id
    ,1 AS lagerbestand_fg
    ,nb_id
    ,art_id
    ,wup_id
    ,dat
    ,gp_id
    ,1 AS relevant_fg
    ,wrg_id
    ,SUM(menge_lgbest_erp_frei_bme)               AS menge_lgbest_erp_frei_bme
    ,SUM(menge_lgbest_erp_gesamt_bme)             AS menge_lgbest_erp_gesamt_bme
    ,SUM(menge_lgbest_erp_qual_bme)               AS menge_lgbest_erp_qual_bme
    ,SUM(vk_netto * menge_lgbest_erp_frei_bme)    AS betrag_vk_netto_frei_bme
    ,SUM(vk_netto * menge_lgbest_erp_gesamt_bme)  AS betrag_vk_netto_gesamt_bme
    ,SUM(vk_netto * menge_lgbest_erp_qual_bme)    AS betrag_vk_netto_qual_bme
  FROM DBP_ETL.lagerbest_erp_per_tag_kmo_tmp2
  GROUP BY
     mandant_id
    ,vw_id
    ,bezugsweg_id
    ,lagerbestand_fg
    ,nb_id
    ,art_id
    ,wup_id
    ,dat
    ,gp_id
    ,relevant_fg
    ,wrg_id
) AS t01

LEFT JOIN DBP_DATA.art_bestand_vw_sum t02
   ON t01.mandant_id      = t02.mandant_id
  AND t01.wup_id          = t02.wup_id
  AND t01.nb_id           = t02.nb_id
  AND t01.art_id          = t02.art_id
  AND t01.dat             = t02.dat
  AND t01.lagerbestand_fg = t02.lagerbestand_fg
  AND t01.bezugsweg_id    = t02.bezugsweg_id
  AND t01.vw_id           = t02.vw_id
  AND t01.gp_id           = t02.gp_id
  AND t01.wrg_id          = t02.wrg_id
;

DROP TABLE IF EXISTS DBP_ETL.lagerbest_erp_per_tag_kmo_tmp2;

DELETE FROM DBP_DATA.art_bestand_vw_sum
using DBP_ETL.art_bestand_vw_sum_kmo_tmp
WHERE DBP_DATA.art_bestand_vw_sum.mandant_id      = DBP_ETL.art_bestand_vw_sum_kmo_tmp.mandant_id
  AND DBP_DATA.art_bestand_vw_sum.vw_id           = DBP_ETL.art_bestand_vw_sum_kmo_tmp.vw_id
  AND DBP_DATA.art_bestand_vw_sum.bezugsweg_id    = DBP_ETL.art_bestand_vw_sum_kmo_tmp.bezugsweg_id
  AND DBP_DATA.art_bestand_vw_sum.lagerbestand_fg = DBP_ETL.art_bestand_vw_sum_kmo_tmp.lagerbestand_fg
  AND DBP_DATA.art_bestand_vw_sum.nb_id           = DBP_ETL.art_bestand_vw_sum_kmo_tmp.nb_id
  AND DBP_DATA.art_bestand_vw_sum.art_id          = DBP_ETL.art_bestand_vw_sum_kmo_tmp.art_id
  AND DBP_DATA.art_bestand_vw_sum.wup_id          = DBP_ETL.art_bestand_vw_sum_kmo_tmp.wup_id
  AND DBP_DATA.art_bestand_vw_sum.dat             = DBP_ETL.art_bestand_vw_sum_kmo_tmp.dat
  AND DBP_DATA.art_bestand_vw_sum.gp_id           = DBP_ETL.art_bestand_vw_sum_kmo_tmp.gp_id
  AND DBP_DATA.art_bestand_vw_sum.wrg_id          = DBP_ETL.art_bestand_vw_sum_kmo_tmp.wrg_id
;

DELETE
FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp
WHERE COALESCE(menge_lgbest_erp_frei_bme, 0)   = 0
  AND COALESCE(menge_lgbest_erp_gesamt_bme, 0) = 0
  AND COALESCE(menge_lgbest_erp_qual_bme, 0)   = 0
  AND COALESCE(betrag_vk_netto_frei_bme, 0)    = 0
  AND COALESCE(betrag_vk_netto_gesamt_bme, 0)  = 0
  AND COALESCE(betrag_vk_netto_qual_bme, 0)    = 0
  AND COALESCE(menge_abgang_bme, 0)            = 0
  AND COALESCE(betrag_vk_netto_abgang, 0 )     = 0
;

INSERT INTO DBP_DATA.art_bestand_vw_sum
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
  ,td_insert
  ,td_update
)
SELECT
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,COALESCE (menge_abgang_bme, CAST (0 AS DECIMAL(18,3)))
  ,COALESCE (betrag_vk_netto_abgang, CAST (0 AS DECIMAL(18,4)))
  ,CURRENT_TIMESTAMP
  ,CURRENT_TIMESTAMP
FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp
;

INSERT INTO DBP_ETL.lager_process_tag_kmo
(
  mandant_id,
  dat,
  verarbeitet_fg
)
SELECT
  mandant_id,
  dat,
  1 AS verarbeitet_fg
FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp
WHERE (mandant_id, dat, verarbeitet_fg) NOT IN
 (SELECT mandant_id, dat, verarbeitet_fg
  FROM DBP_ETL.lager_process_tag_kmo
 )
GROUP BY 1,2,3
;

DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_kmo_tmp;
INSERT INTO DBP_ETL.lager_process_tag_kmo
(
  mandant_id,
  dat,
  verarbeitet_fg
)
SELECT
  l.mandant_id,
  t.dat,
  0 AS verarbeitet_fg
FROM DBP_DATA.tag t,
  (SELECT mandant_id
         ,MIN(dat) min_dat
   FROM DBP_ETL.lager_process_tag_kmo
   WHERE verarbeitet_fg = 1
   GROUP BY mandant_id
  ) l

WHERE t.dat < CURRENT_DATE -- maximal bis zum Vortag
  AND t.dat > l.min_dat
  AND (l.mandant_id, t.dat) NOT IN
  (SELECT mandant_id, dat
   FROM DBP_ETL.lager_process_tag_kmo
  ) -- noch nicht in lager_process_tag_kmo Tabelle
;

INSERT INTO DBP_DATA.art_bestand_vw_sum
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,td_insert
  ,td_update
)
SELECT
   a.mandant_id
  ,a.vw_id
  ,a.bezugsweg_id
  ,a.lagerbestand_fg
  ,a.nb_id
  ,a.art_id
  ,a.wup_id
  ,l.dat
  ,a.gp_id
  ,a.relevant_fg
  ,a.wrg_id
  ,a.menge_lgbest_erp_frei_bme
  ,a.menge_lgbest_erp_gesamt_bme
  ,a.menge_lgbest_erp_qual_bme
  ,a.betrag_vk_netto_frei_bme
  ,a.betrag_vk_netto_gesamt_bme
  ,a.betrag_vk_netto_qual_bme
  ,CURRENT_TIMESTAMP
  ,CURRENT_TIMESTAMP
FROM DBP_DATA.art_bestand_vw_sum a

INNER JOIN
(
  -- Ermittlung des maximalen bereits verarbeiteten Tag,
  -- der kleiner ist als der noch zu verarbeitende Tag.
  SELECT
    l.mandant_id, l.dat, v.dat AS max_verarbeitet_dat
  FROM DBP_ETL.lager_process_tag_kmo l

  INNER JOIN DBP_ETL.lager_process_tag_kmo v
     ON l.mandant_id = v.mandant_id
    AND v.verarbeitet_fg = 1 -- bereits verarbeitet
    AND l.dat > v.dat

  WHERE l.verarbeitet_fg = 0 -- noch nicht verarbeitet

  QUALIFY COUNT(*) OVER (PARTITION BY l.mandant_id, l.dat ORDER BY v.dat DESC ROWS UNBOUNDED PRECEDING) = 1
) l
ON l.dat >= a.dat
AND l.mandant_id = a.mandant_id

WHERE a.lagerbestand_fg = 1
  AND a.mandant_id IN (${MIDKMO})
  AND a.dat = max_verarbeitet_dat
;

DROP TABLE IF EXISTS DBP_ETL.lager_process_tag_kmo;
