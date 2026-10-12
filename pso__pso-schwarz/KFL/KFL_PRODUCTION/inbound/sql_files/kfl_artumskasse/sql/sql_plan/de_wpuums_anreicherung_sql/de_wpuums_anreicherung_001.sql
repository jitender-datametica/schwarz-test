CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_anr AS (
SELECT TOP 0 *
FROM DBP_DATA.artbew
);

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_dat (
  dat DATE
);

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_dat_min (
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

INSERT INTO DBP_ETL.de_wpuums_dat (dat)
SELECT dat
FROM DBP_DATA.artbew_agg_wt
WHERE mandant_id = 1 AND
      dat >= '2021-09-25'
GROUP BY 1
;

INSERT INTO DBP_ETL.de_wpuums_dat_min (dat)
SELECT MIN(dat)
FROM DBP_DATA.artbew_agg_wt
WHERE mandant_id = 1 AND
      dat >= '2021-09-25'
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
    ,CAST(bonusbasis         AS DECIMAL(18,4)) AS bonusbasis

  FROM DBP_DATA.art_gp_wup_zu_per a

  INNER JOIN DBP_ETL.de_wpuums_dat_min m
  ON a.dat_bis >= m.dat

  WHERE a.mandant_id = 1) a

-- auf Tag auffaechern
INNER JOIN DBP_ETL.de_wpuums_dat d
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
FROM DBP_ETL.de_wpuums_dat a

INNER JOIN DBP_DATA.art_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per ekbnk /*optional*/
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
FROM DBP_ETL.de_wpuums_dat a

INNER JOIN DBP_DATA.art_wup_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.wup_id  = ein.wup_id 
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.wup_id  = ein.wup_id 
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

INSERT INTO DBP_ETL.de_wpuums_anr (mandant_id
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
                                     ,wrg
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
                                     ,standard_aktion_id
                                     ,umrechnungskurs_hist
                                     ,aktionsart_id_liste_txt
                                     ,aktionsart_bez_liste_txt
                                     ,aktion_typ_id_liste_txt
                                     ,aktion_typ_bez_liste_txt)
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
      ,y.wrg
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
      ,y.bonusbasis_                    AS bonusbasis
      ,y.bonusbasis_konz_               AS bonusbasis_konz
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
      ,y.umrechnungskurs_hist
      ,y.aktionsart_id_liste_txt
      ,y.aktionsart_bez_liste_txt
      ,y.aktion_typ_id_liste_txt
      ,y.aktion_typ_bez_liste_txt
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
            ,a.wrg
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
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_netto, agww.ek_netto, agwww.ek_netto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_
            ,0 AS diff_ek_netto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_nettonetto_
            ,0 AS diff_ek_nettonetto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_kal_basis, agww.ek_kal_basis, agwww.ek_kal_basis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_kal_basis_
            ,0 AS diff_ek_kal_basis_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_mep, agww.ek_mep, agwww.ek_mep) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_
            ,0 AS diff_ek_mep_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS einstandspreis_
            ,0 AS diff_einstandspreis_konz_
            ,menge * COALESCE(agw.logistikkostenzuschlag, agww.logistikkostenzuschlag, 0.0000) AS logkostenzuschlag_
            ,0 AS diff_logkostenzuschlag_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_
            ,0 AS diff_ek_netto_bnk_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk_sachk, agww.ek_netto_bnk_sachk, agwww.ek_netto_bnk_sachk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_sachk_
            ,0 AS diff_ek_netto_bnk_sachk_konz_
            ,a.ek_gld
            ,a.diff_ek_gld_konz
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_mep_vor_fwu, agww.ek_mep_vor_fwu, agwww.ek_mep_vor_fwu) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_vor_fwu_
            ,0 AS ek_mep_vor_fwu_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.bonusbasis, agww.bonusbasis, agwww.bonusbasis) AS DECIMAL(18,4)),
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
            ,a.umrechnungskurs_hist
            ,a.aktionsart_id_liste_txt
            ,a.aktionsart_bez_liste_txt
            ,a.aktion_typ_id_liste_txt
            ,a.aktion_typ_bez_liste_txt
      FROM DBP_DATA.artbew a			
      INNER JOIN DBP_ETL.de_wpuums_dat d
        ON a.dat = d.dat

      -- Lieferant und Ausstiegspunkt ermitteln
      LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per x
      ON a.mandant_id = x.mandant_id
      AND a.wup_id = x.wup_id
      AND a.art_id = x.art_id
      AND a.dat BETWEEN x.dat_von AND x.dat_bis

      LEFT JOIN DBP_DATA.ek_orderbuch xxx
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

      WHERE a.mandant_id = 1) y
;

DELETE FROM DBP_DATA.artbew a
WHERE a.dat in (select dat from DBP_ETL.de_wpuums_dat)
  AND a.mandant_id = 1
;

INSERT INTO DBP_DATA.artbew
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
  ,wrg
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
  ,umrechnungskurs_hist
  ,aktionsart_id_liste_txt
  ,aktionsart_bez_liste_txt
  ,aktion_typ_id_liste_txt
  ,aktion_typ_bez_liste_txt
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
  ,wrg
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
  ,umrechnungskurs_hist
  ,aktionsart_id_liste_txt
  ,aktionsart_bez_liste_txt
  ,aktion_typ_id_liste_txt
  ,aktion_typ_bez_liste_txt
FROM DBP_ETL.de_wpuums_anr;

