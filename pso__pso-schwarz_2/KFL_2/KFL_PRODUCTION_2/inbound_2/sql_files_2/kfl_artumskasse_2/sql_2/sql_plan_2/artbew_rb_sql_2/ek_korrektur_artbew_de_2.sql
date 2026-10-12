-- 06.10.2023, -dbay-
--
-- EK-Korrekturen (DE) fuer die ARTBEW. In diesem Skript nur die
-- gemeldeten Tage und Artikel_2 einfuegen, dann laufen lassen.
--
-- Voraussetzung sind eine_2 konsistente ZEKP_2 und ART_GP_NM_ZU_PER_2!

create or replace volatile table _artikel_id as (
select b.art_id
from _artikel a
join dbp_data.art_2 b
  on a.kl_art_id = b.kl_art_id and
     b.dat_bis = '9999-12-31' and
     b.mandant_id = 1
);

create or replace volatile table _artikel (
  kl_art_id integer
);

insert into _artikel values (00010006);

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_anr_2 LIKE DBP_DATA.artbew_2;

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_dat_2 (
  dat DATE
);

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_dat_min_2 (
  dat DATE
);

CREATE OR REPLACE VOLATILE TABLE _vol_art_gp_wup_zu_per (
  mandant_id              SMALLINT NOT NULL,
  art_id                  INTEGER NOT NULL,
  gp_id                   INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  nb_id                   SMALLINT,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat                     DATE NOT NULL,
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logistikkostenzuschlag  DECIMAL(18,4),
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),
  ek_mep_vor_fwu          DECIMAL(18,4),
  bonusbasis              DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _art_wup_man_spanne_tmp (
  mandant_id SMALLINT NOT NULL,
  art_id     INTEGER NOT NULL,
  wup_id     INTEGER NOT NULL,
  nb_id      SMALLINT NOT NULL,
  dat        DATE NOT NULL,
  zwgs       DECIMAL(9,4),
  zwgm       DECIMAL(9,4),
  zwge       DECIMAL(9,4)
);

INSERT INTO DBP_ETL.de_wpuums_dat_2 (dat)
SELECT dat
FROM DBP_DATA.tag_2
WHERE dat between '2024-12-29' and '2025-01-02'
GROUP BY 1
;

INSERT INTO DBP_ETL.de_wpuums_dat_min_2 (dat)
SELECT MIN(dat)
FROM DBP_DATA.tag_2
WHERE dat between '2024-12-29' and '2025-01-02'
HAVING MIN(dat) IS NOT NULL
;

INSERT INTO _vol_art_gp_wup_zu_per
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,bonusbasis
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,bonusbasis
FROM
(
  SELECT
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,gp_id
    ,einkaufsorganisation_id
    ,dat_von
    ,dat_bis
    ,wrg_id
    ,CAST(ek_brutto          AS DECIMAL(18,4)) AS ek_brutto
    ,CAST(ek_netto           AS DECIMAL(18,4)) AS ek_netto
    ,CAST(ek_nettonetto      AS DECIMAL(18,4)) AS ek_nettonetto
    ,CAST(ek_kal_basis       AS DECIMAL(18,4)) AS ek_kal_basis
    ,CAST(ek_mep             AS DECIMAL(18,4)) AS ek_mep
    ,CAST(einstandspreis     AS DECIMAL(18,4)) AS einstandspreis
    ,logistikkostenzuschlag
    ,CAST(ek_netto_bnk       AS DECIMAL(18,4)) AS ek_netto_bnk
    ,CAST(ek_netto_bnk_sachk AS DECIMAL(18,4)) AS ek_netto_bnk_sachk
    ,CAST(ek_mep_vor_fwu     AS DECIMAL(18,4)) AS ek_mep_vor_fwu
    ,CAST(bonusbasis          AS DECIMAL(18,4)) AS bonusbasis
  FROM DBP_DATA.art_gp_wup_zu_per_2 a

  INNER JOIN DBP_ETL.de_wpuums_dat_min_2 m
  ON a.dat_bis >= m.dat

  WHERE a.mandant_id = 1) a

-- auf Tag_2 auffaechern
INNER JOIN DBP_ETL.de_wpuums_dat_2 d
ON d.dat BETWEEN a.dat_von AND a.dat_bis
;

-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren

INSERT INTO _art_wup_man_spanne_tmp (mandant_id,
                                     art_id,
                                     wup_id,
                                     nb_id,
                                     dat,
                                     zwgs,
                                     zwgm,
                                     zwge)
SELECT ein.mandant_id
      ,ein.art_id
      ,-1 AS wup_id
      ,-1 AS nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM DBP_ETL.de_wpuums_dat_2 a

