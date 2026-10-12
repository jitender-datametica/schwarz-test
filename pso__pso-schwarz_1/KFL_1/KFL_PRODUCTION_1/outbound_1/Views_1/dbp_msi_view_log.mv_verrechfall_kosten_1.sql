-- 03.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1
 -- dbp_msi.akt_msi_user_wrg_typ_zu_1 v05

-- ,v01.verrechfall_id
 -- ,v02.verrechfall_kosten_id

-- 2022.02.16, dknop, adding inner join to akt_msi_user_wrg_typ_zu_1, CROSS JOIN to dbp_msi_view_log.mv_kurs_1 for umrechnungskurs

-- 08.02.2021, SPEC0091861, AP0073899, dknop, adding CROSS JOIN to dbp_view.v_verrechfall_1
 -- ,v02.mwst_id

-- 23.06.2021, SPEC0091861, AP0073899, dknop, belos_adresse_rechnung_id, belos_adresse_steuerung_id

-- 2024-10-29, nwag, limit to akt_kj > -2 due to TU repeating

-- 16.06.2021, dknop, per Silke Panzer request, adding filter soll_ist_fg = 1
 -- ,v02.zeit_verrechnung_intern

-- ,v02.bemerkung
 -- ,v02.soll_ist_fg

-- doing max() is mostly "just in case"; as of 2024-07-08 there are no cases in which there are > 1 distinct values for rechnung/steuerung

-- dbp_msi.akt_msi_user_wrg_typ_zu_1 v05
 -- ,v02.dat_verrechnung_intern
 -- ,v02.verrechfall_status_id

-- ,v01.belosart_fg
 -- 2024-07-08, dknop, adding union to new Kostenarten

-- example: where v01.belos_vorgang_id=18891068
 -- 2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT

-- ,v02.manuelle_erfassung_fg
 -- ,v02.dat_verrechnung_extern

-- 2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_1 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

-- ,v01.storno_fg
 CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_verrechfall_kosten_1(USERID STRING) AS WITH M_KOSTENART AS (SELECT
    'MDIES' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MSTRO' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MGAS' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MMAUT' AS verrechfall_kostenart_id
   UNION ALL
   SELECT 'MKUEH' AS verrechfall_kostenart_id) (SELECT *
  FROM (SELECT V01.belos_vorgang_id,
      V01.mandant_id,
      V02.verrechfall_kostenart_id,
      SUM(CASE
        WHEN V04.wrg_typ_id = 0
        THEN V02.betrag_kosten * V03.umrechnungskurs
        ELSE V02.betrag_kosten
        END) AS betrag_kosten,
      COALESCE(V01.belos_adresse_rechnung_id, '-1') AS belos_adresse_rechnung_id,
      COALESCE(V01.belos_adresse_steuerung_id, '-1') AS belos_adresse_steuerung_id,
       CASE
       WHEN V05.wrg_typ_id = 0
       THEN 'EUR'
       ELSE V01.wrg_id
       END AS wrg_id_
     FROM kfl_production_dbp_view.v_verrechfall_1 AS V01
      LEFT JOIN kfl_production_dbp_view.v_verrechfall_kosten_1 AS V02 ON V01.verrechfall_id = V02.verrechfall_id AND V01.mandant_id
         = V02.mandant_id
      LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_1 AS V03 ON V01.wrg_id = V03.von_wrg_id
      INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V04 ON V02.mandant_id = V04.mandant_id
      INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V05 ON V04.wrg_typ_id = V05.wrg_typ_id
       
     WHERE V02.soll_ist_fg = 1
     GROUP BY V01.belos_vorgang_id,
      V01.mandant_id,
      V02.verrechfall_kostenart_id,
      V01.belos_adresse_rechnung_id,
      V01.belos_adresse_steuerung_id,
      V01.wrg_id,
      V05.wrg_typ_id
     UNION DISTINCT
     SELECT t13.belos_vorgang_id,
      t13.mandant_id,
      t13.verrechfall_kostenart_id,
      t13.betrag_kosten,
      t13.belos_adresse_rechnung_id,
      t13.belos_adresse_steuerung_id,
       CASE
       WHEN t13.wrg_typ_id = 0
       THEN 'EUR'
       ELSE t13.wrg_id
       END AS wrg_id_
     FROM (SELECT bv.belos_vorgang_id,
        bv.mandant_id,
        t10.verrechfall_kostenart_id,
        vf.belos_adresse_rechnung_id,
        vf.belos_adresse_steuerung_id,
        V05.wrg_typ_id,
        TU_K_UP.wrg_id,
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
          END) AS betrag_kosten
       FROM kfl_production_dbp_view.v_transportation_unit_kosten_1 AS TU_K_UP
        INNER JOIN (SELECT B.mandant_id,
          B.tour_id,
          B.dat_leistung,
          MAX(B.belos_vorgang_id) AS belos_vorgang_id,
          MAX(B.belos_adresse_absender_num_id) AS belos_adresse_absender_num_id
         FROM kfl_production_dbp_view.v_belos_vorgang_1 AS B
          INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON B.dat_leistung = T.dat AND T.akt_kj >= - 2
         GROUP BY B.mandant_id,
          B.dat_leistung,
          B.tour_id) AS bv ON TU_K_UP.mandant_id = bv.mandant_id AND TU_K_UP.transportation_unit_id = bv.tour_id AND
           TU_K_UP.wup_id = bv.belos_adresse_absender_num_id AND TU_K_UP.kj_transportation_unit = EXTRACT(YEAR FROM bv.dat_leistung
           )
        INNER JOIN (SELECT mandant_id,
          belos_vorgang_id,
          MAX(belos_adresse_rechnung_id) AS belos_adresse_rechnung_id,
          MAX(belos_adresse_steuerung_id) AS belos_adresse_steuerung_id
         FROM kfl_production_dbp_view.v_verrechfall_1 AS BV
         WHERE storno_fg = 0
          AND belosart_fg = 1
         GROUP BY mandant_id,
          belos_vorgang_id) AS vf_1 ON bv.mandant_id = vf.mandant_id AND bv.belos_vorgang_id = vf.belos_vorgang_id
        INNER JOIN M_KOSTENART AS t10 ON TRUE
        LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_1 AS V03 ON TU_K_UP.wrg_id = V03.von_wrg_id
        INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V04 ON bv.mandant_id = V04.mandant_id
        INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V05 ON V04.wrg_typ_id = V05.wrg_typ_id
         
       GROUP BY bv.belos_vorgang_id,
        bv.mandant_id,
        t10.verrechfall_kostenart_id,
        vf.belos_adresse_rechnung_id,
        vf.belos_adresse_steuerung_id,
        V05.wrg_typ_id,
        TU_K_UP.wrg_id
       HAVING betrag_kosten > 0) AS t13));