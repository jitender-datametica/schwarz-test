CREATE OR REPLACE TABLE DBP_ETL.kmo_wpuums_anr_1 LIKE DBP_DATA.artbew_1;
CREATE OR REPLACE TABLE DBP_ETL.kmo_wpuums_dat_1 (dat DATE, UNIQUE (dat));
CREATE OR REPLACE TABLE DBP_ETL.kmo_wpuums_dat_min_1 (dat DATE, UNIQUE (dat));

CREATE OR REPLACE TRANSIENT TABLE __vol_art_gp_wup_zu_per  (
  mandant_id              BYTEINT NOT NULL,
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

CREATE OR REPLACE TRANSIENT TABLE _art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX}  (
  mandant_id BYTEINT NOT NULL,
  art_id     INTEGER NOT NULL,
  wup_id     INTEGER NOT NULL,
  nb_id      SMALLINT NOT NULL,
  dat        DATE NOT NULL,
  zwgs       DECIMAL(9,4),
  zwgm       DECIMAL(9,4),
  zwge       DECIMAL(9,4)
) ;

INSERT INTO DBP_ETL.kmo_wpuums_dat_1 (dat)
SELECT dat FROM DBP_ETL.kmo_wpuums_art_gp_wup_zu_1
GROUP BY 1;

INSERT INTO DBP_ETL.kmo_wpuums_dat_min_1 (dat)
SELECT MIN(dat) FROM DBP_ETL.kmo_wpuums_art_gp_wup_zu_1;

INSERT INTO __vol_art_gp_wup_zu_per
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
    ,CAST(ek_brutto           AS DECIMAL(18,4)) AS ek_brutto
    ,CAST(ek_netto            AS DECIMAL(18,4)) AS ek_netto
    ,CAST(ek_nettonetto       AS DECIMAL(18,4)) AS ek_nettonetto
    ,CAST(ek_kal_basis        AS DECIMAL(18,4)) AS ek_kal_basis
    ,CAST(ek_mep              AS DECIMAL(18,4)) AS ek_mep
    ,CAST(einstandspreis      AS DECIMAL(18,4)) AS einstandspreis
    ,logistikkostenzuschlag
    ,CAST(ek_netto_bnk        AS DECIMAL(18,4)) AS ek_netto_bnk
    ,CAST(ek_netto_bnk_sachk  AS DECIMAL(18,4)) AS ek_netto_bnk_sachk
    ,CAST(ek_mep_vor_fwu      AS DECIMAL(18,4)) AS ek_mep_vor_fwu
    ,CAST(bonusbasis          AS DECIMAL(18,4)) AS bonusbasis
  FROM DBP_DATA.art_gp_wup_zu_per_1 a

  INNER JOIN DBP_ETL.kmo_wpuums_dat_min_1 m
  ON a.dat_bis >= m.dat

  WHERE a.mandant_id > 1) a

-- auf Tag_1 auffaechern
INNER JOIN DBP_ETL.kmo_wpuums_dat_1 d
ON d.dat BETWEEN a.dat_von AND a.dat_bis
;

INSERT INTO _art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX} 
(mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat,
 zwgs,
 zwgm,
 zwge
)
SELECT ein.mandant_id
      ,ein.art_id
      ,-1 AS wup_id
      ,-1 AS nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM DBP_ETL.kmo_wpuums_dat_1 a

INNER JOIN DBP_DATA.art_man_spanne_per_1 ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_1 mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_1 ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

INSERT INTO _art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX} 
(       mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat,
        zwgs,
        zwgm,
        zwge
)
SELECT ein.mandant_id
      ,ein.art_id
      ,ein.wup_id 
      ,ein.nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM DBP_ETL.kmo_wpuums_dat_1 a

INNER JOIN DBP_DATA.art_wup_man_spanne_per_1 ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_1 mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.wup_id  = ein.wup_id 
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_1 ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.wup_id  = ein.wup_id 
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