/*
_---------------------------------------------------------------------------------------------------------
_                                  STUECKLISTENAUFLOESUNG INKL. EK-BEWERTUNG                                             
_---------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VOLATILE TABLE _step01 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  promo_fg INTEGER,
  aktion_id VARCHAR(10),
  dat DATE,
  wrg CHAR(3),
  ean_kasse DECIMAL(26,0),
  wg_id INTEGER,
  bezugsweg_id SMALLINT,
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER
);

CREATE OR REPLACE VOLATILE TABLE _step02 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  promo_fg INTEGER,
  aktion_id VARCHAR(10),
  dat DATE,
  wrg CHAR(3),
  ean_kasse DECIMAL(26,0),
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id SMALLINT,
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  ek_mep_vor_fwu DECIMAL(18,4),
  bonusbasis DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _step02a (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  promo_fg INTEGER,
  aktion_id VARCHAR(10),
  dat DATE,
  wrg CHAR(3),
  ean_kasse DECIMAL(26,0),
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id SMALLINT,
  umsatz_anteil DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst DECIMAL(18,4),
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  ek_mep_vor_fwu DECIMAL(18,4),
  bonusbasis DECIMAL(18,4),
  diff_ek_brutto_konz DECIMAL(18,4),
  diff_ek_netto_konz DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  diff_ek_kal_basis_konz DECIMAL(18,4),
  diff_ek_mep_konz DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  diff_logkostenzuschlag_konz DECIMAL(18,4),
  diff_ek_netto_bnk_konz DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
  ek_mep_vor_fwu_konz DECIMAL(18,4),
  bonusbasis_konz DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _step03 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  promo_fg INTEGER,
  aktion_id VARCHAR(10),
  dat DATE,
  wrg CHAR(3),
  ean_kasse DECIMAL(26,0),
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id SMALLINT,
  umsatz_anteil DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst DECIMAL(18,4),
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  ek_mep_vor_fwu DECIMAL(18,4),
  bonusbasis DECIMAL(18,4),
  diff_ek_brutto_konz DECIMAL(18,4),
  diff_ek_netto_konz DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  diff_ek_kal_basis_konz DECIMAL(18,4),
  diff_ek_mep_konz DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  diff_logkostenzuschlag_konz DECIMAL(18,4),
  diff_ek_netto_bnk_konz DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
  ek_mep_vor_fwu_konz DECIMAL(18,4),
  bonusbasis_konz DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _aggregat01 (
  mandant_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  promo_fg INTEGER,
  aktion_id VARCHAR(10),
  wup_id INTEGER,
  nb_id SMALLINT,
  dat DATE,
  ean_kasse DECIMAL(26,0),
  umsatz_netto DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _spannen_agg1 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  kopf_art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  promo_fg INTEGER,
  aktion_id VARCHAR(10),
  stueckliste_id INTEGER,
  dat DATE,
  ean_kasse DECIMAL(26,0),
  ek_netto_sum DECIMAL(18,4)
);

-- 18.12.2012, -dba-
--
-- Aus der ARTBEW werden zunaechst fuer die relevanten Tage alle betroffenen Kopfartikel ermittelt. Ueber den
-- nachgelagerten JOIN gegen die Komponententabelle STUECKLISTE_DET werden dann die zugehoerigen Fußartikel mit
-- der auf Basismengeneinheit geeichten Menge in die Zwischentabelle STEP01 eingespielt.

INSERT INTO _step01 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     promo_fg,
                     aktion_id,
                     dat,
                     wrg,
                     ean_kasse,
                     wg_id,
                     bezugsweg_id,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       b.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.promo_fg,
       a.aktion_id,
       a.dat,
       a.wrg,
       a.ean_kasse,
       y.wg_id,
       COALESCE(x.bezugsweg_id,a.bezugsweg_id) AS bezugsweg_id,
       SUM(CAST(a.menge AS FLOAT)) AS menge,
       SUM(CAST(a.umsatz_netto AS DECIMAL(18,4))) AS umsatz_netto_alt,
       SUM(CAST(a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_mwst_betrag_alt,
       SUM(CAST(a.umsatz_netto+a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_bto,
       CAST(0 AS FLOAT) AS umrechnungskurs,
       a.art_id AS kopf_art_id,
       -- falls eine Komponente mehrfach in der Stueckliste vorhanden ist: Menge aufsummieren 
       CAST(SUM(CAST(a.menge AS FLOAT) * CAST(b.komponentenmenge AS FLOAT)) / MAX(COALESCE(c.umrech_faktor, 1.0000)) AS DECIMAL(18,4)) AS komponentenmengen_faktor,
       b.stueckliste_id
FROM DBP_DATA.artbew a

LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  art_id,
                  dat_von,
                  dat_bis,
                  bezugsweg_id
           FROM DBP_DATA.art_wup_zu_per
           WHERE mandant_id = 1
             AND dat_bis >= (SELECT dat FROM DBP_ETL.de_wpuums_dat_min)
           ) x
  ON a.wup_id = x.wup_id AND
     a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.dat BETWEEN x.dat_von AND x.dat_bis

JOIN DBP_DATA.art_wg_zu_per y
  ON a.mandant_id = y.mandant_id AND
     a.art_id = y.art_id AND
	 y.arthiertyp_id = 2 AND
	 y.dat_bis = '9999-12-31'

JOIN DBP_ETL.de_wpuums_dat d
  ON a.dat = d.dat

-- Ermittlung Kopfartikel
--
-- 29.01.2013, DBA
--
-- Aenderung hinsichtlich des Abgreifens von Stuecklistenkoepfen! Die Stammtabelle ist laut
-- Vorgabe (!!!) nicht eindeutig pro Kopfartikel versorgt, so dass zu einem Stichtag durchaus
-- mehrere Koepfe in verschiedenen Stuecklisten gefuehrt werden koennen. Das ist natuerlich
-- fachlich vollkommener Bloedsinn, aber laut FB sollte man hier mit einem MAX(...) das Ganze
-- zurechtstutzen. (Aufgefallen war das Problem am 29.01.2013 bei den Artikeln 180600, 180580
-- fuer den Mandant 8 mit Stichtag 28.01.2013.)
--
-- Des Weiteren die Filter auf STLAN=3 u. WERKS IS NULL fuer Stuecklistenkopf hinterlegt (s.
-- IT-Konzept [DWH BE TP5-016-Abbildung VK Set]).
JOIN (SELECT a.mandant_id,
             a.stueckliste_id,
             a.dat_von,
             a.dat_bis,
             a.art_id,
             NULL wup_id,
             NULL nb_id,
             a.stueckliste_verwendung_id
      FROM DBP_DATA.stueckliste a
      JOIN DBP_ETL.de_wpuums_dat_min m
        ON a.dat_bis >= m.dat
      WHERE --a.wup_id IS NULL AND
            a.stueckliste_verwendung_id = 3 AND
           (a.mandant_id, a.art_id, a.stueckliste_id) IN (SELECT mandant_id,
                                                                 art_id,
                                                                 MAX(stueckliste_id) AS stueckliste_id
                                                          FROM DBP_DATA.stueckliste
                                                          GROUP BY 1,2)) k
  ON a.mandant_id = k.mandant_id  AND 
     a.art_id     = k.art_id      AND
     a.dat BETWEEN k.dat_von AND k.dat_bis

-- Ermittlung Fußartikel
JOIN (SELECT *
      FROM DBP_DATA.stueckliste_det
      WHERE stueckliste_typ_id = 'M') b
  ON k.mandant_id     = b.mandant_id     AND 
     k.stueckliste_id = b.stueckliste_id AND
     a.dat BETWEEN b.dat_von AND b.dat_bis

-- Ermittlung Umrechnungsfaktor, damit korrekter Bezug zur Basismengeneinheit hergestellt wird.
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per c
ON b.mandant_id               = c.mandant_id          AND 
   b.art_id                   = c.art_id              AND 
   b.komponentenmenge_einh_id = c.altnv_menge_einh_id AND 
   c.dat_bis = '9999-12-31'
   
WHERE a.mandant_id = 1    AND
      a.menge <> 0        AND  /* nur Positionen mit Abverkauf beruecksichtigen! */
      a.umsatz_netto <> 0      /* nur Positionen mit Abverkauf beruecksichtigen! */

