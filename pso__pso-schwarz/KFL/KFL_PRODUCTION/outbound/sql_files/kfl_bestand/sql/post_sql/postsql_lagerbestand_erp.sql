UPDATE dbp_etl.lagerbestand_erp SET
 ek_netto_bnk = t0.ek_netto_bnk_,
 komponentenmenge = t0.komponentenmenge_,
 td_update = CURRENT_TIMESTAMP() FROM (SELECT A.mandant_id AS mandant_id_,
   A.wup_id AS wup_id_,
   A.art_id AS art_id_,
   A.lagerort_id AS lagerort_id_,
    CASE
    WHEN A.nb_id IN (99, - 111)
    THEN COALESCE(AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12
     .ek_netto_bnk, 0)
    ELSE COALESCE(AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
    END AS ek_netto_bnk_,
    CASE
    WHEN A.nb_id IN (99, - 111)
    THEN COALESCE(AGW5.komponentenmenge, AGW6.komponentenmenge, AGW7.komponentenmenge, AGW8.komponentenmenge, AGW11.komponentenmenge
     , AGW12.komponentenmenge, 0)
    ELSE COALESCE(AGW11.komponentenmenge, AGW12.komponentenmenge, AGW6.komponentenmenge, AGW8.komponentenmenge, 0)
    END AS komponentenmenge_
  FROM dbp_etl.lagerbestand_erp AS A
   LEFT JOIN dbp_etl.ek05 AS AGW5 ON A.art_id = AGW5.art_id AND A.dat_von BETWEEN AGW5.dat_von AND AGW5.dat_bis
      /* richtiges Datum */ AND A.wup_id = AGW5.wup_id /* richtiges Lager */
     /* zentral
lager       falsch
datum       richtig
lieferant   falsch */
   LEFT JOIN dbp_etl.ek06 AS AGW6 ON A.art_id = AGW6.art_id AND A.dat_von BETWEEN AGW6.dat_von AND AGW6.dat_bis
     /* richtiges Datum */ /* zentral
lager       richtig
datum       falsch
lieferant   falsch */
   LEFT JOIN dbp_etl.ek07 AS AGW7 ON A.art_id = AGW7.art_id AND A.wup_id = AGW7.wup_id
     /* richtiges Lager */ /* zentral
lager       falsch
datum       falsch
lieferant   falsch */
   LEFT JOIN dbp_etl.ek08 AS AGW8 ON A.art_id = AGW8.art_id
    /* dezentral
lager       -1
datum       richtig
lieferant   falsch */
   LEFT JOIN dbp_etl.ek11 AS AGW11 ON A.art_id = AGW11.art_id AND A.dat_von BETWEEN AGW11.dat_von AND
     AGW11.dat_bis /* richtiges Datum */ /* dezentral
lager       -1
datum       falsch
lieferant   falsch */
   LEFT JOIN dbp_etl.ek12 AS AGW12 ON A.art_id = AGW12.art_id
    -- GROUP BY mandant_id_,art_id_,wup_id_,lagerort_id_

    -- QUALIFY CSUM(1,CAST((ek_netto_bnk_ )AS NUMERIC(29,4)) DESC,komponentenmenge_ DESC) = 1

  QUALIFY (ROW_NUMBER() OVER (PARTITION BY A.mandant_id, A.art_id, A.wup_id, A.lagerort_id ORDER BY CAST(CASE
          WHEN A.nb_id IN (99, - 111)
          THEN COALESCE(AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, 0)
          ELSE COALESCE(AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
          END AS NUMERIC) IS NULL DESC, CAST(CASE
          WHEN A.nb_id IN (99, - 111)
          THEN COALESCE(AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, 0)
          ELSE COALESCE(AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
          END AS NUMERIC) DESC, CASE
         WHEN A.nb_id IN (99, - 111)
         THEN COALESCE(AGW5.komponentenmenge, AGW6.komponentenmenge, AGW7.komponentenmenge, AGW8.komponentenmenge, AGW11
          .komponentenmenge, AGW12.komponentenmenge, 0)
         ELSE COALESCE(AGW11.komponentenmenge, AGW12.komponentenmenge, AGW6.komponentenmenge, AGW8.komponentenmenge, 0)
         END IS NULL DESC, CASE
         WHEN A.nb_id IN (99, - 111)
         THEN COALESCE(AGW5.komponentenmenge, AGW6.komponentenmenge, AGW7.komponentenmenge, AGW8.komponentenmenge, AGW11
          .komponentenmenge, AGW12.komponentenmenge, 0)
         ELSE COALESCE(AGW11.komponentenmenge, AGW12.komponentenmenge, AGW6.komponentenmenge, AGW8.komponentenmenge, 0)
         END DESC)) = 1) AS t0
WHERE lagerbestand_erp.mandant_id = t0.mandant_id_ AND lagerbestand_erp.wup_id = t0.wup_id_ AND lagerbestand_erp.art_id
   = t0.art_id_ AND lagerbestand_erp.lagerort_id = t0.lagerort_id_;


UPDATE dbp_etl.lagerbestand_erp SET
 vk_netto = x.vk_netto_,
 td_update = CURRENT_TIMESTAMP() FROM (SELECT A.mandant_id AS mandant_id_,
   A.dat_von AS dat_von_,
   A.dat_bis AS dat_bis_,
   A.art_id AS art_id_,
   COALESCE(AP.vk_brutto, 0) AS vk_brutto_,
   CAST(COALESCE(AP.vk_brutto, 0) / CASE
      WHEN MWST.mwst_id IS NULL
      THEN 1
      ELSE 1 + MWST.mwst / 100
      END AS NUMERIC) AS vk_netto_
  FROM dbp_etl.lagerbestand_erp AS A
   INNER JOIN dbp_data.art AS ART ON A.art_id = ART.art_id AND A.mandant_id = ART.mandant_id
   INNER JOIN dbp_data.mwst_per AS MWST ON MWST.mandant_id = 1 AND ART.mwst_id = MWST.mwst_id AND A.dat_von
     BETWEEN MWST.dat_von AND MWST.dat_bis
   LEFT JOIN dbp_data.art_pm_vw_zu_per AS AP ON AP.mandant_id = 1 AND A.art_id = AP.art_id AND A.dat_von
        BETWEEN AP.dat_von AND AP.dat_bis AND AP.preistyp_id = 0 AND AP.pm_id = 1 AND AP.vw_id = 6
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY A.mandant_id, A.dat_von, A.dat_bis, A.art_id ORDER BY ABS(AP.vk_brutto)
        IS NULL DESC, ABS(AP.vk_brutto) DESC)) = 1) AS x
WHERE lagerbestand_erp.mandant_id = x.mandant_id_ AND lagerbestand_erp.dat_von = x.dat_von_ AND lagerbestand_erp.dat_bis
    = x.dat_bis_ AND lagerbestand_erp.art_id = x.art_id_;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.lagerbestand_erp
WHERE (mandant_id, wup_id, nb_id, lagerort_id, art_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme,
  menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme)
 IN (SELECT (mandant_id, wup_id, nb_id, lagerort_id, art_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme
    )
  FROM dbp_data.lagerbestand_erp_per
  WHERE mandant_id = 1
   AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


--[OK] statement is translated correctly (syntax and type checks are fine)


-- Palettenfaktor und Default Mengeneinheit holen
 INSERT INTO dbp_data.lagerbestand_erp_per (wup_id,
 mandant_id, nb_id, lagerort_id, art_id, dat_von, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme,
 menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme,
 sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status, menge_lgbest_erp_kolli, menge_lgbest_erp_palette, dat_bis,
 betrag_lgbest_erp, wrg_id, vk_netto_lgbest_erp, td_insert)
(SELECT T.wup_id,
  T.mandant_id,
  T.nb_id,
  T.lagerort_id,
  T.art_id,
  T.dat_von,
  T.menge_lgbest_erp_frei_bme,
  T.menge_lgbest_erp_umlag_bme,
  T.menge_lgbest_erp_qual_bme,
  T.menge_lgbest_erp_nf_charge_bme,
  T.menge_lgbest_erp_gesp_bme,
  T.menge_lgbest_erp_ret_gesp_bme,
  T.sperr_id,
  T.gjmo_buch,
  T.lagerort_loesch_fg,
  T.pflege_status,
  CAST((T.menge_lgbest_erp_frei_bme + T.menge_lgbest_erp_umlag_bme + T.menge_lgbest_erp_qual_bme + T.menge_lgbest_erp_gesp_bme + T.menge_lgbest_erp_ret_gesp_bme) * CASE
     WHEN aukolli.umrech_faktor IS NULL
     THEN 1
     ELSE aukolli.umrech_faktor
     END AS NUMERIC) AS
  t_menge_lgbest_erp_frei_bme_t_menge_lgbest_erp_umlag_bme_t_menge_lgbest_erp_qual_bme_t_menge_lgbest_erp_gesp_bme_t_menge_lgbest_erp_ret_gesp_bme_aukolli_umrech_faktor_aukolli_umrech_faktor
  ,
  CAST(CASE
    WHEN aupalette.umrech_faktor IS NULL
    THEN NULL
    ELSE ROUND(CAST((T.menge_lgbest_erp_frei_bme + T.menge_lgbest_erp_umlag_bme + T.menge_lgbest_erp_qual_bme + T.menge_lgbest_erp_gesp_bme + T.menge_lgbest_erp_ret_gesp_bme) * aupalette.umrech_faktor AS NUMERIC)
     , 3)
    END AS NUMERIC),
  T.dat_bis,
  ROUND(CAST((T.menge_lgbest_erp_frei_bme + T.menge_lgbest_erp_gesp_bme + T.menge_lgbest_erp_qual_bme + T.menge_lgbest_erp_ret_gesp_bme + T.menge_lgbest_erp_umlag_bme) * CAST(CAST(T.ek_netto_bnk AS NUMERIC)
       * T.komponentenmenge AS FLOAT64) AS NUMERIC), 2) AS betrag_lgbest_erp,
  T.wrg_id,
  COALESCE(ROUND(CAST((T.menge_lgbest_erp_frei_bme + T.menge_lgbest_erp_umlag_bme + T.menge_lgbest_erp_qual_bme + T.menge_lgbest_erp_nf_charge_bme + T.menge_lgbest_erp_gesp_bme + T.menge_lgbest_erp_ret_gesp_bme) * CAST(T.vk_netto AS FLOAT64)
      AS NUMERIC), 4), 0) AS vk_netto_lgbest_erp,
  CURRENT_TIMESTAMP()
 FROM dbp_etl.lagerbestand_erp AS T
  LEFT JOIN (SELECT art_id,
    paletten_faktor_einh_id,
    ausg_menge_einh_id,
    dat_von,
    dat_bis
   FROM dbp_data.art_vorschlagswert_per
   WHERE mandant_id = 1) AS av ON T.art_id = av.art_id AND T.dat_von BETWEEN av.dat_von AND av.dat_bis
    -- Umrechnungsfaktor für Palettenfaktor holen

  LEFT JOIN (SELECT art_id,
    umrech_faktor,
    altnv_menge_einh_id,
    dat_von,
    dat_bis
   FROM dbp_data.art_umrechnung_faktor_per
   WHERE mandant_id = 1) AS aupalette ON T.art_id = aupalette.art_id AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
      AND T.dat_von BETWEEN aupalette.dat_von AND aupalette.dat_bis
    -- Umrechnungsfaktor für Default Mengeneinheit holen

  LEFT JOIN (SELECT art_id,
    altnv_menge_einh_id,
    dat_von,
    dat_bis,
    umrech_faktor
   FROM dbp_data.art_umrechnung_faktor_per
   WHERE mandant_id = 1) AS aukolli ON T.art_id = aukolli.art_id AND av.ausg_menge_einh_id = aukolli.altnv_menge_einh_id
      AND T.dat_von BETWEEN aukolli.dat_von AND aukolli.dat_bis);


INSERT INTO dbp_etl.lagerbestand_erp_tmp2 (wup_id, mandant_id, nb_id, lagerort_id, art_id,
 menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
 menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status,
 dat_von, dat_bis, menge_lgbest_erp_kolli, menge_lgbest_erp_palette, betrag_lgbest_erp, wrg_id, vk_netto_lgbest_erp)
(SELECT A.wup_id,
  A.mandant_id,
  A.nb_id,
  A.lagerort_id,
  A.art_id,
  A.menge_lgbest_erp_frei_bme,
  A.menge_lgbest_erp_umlag_bme,
  A.menge_lgbest_erp_qual_bme,
  A.menge_lgbest_erp_nf_charge_bme,
  A.menge_lgbest_erp_gesp_bme,
  A.menge_lgbest_erp_ret_gesp_bme,
  A.sperr_id,
  A.gjmo_buch,
  A.lagerort_loesch_fg,
  A.pflege_status,
  A.dat_von,
  dt1.dat_bis,
  A.menge_lgbest_erp_kolli,
  A.menge_lgbest_erp_palette,
  A.betrag_lgbest_erp,
  A.wrg_id,
  A.vk_netto_lgbest_erp
 FROM dbp_data.lagerbestand_erp_per AS A
  INNER JOIN (SELECT mandant_id,
    wup_id,
    nb_id,
    lagerort_id,
    art_id,
    dat_von,
     CASE
     WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wup_id,
           nb_id, lagerort_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) -
       ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
     THEN PARSE_DATE('%F', '9999-12-31')
     ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
             mandant_id, wup_id, nb_id, lagerort_id, art_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING
           AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL - 1
      DAY)
     END AS dat_bis
   FROM dbp_data.lagerbestand_erp_per
   WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')) AS dt1 ON TRUE
 WHERE A.mandant_id = dt1.mandant_id
  AND A.wup_id = dt1.wup_id
  AND A.nb_id = dt1.nb_id
  AND A.lagerort_id = dt1.lagerort_id
  AND A.art_id = dt1.art_id
  AND A.dat_von = dt1.dat_von
  AND A.dat_bis <> dt1.dat_bis);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.lagerbestand_erp_per
WHERE (mandant_id, wup_id, nb_id, lagerort_id, art_id, dat_von) IN (SELECT (mandant_id, wup_id, nb_id, lagerort_id,
    art_id, dat_von)
  FROM dbp_etl.lagerbestand_erp_tmp2);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.lagerbestand_erp_per (wup_id, mandant_id, nb_id, lagerort_id, art_id, dat_von,
 menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
 menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status,
 menge_lgbest_erp_kolli, menge_lgbest_erp_palette, dat_bis, betrag_lgbest_erp, wrg_id, vk_netto_lgbest_erp, td_insert)
(SELECT wup_id,
  mandant_id,
  nb_id,
  lagerort_id,
  art_id,
  dat_von,
  menge_lgbest_erp_frei_bme,
  menge_lgbest_erp_umlag_bme,
  menge_lgbest_erp_qual_bme,
  menge_lgbest_erp_nf_charge_bme,
  menge_lgbest_erp_gesp_bme,
  menge_lgbest_erp_ret_gesp_bme,
  sperr_id,
  gjmo_buch,
  lagerort_loesch_fg,
  pflege_status,
  menge_lgbest_erp_kolli,
  menge_lgbest_erp_palette,
  dat_bis,
  betrag_lgbest_erp,
  wrg_id,
  vk_netto_lgbest_erp,
  CURRENT_TIMESTAMP()
 FROM dbp_etl.lagerbestand_erp_tmp2);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_tmp2;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.bestand_mardh_mard_vz_log (art_id, mandant_id, wup_id, nb_id, lagerort_id, dat)
(SELECT art_id,
  mandant_id,
  wup_id,
  nb_id,
  lagerort_id,
  dat_von
 FROM dbp_etl.lagerbestand_erp
 WHERE (art_id, mandant_id, wup_id, nb_id, lagerort_id, dat_von) NOT IN (SELECT (art_id, mandant_id, wup_id, nb_id,
      lagerort_id, dat)
    FROM dbp_etl.bestand_mardh_mard_vz_log)
 GROUP BY wup_id,
  mandant_id,
  nb_id,
  lagerort_id,
  art_id,
  dat_von);


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_dat (
dat DATE NOT NULL
);


INSERT INTO dbp_etl.art_bestand_vw_sum_dat (dat)
(SELECT dat_von
 FROM dbp_etl.lagerbestand_erp
 GROUP BY dat_von);