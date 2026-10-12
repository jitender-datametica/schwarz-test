CREATE OR REPLACE TABLE dbp_etl.sal_final_1 (
      mandant_id BYTEINT,
      art_id INTEGER,
      wrg_id VARCHAR(3) COLLATE 'en-ci',
      kjwo INTEGER,
      owg_id SMALLINT,
      wg_id SMALLINT,
      wug_id SMALLINT,
      k1_artbew_menge DECIMAL(18,3),
      k1_anz_wup_absatz INTEGER,
      k1_anz_wup_listung INTEGER,
      k2_artbew_menge DECIMAL(18,3),
      k2_anz_wup_absatz INTEGER,
      k2_anz_wup_listung INTEGER,
      k3_artbew_menge DECIMAL(18,3),
      k3_anz_wup_absatz INTEGER,
      k3_anz_wup_listung INTEGER,
      k4_artbew_menge DECIMAL(18,3),
      k4_anz_wup_absatz INTEGER,
      k4_anz_wup_listung INTEGER,
      k5_artbew_menge DECIMAL(18,3),
      k5_anz_wup_absatz INTEGER,
      k5_anz_wup_listung INTEGER,
      ost_basis_artbew_menge DECIMAL(18,3),
      ost_basis_anz_wup_absatz INTEGER,
      ost_basis_anz_wup_listung INTEGER,
      ost_gross_artbew_menge DECIMAL(18,3),
      ost_gross_anz_wup_absatz INTEGER,
      ost_gross_anz_wup_listung INTEGER,
      sued_ost_artbew_menge DECIMAL(18,3),
      sued_ost_anz_wup_absatz INTEGER,
      sued_ost_anz_wup_listung INTEGER,
      sued_west_artbew_menge DECIMAL(18,3),
      sued_west_anz_wup_absatz INTEGER,
      sued_west_anz_wup_listung INTEGER,
      west_artbew_menge DECIMAL(18,3),
      west_anz_wup_absatz INTEGER,
      west_anz_wup_listung INTEGER,
      nord_artbew_menge DECIMAL(18,3),
      nord_anz_wup_absatz INTEGER,
      nord_anz_wup_listung INTEGER,
      total_artbew_menge FLOAT,
      total_artbew_menge_sa FLOAT,
      total_artbew_menge_vj FLOAT,
      total_umsatz_netto FLOAT,
      total_umsatz_netto_sa FLOAT,
      total_umsatz_netto_af FLOAT,
      total_rohertrag FLOAT,
      total_rohertrag_sa FLOAT,
      total_rohertrag_af FLOAT,
      total_rohertrag_vj FLOAT,
      total_rohertrag_olk FLOAT,
      total_rohertrag_olk_sa FLOAT,
      total_rohertrag_olk_af FLOAT,
      total_rohertrag_olk_vj FLOAT,
      abschriftsbetrag_ohne_werbung_netto DECIMAL(18,2),
      anz_wup_absatz INTEGER,
      anz_wup_listung INTEGER,
      anz_akt_wup_listung INTEGER,
      listung_min_1_wup_fg BYTEINT,
      listung_min_1_sst_durchg_fg BYTEINT,
      listung_min_1_sst_durchg_mvke_fg BYTEINT,
      listung_min_1_region_durchg_fg BYTEINT,
      listung_min_1_region_durchg_baustein_fg BYTEINT
);

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_zu_per AS (
SELECT a.*
FROM dbp_data.art_list_wup_zu_per_1 a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
JOIN dbp_data.wup_1 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      a.list_quelle_id IN ('1','3','7','C') AND
      a.art_id/100 = a.struktur_art_id AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE
);

CREATE OR REPLACE TABLE dbp_etl.sal_artbew_wg_art_wo_sum_1 AS (
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
	   a.art_id,
	   a.wup_id,
	   a.nb_id,
	   a.bewart_id,
	   a.menge,
	   a.umsatz_netto,
	   a.ek_mep
FROM dbp_data.artbew_wo_sum_1 a
JOIN dbp_data.woche_kj_kl_1 c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
	 b.arthiertyp_id = 2 AND
	 b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
WHERE a.mandant_id = 1
);

CREATE OR REPLACE VIEW dbp_etl.mv_sal_listung_markt_kw_1 (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,kjwo
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,anz_wo_mit_absatz
                                           ,anz_wo_mit_absatz_sa
                                           ,anz_wo_mit_absatz_af) AS
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.sal_artbew_wg_art_wo_sum_1 v01
JOIN dbp_view.v_art_wg_zu_per_1 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_view.v_wup_1 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
	 v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
	  v03.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VIEW  dbp_etl.mv_sal_artbew_wo_sum_1 (kjwo
                                        ,art_id
                                        ,wg_id
                                        ,bewart_id
                                        ,mandant_id
                                        ,wup_id
                                        ,nb_id
                                        ,ek_mep_umsatz
                                        ,umsatz_netto
                                        ,vk_menge) AS 
SELECT kjwo
      ,art_id
      ,wg_id
      ,bewart_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,CAST(ek_mep AS FLOAT)
      ,CAST(umsatz_netto AS FLOAT)
      ,CAST(menge AS FLOAT)
FROM dbp_etl.sal_artbew_wg_art_wo_sum_1
WHERE mandant_id = 1
;

