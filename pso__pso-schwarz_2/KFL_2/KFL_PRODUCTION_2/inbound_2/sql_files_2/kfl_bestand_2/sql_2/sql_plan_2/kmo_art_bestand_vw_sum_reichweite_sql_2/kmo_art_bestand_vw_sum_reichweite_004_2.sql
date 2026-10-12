--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_rw_kmo_tmp_2
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
   tmp.mandant_id
  ,tmp.vw_id
  ,4 AS bezugsweg_id
  ,1 AS lagerbestand_fg
  ,tmp.nb_id
  ,tmp.art_id
  ,tmp.wup_id
  ,tmp.dat_buch
  ,tmp._gp_id                                     AS gp_id
  ,1 AS relevant_fg
  ,tmp.wrg_id
  ,COALESCE(t03.menge_lgbest_erp_frei_bme, 0)     AS menge_lgbest_erp_frei_bme
  ,COALESCE(t03.menge_lgbest_erp_gesamt_bme, 0)   AS menge_lgbest_erp_gesamt_bme
  ,COALESCE(t03.menge_lgbest_erp_qual_bme, 0)     AS menge_lgbest_erp_qual_bme
  ,CASE WHEN t03.mandant_id IS NOT NULL THEN t03.betrag_vk_netto_frei_bme END    AS betrag_vk_netto_frei_bme
  ,CASE WHEN t03.mandant_id IS NOT NULL THEN t03.betrag_vk_netto_gesamt_bme END  AS betrag_vk_netto_gesamt_bme
  ,CASE WHEN t03.mandant_id IS NOT NULL THEN t03.betrag_vk_netto_qual_bme END    AS betrag_vk_netto_qual_bme
  ,tmp.menge_abgang_bme
  ,tmp.betrag_vk_netto_abgang
FROM
(
  SELECT
     t01.mandant_id
    ,w.vw_id
    ,t01.nb_id
    ,t02.art_id
    ,t01.wup_id
    ,t01.dat_buch
    ,COALESCE (agn.gp_id, -1)         AS _gp_id
    ,t02.wrg_id
         -- Lt. Hr. Sarbak muss das soll_haben_kz beruecksichtigt werden, um das richtige Vorzeichen zu ermitteln.
         -- Dies erfolgt schon in der Anreicherung der lager_bew_det (s. kmo_mkpfmseg.btq)
         -- Somit koennen die Werte der lager_bew_det einfach summiert werden.
    ,SUM(t02.menge_lagerbew_bme)                        AS menge_abgang_bme
    ,SUM(t02.betrag_vk_netto_vz)                        AS betrag_vk_netto_abgang
  FROM DBP_ETL.kmo_mseg_reichweite_2 t01

  INNER JOIN DBP_DATA.wup_2 w
     ON t01.mandant_id = w.mandant_id
    AND t01.wup_id     = w.wup_id
    AND t01.nb_id      = w.nb_id
    AND t01.nb_id      = -111          -- Nur Laeger beruecksichtigen

  INNER JOIN DBP_DATA.lagerbew_det_2 t02
     ON t01.mandant_id = t02.mandant_id
    AND t01.dat_buch   = t02.dat_buch
    AND t01.wup_id     = t02.wup_id
    AND t01.nb_id      = t02.nb_id
    AND t01.nb_id      = -111         -- Nur Laeger beruecksichtigen

  LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per_2 agn
     ON t01.mandant_id = agn.mandant_id
    AND t02.wup_id     = agn.wup_id
    AND t02.nb_id      = agn.nb_id
    AND t02.art_id     = agn.art_id
    AND t02.dat_buch BETWEEN agn.dat_von AND agn.dat_bis

/* In DE verwendeter Filter:
  WHERE TRIM(t02.lagerort_id) IN ('0', '1', '2', '3', '4', '6', '7', 'W2', 'KL0', 'KL1', 'KL2', 'KL3', 'KL4', 'KL6', 'KL7') -- Hr. Ferber 2008.09.25
    AND t02.lager_bewart_id IN ('641', '643', '645', '651', '945', 'Z46', 'Z48')
*/
  WHERE t02.lager_bewart_id IN ('641', '642', '647', '648')  -- Logik aus View msi_view_ais_kmo.mv_lagerbew_det_2
     OR (t02.lagerort_id = '0019' AND t02.lager_bewart_id IN ('301', '302', '311', '312'))  -- Fuer Retouren nur lagerort_id 19

  GROUP BY t01.mandant_id
    ,w.vw_id
    ,t01.nb_id
    ,t02.art_id
    ,t01.wup_id
    ,t01.dat_buch
    ,_gp_id
    ,t02.wrg_id
) tmp

LEFT OUTER JOIN DBP_DATA.art_bestand_vw_sum_2 t03
   ON tmp.mandant_id      = t03.mandant_id
  AND tmp.dat_buch        = t03.dat
  AND tmp.wup_id          = t03.wup_id
  AND tmp.nb_id           = t03.nb_id
  AND tmp.art_id          = t03.art_id
  AND tmp._gp_id          = t03.gp_id
  AND t03.lagerbestand_fg = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_bestand_vw_sum_2
WHERE  (mandant_id, dat, wup_id, nb_id, vw_id, art_id, bezugsweg_id, lagerbestand_fg, gp_id) IN
  (SELECT mandant_id, dat, wup_id, nb_id, vw_id, art_id, bezugsweg_id, lagerbestand_fg, gp_id
   FROM DBP_ETL.art_bestand_vw_sum_rw_kmo_tmp_2
  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_bestand_vw_sum_2
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
FROM DBP_ETL.art_bestand_vw_sum_rw_kmo_tmp_2
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_mseg_reichweite_2;