GROUP BY a.mandant_id,a.wup_id,a.nb_id,b.art_id,a.dat,a.art_id,b.stueckliste_id,a.wrg,a.ean_kasse,y.wg_id,COALESCE(x.bezugsweg_id,a.bezugsweg_id),a.bewart_id,a.bewart_det_id,a.promo_fg,a.aktion_id
;

-- 18.12.2012, -dba-
--
-- Nachgelagert werden dann alle Koepfe in dieselbe volatile Tabelle gespielt. Als Kennung wird in die Spalte
-- KOPF_ART_ID nun der Wert "-100" eingestellt, um spaeter zwischen Kopf und Fuß unterscheiden zu koennen.

INSERT INTO _step01 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     promo_fg,
                     aktion_id,
                     dat,
                     wrg,
                     ean_kasse,
                     wg_id,
                     bezugsweg_id,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.promo_fg,
       a.aktion_id,
       a.dat,
       a.wrg,
       a.ean_kasse,
       y.wg_id,
       COALESCE(x.bezugsweg_id,a.bezugsweg_id) AS bezugsweg_id,
       SUM(CAST(a.menge AS FLOAT)) AS menge,
       SUM(CAST(a.umsatz_netto AS DECIMAL(18,4))) AS umsatz_netto_alt,
       SUM(CAST(a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_mwst_betrag_alt,
       SUM(CAST(a.umsatz_netto+a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_bto,
       CAST(0 AS FLOAT) AS umrechnungskurs,
       -100 AS kopf_art_id,
       0 AS komponentenmengen_faktor,
       c.stueckliste_id
FROM DBP_DATA.artbew a

LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  art_id,
                  dat_von,
                  dat_bis,
                  bezugsweg_id
           FROM DBP_DATA.art_wup_zu_per
           WHERE mandant_id = 1
             AND dat_bis >= (SELECT dat FROM DBP_ETL.de_wpuums_dat_min)
           ) x
  ON a.wup_id = x.wup_id AND
     a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.dat BETWEEN x.dat_von AND x.dat_bis

JOIN DBP_DATA.art_wg_zu_per y
  ON a.mandant_id = y.mandant_id AND
     a.art_id = y.art_id AND
	 y.arthiertyp_id = 2 AND
	 y.dat_bis = '9999-12-31'

JOIN DBP_ETL.de_wpuums_dat d
  ON a.dat = d.dat

-- Ermittlung Kopfartikel
--
-- 29.01.2013, DBA
--
-- Aenderung hinsichtlich des Abgreifens von Stuecklistenkoepfen! Die Stammtabelle ist laut
-- Vorgabe (!!!) nicht eindeutig pro Kopfartikel versorgt, so dass zu einem Stichtag durchaus
-- mehrere Koepfe in verschiedenen Stuecklisten gefuehrt werden koennen. Das ist natuerlich
-- fachlich vollkommener Bloedsinn, aber laut FB sollte man hier mit einem MAX(...) das Ganze
-- zurechtstutzen. (Aufgefallen war das Problem am 29.01.2013 bei den Artikeln 180600, 180580
-- fuer den Mandant 8 mit Stichtag 28.01.2013.)
--
-- Des Weiteren die Filter auf STLAN=3 u. WERKS IS NULL fuer Stuecklistenkopf hinterlegt (s.
-- IT-Konzept [DWH BE TP5-016-Abbildung VK Set]).
JOIN (SELECT a.mandant_id,
             a.stueckliste_id,
             a.dat_von,
             a.dat_bis,
             a.art_id,
             NULL wup_id,
             NULL nb_id,
             a.stueckliste_verwendung_id
      FROM DBP_DATA.stueckliste a
      JOIN DBP_ETL.de_wpuums_dat_min m
        ON a.dat_bis >= m.dat
      WHERE a.stueckliste_verwendung_id = 3 AND
           (a.mandant_id, a.art_id, a.stueckliste_id) IN (SELECT mandant_id,
                                                                 art_id,
                                                                 MAX(stueckliste_id) AS stueckliste_id
                                                          FROM DBP_DATA.stueckliste
                                                          GROUP BY 1,2)) c
  ON a.mandant_id = c.mandant_id  AND 
     a.art_id     = c.art_id      AND
     a.dat BETWEEN c.dat_von AND c.dat_bis

WHERE a.mandant_id = 1    AND
      a.menge <> 0        AND /* nur Positionen mit Abverkauf beruecksichtigen! */
      a.umsatz_netto <> 0     /* nur Positionen mit Abverkauf beruecksichtigen! */
  
GROUP BY a.mandant_id,a.wup_id,a.nb_id,a.art_id,a.dat,umrechnungskurs,a.art_id,c.stueckliste_id,a.wrg,a.ean_kasse,y.wg_id,COALESCE(x.bezugsweg_id,a.bezugsweg_id),a.bewart_id,a.bewart_det_id,a.promo_fg,a.aktion_id
;

-- 18.12.2012, -dba-
--
-- Standardmaeßige EK-Ermittlung, die an dieser Stelle nur fuer die Fußartikel greift, da die VK-Set Kopfartikel
-- NICHT in der EK-Tabelle gefuehrt werden! Somit sind selbige nach diesem Step noch NULL!

INSERT INTO _step02 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     promo_fg,
                     aktion_id,
                     dat,
                     wrg,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     ek_mep_vor_fwu,
                     bonusbasis)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.promo_fg,
       a.aktion_id,
       a.dat,
       a.wrg,
       a.ean_kasse,
       a.menge,
       a.umsatz_netto_alt,
       a.umsatz_mwst_betrag_alt,
       a.umsatz_bto,
       a.umrechnungskurs,
       a.kopf_art_id,
       a.komponentenmengen_faktor,
       a.stueckliste_id,
       x.bq_findung_id,
       a.komponentenmengen_faktor * COALESCE(agw.ek_brutto, agww.ek_brutto)                                  AS ek_brutto_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_netto, agww.ek_netto)                                    AS ek_netto_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_nettonetto, agww.ek_nettonetto)                          AS ek_nettonetto_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_kal_basis, agww.ek_kal_basis)                            AS ek_kal_basis_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_mep, agww.ek_mep)                                        AS ek_mep_,
       a.komponentenmengen_faktor * COALESCE(agw.einstandspreis, agww.einstandspreis)                        AS einstandspreis_,
       a.komponentenmengen_faktor * COALESCE(agw.logistikkostenzuschlag, agww.logistikkostenzuschlag,0.0000) AS logistikkostenzuschlag_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_netto_bnk, agww.ek_netto_bnk)                            AS ek_netto_bnk_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_netto_bnk_sachk, agww.ek_netto_bnk_sachk)                AS ek_netto_bnk_sachk_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_mep_vor_fwu, agww.ek_mep_vor_fwu)                        AS ek_mep_vor_fwu_,
       a.komponentenmengen_faktor * COALESCE(agw.bonusbasis, agww.bonusbasis)                                AS bonusbasis_