INNER JOIN DBP_DATA.art_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

-- Nun die betriebsspezifischen manuellen Spannenfaktoren!

INSERT INTO _art_wup_man_spanne_tmp (mandant_id,
                                     art_id,
                                     wup_id,
                                     nb_id,
                                     dat,
                                     zwgs,
                                     zwgm,
                                     zwge)
SELECT ein.mandant_id
      ,ein.art_id
      ,ein.wup_id 
      ,ein.nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM DBP_ETL.de_wpuums_dat_2 a

INNER JOIN DBP_DATA.art_wup_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.wup_id  = ein.wup_id 
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.wup_id  = ein.wup_id 
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

INSERT INTO DBP_ETL.de_wpuums_anr_2 (mandant_id
                                     ,wup_id
                                     ,nb_id
                                     ,art_id
                                     ,gp_id
                                     ,einkaufsorganisation_id
                                     ,bewart_id
                                     ,dat
                                     ,aktion_id
                                     ,herst_id
                                     ,mwst_id
                                     ,wrg_2
                                     ,posten_id
                                     ,bezugsweg_id
                                     ,ean_kasse
                                     ,menge
                                     ,umsatz_netto
                                     ,diff_umsatz_netto_konz
                                     ,umsatz_mwst_betrag
                                     ,diff_umsatz_mwst_betrag_konz
                                     ,ek_brutto
                                     ,diff_ek_brutto_konz
                                     ,ek_netto
                                     ,diff_ek_netto_konz
                                     ,ek_nettonetto
                                     ,diff_ek_nettonetto_konz
                                     ,ek_kal_basis
                                     ,diff_ek_kal_basis_konz
                                     ,ek_mep
                                     ,diff_ek_mep_konz
                                     ,einstandspreis
                                     ,diff_einstandspreis_konz
                                     ,logkostenzuschlag
                                     ,diff_logkostenzuschlag_konz
                                     ,ek_netto_bnk
                                     ,diff_ek_netto_bnk_konz
                                     ,ek_netto_bnk_sachk
                                     ,diff_ek_netto_bnk_sachk_konz
                                     ,ek_gld
                                     ,diff_ek_gld_konz
                                     ,ek_mep_vor_fwu
                                     ,ek_mep_vor_fwu_konz
                                     ,bonusbasis
                                     ,bonusbasis_konz
                                     ,bq_findung_id
                                     ,promo_fg
                                     ,bewart_det_id
                                     ,pv_aktion
                                     ,pv_bby
                                     ,pv_kdn_bby
                                     ,pv_kdp_bby
                                     ,pv_aktion_bby
                                     ,pv_aktion_kdn_bby
                                     ,pv_aktion_kdp_bby
                                     ,wup_bereinigt_fg
                                     ,standard_aktion_id)
SELECT y.mandant_id
      ,y.wup_id
      ,y.nb_id
      ,y.art_id
      ,y.gp_id
      ,y.einkaufsorganisation_id
      ,y.bewart_id
      ,y.dat
      ,y.aktion_id
      ,y.herst_id
      ,y.mwst_id
      ,y.wrg_2
      ,y.posten_id
      ,y.bezugsweg_id
      ,y.ean_kasse
      ,y.menge
      ,y.umsatz_netto
      ,y.diff_umsatz_netto_konz
      ,y.umsatz_mwst_betrag
      ,y.diff_umsatz_mwst_betrag_konz
      ,y.ek_brutto_                     AS ek_brutto 
      ,y.diff_ek_brutto_konz_           AS diff_ek_brutto_konz
      ,y.ek_netto_                      AS ek_netto 
      ,y.diff_ek_netto_konz_            AS diff_ek_netto_konz
      ,y.ek_nettonetto_                 AS ek_nettonetto 
      ,y.diff_ek_nettonetto_konz_       AS diff_ek_nettonetto_konz     
      ,y.ek_kal_basis_                  AS ek_kal_basis 
      ,y.diff_ek_kal_basis_konz_        AS diff_ek_kal_basis_konz 
      ,y.ek_mep_                        AS ek_mep 
      ,y.diff_ek_mep_konz_              AS diff_ek_mep_konz 
      ,y.einstandspreis_                AS einstandspreis 
      ,y.diff_einstandspreis_konz_      AS diff_einstandspreis_konz 
      ,y.logkostenzuschlag_
      ,y.diff_logkostenzuschlag_konz_
      ,y.ek_netto_bnk_                  AS ek_netto_bnk 
      ,y.diff_ek_netto_bnk_konz_        AS diff_ek_netto_bnk_konz 
      ,y.ek_netto_bnk_sachk_            AS ek_netto_bnk_sachk 
      ,y.diff_ek_netto_bnk_sachk_konz_  AS diff_ek_netto_bnk_sachk_konz 
      ,y.ek_gld 
      ,y.diff_ek_gld_konz
      ,y.ek_mep_vor_fwu_                AS ek_mep_vor_fwu
      ,y.ek_mep_vor_fwu_konz_           AS ek_mep_vor_fwu_konz
      ,y.bonusbasis_                     AS bonusbasis
      ,y.bonusbasis_konz_                AS bonusbasis_konz
      ,y.bq_findung_id
      ,y.promo_fg
      ,y.bewart_det_id
      ,y.pv_aktion
      ,y.pv_bby
      ,y.pv_kdn_bby
      ,y.pv_kdp_bby
      ,y.pv_aktion_bby
      ,y.pv_aktion_kdn_bby
      ,y.pv_aktion_kdp_bby
      ,y.wup_bereinigt_fg
      ,y.standard_aktion_id
