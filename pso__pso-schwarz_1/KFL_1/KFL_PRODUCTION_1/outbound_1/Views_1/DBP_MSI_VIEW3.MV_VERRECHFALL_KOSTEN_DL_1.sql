-- dbp_msi.akt_msi_user_wrg_typ_zu_1 v05
 -- 21.07.2014 srom, vorzeichen_fg für Hilfsattribut zur Berichtsdarstellung

-- 11.03.2016 srom, INC0679096, Ausgrenzung Status_1 analog mv_verrechfall_kosten_1

-- doing max() is mostly "just in case"; as of 2024-07-08 there are no cases in which there are > 1 distinct values for rechnung/steuerung

-- 13.04.2010  Alex Lipkin   neu erstellt
 -- 05.03.2014 srom, Anforderung 583005, Zeit_1 Verrechnung Intern

-- 2024-07-30, dknop, adding union to new Kostenarten
 -- dbp_msi.akt_msi_user_wrg_typ_zu_1 v04

-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_1 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_verrechfall_kosten_dl_1(USERID STRING) AS WITH M_KOSTENART AS (SELECT 'MDIES' AS
    verrechfall_kostenart_id
   UNION ALL
   SELECT 'MSTRO' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MGAS' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MMAUT' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MKUEH' AS verrechfall_kostenart_id) (SELECT *
  FROM (SELECT V03.mandant_id,
      V03.verrechfall_kosten_id -- ,mwst_id
 -- ,storno_fg
 -- ,soll_ist_fg
 -- ,manuelle_erfassung_fg
,
       CASE
       WHEN V04.wrg_typ_id = 0
       THEN 'EUR'
       ELSE V03.wrg_id
       END AS wrg_id_,
      V03.wrg_typ_id,
      V03.verrechfall_id -- ,dat_verrechnung_intern
 -- ,dat_verrechnung_extern
,
      V03.verrechfall_kostenart_id -- ,verrechfall_status_id
,
      V03.betrag_kosten -- ,bemerkung
 -- ,zeit_verrechnung_intern
,
      V03.dt_verechnung_intern,
      V03.vorzeichen_fg
     FROM kfl_production_dbp_msi_view3.tbl_mv_verrechfall_kosten_dl_1 AS V03
      INNER JOIN kfl_production_dbp_msi_view3.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V04 ON V03.wrg_typ_id = V04.wrg_typ_id
     WHERE V03.soll_ist_fg = 1
      AND V03.belosart_fg = 1
      AND V03.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090')
     UNION DISTINCT
     SELECT t13.mandant_id,
      t13.verrechfall_kosten_id,
       CASE
       WHEN t13.wrg_typ_id = 0
       THEN 'EUR'
       ELSE t13.wrg_id
       END AS wrg_id_,
      t13.wrg_typ_id,
      t13.verrechfall_id,
      t13.verrechfall_kostenart_id,
      t13.betrag_kosten_,
      DATETIME(t13.dat_verrechnung_intern, COALESCE(t13.zeit_verrechnung_intern, TIME '00:00:00')) AS
      dt_verechnung_intern,
       CASE
       WHEN t13.betrag_kosten_ < 0
       THEN 1
       ELSE 0
       END AS vorzeichen_fg
     FROM (SELECT TU_K_UP.mandant_id,
        vk.verrechfall_kosten_id,
        TU_K_UP.wrg_id,
        V05.wrg_typ_id,
        vf.verrechfall_id,
        t10.verrechfall_kostenart_id,
        vk.dat_verrechnung_intern,
        vk.zeit_verrechnung_intern,
        SUM(CASE
          WHEN t10.verrechfall_kostenart_id = 'MDIES'
          THEN CASE
           WHEN V04.wrg_typ_id = 0
           THEN TU_K_UP.betrag_diesel * V03.umrechnungskurs
           ELSE TU_K_UP.betrag_diesel
           END
          WHEN t10.verrechfall_kostenart_id = 'MSTRO'
          THEN CASE
           WHEN V04.wrg_typ_id = 0
           THEN TU_K_UP.betrag_strom * V03.umrechnungskurs
           ELSE TU_K_UP.betrag_strom
           END
          WHEN t10.verrechfall_kostenart_id = 'MGAS'
          THEN CASE
           WHEN V04.wrg_typ_id = 0
           THEN TU_K_UP.betrag_gas * V03.umrechnungskurs
           ELSE TU_K_UP.betrag_gas
           END
          WHEN t10.verrechfall_kostenart_id = 'MMAUT'
          THEN CASE
           WHEN V04.wrg_typ_id = 0
           THEN TU_K_UP.betrag_maut * V03.umrechnungskurs
           ELSE TU_K_UP.betrag_maut
           END
          WHEN t10.verrechfall_kostenart_id = 'MKUEH'
          THEN CASE
           WHEN V04.wrg_typ_id = 0
           THEN TU_K_UP.betrag_kuehlung * V03.umrechnungskurs
           ELSE TU_K_UP.betrag_kuehlung
           END
          ELSE 0
          END) AS betrag_kosten_
       FROM kfl_production_dbp_view.v_transportation_unit_kosten_1 AS TU_K_UP
        INNER JOIN (SELECT mandant_id,
          tour_id,
          MAX(belos_vorgang_id) AS belos_vorgang_id,
          MAX(belos_adresse_absender_num_id) AS belos_adresse_absender_num_id
         FROM kfl_production_dbp_view.v_belos_vorgang_1
         GROUP BY mandant_id,
          tour_id) AS bv ON TU_K_UP.mandant_id = bv.mandant_id AND TU_K_UP.transportation_unit_id = bv.tour_id AND
          TU_K_UP.wup_id = bv.belos_adresse_absender_num_id
        INNER JOIN (SELECT mandant_id,
          belos_vorgang_id,
          verrechfall_id,
          MAX(belos_adresse_rechnung_id) AS belos_adresse_rechnung_id,
          MAX(belos_adresse_steuerung_id) AS belos_adresse_steuerung_id
         FROM kfl_production_dbp_view.v_verrechfall_1 AS BV
         WHERE storno_fg = 0
          AND belosart_fg = 1
         GROUP BY mandant_id,
          verrechfall_id,
          belos_vorgang_id) AS vf_1 ON bv.mandant_id = vf.mandant_id AND bv.belos_vorgang_id = vf.belos_vorgang_id
        INNER JOIN (SELECT mandant_id,
          verrechfall_id,
          MAX(verrechfall_kosten_id) AS verrechfall_kosten_id,
          MAX(dat_verrechnung_intern) AS dat_verrechnung_intern,
          MAX(zeit_verrechnung_intern) AS zeit_verrechnung_intern
         FROM kfl_production_dbp_view.v_verrechfall_kosten_1
         GROUP BY mandant_id,
          verrechfall_id) AS vk_1 ON vf.verrechfall_id = vk.verrechfall_id AND vf.mandant_id = vk.mandant_id
        LEFT JOIN kfl_production_dbp_msi_view3.mv_kurs_1 AS V03 ON TU_K_UP.wrg_id = V03.von_wrg_id
        INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V04 ON bv.mandant_id = V04.mandant_id
        INNER JOIN kfl_production_dbp_msi_view3.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V05 ON V04.wrg_typ_id = V05.wrg_typ_id
         
        INNER JOIN M_KOSTENART AS t10 ON TRUE
       GROUP BY TU_K_UP.mandant_id,
        vk.verrechfall_kosten_id,
        TU_K_UP.wrg_id,
        V05.wrg_typ_id,
        vf.verrechfall_id,
        t10.verrechfall_kostenart_id,
        vk.dat_verrechnung_intern,
        vk.zeit_verrechnung_intern
       HAVING betrag_kosten_ > 0) AS t13));