FROM _step01 a

JOIN DBP_DATA.art_gp_nm_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id     = x.art_id     AND
     a.wup_id     = x.wup_id     AND
     a.dat BETWEEN x.dat_von AND x.dat_bis
                         
-- Ermittlung betriebsspezifischer ZEKP Satz mit VZ aus
-- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1
LEFT OUTER JOIN _vol_art_gp_wup_zu_per agw
  ON a.mandant_id                 = agw.mandant_id
    AND x.vz_wup_id               = agw.wup_id  /*hier Zugriff mit Wup/VZ aus Kreisprozess !!*/
    --AND x.nb_id                   = agw.nb_id
    AND a.art_id                  = agw.art_id
    AND x.gp_id                   = agw.gp_id
    AND x.einkaufsorganisation_id = agw.einkaufsorganisation_id
    AND a.dat                     = agw.dat

-- Betrieb = blank für Bezugsweg 1 und 4 beim ersten
-- Zugriff nichts gefunden wird.
LEFT OUTER JOIN _vol_art_gp_wup_zu_per agww
  ON a.mandant_id                 = agww.mandant_id
    AND agww.wup_id               = -1  /*Betrieb = 'blank'*/
    AND a.art_id                  = agww.art_id
    AND x.gp_id                   = agww.gp_id
    AND x.einkaufsorganisation_id = agww.einkaufsorganisation_id
    AND a.dat                     = agww.dat
;

-- 18.12.2012, -dba-
--
-- Im normalen Deltabetrieb eigentlich ein obsoleter Step. Allerdings können durch das Anziehen unserer neuen
-- BQ-Tabelle ART_GP_NM_ZU_PER, die erst ab Oktober regelmaeßig mitlief, Ungenauigkeiten beim Lieferanten fuer
-- historische Daten (z.B. auf Q fuer Initialbefuellung!) entstehen. Deswegen zur Sicherheit noch einmal ein
-- Update und das Setzen auf den UMSATZ_NETTO (Spanne 0%) fuer solche Faelle.

UPDATE _step02

SET ek_brutto = umsatz_netto_alt,
    ek_netto  = umsatz_netto_alt,
    ek_nettonetto = umsatz_netto_alt,
    ek_kal_basis = umsatz_netto_alt,
    ek_mep = umsatz_netto_alt,
    einstandspreis = umsatz_netto_alt,
    ek_netto_bnk = umsatz_netto_alt,
    ek_netto_bnk_sachk = umsatz_netto_alt,
    ek_mep_vor_fwu = umsatz_netto_alt,
    bonusbasis = umsatz_netto_alt

WHERE _step02.kopf_art_id <> -100 AND
      _step02.ek_brutto = 0
;

-- 18.12.2012, -dba-
--
-- Zunaechst wird eine Tabelle mit Kopfinformationen bzgl. UMSATZ_NETTO erstellt.
INSERT INTO _aggregat01 (mandant_id,
                         art_id,
                         bewart_id,
                         bewart_det_id,
                         promo_fg,
                         aktion_id,
                         wup_id,
                         nb_id,
                         dat,
                         ean_kasse,
                         umsatz_netto)
SELECT a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.promo_fg,
       a.aktion_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.ean_kasse,
       a.umsatz_netto_alt AS umsatz_netto
FROM _step02 a
WHERE a.kopf_art_id = -100
;

-- 18.12.2012, -dba-
--
-- Hier die ungleich wichtigere Tabelle! Da wir bei der Bestimmung der Umsatzanteile pro Komponente uns am
-- Verhaeltnis von EKN1 (Gesamt) zum EK-Wert eines Einzelartikels orientieren, wird hier in EK_NETTO_SUM 
-- der gesamte EKN1-Wert der Komponenten gespeichert.

INSERT INTO _spannen_agg1 (mandant_id,
                           wup_id,
                           kopf_art_id,
                           bewart_id,
                           bewart_det_id,
                           promo_fg,
                           aktion_id,
                           stueckliste_id,
                           dat,
                           ean_kasse,
                           ek_netto_sum)
