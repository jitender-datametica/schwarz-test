CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm_materialized.mv_artbew_1(USERID STRING) AS
SELECT artbew.dat,
 T.kjwo,
 T.kjmo,
 artbew.art_id,
 artbew.mandant_id,
 artbew.nb_id,
 V05.aktuell_wup_id AS wup_id,
 artbew.vk_menge,
  COALESCE(artbew.vk_menge, 0) - COALESCE(CASE
    WHEN artbew.mandant_id = 1
    THEN absch_de.menge_preisabschriften
    ELSE absch_kmo.menge_preisabschriften
    END, 0) AS vk_menge_opa,
 artbew.vk_menge_af,
 artbew.vk_menge_sa,
 artbew.umsatz_netto,
 artbew.umsatz_netto_af,
 artbew.umsatz_netto_sa
FROM (SELECT V01.dat,
   V01.art_id,
   V01.mandant_id,
   V01.nb_id,
   V01.wup_id,
   SUM(V01.menge) AS vk_menge,
   SUM(CASE
     WHEN V01.bewart_id IN (1001, 1010)
     THEN V01.menge
     ELSE NULL
     END) AS vk_menge_af,
   SUM(CASE
     WHEN V01.bewart_id = 1002
     THEN V01.menge
     ELSE NULL
     END) AS vk_menge_sa,
   SUM(CASE
     WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1
     THEN CAST(V01.diff_umsatz_netto_konz AS NUMERIC)
     ELSE CAST(V01.umsatz_netto AS NUMERIC)
     END) AS umsatz_netto,
   SUM(CASE
     WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
     THEN CAST(V01.diff_umsatz_netto_konz AS NUMERIC)
     WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
         IN (1001, 1010)
     THEN CAST(V01.umsatz_netto AS NUMERIC)
     ELSE NULL
     END) AS umsatz_netto_af,
   SUM(CASE
     WHEN V02.wrg_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
     THEN CAST(V01.diff_umsatz_netto_konz AS NUMERIC)
     WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id =
        1002
     THEN CAST(V01.umsatz_netto AS NUMERIC)
     ELSE NULL
     END) AS umsatz_netto_sa
  FROM kfl_production_dbp_view.v_artbew_1 AS V01
   INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V02 ON TRUE
  GROUP BY V01.dat,
   V01.art_id,
   V01.mandant_id,
   V01.nb_id,
   V01.wup_id) AS artbew_1
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON artbew.mandant_id = V05.mandant_id AND artbew.wup_id = V05.wup_id
  AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   art_id,
   dat,
   SUM(CASE
     WHEN abschrift_menge_einh_id = 'G'
     THEN menge_abschrift / 1000
     ELSE menge_abschrift
     END) AS menge_preisabschriften
  FROM kfl_production_dbp_view.v_marktabschriften_1 AS V01
  WHERE mandant_id = 1
   AND abschriftart_id IN (5, 7)
  GROUP BY mandant_id,
   wup_id,
   art_id,
   dat) AS absch_de ON artbew.mandant_id = absch_de.mandant_id AND artbew.wup_id = absch_de.wup_id AND artbew.art_id =
    absch_de.art_id AND artbew.dat = absch_de.dat
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   art_id,
   dat_umbew AS dat,
   SUM(menge_erf) AS menge_preisabschriften
  FROM kfl_production_dbp_view.v_art_umbewertung_1 AS ABSCH
  WHERE mandant_id = 6 AND preis_aend_grund_id = 2
   OR mandant_id IN (2, 4, 5, 7, 8) AND preis_aend_grund_id = 7
   OR mandant_id = 3 AND preis_aend_grund_id = 11
  GROUP BY mandant_id,
   wup_id,
   art_id,
   dat) AS absch_kmo ON artbew.mandant_id = absch_kmo.mandant_id AND artbew.wup_id = absch_kmo.wup_id AND artbew.art_id
    = absch_kmo.art_id AND artbew.dat = absch_kmo.dat
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON artbew.dat = T.dat;