INSERT INTO DBP_ETL.kmo_wpuums_anr_1 (mandant_id
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
                                   ,wrg_1
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
                                   ,ek_mep_vor_fwu
                                   ,ek_mep_vor_fwu_konz
                                   ,bonusbasis
                                   ,bonusbasis_konz
                                   ,pv_bonrabatt_bby
                                   ,wup_bereinigt_fg
                                   ,pv_aktion_konz
                                   ,pv_bby_konz
                                   ,pv_kdn_bby_konz
                                   ,pv_kdp_bby_konz
                                   ,pv_aktion_bby_konz
                                   ,pv_aktion_kdn_bby_konz
                                   ,pv_aktion_kdp_bby_konz
                                   ,pv_bonrabatt_bby_konz
                                   ,standard_aktion_id
                                   ,umrechnungskurs_hist)
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
      ,y.wrg_1
      ,y.posten_id
      ,y.bezugsweg_id
      ,y.ean_kasse
      ,y.menge
      ,y.umsatz_netto
      ,y.diff_umsatz_netto_konz
      ,y.umsatz_mwst_betrag
      ,y.diff_umsatz_mwst_betrag_konz
      ,(y.ek_brutto_                    ) AS ek_brutto 
      ,(y.diff_ek_brutto_konz_          ) AS diff_ek_brutto_konz
      ,(y.ek_netto_                     ) AS ek_netto 
      ,(y.diff_ek_netto_konz_           ) AS diff_ek_netto_konz
      ,(y.ek_nettonetto_                ) AS ek_nettonetto 
      ,(y.diff_ek_nettonetto_konz_      ) AS diff_ek_nettonetto_konz     
      ,(y.ek_kal_basis_                 ) AS ek_kal_basis 
      ,(y.diff_ek_kal_basis_konz_       ) AS diff_ek_kal_basis_konz 
      ,(y.ek_mep_                       ) AS ek_mep 
      ,(y.diff_ek_mep_konz_             ) AS diff_ek_mep_konz 
      ,(y.einstandspreis_               ) AS einstandspreis 
      ,(y.diff_einstandspreis_konz_     ) AS diff_einstandspreis_konz 
      ,y.logkostenzuschlag_
      ,y.diff_logkostenzuschlag_konz_
      ,(y.ek_netto_bnk_                 ) AS ek_netto_bnk 
      ,(y.diff_ek_netto_bnk_konz_       ) AS diff_ek_netto_bnk_konz 
      ,(y.ek_netto_bnk_sachk_           ) AS ek_netto_bnk_sachk 
      ,(y.diff_ek_netto_bnk_sachk_konz_ ) AS diff_ek_netto_bnk_sachk_konz 
      ,y.ek_gld 
      ,y.diff_ek_gld_konz
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
      ,y.ek_mep_vor_fwu_ as ek_mep_vor_fwu
      ,y.ek_mep_vor_fwu_konz_ as ek_mep_vor_fwu_konz
      ,y.bonusbasis_ as bonusbasis
      ,y.bonusbasis_konz_ as bonusbasis_konz
      ,y.pv_bonrabatt_bby
      ,y.wup_bereinigt_fg
      ,y.pv_aktion_konz
      ,y.pv_bby_konz
      ,y.pv_kdn_bby_konz
      ,y.pv_kdp_bby_konz
      ,y.pv_aktion_bby_konz
      ,y.pv_aktion_kdn_bby_konz
      ,y.pv_aktion_kdp_bby_konz
      ,y.pv_bonrabatt_bby_konz
      ,y.standard_aktion_id
      ,y.umrechnungskurs_hist
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
            ,a.wrg_1
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
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_brutto, agww.ek_brutto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_brutto_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_brutto_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_brutto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_netto, agww.ek_netto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_netto_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_netto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_nettonetto, agww.ek_nettonetto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_nettonetto_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_nettonetto_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_nettonetto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_kal_basis, agww.ek_kal_basis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_kal_basis_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_kal_basis_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_kal_basis_konz_                
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_mep, agww.ek_mep) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_mep_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_mep_konz_                 
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.einstandspreis, agww.einstandspreis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS einstandspreis_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(einstandspreis_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_einstandspreis_konz_
            ,menge * COALESCE(agw.logistikkostenzuschlag, agww.logistikkostenzuschlag, 0.0000) AS logkostenzuschlag_
            ,logkostenzuschlag_ * z.umrechnungskurs AS diff_logkostenzuschlag_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk, agww.ek_netto_bnk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_netto_bnk_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_netto_bnk_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk_sachk, agww.ek_netto_bnk_sachk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_sachk_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_netto_bnk_sachk_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_netto_bnk_sachk_konz_
            ,a.ek_gld 
            ,a.diff_ek_gld_konz
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
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.ek_mep_vor_fwu, agww.ek_mep_vor_fwu) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_vor_fwu_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(ek_mep_vor_fwu_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS ek_mep_vor_fwu_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(a.menge * COALESCE(agw.bonusbasis, agww.bonusbasis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS bonusbasis_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP_1          */ CAST(bonusbasis_ * case when y.conv_fg = 1 then 1 else z.umrechnungskurs end AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS bonusbasis_konz_
            ,a.pv_bonrabatt_bby
            ,a.wup_bereinigt_fg
            ,a.pv_aktion_konz
            ,a.pv_bby_konz
            ,a.pv_kdn_bby_konz
            ,a.pv_kdp_bby_konz
            ,a.pv_aktion_bby_konz
            ,a.pv_aktion_kdn_bby_konz
            ,a.pv_aktion_kdp_bby_konz
            ,a.pv_bonrabatt_bby_konz
            ,a.standard_aktion_id
            ,a.umrechnungskurs_hist
      FROM DBP_DATA.artbew_1 a
      
      left join (select a.*,
                        1 as conv_fg
                 from dbp_data.mandant_wrg_zu_per_1 a
                 where a.von_wrg_id is not null and
                       a.wrg_id <> a.von_wrg_id and
                       current_date between a.dat_von and a.dat_bis) y
        on a.mandant_id = y.mandant_id and
           a.wrg_1 = y.wrg_id
      
      INNER JOIN DBP_ETL.kmo_wpuums_dat_1 d
      ON a.dat = d.dat
        
      INNER JOIN DBP_ETL.kmo_wpuums_art_gp_wup_zu_1 z
        ON a.mandant_id = z.mandant_id
       AND a.art_id = z.art_id
       AND a.wup_id = z.wup_id
       AND a.nb_id = z.nb_id
       AND a.dat = z.dat
          
      -- Lieferant und Ausstiegspunkt ermitteln
      LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per_1 x
      ON a.mandant_id = x.mandant_id
        AND a.wup_id = x.wup_id
        AND a.art_id = x.art_id 
        AND a.dat BETWEEN x.dat_von AND x.dat_bis 
          
      -- Betriebsspezifischer EK Preis 
      LEFT OUTER JOIN __vol_art_gp_wup_zu_per agw
      ON x.mandant_id   = agw.mandant_id 
        AND x.vz_wup_id = agw.wup_id 
        AND x.art_id    = agw.art_id
        AND x.gp_id     = agw.gp_id 
        AND a.dat       = agw.dat
        
      -- Betriebsuebergreifender EK Preis
      LEFT OUTER JOIN __vol_art_gp_wup_zu_per agww
      ON x.mandant_id = agww.mandant_id 
        AND -1        = agww.wup_id 
        AND x.art_id  = agww.art_id
        AND x.gp_id   = agww.gp_id 
        AND a.dat     = agww.dat
        
      -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren
      LEFT OUTER JOIN _art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX} ms
      ON a.mandant_id = ms.mandant_id
        AND a.art_id  = ms.art_id
        AND ms.wup_id = -1
        AND a.dat = ms.dat
        AND x.bq_findung_id = 27
      
      -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren
      LEFT OUTER JOIN _art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX} ma
      ON a.mandant_id = ma.mandant_id
        AND a.art_id = ma.art_id
        AND a.wup_id = ma.wup_id
        AND a.dat = ma.dat 
        AND x.bq_findung_id = 26) y
;

UPDATE DBP_ETL.kmo_wpuums_anr_1
SET ek_gld           = umsatz_netto
  , diff_ek_gld_konz = diff_umsatz_netto_konz
WHERE DBP_ETL.kmo_wpuums_anr.art_id = -1 /*unbekannter Artikel_1*/
;

UPDATE DBP_ETL.kmo_wpuums_anr_1
FROM DBP_DATA.art_1 a
SET ek_gld           = ek_netto 
  , diff_ek_gld_konz = diff_ek_netto_konz 
WHERE DBP_ETL.kmo_wpuums_anr.mandant_id = a.mandant_id 
  AND DBP_ETL.kmo_wpuums_anr.art_id     = a.art_id 
  AND DBP_ETL.kmo_wpuums_anr.art_id     > -1
  AND a.wg_art_fg                         = 1 /*Warengruppenerfassartikel*/
;

UPDATE DBP_ETL.kmo_wpuums_anr_1

SET ek_gld           = ek_gld_ * menge 
  , diff_ek_gld_konz = ek_gld_ * menge * umrechnungskurs 

FROM DBP_DATA.kurs_1 k,
(
  SELECT 
     g.mandant_id
    ,g.wup_id
    ,g.art_id
    ,g.dat 
    ,COALESCE(g.ek_gld, 0) AS ek_gld_
  FROM DBP_DATA.art_wup_tag_gld_1 g
  
  INNER JOIN DBP_DATA.art_1 a
  ON g.mandant_id = a.mandant_id 
    AND g.art_id = a.art_id  
    AND a.wg_art_fg = 0 /*keine WG Erfassartiekel*/
    AND a.art_id    > -1
) g WHERE DBP_ETL.kmo_wpuums_anr.mandant_id = g.mandant_id
  AND DBP_ETL.kmo_wpuums_anr.wup_id     = g.wup_id
  AND DBP_ETL.kmo_wpuums_anr.art_id     = g.art_id
  AND DBP_ETL.kmo_wpuums_anr.dat        = g.dat
  
  -- Umrechnungskurs ermitteln
  AND DBP_ETL.kmo_wpuums_anr.wrg_1        = k.von_wrg_id
  --AND DBP_ETL.kmo_wpuums_anr.dat  BETWEEN k.dat_von AND k.dat_bis
  AND k.dat_bis = '9999-12-31'
  AND k.kurstyp_id = 3
  AND k.nach_wrg_id = 'EUR'
;

DELETE FROM DBP_DATA.artbew_1 a
WHERE a.dat IN (SELECT dat FROM DBP_ETL.kmo_wpuums_dat_1) AND 
      a.mandant_id > 1 AND 
     (a.mandant_id,a.wup_id,a.nb_id,a.art_id,a.dat,a.promo_fg) IN (SELECT mandant_id,wup_id,nb_id,art_id,dat,promo_fg FROM DBP_ETL.kmo_wpuums_anr_1)
;

INSERT INTO DBP_DATA.artbew_1
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
  ,wrg_1
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
  ,ek_mep_vor_fwu
  ,ek_mep_vor_fwu_konz
  ,bonusbasis
  ,bonusbasis_konz
  ,pv_bonrabatt_bby
  ,wup_bereinigt_fg
  ,pv_aktion_konz
  ,pv_bby_konz
  ,pv_kdn_bby_konz
  ,pv_kdp_bby_konz
  ,pv_aktion_bby_konz
  ,pv_aktion_kdn_bby_konz
  ,pv_aktion_kdp_bby_konz
  ,pv_bonrabatt_bby_konz
  ,standard_aktion_id
  ,umrechnungskurs_hist
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
  ,wrg_1
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
  ,current_timestamp as td_insert
  ,current_timestamp as td_update
  ,ek_mep_vor_fwu
  ,ek_mep_vor_fwu_konz
  ,bonusbasis
  ,bonusbasis_konz
  ,pv_bonrabatt_bby
  ,wup_bereinigt_fg
  ,pv_aktion_konz
  ,pv_bby_konz
  ,pv_kdn_bby_konz
  ,pv_kdp_bby_konz
  ,pv_aktion_bby_konz
  ,pv_aktion_kdn_bby_konz
  ,pv_aktion_kdp_bby_konz
  ,pv_bonrabatt_bby_konz
  ,standard_aktion_id
  ,umrechnungskurs_hist
FROM DBP_ETL.kmo_wpuums_anr_1
;