SELECT a.mandant_id,
       a.wup_id,
       a.kopf_art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.promo_fg,
       a.aktion_id,
       a.stueckliste_id,
       a.dat,
       a.ean_kasse,
       SUM(a.ek_netto) AS ek_netto_sum
FROM _step02 a
JOIN _aggregat01 b
  ON a.mandant_id  = b.mandant_id AND
     a.wup_id      = b.wup_id     AND
     a.kopf_art_id = b.art_id     AND
     a.dat         = b.dat        AND
     a.ean_kasse   = b.ean_kasse  AND
     a.bewart_det_id = b.bewart_det_id AND
     a.bewart_id = b.bewart_id AND
     a.promo_fg = b.promo_fg AND
     a.aktion_id = b.aktion_id
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

INSERT INTO _step02a (mandant_id,
                      wup_id,
                      nb_id,
                      art_id,
                      bewart_id,
                      bewart_det_id,
                      promo_fg,
                      aktion_id,
                      dat,
                      wrg,
                      ean_kasse,
                      menge,
                      umsatz_netto_alt,
                      umsatz_mwst_betrag_alt,
                      umsatz_bto,
                      umrechnungskurs,
                      kopf_art_id,
                      komponentenmengen_faktor,
                      stueckliste_id,
                      bq_findung_id,
                      umsatz_anteil,
                      umsatz_netto,
                      umsatz_mwst,
                      ek_brutto,
                      ek_netto,
                      ek_nettonetto,
                      ek_kal_basis,
                      ek_mep,
                      einstandspreis,
                      logistikkostenzuschlag,
                      ek_netto_bnk,
                      ek_netto_bnk_sachk,
                      ek_mep_vor_fwu,
                      bonusbasis,
                      diff_ek_brutto_konz,
                      diff_ek_netto_konz,
                      diff_ek_nettonetto_konz,
                      diff_ek_kal_basis_konz,
                      diff_ek_mep_konz,
                      diff_einstandspreis_konz,
                      diff_logkostenzuschlag_konz,
                      diff_ek_netto_bnk_konz,
                      diff_ek_netto_bnk_sachk_konz,
                      ek_mep_vor_fwu_konz,
                      bonusbasis_konz)
SELECT DISTINCT
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_id,
       z.bewart_det_id,
       z.promo_fg,
       z.aktion_id,
       z.dat,
       z.wrg,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       CAST(z.ek_netto AS DECIMAL(18,10))/CAST(a.ek_netto_sum AS DECIMAL(18,10)) AS umsatz_anteil_,
       CAST(z.umsatz_netto_alt*umsatz_anteil_ AS DECIMAL(18,4)) AS umsatz_netto,
       CAST(z.umsatz_mwst_betrag_alt*umsatz_anteil_ AS DECIMAL(18,4)) AS umsatz_mwst,
       z.ek_brutto,
       z.ek_netto,
       z.ek_nettonetto,
       z.ek_kal_basis,
       z.ek_mep,
       z.einstandspreis,
       z.logistikkostenzuschlag,
       z.ek_netto_bnk,
       z.ek_netto_bnk_sachk,
       z.ek_mep_vor_fwu,
       z.bonusbasis,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz,
       CAST(0 AS DECIMAL(18,4)) AS ek_mep_vor_fwu_konz,
       CAST(0 AS DECIMAL(18,4)) AS bonusbasis_konz
FROM _step02 z
JOIN _spannen_agg1 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.kopf_art_id    = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.ean_kasse      = a.ean_kasse      AND
     z.dat            = a.dat            AND
     z.bewart_det_id  = a.bewart_det_id  AND
     z.bewart_id  = a.bewart_id AND
     z.promo_fg = a.promo_fg AND
     z.aktion_id = a.aktion_id
WHERE a.ek_netto_sum <> 0
;

-- 18.12.2012, -dba-
--
-- Laut Konzept gilt die Regel: Manuelle Spannen stehen ueber der Stuecklistenaufloesung! Falls also fuer die
-- Komponentenartikel manuelle Spannen gepflegt sein sollten, wird das Ganze wieder ueberschrieben!!! Es obliegt 
-- somit dem Fachbereich, hier fuer eine adäquate Pflege der VK-Set Artikel zu sorgen, da ansonsten das Prozedere 
-- obsolet waere!

-- manuelle Spanne ohne Betriebsbezug
UPDATE _step02a FROM (SELECT ein.mandant_id,
                             ein.art_id,
                             a.dat,
                             ein.ek_faktor AS zwgs,
                             COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                             COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                      FROM DBP_ETL.de_wpuums_dat a
                     
                      JOIN DBP_DATA.art_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
                        ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                           ein.loesch_fg = 0 AND 
                           a.dat BETWEEN ein.dat_von AND ein.dat_bis
                     
                      LEFT JOIN DBP_DATA.art_man_spanne_per mep /*optional*/
                        ON mep.mandant_id = ein.mandant_id AND 
                           mep.art_id  = ein.art_id AND 
                           mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                           mep.loesch_fg = 0 AND 
                           a.dat BETWEEN mep.dat_von AND mep.dat_bis
                     
                      LEFT JOIN DBP_DATA.art_man_spanne_per ekbnk /*optional*/
                        ON ekbnk.mandant_id = ein.mandant_id AND 
                           ekbnk.art_id  = ein.art_id AND 
                           ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                           ekbnk.loesch_fg = 0 AND 
                           a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis) ms
                          
SET ek_brutto                    = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto                     = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_nettonetto                = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_kal_basis                 = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep                       = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,einstandspreis               = CAST(umsatz_netto * zwgs AS DECIMAL(18,4))
   ,ek_netto_bnk                 = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk           = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep_vor_fwu               = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,bonusbasis                   = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))

WHERE _step02a.mandant_id     = ms.mandant_id
  AND _step02a.art_id         = ms.art_id
  AND _step02a.dat            = ms.dat
  AND _step02a.kopf_art_id   <> -100
;