FROM (SELECT a.mandant_id
            ,a.wup_id
            ,a.nb_id
            ,a.art_id
            ,COALESCE(x.gp_id, a.gp_id) AS gp_id
            ,COALESCE(x.einkaufsorganisation_id, a.einkaufsorganisation_id) AS einkaufsorganisation_id
            ,a.bewart_id
            ,a.dat
            ,a.aktion_id
            ,a.herst_id
            ,a.mwst_id
            ,a.wrg_2
            ,a.posten_id
            ,COALESCE(x.bezugsweg_id, a.bezugsweg_id) AS bezugsweg_id
            ,a.ean_kasse
            ,a.menge
            ,a.umsatz_netto
            ,a.diff_umsatz_netto_konz
            ,a.umsatz_mwst_betrag
            ,a.diff_umsatz_mwst_betrag_konz
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             CAST(a.menge * COALESCE(agw.ek_brutto, agww.ek_brutto, agwww.ek_brutto) AS DECIMAL(18,4)),
                             CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_brutto_
            ,0 AS diff_ek_brutto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_netto, agww.ek_netto, agwww.ek_netto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_
            ,0 AS diff_ek_netto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_nettonetto_
            ,0 AS diff_ek_nettonetto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_kal_basis, agww.ek_kal_basis, agwww.ek_kal_basis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_kal_basis_
            ,0 AS diff_ek_kal_basis_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_mep, agww.ek_mep, agwww.ek_mep) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_
            ,0 AS diff_ek_mep_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS einstandspreis_
            ,0 AS diff_einstandspreis_konz_
            ,menge * COALESCE(agw.logistikkostenzuschlag, agww.logistikkostenzuschlag, 0.0000) AS logkostenzuschlag_
            ,0 AS diff_logkostenzuschlag_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_
            ,0 AS diff_ek_netto_bnk_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk_sachk, agww.ek_netto_bnk_sachk, agwww.ek_netto_bnk_sachk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_sachk_
            ,0 AS diff_ek_netto_bnk_sachk_konz_
            ,a.ek_gld
            ,a.diff_ek_gld_konz
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.ek_mep_vor_fwu, agww.ek_mep_vor_fwu, agwww.ek_mep_vor_fwu) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_vor_fwu_
            ,0 AS ek_mep_vor_fwu_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_2          */ CAST(a.menge * COALESCE(agw.bonusbasis, agww.bonusbasis, agwww.bonusbasis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS bonusbasis_
            ,0 AS bonusbasis_konz_
            ,COALESCE(x.bq_findung_id, 30) AS bq_findung_id
            ,a.promo_fg
            ,a.bewart_det_id
            ,a.pv_aktion
            ,a.pv_bby
            ,a.pv_kdn_bby
            ,a.pv_kdp_bby
            ,a.pv_aktion_bby
            ,a.pv_aktion_kdn_bby
            ,a.pv_aktion_kdp_bby
            ,a.wup_bereinigt_fg
            ,a.standard_aktion_id
      FROM DBP_DATA.artbew_2 a			
      INNER JOIN DBP_ETL.de_wpuums_dat_2 d
        ON a.dat = d.dat

      -- Lieferant und Ausstiegspunkt ermitteln
      LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per_2 x
      ON a.mandant_id = x.mandant_id
      AND a.wup_id = x.wup_id
      AND a.art_id = x.art_id
      AND a.dat BETWEEN x.dat_von AND x.dat_bis

      LEFT JOIN DBP_DATA.ek_orderbuch_2 xxx_2
        ON a.mandant_id = xxx.mandant_id
      AND x.gp_id = xxx.wup_id
      AND a.art_id = xxx.art_id
      AND a.dat BETWEEN xxx.dat_von AND xxx.dat_bis

      -- Betriebsuebergreifender EK Preis
      LEFT OUTER JOIN _vol_art_gp_wup_zu_per agwww
      ON x.mandant_id = agwww.mandant_id
      AND x.gp_id        = agwww.wup_id
      AND x.art_id  = agwww.art_id
      AND COALESCE(xxx.gp_id,x.gp_id)   = agwww.gp_id
      AND a.dat     = agwww.dat

      -- Betriebsspezifischer EK Preis
      LEFT OUTER JOIN _vol_art_gp_wup_zu_per agw
      ON x.mandant_id   = agw.mandant_id
      AND x.vz_wup_id = agw.wup_id
      AND x.art_id    = agw.art_id
      AND COALESCE(xxx.gp_id,x.gp_id)     = agw.gp_id
      AND a.dat       = agw.dat

      -- Betriebsuebergreifender EK Preis
      LEFT OUTER JOIN _vol_art_gp_wup_zu_per agww
      ON x.mandant_id = agww.mandant_id
      AND -1        = agww.wup_id
      AND x.art_id  = agww.art_id
      AND x.gp_id   = agww.gp_id
      AND a.dat     = agww.dat

      -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren
      LEFT OUTER JOIN _art_wup_man_spanne_tmp ms
      ON a.mandant_id = ms.mandant_id
      AND a.art_id  = ms.art_id
      AND ms.wup_id = -1
      AND a.dat = ms.dat
      AND x.bq_findung_id = 27

      -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren
      LEFT OUTER JOIN _art_wup_man_spanne_tmp ma
      ON a.mandant_id = ma.mandant_id
      AND a.art_id = ma.art_id
      AND a.wup_id = ma.wup_id
      AND a.dat = ma.dat
      AND x.bq_findung_id = 26

      WHERE a.mandant_id = 1 and
            a.art_id in (select art_id from _artikel_id) and
            a.dat between '2024-12-29' and '2025-01-02') y
;

-- 564.034





delete from DBP_DATA.artbew_2 a
where (a.mandant_id,a.wup_id,a.art_id,a.dat) in (select mandant_id,wup_id,art_id,dat from DBP_ETL.de_wpuums_anr_2)
;

INSERT INTO DBP_DATA.artbew_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_2
  ,posten_id
  ,bezugsweg_id
  ,ean_kasse
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,ek_brutto
  ,diff_ek_brutto_konz
  ,ek_netto
  ,diff_ek_netto_konz
  ,ek_nettonetto
  ,diff_ek_nettonetto_konz
  ,ek_kal_basis
  ,diff_ek_kal_basis_konz
  ,ek_mep
  ,diff_ek_mep_konz
  ,einstandspreis
  ,diff_einstandspreis_konz
  ,logkostenzuschlag
  ,diff_logkostenzuschlag_konz
  ,ek_netto_bnk
  ,diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz
  ,ek_gld
  ,diff_ek_gld_konz
  ,ek_mep_vor_fwu
  ,ek_mep_vor_fwu_konz
  ,bonusbasis
  ,bonusbasis_konz
  ,bq_findung_id
  ,promo_fg
  ,bewart_det_id
  ,pv_aktion
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
  ,pv_aktion_bby
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby  
  ,td_insert
  ,td_update
  ,wup_bereinigt_fg
  ,standard_aktion_id
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_2
  ,posten_id
  ,bezugsweg_id
  ,ean_kasse
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,ek_brutto
  ,diff_ek_brutto_konz
  ,ek_netto
  ,diff_ek_netto_konz
  ,ek_nettonetto
  ,diff_ek_nettonetto_konz
  ,ek_kal_basis
  ,diff_ek_kal_basis_konz
  ,ek_mep
  ,diff_ek_mep_konz
  ,einstandspreis
  ,diff_einstandspreis_konz
  ,logkostenzuschlag
  ,diff_logkostenzuschlag_konz
  ,ek_netto_bnk
  ,diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz
  ,ek_gld
  ,diff_ek_gld_konz
  ,ek_mep_vor_fwu
  ,ek_mep_vor_fwu_konz
  ,bonusbasis
  ,bonusbasis_konz
  ,bq_findung_id
  ,promo_fg
  ,bewart_det_id
  ,pv_aktion
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
  ,pv_aktion_bby
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby    
  ,CURRENT_TIMESTAMP as td_insert
  ,CURRENT_TIMESTAMP as td_update
  ,wup_bereinigt_fg
  ,standard_aktion_id
FROM DBP_ETL.de_wpuums_anr_2
;