CREATE OR REPLACE VOLATILE TABLE _step00 AS (
SELECT b.kjwo,
       a.mandant_id,
       a.art_id
FROM dbp_data.art_1 a
JOIN dbp_data.woche_1 b
  ON 1 = 1
WHERE a.mandant_id = 1 AND
      b.kjwo BETWEEN 201901 AND (SELECT kjwo FROM dbp_data.woche_1 WHERE akt_wo = -1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step01_1 AS (
SELECT a11.kjwo,	
       a11.art_id,
       a11.mandant_id,
       SUM((CASE WHEN (a14.sm_id = 1 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk1,
       SUM((CASE WHEN (a14.sm_id = 1 AND a14.mandant_id = 1) THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk1,
       SUM((CASE WHEN (a14.sm_id = 2 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk2,
       SUM((CASE WHEN (a14.sm_id = 2 AND a14.mandant_id = 1) THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk2,
       SUM((CASE WHEN (a14.sm_id = 3 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk3,
       SUM((CASE WHEN (a14.sm_id = 3 AND a14.mandant_id = 1) THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk3,
       SUM((CASE WHEN (a14.sm_id = 4 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk4,
       SUM((CASE WHEN (a14.sm_id = 4 AND a14.mandant_id = 1) THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk4,
       SUM((CASE WHEN (a14.sm_id = 5 AND a14.mandant_id = 1) THEN a11.absatz ELSE NULL end))  absatz_sk5,
       SUM((CASE WHEN (a14.sm_id = 5 AND a14.mandant_id = 1) THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sk5,
       SUM((CASE WHEN (a14.mandant_id = 1 AND a14.sm_id IN (1, 2, 3, 4, 5)) THEN a11.absatz_sa ELSE NULL end))  absatz_sa_sk1_bis6
FROM dbp_etl.mv_sal_listung_markt_kw_1 a11
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_1 a14
  ON a11.mandant_id = a14.mandant_id AND 
     a11.nb_id = a14.nb_id AND 
     a11.wg_id = a14.wg_id AND 
     a11.wup_id = a14.wup_id
WHERE ((a14.sm_id = 1 AND a14.mandant_id = 1) OR 
       (a14.sm_id = 2 AND a14.mandant_id = 1) OR 
       (a14.sm_id = 3 AND a14.mandant_id = 1) OR 
       (a14.sm_id = 4 AND a14.mandant_id = 1) OR 
       (a14.sm_id = 5 AND a14.mandant_id = 1))
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step02_1 AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       SUM((CASE WHEN (a14.sm_id = 1 AND a14.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sk1,
       SUM((CASE WHEN (a14.sm_id = 2 AND a14.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sk2,
       SUM((CASE WHEN (a14.sm_id = 3 AND a14.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sk3,
       SUM((CASE WHEN (a14.sm_id = 4 AND a14.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sk4,
       SUM((CASE WHEN (a14.sm_id = 5 AND a14.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sk5
FROM dbp_msi_view2.mv_max_listung_markt_kw_1 a11
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_1 a14
  ON a11.mandant_id = a14.mandant_id AND 
     a11.nb_id = a14.nb_id AND 
     a11.wg_id = a14.wg_id AND 
     a11.wup_id = a14.wup_id
WHERE a11.mandant_id = 1 AND
    ((a14.sm_id = 1 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 2 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 3 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 4 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 5 AND a14.mandant_id = 1))
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step03_1 AS (
SELECT a11.kjwo,	
       a11.art_id,
       a11.mandant_id,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'N' THEN a11.absatz ELSE NULL end))  absatz_nord,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'N' THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_nord,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'O' THEN a11.absatz ELSE NULL end))  absatz_ost_basis,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'O' THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ost_basis,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'Q' THEN a11.absatz ELSE NULL end))  absatz_ost_gross,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'Q' THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_ost_gross,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'G' THEN a11.absatz ELSE NULL end))  absatz_sued_ost,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'G' THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sued_ost,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'M' THEN a11.absatz ELSE NULL end))  absatz_sued_west,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'M' THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_sued_west,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'W' THEN a11.absatz ELSE NULL end))  absatz_west,
       SUM((CASE WHEN a11.kreistyp_gruppe_id = 'W' THEN a11.anz_wo_mit_absatz ELSE NULL end))  anz_wo_mit_abs_west
FROM dbp_etl.mv_sal_listung_markt_kw_1 a11
WHERE a11.mandant_id = 1 AND 
     (a11.kreistyp_gruppe_id = 'N' OR 
      a11.kreistyp_gruppe_id = 'O' OR 
      a11.kreistyp_gruppe_id = 'Q' OR 
      a11.kreistyp_gruppe_id = 'G' OR 
      a11.kreistyp_gruppe_id = 'M' OR 
      a11.kreistyp_gruppe_id = 'W')
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step04 AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       SUM((CASE WHEN (a11.kreistyp_gruppe_id = 'N' AND a11.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_nord,
       SUM((CASE WHEN (a11.kreistyp_gruppe_id = 'O' AND a11.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_ost_basis,
       SUM((CASE WHEN (a11.kreistyp_gruppe_id = 'Q' AND a11.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_ost_gross,
       SUM((CASE WHEN (a11.kreistyp_gruppe_id = 'G' AND a11.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sued_ost,
       SUM((CASE WHEN (a11.kreistyp_gruppe_id = 'M' AND a11.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_sued_west,
       SUM((CASE WHEN (a11.kreistyp_gruppe_id = 'W' AND a11.mandant_id = 1) THEN a11.listung ELSE 0 end))  list_west
FROM dbp_msi_view2.mv_max_listung_markt_kw_1 a11
WHERE a11.mandant_id = 1 AND
     (a11.kreistyp_gruppe_id = 'N' OR 
      a11.kreistyp_gruppe_id = 'O' OR 
      a11.kreistyp_gruppe_id = 'Q' OR 
      a11.kreistyp_gruppe_id = 'G' OR 
      a11.kreistyp_gruppe_id = 'M' OR 
      a11.kreistyp_gruppe_id = 'W')
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step05 AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       COUNT(DISTINCT a11.wup_id) anz_markt_abv,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.ek_mep_umsatz END))) re_mep_af,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep_umsatz END))) re_mep_sa,
      (ZEROIFNULL(SUM(a11.umsatz_netto)) - ZEROIFNULL(SUM(a11.ek_mep_umsatz))) re_mep_tot,
      (ZEROIFNULL(SUM(a11.umsatz_netto))) umsatz_netto_tot,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END))) umsatz_netto_af,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END))) umsatz_netto_sa,
      (ZEROIFNULL(SUM(a11.vk_menge))) menge_tot,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.vk_menge END))) menge_sa
FROM dbp_etl.mv_sal_artbew_wo_sum_1 a11
WHERE a11.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step07 AS (
SELECT a14.kjwo,
       a16.art_id,
       a16.mandant_id,
       SUM(a11.abschriftenbetrag_netto) AS abschr_vk_o_werbung
FROM dbp_msi_view2.mv_marktabschriften_1 a11
JOIN dbp_msi_view2.mv_art_wg_zu_per_1	a16
  ON a11.art_id = a16.art_id AND 
     a11.mandant_id = a16.mandant_id
JOIN dbp_data.tag_1 a14
  ON a11.dat = a14.dat
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_1 a17
  ON a11.mandant_id = a17.mandant_id AND 
     a11.nb_id = a17.nb_id AND 
     a11.wup_id = a17.wup_id AND 
     a16.mandant_id = a17.mandant_id AND 
     a16.wg_id = a17.wg_id
WHERE a17.mandant_id = 1 AND
      a11.abschriftenart_id IN (5,7,9,10,23,26,100,101,102,103,104,120,121,122,151,152,153,154,155,156,157,158)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step08 AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       SUM(a11.listung)  list_gesamt,
       MAX(a11.listung) AS listung_min_1_wup_fg
FROM dbp_msi_view2.mv_max_listung_markt_kw_1 a11
WHERE a11.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step09 AS (
SELECT a12.kjwo,
       a11.art_id,
       a11.mandant_id,
       CASE WHEN MIN(a11.sm_id) <> 0 THEN 1 ELSE 0 END AS listung_min_1_SST_durchg_v1
FROM dbp_msi_view2.mv_sternchen_logik_1 a11
JOIN dbp_data.woche_1 a12
  ON 1 = 1
WHERE a11.mandant_id = 1 AND 
      a11.list_durchg_fg = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step10 AS (
SELECT t2.kjwo,
       t1.art_id,
       t1.mandant_id,
       CASE 
         WHEN MAX(typ_ost_basis) <> '' OR
              MAX(typ_ost_gross) <> '' OR
              MAX(typ_sued_ost)  <> '' OR
              MAX(typ_sued_west) <> '' OR
              MAX(typ_west)      <> '' OR
              MAX(typ_nord)      <> '' 
         THEN 1 
         ELSE 0 
       END AS listung_min_1_region_durchg_v1
FROM dbp_msi_view2.mv_sternchen_logik_kreistyp_1 t1_1
JOIN dbp_data.woche_1 t2
  ON 1 = 1
WHERE t1.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step11 AS (
SELECT b.kjwo,
       a.art_id,
       a.mandant_id,
       a.sm_id
FROM dbp_etl_process.art_sm_vw_zu_per_1 a
JOIN dbp_data.woche_1 b
  ON 1 = 1
WHERE a.mandant_id = 1 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _step12 AS (
SELECT a12.kjwo,
       a11.art_id,
       a11.mandant_id,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.ek_mep - a11.logkostenzuschlag END))) re_mep_af_olk,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep - a11.logkostenzuschlag END))) re_mep_sa_olk,
      (ZEROIFNULL(SUM(a11.umsatz_netto)) - ZEROIFNULL(SUM(a11.ek_mep - a11.logkostenzuschlag))) re_mep_tot_olk
FROM dbp_data.artbew_1 a11
JOIN dbp_data.tag_1 a12
  ON a11.dat = a12.dat
WHERE a11.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step14 AS (
SELECT c.kjwo,
       a.mandant_id,
       a.art_id,
       1 AS list_region_teresa
FROM _art_list_wup_zu_per a
JOIN dbp_data.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
JOIN dbp_data.woche_1 c
  ON 1 = 1
WHERE a.list_quelle_id IN ('3') AND
      a.baustein_id  IN (SELECT baustein_id
                         FROM dbp_etl.baustein_region_zu_1) AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

-- 10.01.2022, -dbay-
--
-- SDQ jetzt mit Sortimentstool-Logik.

CREATE OR REPLACE TABLE dbp_etl.sal_int_artbew_wg_art_wo_sum_de_1 (
      mandant_id BYTEINT,
      kjwo INTEGER,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      bewart_id SMALLINT,
      menge DECIMAL(18,3),
      umsatz_netto DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      ek_mep DECIMAL(18,4))
;

CREATE OR REPLACE TABLE dbp_etl.sal_int_listung_markt_kw_1 (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id VARCHAR(4),
      kjwo INTEGER,
      absatz DECIMAL(18,3),
      absatz_sa DECIMAL(18,3),
      absatz_af DECIMAL(18,3),
      umsatz DECIMAL(18,4),
      umsatz_sa DECIMAL(18,4),
      umsatz_af DECIMAL(18,4),
      umsatz_brutto DECIMAL(18,4),
      umsatz_brutto_af DECIMAL(18,4),
      umsatz_brutto_sa DECIMAL(18,4),
      ertrag DECIMAL(18,4),
      ertrag_sa DECIMAL(18,4),
      ertrag_af DECIMAL(18,4),
      anzahl_wochen_mit_absatz INTEGER,
      anzahl_wochen_mit_absatz_sa INTEGER,
      anzahl_wochen_mit_absatz_af INTEGER)
;

INSERT INTO dbp_etl.sal_int_artbew_wg_art_wo_sum_de_1
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.umsatz_netto+a.umsatz_mwst_betrag AS umsatz_brutto,
       a.ek_mep
FROM dbp_data.artbew_wo_sum_1 a
JOIN dbp_data.woche_kj_kl_1 c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
WHERE a.mandant_id = 1
;

INSERT INTO dbp_etl.sal_int_listung_markt_kw_1 (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,kjwo
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,umsatz
                                           ,umsatz_sa
                                           ,umsatz_af
                                           ,umsatz_brutto
                                           ,umsatz_brutto_sa
                                           ,umsatz_brutto_af
                                           ,ertrag
                                           ,ertrag_sa
                                           ,ertrag_af
                                           ,anzahl_wochen_mit_absatz
                                           ,anzahl_wochen_mit_absatz_sa
                                           ,anzahl_wochen_mit_absatz_af)
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto)) AS umsatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZeroIfNull(Sum(v01.umsatz_brutto)) AS umsatz_brutto
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_brutto end)) AS umsatz_brutto_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_brutto end)) AS umsatz_brutto_af
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.sal_int_artbew_wg_art_wo_sum_de_1 v01
JOIN dbp_data.art_wg_zu_per_1 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_1 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre (
    kjwo INTEGER,
    art_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT,
    anz_wo_mit_absatz_af FLOAT,
    anz_wo_mit_absatz_sa FLOAT
);

INSERT INTO ZZSP07_pre
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       a11.wup_id,
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz,
       CASE WHEN Sum(a11.absatz_af) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_af,
       CASE WHEN Sum(a11.absatz_sa) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz_sa
FROM dbp_etl.sal_int_listung_markt_kw_1 a11
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre_xxx AS (
SELECT mandant_id,
       kjwo,
       art_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM ZZSP07_pre
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre (
    kjwo INTEGER,
    art_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung_1 FLOAT)
;

INSERT INTO ZZSP08_pre
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       a11.wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung_1
FROM dbp_data.art_wup_listung_kjwo_1 a11
WHERE a11.mandant_id = 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_xxx AS (
SELECT mandant_id,
       kjwo,
       art_id,
       Sum(anz_wo_listung_1) AS anz_wo_listung_1
FROM ZZSP08_pre
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre_akt AS (
SELECT mandant_id,
       art_id,
       count(distinct wup_id) AS ANZ_AKT_WUP_LISTUNG
FROM ZZSP08_pre
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _mm AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

CREATE OR REPLACE VOLATILE TABLE _mm_y AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

DELETE FROM _mm_y
WHERE anz_wo_mit_absatz = 0
;

CREATE OR REPLACE VOLATILE TABLE _mm_y_xxx AS (
SELECT mandant_id,
       kjwo,
       art_id,
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM _mm_y
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _sal_final AS (
SELECT a.mandant_id,
       a.art_id,
       'EUR' AS wrg_id,
       a.kjwo,
       c.owg_id,
       b.wg_id,
       b.wug_id,
-----------------------------------------------------------------
       COALESCE(d.absatz_sk1,0) AS k1_artbew_menge,
       COALESCE(d.anz_wo_mit_abs_sk1,0) AS k1_anz_wup_absatz,
       COALESCE(e.list_sk1,0) AS k1_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(d.absatz_sk2,0) AS k2_artbew_menge,
       COALESCE(d.anz_wo_mit_abs_sk2,0) AS k2_anz_wup_absatz,
       COALESCE(e.list_sk2,0) AS k2_anz_wup_listung, 
-----------------------------------------------------------------
       COALESCE(d.absatz_sk3,0) AS k3_artbew_menge,
       COALESCE(d.anz_wo_mit_abs_sk3,0) AS k3_anz_wup_absatz,
       COALESCE(e.list_sk3,0) AS k3_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(d.absatz_sk4,0) AS k4_artbew_menge,
       COALESCE(d.anz_wo_mit_abs_sk4,0) AS k4_anz_wup_absatz,
       COALESCE(e.list_sk4,0) AS k4_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(d.absatz_sk5,0) AS k5_artbew_menge,
       COALESCE(d.anz_wo_mit_abs_sk5,0) AS k5_anz_wup_absatz,
       COALESCE(e.list_sk5,0) AS k5_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(f.absatz_ost_basis,0) AS ost_basis_artbew_menge,
       COALESCE(f.anz_wo_mit_abs_ost_basis,0) AS ost_basis_anz_wup_absatz,
       COALESCE(g.list_ost_basis,0) AS ost_basis_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(f.absatz_ost_gross,0) AS ost_gross_artbew_menge,
       COALESCE(f.anz_wo_mit_abs_ost_gross,0) AS ost_gross_anz_wup_absatz,
       COALESCE(g.list_ost_gross,0) AS ost_gross_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(f.absatz_sued_ost,0) AS sued_ost_artbew_menge,
       COALESCE(f.anz_wo_mit_abs_sued_ost,0) AS sued_ost_anz_wup_absatz,
       COALESCE(g.list_sued_ost,0) AS sued_ost_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(f.absatz_sued_west,0) AS sued_west_artbew_menge,
       COALESCE(f.anz_wo_mit_abs_sued_west,0) AS sued_west_anz_wup_absatz,
       COALESCE(g.list_sued_west,0) AS sued_west_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(f.absatz_west,0) AS west_artbew_menge,
       COALESCE(f.anz_wo_mit_abs_west,0) AS west_anz_wup_absatz,
       COALESCE(g.list_west,0) AS west_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(f.absatz_nord,0) AS nord_artbew_menge,
       COALESCE(f.anz_wo_mit_abs_nord,0) AS nord_anz_wup_absatz,
       COALESCE(g.list_nord,0) AS nord_anz_wup_listung,
-----------------------------------------------------------------
       COALESCE(h.menge_tot,0) AS total_artbew_menge,
       COALESCE(h.menge_sa,0) AS total_artbew_menge_sa,
       0 AS total_artbew_menge_vj,
-----------------------------------------------------------------
       COALESCE(h.umsatz_netto_tot,0) AS total_umsatz_netto,
       COALESCE(h.umsatz_netto_sa,0) AS total_umsatz_netto_sa,
       COALESCE(h.umsatz_netto_af,0) AS total_umsatz_netto_af,
-----------------------------------------------------------------
       COALESCE(h.re_mep_tot,0) AS total_rohertrag,
       COALESCE(h.re_mep_sa,0) AS total_rohertrag_sa,
       COALESCE(h.re_mep_af,0) AS total_rohertrag_af,
       0 AS total_rohertrag_vj,
-----------------------------------------------------------------
       COALESCE(o.re_mep_tot_olk,0) AS total_rohertrag_olk,
       COALESCE(o.re_mep_sa_olk,0) AS total_rohertrag_olk_sa,
       COALESCE(o.re_mep_af_olk,0) AS total_rohertrag_olk_af,
       0 AS total_rohertrag_olk_vj,
-----------------------------------------------------------------      
       COALESCE(j.abschr_vk_o_werbung,0) AS abschriftsbetrag_ohne_werbung_netto,
----------------------------------------------------------------- 
       COALESCE(r.anz_wo_mit_absatz,0)   AS anz_wup_absatz,
       COALESCE(s.anz_wo_listung_1,0)      AS anz_wup_listung,
       COALESCE(t.anz_akt_wup_listung,0) AS anz_akt_wup_listung,
-----------------------------------------------------------------    
       COALESCE(k.listung_min_1_wup_fg,0) AS listung_min_1_wup_fg,
       COALESCE(l.listung_min_1_SST_durchg_v1,0) AS listung_min_1_sst_durchg_fg,
       COALESCE(CASE WHEN n.sm_id > 0 THEN 1 ELSE 0 END,0) AS listung_min_1_sst_durchg_mvke_fg,
-----------------------------------------------------------------     
       COALESCE(m.listung_min_1_region_durchg_v1,0) AS listung_min_1_region_durchg_fg,
       COALESCE(q.list_region_teresa,0) AS listung_min_1_region_durchg_baustein_fg
FROM _step00 a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN dbp_data.wg_per_1 c
  ON a.mandant_id = c.mandant_id AND
     b.wg_id = c.wg_id AND
     c.dat_bis = '9999-12-31' AND
     c.arthiertyp_id = 2
LEFT JOIN _step01_1 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     a.kjwo = d.kjwo
LEFT JOIN _step02_1 e
  ON a.mandant_id = e.mandant_id AND
     a.art_id = e.art_id AND
     a.kjwo = e.kjwo
LEFT JOIN _step03_1 f
  ON a.mandant_id = f.mandant_id AND
     a.art_id = f.art_id AND
     a.kjwo = f.kjwo
LEFT JOIN _step04 g
  ON a.mandant_id = g.mandant_id AND
     a.art_id = g.art_id AND
     a.kjwo = g.kjwo     
LEFT JOIN _step05 h
  ON a.mandant_id = h.mandant_id AND
     a.art_id = h.art_id AND
     a.kjwo = h.kjwo
LEFT JOIN _step07 j
  ON a.mandant_id = j.mandant_id AND
     a.art_id = j.art_id AND
     a.kjwo = j.kjwo
LEFT JOIN _step08 k
  ON a.mandant_id = k.mandant_id AND
     a.art_id = k.art_id AND
     a.kjwo = k.kjwo  
LEFT JOIN _step09 l
  ON a.mandant_id = l.mandant_id AND
     a.art_id = l.art_id AND
     a.kjwo = l.kjwo  
LEFT JOIN _step10 m
  ON a.mandant_id = m.mandant_id AND
     a.art_id = m.art_id AND
     a.kjwo = m.kjwo  
LEFT JOIN _step11 n
  ON a.mandant_id = n.mandant_id AND
     a.art_id = n.art_id AND
     a.kjwo = n.kjwo
LEFT JOIN _step12 o
  ON a.mandant_id = o.mandant_id AND
     a.art_id = o.art_id AND
     a.kjwo = o.kjwo 
LEFT JOIN _step14 q
  ON a.mandant_id = q.mandant_id AND
     a.art_id = q.art_id AND
     a.kjwo = q.kjwo 
LEFT JOIN _mm_y_xxx r
  ON a.mandant_id = r.mandant_id AND
     a.art_id = r.art_id AND
     a.kjwo = r.kjwo
LEFT JOIN ZZSP08_pre_xxx s
  ON a.mandant_id = s.mandant_id AND
     a.art_id = s.art_id AND
     a.kjwo = s.kjwo
LEFT JOIN ZZSP08_pre_akt t
  ON a.mandant_id = t.mandant_id AND
     a.art_id = t.art_id 
);

INSERT INTO dbp_etl.sal_final_1
SELECT *
FROM _sal_final
;

UPDATE dbp_etl.sal_final_1 SET listung_min_1_wup_fg = 0;

UPDATE dbp_etl.sal_final_1 FROM (SELECT a11.art_id,
                                      a11.mandant_id
                               FROM dbp_data.art_list_wup_zu_per_1 a11
                               WHERE CURRENT_DATE BETWEEN a11.dat_von AND a11.dat_bis AND
                                     a11.mandant_id = 1
                               GROUP BY 1,2) b

SET listung_min_1_wup_fg = 1

WHERE dbp_etl.sal_final.mandant_id = b.mandant_id AND
      dbp_etl.sal_final.art_id = b.art_id
;

DELETE FROM dbp_data.sal_int_1
WHERE (mandant_id,kjwo) IN (SELECT mandant_id,kjwo FROM dbp_etl.sal_final_1)
;

INSERT INTO dbp_data.sal_int_1 (mandant_id
                             ,art_id
                             ,wrg_id
                             ,kjwo
                             ,owg_id
                             ,wg_id
                             ,wug_id
                             ,k1_artbew_menge
                             ,k1_anz_wup_absatz
                             ,k1_anz_wup_listung
                             ,k2_artbew_menge
                             ,k2_anz_wup_absatz
                             ,k2_anz_wup_listung
                             ,k3_artbew_menge
                             ,k3_anz_wup_absatz
                             ,k3_anz_wup_listung
                             ,k4_artbew_menge
                             ,k4_anz_wup_absatz
                             ,k4_anz_wup_listung
                             ,k5_artbew_menge
                             ,k5_anz_wup_absatz
                             ,k5_anz_wup_listung
                             ,ost_basis_artbew_menge
                             ,ost_basis_anz_wup_absatz
                             ,ost_basis_anz_wup_listung
                             ,ost_gross_artbew_menge
                             ,ost_gross_anz_wup_absatz
                             ,ost_gross_anz_wup_listung
                             ,sued_ost_artbew_menge
                             ,sued_ost_anz_wup_absatz
                             ,sued_ost_anz_wup_listung
                             ,sued_west_artbew_menge
                             ,sued_west_anz_wup_absatz
                             ,sued_west_anz_wup_listung
                             ,west_artbew_menge
                             ,west_anz_wup_absatz
                             ,west_anz_wup_listung
                             ,nord_artbew_menge
                             ,nord_anz_wup_absatz
                             ,nord_anz_wup_listung
                             ,total_artbew_menge
                             ,total_artbew_menge_sa
                             ,total_artbew_menge_vj
                             ,total_umsatz_netto
                             ,total_umsatz_netto_sa
                             ,total_umsatz_netto_af
                             ,total_rohertrag
                             ,total_rohertrag_sa
                             ,total_rohertrag_af
                             ,total_rohetrag_vj
                             ,total_rohertrag_olk
                             ,total_rohertrag_olk_sa
                             ,total_rohertrag_olk_af
                             ,total_rohertrag_olk_vj
                             ,abschriftsbetrag_ohne_werbung_netto
                             ,anz_wup_absatz
                             ,anz_wup_listung
                             ,anz_akt_wup_listung
                             ,listung_min_1_wup_fg
                             ,listung_min_1_sst_durchg_fg
                             ,listung_min_1_sst_durchg_mvke_fg
                             ,listung_min_1_region_durchg_fg
                             ,listung_min_1_region_durchg_baustein_fg)
SELECT DISTINCT
       mandant_id
      ,art_id
      ,wrg_id
      ,kjwo
      ,owg_id
      ,wg_id
      ,wug_id
      ,k1_artbew_menge
      ,k1_anz_wup_absatz
      ,k1_anz_wup_listung
      ,k2_artbew_menge
      ,k2_anz_wup_absatz
      ,k2_anz_wup_listung
      ,k3_artbew_menge
      ,k3_anz_wup_absatz
      ,k3_anz_wup_listung
      ,k4_artbew_menge
      ,k4_anz_wup_absatz
      ,k4_anz_wup_listung
      ,k5_artbew_menge
      ,k5_anz_wup_absatz
      ,k5_anz_wup_listung
      ,ost_basis_artbew_menge
      ,ost_basis_anz_wup_absatz
      ,ost_basis_anz_wup_listung
      ,ost_gross_artbew_menge
      ,ost_gross_anz_wup_absatz
      ,ost_gross_anz_wup_listung
      ,sued_ost_artbew_menge
      ,sued_ost_anz_wup_absatz
      ,sued_ost_anz_wup_listung
      ,sued_west_artbew_menge
      ,sued_west_anz_wup_absatz
      ,sued_west_anz_wup_listung
      ,west_artbew_menge
      ,west_anz_wup_absatz
      ,west_anz_wup_listung
      ,nord_artbew_menge
      ,nord_anz_wup_absatz
      ,nord_anz_wup_listung
      ,total_artbew_menge
      ,total_artbew_menge_sa
      ,total_artbew_menge_vj
      ,total_umsatz_netto
      ,total_umsatz_netto_sa
      ,total_umsatz_netto_af
      ,total_rohertrag AS total_rohertrag
      ,total_rohertrag_sa AS total_rohertrag_sa
      ,total_rohertrag_af AS total_rohertrag_af
      ,total_rohertrag_vj AS total_rohertrag_vj
      ,total_rohertrag_olk AS total_rohertrag_olk
      ,total_rohertrag_olk_sa AS total_rohertrag_olk_sa
      ,total_rohertrag_olk_af AS total_rohertrag_olk_af
      ,total_rohertrag_olk_vj AS total_rohertrag_olk_vj
      ,abschriftsbetrag_ohne_werbung_netto
      ,anz_wup_absatz
      ,anz_wup_listung
      ,anz_akt_wup_listung
      ,listung_min_1_wup_fg
      ,listung_min_1_sst_durchg_fg
      ,listung_min_1_sst_durchg_mvke_fg
      ,listung_min_1_region_durchg_fg
      ,listung_min_1_region_durchg_baustein_fg
FROM dbp_etl.sal_final_1
WHERE (total_artbew_menge <> 0 OR
       listung_min_1_wup_fg = 1 OR
       anz_wup_listung > 0 OR
       abschriftsbetrag_ohne_werbung_netto <> 0)
;

CREATE OR REPLACE VOLATILE TABLE _step0 AS (
SELECT mandant_id,
       art_id
FROM dbp_data.sal_int_1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _step1 AS (
SELECT a11.art_id,
       a11.mandant_id,
       CASE WHEN MIN(a11.sm_id) <> 0 THEN 1 ELSE 0 END AS listung_min_1_SST_durchg_v1
FROM dbp_msi_view2.mv_sternchen_logik_1 a11
WHERE a11.mandant_id = 1 AND 
      a11.list_durchg_fg = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _step2 AS (
SELECT t1.art_id,
       t1.mandant_id,
       CASE 
         WHEN MAX(typ_ost_basis) <> 0 OR
              MAX(typ_ost_gross) <> 0 OR
              MAX(typ_sued_ost)  <> 0 OR
              MAX(typ_sued_west) <> 0 OR
              MAX(typ_west)      <> 0 OR
              MAX(typ_nord)      <> 0 
         THEN 1 
         ELSE 0 
       END AS listung_min_1_region_durchg_v1
FROM (SELECT t1.art_id
           , MAX(typ_ost_basis) AS typ_ost_basis
           , MAX (typ_ost_gross) AS typ_ost_gross
           , MAX (typ_sued_ost) AS typ_sued_ost
           , MAX (typ_sued_west) AS typ_sued_west
           , MAX (typ_west) AS typ_west
           , MAX (typ_nord) AS typ_nord
           , t1.mandant_id
      FROM (SELECT v01.art_id
                 , CASE WHEN v01.kreistyp_gruppe_id = 'O' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_ost_basis
                 , CASE WHEN v01.kreistyp_gruppe_id = 'Q' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_ost_gross
                 , CASE WHEN v01.kreistyp_gruppe_id = 'G' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_sued_ost
                 , CASE WHEN v01.kreistyp_gruppe_id = 'M' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_sued_west
                 , CASE WHEN v01.kreistyp_gruppe_id = 'W' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_west
                 , CASE WHEN v01.kreistyp_gruppe_id = 'N' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_nord
                 , v01.mandant_id
           FROM DBP_DATA.sternchen_logik_kreis_1 v01
           WHERE v01.mandant_id = 1) t1_1
      GROUP BY t1.art_id, t1.mandant_id) t1_1
WHERE t1.mandant_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _step3 AS (
SELECT a.art_id,
       a.mandant_id,
       a.sm_id
FROM dbp_etl_process.art_sm_vw_zu_per_1 a
WHERE a.mandant_id = 1 AND
	  CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step4 AS (
SELECT a.mandant_id,
       a.art_id,
       1 AS list_region_teresa
FROM _art_list_wup_zu_per a
JOIN dbp_data.wup_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
JOIN dbp_data.woche_1 c
  ON 1 = 1
WHERE a.list_quelle_id IN ('3') AND
      a.baustein_id  IN (SELECT baustein_id
                         FROM dbp_etl.baustein_region_zu_1) AND
      b.nb_id = 0 AND
      b.dat_eroeffnung < CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _sal_upd AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(b.listung_min_1_SST_durchg_v1,0) AS listung_min_1_sst_durchg_fg,
       COALESCE(CASE WHEN d.sm_id > 0 THEN 1 ELSE 0 END,0) AS listung_min_1_sst_durchg_mvke_fg,
       COALESCE(c.listung_min_1_region_durchg_v1,0) AS listung_min_1_region_durchg_fg,
       COALESCE(e.list_region_teresa,0) AS listung_min_1_region_durchg_baustein_fg
FROM _step0 a
LEFT JOIN _step1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN _step2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
LEFT JOIN _step3 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id
LEFT JOIN _step4 e
  ON a.mandant_id = e.mandant_id AND
     a.art_id = e.art_id
);

CREATE OR REPLACE VOLATILE TABLE _sal_upd2 AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(b.listung_min_1_wup_fg,0) AS listung_min_1_wup_fg
FROM _sal_upd a
LEFT JOIN (SELECT a11.art_id,
                  a11.mandant_id,
                  1 AS listung_min_1_wup_fg
           FROM dbp_data.art_list_wup_zu_per_1 a11
           WHERE CURRENT_DATE BETWEEN a11.dat_von AND a11.dat_bis AND
                 a11.mandant_id = 1
           GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
);

UPDATE dbp_data.sal_int_1 SET listung_min_1_wup_fg = 0,
                             listung_min_1_sst_durchg_fg = 0,
                             listung_min_1_sst_durchg_mvke_fg = 0,
                             listung_min_1_region_durchg_fg = 0,
                             listung_min_1_region_durchg_baustein_fg = 0
;

UPDATE dbp_data.sal_int_1 FROM (SELECT mandant_id,
                                     art_id,
                                     MAX(listung_min_1_sst_durchg_fg) AS listung_min_1_sst_durchg_fg,
                                     MAX(listung_min_1_sst_durchg_mvke_fg) AS listung_min_1_sst_durchg_mvke_fg,
                                     MAX(listung_min_1_region_durchg_fg) AS listung_min_1_region_durchg_fg,
                                     MAX(listung_min_1_region_durchg_baustein_fg) AS listung_min_1_region_durchg_baustein_fg
                              FROM _sal_upd
                              GROUP BY 1,2) b

SET listung_min_1_sst_durchg_fg = b.listung_min_1_sst_durchg_fg,
    listung_min_1_sst_durchg_mvke_fg = b.listung_min_1_sst_durchg_mvke_fg,
    listung_min_1_region_durchg_fg = b.listung_min_1_region_durchg_fg,
    listung_min_1_region_durchg_baustein_fg = b.listung_min_1_region_durchg_baustein_fg

WHERE dbp_data.sal_int.mandant_id = b.mandant_id AND
      dbp_data.sal_int.art_id = b.art_id
;

UPDATE dbp_data.sal_int_1 FROM (SELECT mandant_id,
                                     art_id,
                                     MIN(listung_min_1_wup_fg) AS listung_min_1_wup_fg
                              FROM _sal_upd2
                              GROUP BY 1,2) b

SET listung_min_1_wup_fg = b.listung_min_1_wup_fg

WHERE dbp_data.sal_int.mandant_id = b.mandant_id AND
      dbp_data.sal_int.art_id = b.art_id
;

-- 02.02.22, -dbay-
--
-- update for assortment tool for keeping it synchronized

create or replace volatile table _daily_sal_upd as (
select a.mandant_id,
       b.matching_id,
       coalesce(b.anzahl_markt_wochen_kombis_abverkauf_mit_listung,0) as tm_anz_abverkauf,
       coalesce(b.anzahl_markt_wochen_kombis_listung,0) as tm_anz_listung,
       sum(a.anz_wup_absatz) as sal_anz_abverkauf,
       sum(a.anz_wup_listung) as sal_anz_listung
from dbp_data.sal_int_1 a
join (select mandant_id,
             art_matching_id,
             art_id
      from dbp_etl.art_matching_nielsen_per_1
      group by 1,2,3) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id
join dbp_etl_process.tupel_mat_etl_1 b
  on c.mandant_id = b.mandant_id and
     c.art_matching_id = b.matching_id
where a.kjwo in (select x.kjwo
                 from (select kjwo,
                              rank() over (order by kjwo desc) * (-1) as akt_wo
                       from dbp_data.art_nielsen_fakten_kjwo_1
                       where mandant_id = 1
                       group by 1) x
                 where akt_wo between -52 and -1) and
      a.mandant_id = 1 and
      b.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_1 where mandant_id = 1)
group by 1,2,3,4
having (tm_anz_abverkauf <> sal_anz_abverkauf or tm_anz_listung <> sal_anz_listung)
);

update dbp_etl_process.tupel_mat_etl_1 from (select *
                                           from _daily_sal_upd) b
                                           
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
    
where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_1 where mandant_id = 1)
;

update dbp_msi_data.tupel_mat_quarantaene_1 from (select *
                                                from _daily_sal_upd) b
                                           
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
    
where dbp_msi_data.tupel_mat_quarantaene.mandant_id = b.mandant_id and
      dbp_msi_data.tupel_mat_quarantaene.matching_id = b.matching_id and
      dbp_msi_data.tupel_mat_quarantaene.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_1 where mandant_id = 1)
;

update dbp_msi_data.tupel_mat_1 from (select *
                                    from _daily_sal_upd) b
                                           
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
    
where dbp_msi_data.tupel_mat.mandant_id = b.mandant_id and
      dbp_msi_data.tupel_mat.matching_id = b.matching_id and
      dbp_msi_data.tupel_mat.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_1 where mandant_id = 1)
;