-- Hier die betriebsspezifischen manuellen Spannenfaktoren
UPDATE _step02a FROM (SELECT ein.mandant_id,
                             ein.wup_id,
                             ein.art_id,
                             a.dat,
                             ein.ek_faktor AS zwgs,
                             COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                             COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                      FROM DBP_ETL.de_wpuums_dat a
                      
                      JOIN DBP_DATA.art_wup_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
                        ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                           ein.loesch_fg = 0 AND 
                           a.dat BETWEEN ein.dat_von AND ein.dat_bis
                      
                      LEFT JOIN DBP_DATA.art_wup_man_spanne_per mep /*optional*/
                        ON mep.mandant_id = ein.mandant_id AND 
                           mep.wup_id  = ein.wup_id AND 
                           mep.art_id  = ein.art_id AND 
                           mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                           mep.loesch_fg = 0 AND 
                           a.dat BETWEEN mep.dat_von AND mep.dat_bis
                      
                      LEFT JOIN DBP_DATA.art_wup_man_spanne_per ekbnk /*optional*/
                        ON ekbnk.mandant_id = ein.mandant_id AND 
                           ekbnk.wup_id  = ein.wup_id AND 
                           ekbnk.art_id  = ein.art_id AND 
                           ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                           ekbnk.loesch_fg = 0 AND 
                           a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis) ms
                          
SET ek_brutto                    = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto                     = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_nettonetto                = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_kal_basis                 = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep                       = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,einstandspreis               = CAST(umsatz_netto * zwgs AS DECIMAL(18,4))
   ,ek_netto_bnk                 = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk           = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep_vor_fwu               = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,bonusbasis                   = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))

WHERE _step02a.mandant_id     = ms.mandant_id
  AND _step02a.wup_id         = ms.wup_id 
  AND _step02a.art_id         = ms.art_id
  AND _step02a.dat            = ms.dat
  AND _step02a.kopf_art_id   <> -100
;

-- 18.12.2012, -dba-
--
-- Des Weiteren werden fuer die einzelnen Konditionsstufen die zugrunde liegende Spanne im Verhaeltnis zum 
-- Gesamtabverkauf (UMSATZ_NETTO ermittelt. Mit diesen Spannen werden spaeter die EK-Werte fuer die Kom-
-- ponentenartikel festgeschrieben.

CREATE OR REPLACE VOLATILE TABLE _spannen_agg2 AS (
SELECT a.mandant_id,
       a.wup_id,
       a.kopf_art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.promo_fg,
       a.aktion_id,
       a.ean_kasse,
       a.stueckliste_id,
       a.dat,
       1-SUM(a.ek_brutto/b.umsatz_netto) AS ek_brutto_spn,
       1-SUM(a.ek_netto/b.umsatz_netto) AS ek_netto_spn,
       1-SUM(a.ek_nettonetto/b.umsatz_netto) AS ek_nettonetto_spn,
       1-SUM(a.ek_kal_basis/b.umsatz_netto) AS ek_kal_basis_spn,
       1-SUM(a.ek_mep/b.umsatz_netto) AS ek_mep_spn,
       1-SUM(a.einstandspreis/b.umsatz_netto) AS einstandspreis_spn,
       1-SUM(a.logistikkostenzuschlag/b.umsatz_netto) AS logkostenzuschlag_spn,
       1-SUM(a.ek_netto_bnk/b.umsatz_netto) AS ek_netto_bnk_spn,
       1-SUM(a.ek_netto_bnk_sachk/b.umsatz_netto) AS ek_netto_bnk_sachk_spn,
       1-SUM(a.ek_mep_vor_fwu/b.umsatz_netto) AS ek_mep_vor_fwu_spn,
       1-SUM(a.bonusbasis/b.umsatz_netto) AS bonusbasis_spn
FROM _step02a a
JOIN _aggregat01 b
  ON a.mandant_id  = b.mandant_id AND
     a.wup_id      = b.wup_id     AND
     a.kopf_art_id = b.art_id     AND
     a.dat         = b.dat        AND
     a.ean_kasse   = b.ean_kasse  AND
     a.bewart_det_id = b.bewart_det_id AND
     a.bewart_id = b.bewart_id AND
     a.promo_fg = b.promo_fg AND
     a.aktion_id = b.aktion_id
WHERE b.umsatz_netto <> 0
GROUP BY 1,2,3,4,5,6,7,8,9,10
);

-- 18.12.2012, -dba-
--
-- Wie dem obigen Titel zu entnehmen ist, werden hier fuer saemtliche Komponenten eines VK-Set die entsprechenden
-- Werte ermittelt. Als Anmerkung waere hier noch zu erwaehnen, dass aufgrund von Rundungsungenauigkeiten im Teradata-
-- Umfeld bei der EK-Berechnung laut Spanne leider die Genauigkeit von DECIMAL(18,4) auf DECIMAL(18,2) gesetzt werden
-- musste, da wir ansonsten kein stimmiges Verhaeltnis der EK-Werte im Vergleich von vorher zu nachher gehabt haetten.

INSERT INTO _step03 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     promo_fg,
                     aktion_id,
                     dat,
                     wrg,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     umsatz_anteil,
                     umsatz_netto,
                     umsatz_mwst,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     ek_mep_vor_fwu,
                     bonusbasis,
                     diff_ek_brutto_konz,
                     diff_ek_netto_konz,
                     diff_ek_nettonetto_konz,
                     diff_ek_kal_basis_konz,
                     diff_ek_mep_konz,
                     diff_einstandspreis_konz,
                     diff_logkostenzuschlag_konz,
                     diff_ek_netto_bnk_konz,
                     diff_ek_netto_bnk_sachk_konz,
                     ek_mep_vor_fwu_konz,
                     bonusbasis_konz)
SELECT DISTINCT
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_id,
       z.bewart_det_id,
       z.promo_fg,
       z.aktion_id,
       z.dat,
       z.wrg,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       z.umsatz_anteil,
       z.umsatz_netto,
       z.umsatz_mwst,
       -1*((a.ek_brutto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_brutto_ ,
       -1*((a.ek_netto_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_,
       -1*((a.ek_nettonetto_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_nettonetto_,
       -1*((a.ek_kal_basis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_kal_basis_,
       -1*((a.ek_mep_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_mep_,
       -1*((a.einstandspreis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS einstandspreis_,
       -1*((a.logkostenzuschlag_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS logistikkostenzuschlag_,
       -1*((a.ek_netto_bnk_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_bnk_,
       -1*((a.ek_netto_bnk_sachk_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_bnk_sachk_,
       -1*((a.ek_mep_vor_fwu_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_mep_vor_fwu_,
       -1*((a.bonusbasis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS bonusbasis_,
       CAST(ek_brutto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(ek_netto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(ek_nettonetto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(ek_kal_basis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(ek_mep_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(einstandspreis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(logistikkostenzuschlag_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(ek_netto_bnk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(ek_netto_bnk_sachk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz,
       CAST(ek_mep_vor_fwu_ * umrechnungskurs AS DECIMAL(18,4)) AS ek_mep_vor_fwu_konz,
       CAST(bonusbasis_ * umrechnungskurs AS DECIMAL(18,4)) AS bonusbasis_konz
FROM _step02a z
JOIN _spannen_agg2 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.kopf_art_id    = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.dat            = a.dat            AND
     z.ean_kasse      = a.ean_kasse      AND
     z.bewart_det_id  = a.bewart_det_id  AND
     z.bewart_id  = a.bewart_id AND
     z.promo_fg = a.promo_fg AND
     z.aktion_id = a.aktion_id
;

INSERT INTO _step03 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     promo_fg,
                     aktion_id,
                     dat,
                     wrg,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     umsatz_anteil,
                     umsatz_netto,
                     umsatz_mwst,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     ek_mep_vor_fwu,
                     bonusbasis,
                     diff_ek_brutto_konz,
                     diff_ek_netto_konz,
                     diff_ek_nettonetto_konz,
                     diff_ek_kal_basis_konz,
                     diff_ek_mep_konz,
                     diff_einstandspreis_konz,
                     diff_logkostenzuschlag_konz,
                     diff_ek_netto_bnk_konz,
                     diff_ek_netto_bnk_sachk_konz,
                     ek_mep_vor_fwu_konz,
                     bonusbasis_konz)
SELECT DISTINCT
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_id,
       z.bewart_det_id,
       z.promo_fg,
       z.aktion_id,
       z.dat,
       z.wrg,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       0 AS umsatz_anteil,
       z.umsatz_netto_alt AS umsatz_netto,
       z.umsatz_mwst_betrag_alt AS umsatz_mwst,
       (1-a.ek_brutto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_brutto_,
       (1-a.ek_netto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_netto_,
       (1-a.ek_nettonetto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_nettonetto_,
       (1-a.ek_kal_basis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_kal_basis_,
       (1-a.ek_mep_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_mep_,
       (1-a.einstandspreis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS einstandspreis_,
       (1-a.logkostenzuschlag_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS logistikkostenzuschlag_,
       (1-a.ek_netto_bnk_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_netto_bnk_,
       (1-a.ek_netto_bnk_sachk_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS ek_netto_bnk_sachk_,
       (1-a.ek_mep_vor_fwu_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS ek_mep_vor_fwu_,
       (1-a.bonusbasis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS bonusbasis_,
       CAST(ek_brutto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(ek_netto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(ek_nettonetto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(ek_kal_basis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(ek_mep_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(einstandspreis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(logistikkostenzuschlag_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(ek_netto_bnk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(ek_netto_bnk_sachk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz,
       CAST(ek_mep_vor_fwu_ * umrechnungskurs AS DECIMAL(18,4)) AS ek_mep_vor_fwu_konz,
       CAST(bonusbasis_ * umrechnungskurs AS DECIMAL(18,4)) AS bonusbasis_konz
FROM _step02 z
JOIN _spannen_agg2 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.art_id         = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.dat            = a.dat            AND
     z.ean_kasse      = a.ean_kasse      AND
     z.bewart_det_id  = a.bewart_det_id  AND
     z.bewart_id  = a.bewart_id AND
     z.promo_fg = a.promo_fg AND
     z.aktion_id = a.aktion_id
WHERE z.kopf_art_id = -100
;

MERGE INTO DBP_DATA.artbew a
USING (SELECT *
       FROM _step03
       WHERE kopf_art_id = -100) b

  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.art_id     = b.art_id     AND
     a.ean_kasse  = b.ean_kasse  AND
     a.dat        = b.dat        AND
     a.bewart_det_id = b.bewart_det_id AND
     a.bewart_id = b.bewart_id AND
     a.promo_fg = b.promo_fg AND
     a.aktion_id = b.aktion_id AND
     a.menge      >= 0 
     
WHEN MATCHED THEN UPDATE SET ek_brutto                    =  b.ek_brutto                     ,
                             ek_netto                     =  b.ek_netto                      ,
                             ek_nettonetto                =  b.ek_nettonetto                 ,
                             ek_kal_basis                 =  b.ek_kal_basis                  ,
                             ek_mep                       =  b.ek_mep                        ,
                             einstandspreis               =  b.einstandspreis                ,
                             logkostenzuschlag            =  b.logistikkostenzuschlag        ,
                             ek_netto_bnk                 =  b.ek_netto_bnk                  ,
                             ek_netto_bnk_sachk           =  b.ek_netto_bnk_sachk            ,
                             ek_mep_vor_fwu               =  b.ek_mep_vor_fwu                ,
                             bonusbasis                   =  b.bonusbasis
;

MERGE INTO DBP_DATA.artbew a
USING (SELECT *
       FROM _step03
       WHERE kopf_art_id = -100) b

  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.art_id     = b.art_id     AND
     a.ean_kasse  = b.ean_kasse  AND
     a.dat        = b.dat        AND
     a.bewart_det_id = b.bewart_det_id AND
     a.bewart_id = b.bewart_id AND
     a.promo_fg = b.promo_fg AND
     a.aktion_id = b.aktion_id AND
     a.menge      < 0
     
WHEN MATCHED THEN UPDATE SET ek_brutto                    =  0,
                             ek_netto                     =  0,
                             ek_nettonetto                =  0,
                             ek_kal_basis                 =  0,
                             ek_mep                       =  0,
                             einstandspreis               =  0,
                             logkostenzuschlag            =  0,
                             ek_netto_bnk                 =  0,
                             ek_netto_bnk_sachk           =  0,
                             ek_mep_vor_fwu               =  0,
                             bonusbasis                   =  0
;

DELETE FROM DBP_DATA.artbew_stueckliste_zu
WHERE (mandant_id, wup_id, dat) IN (SELECT mandant_id,
                                           wup_id,
                                           dat
                                    FROM _step03
                                    WHERE mandant_id = 1)
;

INSERT INTO DBP_DATA.artbew_stueckliste_zu (mandant_id,
                                            wup_id,
                                            nb_id,
                                            art_id,
                                            dat,
                                            komponente_art_id,
                                            stueckliste_id,
                                            wrg_id,
                                            umsatz_netto,
                                            umsatz_mwst_betrag,
                                            menge,
                                            ek_brutto,
                                            ek_netto,
                                            ek_nettonetto,
                                            ek_kal_basis,
                                            ek_mep,
                                            einstandspreis,
                                            logkostenzuschlag,
                                            ek_netto_bnk,
                                            ek_netto_bnk_sachk,
                                            bq_findung_id,
                                            umrechnungskurs,
                                            td_insert,
                                            td_update,
                                            ek_mep_vor_fwu,
                                            bonusbasis,
                                            umrechnungskurs_hist,
                                            umrech_faktor,
                                            menge_komponente_in_vk_set)

SELECT x.mandant_id,
       x.wup_id,
       x.nb_id,
       x.kopf_art_id AS art_id,
       x.dat,
       x.art_id AS komponente_art_id,
       x.stueckliste_id,
       x.wrg AS wrg_id,
       COALESCE(x.umsatz_netto,0) AS umsatz_netto,
       COALESCE(x.umsatz_mwst,0) AS umsatz_mwst_betrag,
       x.komponentenmengen_faktor AS menge,
       COALESCE(x.ek_brutto,0) AS ek_brutto,
       COALESCE(x.ek_netto,0) AS ek_netto,
       COALESCE(x.ek_nettonetto,0) AS ek_nettonetto,
       COALESCE(x.ek_kal_basis,0) AS ek_kal_basis,
       COALESCE(x.ek_mep,0) AS ek_mep,
       COALESCE(x.einstandspreis,0) AS einstandspreis,
       COALESCE(x.logistikkostenzuschlag,0) AS logkostenzuschlag,
       COALESCE(x.ek_netto_bnk,0) AS ek_netto_bnk,
       COALESCE(x.ek_netto_bnk_sachk,0) AS ek_netto_bnk_sachk,
       COALESCE(x.bq_findung_id,30) AS bq_findung_id,
       1 AS umrechnungskurs,
       current_timestamp as td_insert,
       current_timestamp as td_update,
       COALESCE(x.ek_mep_vor_fwu,0) as ek_mep_vor_fwu,
       COALESCE(x.bonusbasis,0) as bonusbasis,
       k.umrechnungskurs as umrechnungskurs_hist,
       1 as umrech_faktor,
       null as menge_komponente_in_vk_set
FROM (SELECT mandant_id,
             wup_id,
             nb_id,
             kopf_art_id,
             dat,
             art_id,
             stueckliste_id,
             wrg,
             SUM(umsatz_netto) AS umsatz_netto,
             SUM(umsatz_mwst) AS umsatz_mwst,
             SUM(komponentenmengen_faktor) AS komponentenmengen_faktor,
             SUM(ek_brutto) AS ek_brutto,
             SUM(ek_netto) AS ek_netto,
             SUM(ek_nettonetto) AS ek_nettonetto,
             SUM(ek_kal_basis) AS ek_kal_basis,
             SUM(ek_mep) AS ek_mep,
             SUM(einstandspreis) AS einstandspreis,
             SUM(logistikkostenzuschlag) AS logistikkostenzuschlag,
             SUM(ek_netto_bnk) AS ek_netto_bnk,
             SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
             bq_findung_id,
             MAX(umrechnungskurs) AS umrechnungskurs,
             SUM(ek_mep_vor_fwu) AS ek_mep_vor_fwu,
             SUM(bonusbasis) AS bonusbasis
      FROM _step03
      WHERE kopf_art_id <> -100
      GROUP BY 1,2,3,4,5,6,7,8,21) x
left join dbp_data.kurs k
  on x.wrg = k.von_wrg_id and
     x.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
;

update dbp_data.artbew_stueckliste_zu from (select a.mandant_id,
                                                   a.art_id,
                                                   a.komponente_art_id,
                                                   a.wup_id,
                                                   a.dat,
                                                   a.stueckliste_id,
                                                   max(coalesce(c.umrech_faktor,1.00000)) as umrech_faktor,
                                                   max(b.komponentenmenge) as menge_komponente_in_vk_set
                                            from dbp_data.artbew_stueckliste_zu a
                                            join (select *
                                                  from dbp_data.stueckliste_det
                                                  where stueckliste_typ_id = 'M') b
                                              on a.mandant_id = b.mandant_id and
                                                 a.stueckliste_id = b.stueckliste_id and
                                                 a.komponente_art_id = b.art_id and
                                                 a.dat between b.dat_von and b.dat_bis
                                            left join dbp_data.art_umrechnung_faktor_per c
                                              on b.mandant_id = c.mandant_id and
                                                 b.art_id = c.art_id and
                                                 b.komponentenmenge_einh_id = c.altnv_menge_einh_id and
                                                 a.dat between c.dat_von and c.dat_bis
                                            where a.dat >= (select min(dat) from dbp_data.tag where akt_kj = -2) and
                                                  a.mandant_id = 1
                                            group by 1,2,3,4,5,6) b
                                            
set umrech_faktor = b.umrech_faktor,
    menge_komponente_in_vk_set = b.umrech_faktor*b.menge_komponente_in_vk_set
    
where dbp_data.artbew_stueckliste_zu.mandant_id = b.mandant_id and
      dbp_data.artbew_stueckliste_zu.art_id = b.art_id and
      dbp_data.artbew_stueckliste_zu.komponente_art_id = b.komponente_art_id and
      dbp_data.artbew_stueckliste_zu.wup_id = b.wup_id and
      dbp_data.artbew_stueckliste_zu.dat = b.dat and
      dbp_data.artbew_stueckliste_zu.stueckliste_id = b.stueckliste_id
;
