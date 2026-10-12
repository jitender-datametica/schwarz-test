CREATE OR REPLACE VOLATILE TABLE _xxx_woche_sort AS (
SELECT c.kjmo as kjmo_sort
FROM dbp_data.monat_2 a
JOIN (SELECT kjmo_sort
      from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2
      where kjwo_bis IN (SELECT max(kjwo) FROM dbp_data.art_nielsen_fakten_kjwo_2 WHERE mandant_id = 1)) b
  ON a.kjmo = b.kjmo_sort
JOIN dbp_data.monat_2 c
  ON a.akt_mo = c.akt_mo
);

CREATE OR REPLACE VOLATILE TABLE ZZMQ01 AS (
SELECT kjwo,
       kjwo_vj,
       (SELECT kjmo_sort FROM _xxx_woche_sort) as kjmo_sort
FROM dbp_data.woche_2
WHERE kjwo BETWEEN (SELECT kjwo_von FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND (SELECT kjwo_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort))
GROUP BY 1,2
);

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_stp_de_2 AS (
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
FROM dbp_data.artbew_wo_sum_2 a
JOIN dbp_data.woche_kj_kl_2 c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
	 b.arthiertyp_id = 2 AND
	 b.dat_bis = '9999-12-31'
WHERE a.mandant_id = 1 AND
      b.wg_id BETWEEN 1 AND 999
);

CREATE OR REPLACE VIEW dbp_etl.mv_artbew_wo_sum_2 AS (
SELECT kjwo
      ,art_id
      ,wg_id
      ,bewart_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,CAST(ek_mep AS FLOAT) AS ek_mep_umsatz
      ,CAST(umsatz_netto AS FLOAT) AS umsatz_netto
      ,CAST(menge AS FLOAT) AS menge
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de_2
WHERE mandant_id = 1
);

CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_kw_2 AS (
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
      ,ZEROIFNULL(COUNT(DISTINCT v01.kjwo)) AS anz_wo_mit_absatz
      ,ZEROIFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end)) AS anz_wo_mit_absatz_sa
      ,ZEROIFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end)) AS anz_wo_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
	 v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_tag_2 AS (
SELECT v01.mandant_id
      ,v03.wg_id
      ,v01.art_id
      ,v01.dat
      ,v02.kjwo
      ,v01.wup_id
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(COUNT(DISTINCT v02.dat)) AS anz_tage_mit_absatz
      ,ZEROIFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.dat end)) AS anz_tage_mit_absatz_sa
      ,ZEROIFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v02.dat end)) AS anz_tage_mit_absatz_af
FROM dbp_view.v_artbew_2 v01
JOIN dbp_view.v_tag_2 v02
  ON v01.dat = v02.dat
JOIN dbp_view.v_art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_view.v_wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE ZZMQ00 AS (
SELECT a.art_id,
       a.mandant_id
FROM dbp_data.art_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
WHERE a.wg_art_fg = 0 AND
      b.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND
      a.mandant_id = 1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE ZZMD02 AS (
SELECT xxx.kjwo,
       a13.art_id  art_id,
       a13.mandant_id  mandant_id,
       MAX(a11.ek_kal_basis) AS stk_ek_kb_stamm
FROM dbp_msi_view2.mv_einkaufspreisstamm_2	a11
JOIN ZZMQ01 xxx_2
  ON 1=1
JOIN ZZMQ00 pa12
  ON (a11.art_id = pa12.art_id AND 
      a11.mandant_id = pa12.mandant_id)
JOIN dbp_msi_view2.mv_art_wg_zu_per_2 a13
  ON (a11.art_id = a13.art_id AND
      a11.mandant_id = a13.mandant_id)
WHERE	(a13.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
       a13.mandant_id = 1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD03 AS (
SELECT xxx.kjwo,
       a11.art_id art_id,
       a11.mandant_id mandant_id,
       MAX(a11.VKPK1) WJXBFS1,
       MAX(a11.VKPK4) WJXBFS2
FROM dbp_msi_view2.mv_art_pm_vw_akt_2	a11
JOIN ZZMQ01 xxx_2
  ON 1=1
JOIN ZZMQ00 pa12
  ON (a11.art_id = pa12.art_id AND 
      a11.mandant_id = pa12.mandant_id)
JOIN dbp_msi_view2.mv_art_wg_zu_per_2 a13
  ON (a11.art_id = a13.art_id AND
      a11.mandant_id = a13.mandant_id)
WHERE	(a13.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
       a13.mandant_id = 1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD04 AS (
SELECT xxx.kjwo,
       a12.art_id  art_id,
       a12.mandant_id  mandant_id,
      (ZEROIFNULL((MAX(a11.mwst) / 100.0)) + 1.0)  WJXBFS1
FROM dbp_msi_view2.mv_mwst_per_2	a11
JOIN ZZMQ01 xxx_2
  ON 1=1
JOIN dbp_msi_view2.mv_art_2	a12
  ON a11.mwst_id = a12.mwst_id
JOIN ZZMQ00 pa13
  ON a12.art_id = pa13.art_id AND 
     a12.mandant_id = pa13.mandant_id
JOIN dbp_msi_view2.mv_art_wg_zu_per_2 a14
  ON a12.art_id = a14.art_id AND 
     a12.mandant_id = a14.mandant_id
WHERE	(a14.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
       a14.mandant_id = 1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZOJ05 AS ( 
SELECT pa11.kjwo,
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD02 pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD03 pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD04 pa11
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD06 AS (
SELECT pa11.kjwo,
       pa11.art_id  art_id,
       pa11.mandant_id  mandant_id,
       MAX(CASE WHEN pa12.stk_ek_kb_stamm IS NULL THEN NULL ELSE (1.0 - ZEROIFNULL((pa12.stk_ek_kb_stamm / NULLIFZERO((pa13.WJXBFS1 / NULLIFZERO(pa14.WJXBFS1)))))) END)  Sp_EKKB_01,
       MAX(CASE WHEN pa12.stk_ek_kb_stamm IS NULL THEN NULL ELSE (1.0 - ZEROIFNULL((pa12.stk_ek_kb_stamm / NULLIFZERO((pa13.WJXBFS2 / NULLIFZERO(pa14.WJXBFS1)))))) END)  Sp_EKKB_04
FROM ZZOJ05	pa11
LEFT JOIN ZZMD02 pa12
  ON pa11.art_id = pa12.art_id AND
     pa11.mandant_id = pa12.mandant_id AND
     pa11.kjwo = pa12.kjwo
LEFT JOIN ZZMD03 pa13
  ON pa11.art_id = pa13.art_id AND
     pa11.mandant_id = pa13.mandant_id AND
     pa11.kjwo = pa13.kjwo
LEFT JOIN ZZMD04 pa14
  ON pa11.art_id = pa14.art_id AND 
     pa11.mandant_id = pa14.mandant_id AND
     pa11.kjwo = pa14.kjwo
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre AS (
SELECT a11.kjwo,
       a11.art_id  art_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       COUNT(DISTINCT a11.wup_id) AS anz_maerkte,
       SUM(a11.absatz)  absatz_gesamt,
       SUM(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz,
       SUM(a11.absatz_af) absatz_af_sk1_bis6,
       SUM(a11.anz_wo_mit_absatz_af) anz_wo_mit_abs_af_sk1_bis6,
       SUM(a11.anz_wo_mit_absatz) anz_wo_mit_abs_tot_sk1_bis6
FROM dbp_etl.mv_listung_markt_kw_2 a11
JOIN ZZMQ00 pa12
  ON a11.art_id = pa12.art_id AND 
     a11.mandant_id = pa12.mandant_id
JOIN ZZMQ01 xxx_2
  ON a11.kjwo = xxx.kjwo
WHERE a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
      a11.mandant_id = 1
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       a11.wup_id,
       SUM(a11.listung) anz_wo_listung_2
FROM dbp_msi_view2.mv_max_listung_markt_kw_2	a11
JOIN ZZMQ00 pa12
  ON (a11.art_id = pa12.art_id AND 
      a11.mandant_id = pa12.mandant_id)
JOIN ZZMQ01 pa13
  ON (a11.kjwo = pa13.kjwo)
WHERE (a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
       a11.mandant_id = 1)
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _mm AS (
SELECT a.*,
       b.anz_maerkte,
       b.absatz_gesamt,
       b.anz_wo_mit_absatz,
       b.absatz_af_sk1_bis6,
       b.anz_wo_mit_abs_af_sk1_bis6,
       b.anz_wo_mit_abs_tot_sk1_bis6
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

INSERT INTO _mm
SELECT kjwo,
       art_id,
       mandant_id,
       wup_id,
       anz_wo_listung_2,
       0,0,0,0,0,0
FROM ZZSP08_pre
WHERE (kjwo,art_id,mandant_id,wup_id) NOT IN (SELECT kjwo,art_id,mandant_id,wup_id FROM _mm)
;

CREATE OR REPLACE VOLATILE TABLE ZZSP07 AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       COUNT(DISTINCT a11.wup_id) AS anz_maerkte,
       SUM(a11.absatz_gesamt)  absatz_gesamt,
       SUM(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz,
       SUM(a11.absatz_af_sk1_bis6) absatz_af_sk1_bis6,
       SUM(a11.anz_wo_mit_abs_af_sk1_bis6) anz_wo_mit_abs_af_sk1_bis6,
       SUM(a11.anz_wo_mit_abs_tot_sk1_bis6) anz_wo_mit_abs_tot_sk1_bis6
FROM ZZSP07_pre a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZSP08 AS (
SELECT a11.kjwo,
       a11.art_id,
       a11.mandant_id,
       SUM(a11.anz_wo_listung_2) anz_wo_listung_2
FROM ZZSP08_pre a11
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZOJ09 AS (
SELECT pa11.kjwo,
       pa11.art_id,
       pa11.mandant_id
FROM ZZSP07	pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,
       pa11.art_id,
       pa11.mandant_id
FROM ZZSP08	pa11
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0A_xxx AS (
SELECT pa11.kjwo,
       pa11.art_id,
       pa11.mandant_id,
       1.0  WJXBFS1,
       pa12.absatz_gesamt,
       pa13.anz_wo_listung_2,
       pa12.anz_wo_mit_absatz,
       pa12.anz_maerkte,
       pa12.absatz_af_sk1_bis6,
       pa12.anz_wo_mit_abs_af_sk1_bis6,
       pa12.anz_wo_mit_abs_tot_sk1_bis6
FROM ZZOJ09 pa11
LEFT JOIN ZZSP07 pa12
  ON pa11.art_id = pa12.art_id AND
     pa11.mandant_id = pa12.mandant_id AND
     pa11.kjwo = pa12.kjwo
LEFT JOIN ZZSP08 pa13
  ON pa11.art_id = pa13.art_id AND
     pa11.mandant_id = pa13.mandant_id AND
     pa11.kjwo = pa13.kjwo
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0B AS (
SELECT MAX(a11.kjwo) max_kjwo,
       MIN(a11.kjwo) min_kjwo
FROM dbp_data.woche_2 a11
JOIN ZZMQ01 pa12
  ON a11.kjwo = pa12.kjwo
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0C AS (
SELECT xxx.kjwo,
       a13.art_id,
       a13.mandant_id,
       MIN(a11.sm_id)  min_durchg_gelistet_sst
FROM dbp_msi_view2.mv_sternchen_logik_2 a11
JOIN ZZMQ00 pa12
  ON (a11.art_id = pa12.art_id AND 
      a11.mandant_id = pa12.mandant_id)
JOIN ZZMQ01 xxx_2
  ON 1=1
JOIN dbp_msi_view2.mv_art_wg_zu_per_2 a13
  ON (a11.art_id = a13.art_id AND 
      a11.mandant_id = a13.mandant_id)
WHERE ((a13.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
        a13.mandant_id = 1) AND 
        a11.list_durchg_fg = 1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0D AS (
SELECT a11.kjwo,
       a11.art_id  art_id,
       a11.mandant_id  mandant_id,
       SUM(a11.umsatz_netto)  kassenumsatz_sk_1_bis_6,
       SUM(a11.ek_mep_umsatz)  ek_mep_ums_sk1_bis_6,
       SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto end)  kassenumsatz_af_sk_1_bis_6,
       SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep_umsatz end)  ek_mep_ums_sa_sk1_bis_6,
       SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto end)  kassenumsatz_sa_sk_1_bis_6
FROM dbp_etl.mv_artbew_wo_sum_2	a11
JOIN ZZMQ00 pa12
  ON a11.art_id = pa12.art_id AND 
     a11.mandant_id = pa12.mandant_id
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_2	a16
  ON a11.mandant_id = a16.mandant_id AND 
	 a11.nb_id = a16.nb_id AND 
	 a11.wup_id = a16.wup_id AND 
	 a11.mandant_id = a16.mandant_id AND 
	 a11.wg_id = a16.wg_id
JOIN ZZMQ01 xxx_2
  ON a11.kjwo = xxx.kjwo
WHERE a11.mandant_id = 1 AND 
      a16.sm_id IN (1,2,3,4,5) AND 
      a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
      a11.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0E AS (
SELECT a11.kjwo,
  a11.art_id  art_id,
	a11.mandant_id  mandant_id,
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
FROM	dbp_etl.mv_listung_markt_kw_2	a11
	JOIN	ZZMQ00	pa12
	  ON 	(a11.art_id = pa12.art_id AND 
	a11.mandant_id = pa12.mandant_id)
	JOIN	dbp_msi_view2.mv_wg_wup_sm_zu_per_2	a14
	  ON 	(a11.mandant_id = a14.mandant_id AND 
	a11.nb_id = a14.nb_id AND 
	a11.wg_id = a14.wg_id AND 
	a11.wup_id = a14.wup_id)
WHERE	a14.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
      a11.mandant_id = 1 AND 
    ((a14.sm_id = 1 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 2 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 3 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 4 AND a14.mandant_id = 1) OR 
     (a14.sm_id = 5 AND a14.mandant_id = 1) OR 
     (a14.mandant_id = 1 AND a14.sm_id IN (1,2,3,4,5)))
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0F AS (
SELECT a14.kjwo,
       a16.art_id  art_id,
       a16.mandant_id  mandant_id,
       SUM(a11.abschriftenbetrag_netto)  abschr_vk_o_werbung
FROM dbp_msi_view2.mv_marktabschriften_2	a11
JOIN dbp_msi_view2.mv_art_wg_zu_per_2	a16
  ON (a11.art_id = a16.art_id AND 
      a11.mandant_id = a16.mandant_id)
JOIN ZZMQ00 pa13
  ON (a16.art_id = pa13.art_id AND 
      a16.mandant_id = pa13.mandant_id)
JOIN dbp_msi_view2.mv_tag_2 a14
  ON (a11.dat = a14.dat)
JOIN ZZMQ01 pa15
  ON (a14.kjwo = pa15.kjwo)
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_2 a17
  ON (a11.mandant_id = a17.mandant_id AND 
      a11.nb_id = a17.nb_id AND 
      a11.wup_id = a17.wup_id AND 
      a16.mandant_id = a17.mandant_id AND 
      a16.wg_id = a17.wg_id)
WHERE (a17.mandant_id = 1 AND 
       a17.sm_id IN (1,2,3,4,5) AND 
      (a16.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
       a16.mandant_id = 1) AND 
       a11.abschriftenart_id <> -1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0G AS (
SELECT a11.kjwo,
    a11.art_id  art_id,
	a11.mandant_id  mandant_id,
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
FROM	dbp_etl.mv_listung_markt_kw_2	a11
	JOIN	ZZMQ00	pa12
	  ON 	(a11.art_id = pa12.art_id AND 
	a11.mandant_id = pa12.mandant_id)
WHERE	(a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1)
 AND a11.mandant_id = 1
 AND (a11.kreistyp_gruppe_id = 'N'
 OR a11.kreistyp_gruppe_id = 'O'
 OR a11.kreistyp_gruppe_id = 'Q'
 OR a11.kreistyp_gruppe_id = 'G'
 OR a11.kreistyp_gruppe_id = 'M'
 OR a11.kreistyp_gruppe_id = 'W'))
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMDXY AS (
SELECT xxx.kjwo,
       a11.art_id  art_id,
       a11.mandant_id  mandant_id,
       SUM(a11.absatz_sa) AS absatz_sa_sk1_bis6,
       SUM(a11.anz_tage_mit_absatz_sa) AS anz_tage_mit_abs_sa_sk1_bis6
FROM dbp_etl.mv_listung_markt_tag_2	a11
JOIN ZZMQ00	pa12
  ON a11.art_id = pa12.art_id AND 
     a11.mandant_id = pa12.mandant_id
JOIN dbp_data.tag_2 xxx_2
  on a11.dat = xxx.dat
WHERE a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1)
 AND a11.mandant_id = 1
 AND a11.dat BETWEEN (SELECT dat_von FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort))
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0H AS (
SELECT pa15.kjwo,
       a11.art_id,
	   a11.mandant_id,
	   SUM(a11.ek_mep_umsatz)  ek_mep_ums_sk1_bis_6_vj,
	   SUM(a11.umsatz_netto)  kassenumsatz_sk_1_bis_6_vj
FROM dbp_etl.mv_artbew_wo_sum_2	a11
JOIN ZZMQ00 pa14
  ON a11.art_id = pa14.art_id AND 
	 a11.mandant_id = pa14.mandant_id
JOIN ZZMQ01 pa15
  ON a11.kjwo = pa15.kjwo_vj
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_2 a17
  ON a11.mandant_id = a17.mandant_id AND 
	 a11.nb_id = a17.nb_id AND 
	 a11.wup_id = a17.wup_id AND 
	 a11.mandant_id = a17.mandant_id AND 
	 a11.wg_id = a17.wg_id
WHERE a17.sm_id IN (1,2,3,4,5) AND 
	  a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
	  a11.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0I AS (
SELECT pa15.kjwo,
       a11.art_id,
       a11.mandant_id,
       SUM(a11.absatz) absatz_vj_sk1_bis_6
FROM dbp_etl.mv_listung_markt_kw_2 a11
JOIN ZZMQ00 pa13
  ON a11.art_id = pa13.art_id AND 
     a11.mandant_id = pa13.mandant_id
JOIN ZZMQ01 pa15
  ON a11.kjwo = pa15.kjwo_vj
JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_2 a15
  ON a11.mandant_id = a15.mandant_id AND 
     a11.nb_id = a15.nb_id AND 
     a11.wg_id = a15.wg_id AND 
     a11.wup_id = a15.wup_id
WHERE a15.mandant_id = 1 AND 
      a15.sm_id IN (1,2,3,4,5) AND 
	  a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZMD0J AS (
SELECT a11.kjwo as kjwo,
       a11.art_id  art_id,
	   a11.mandant_id  mandant_id,
      (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.ek_mep_umsatz END)))  WJXBFS1_af,
	  (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END)) - ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep_umsatz END)))  WJXBFS1_sa,
	  (ZEROIFNULL(SUM(a11.umsatz_netto)) - ZEROIFNULL(SUM(a11.ek_mep_umsatz)))  WJXBFS1_tot,
	  (ZEROIFNULL(SUM(a11.umsatz_netto))) umsatz_brutto_tot,
	  (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto END))) umsatz_brutto_af,
	  (ZEROIFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto END))) umsatz_brutto_sa
FROM dbp_etl.mv_artbew_wo_sum_2	a11
JOIN ZZMQ00 pa12
  ON a11.art_id = pa12.art_id AND
     a11.mandant_id = pa12.mandant_id
WHERE a11.wg_id IN (SELECT wg_id FROM dbp_process.bf_sort_wg_2 WHERE mandant_id = 1) AND 
      a11.mandant_id = 1 AND
	  a11.kjwo BETWEEN (SELECT kjwo FROM dbp_data.woche_2 WHERE kjwo IN (SELECT MIN(kjwo) FROM ZZMQ01)) AND (SELECT kjwo FROM dbp_data.woche_2 WHERE kjwo IN (SELECT MAX(kjwo) FROM ZZMQ01))
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE ZZOJ0K AS (
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de_2 pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD06 pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD02 pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0A_xxx pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0C pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0F pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0G pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0D pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0H pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0I pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0J pa11
GROUP BY 1,2,3
UNION
SELECT pa11.kjwo,	
       pa11.art_id,
       pa11.mandant_id
FROM ZZMD0E pa11
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step01_2 AS (
SELECT pa11.kjwo,
    a132.wg_id  wg_id,
	a132.mandant_id  mandant_id,
	a138.wg_bez  wg_bez,
	CAST(a132.wg_id AS VARCHAR (3))  wg_id0,
	a132.wug_id  wug_id,
	a132.mandant_id  mandant_id0,
	a132.wg_id  wug_id0,
	a136.wug_bez  wug_bez,
	CASE WHEN a132.wg_id < 10 THEN '00' || CAST(a132.wg_id AS VARCHAR(3)) WHEN a132.wg_id < 100 THEN '0' || CAST(a132.wg_id AS VARCHAR(3))  ELSE CAST(a132.wg_id AS VARCHAR(3)) end||CASE WHEN a132.wug_id < 10 THEN '00' || CAST(a132.wug_id AS VARCHAR(3)) WHEN a132.wug_id < 100 THEN '0' || CAST(a132.wug_id AS VARCHAR(3))  ELSE CAST(a132.wug_id AS VARCHAR(3)) end  CustCol_58,
	a126.art_id  art_id,
	a126.mandant_id  mandant_id1,
	a133.art_bez  art_bez,
	CASE WHEN a127.art_id < 10000000 THEN '00' || CAST(floor(a127.art_id/100) AS VARCHAR(10)) WHEN a127.art_id < 100000000 THEN '0' || CAST(floor(a127.art_id/100) AS VARCHAR(10))  ELSE CAST(floor(a127.art_id/100) AS VARCHAR(10)) end  CustCol_52,
	a127.loesch_id  loesch_id,
	a127.zek_id  zek_id0,
	a127.mandant_id  mandant_id2,
	a137.zek_lang_bez  zek_lang_bez,
	a127.eigenmarke_id,
	a127.bio_fg,
	a127.tierwohl_kz,
	a127.vegan_fg,
	CASE
	  WHEN a127.posten_id = 'PF'
	  THEN 'X'
	  ELSE ' '
	END AS posten_food,
	CASE
	  WHEN a127.posten_id = 'PN'
	  THEN 'X'
	  ELSE ' '
	END AS posten_nonfood,
	a127.gluten_fg,
	COALESCE(x.mwst, 0) AS mwst,
	a127.aldi_id  aldi_id,
	a127.discount_id  discount_id,
	a135.discount_bez  discount_bez,
	a128.kolli_faktor_dz  kolli_faktor_dz,
	ROUND((1 / NULLIFZERO(a128.kolli_faktor_dz)))  kolli_faktor_dz0,
	a128.koll_faktor_zl  koll_faktor_zl,
	ROUND((1 / NULLIFZERO(a128.koll_faktor_zl)))  kolli_zl,
	a130.mhd_zeitraum_dz  mhd_zeitraum_dz,
	a130.mhd_zeitraum_dz  mhd_zeitraum_dz0,
	a127.mhd_zeitraum  mhd_zeitraum,
	a127.mhd_zeitraum  mhd_zeitraum0,
	a131.art_id  art_id0,
	a131.mandant_id  mandant_id3,
	a131.VKPK1  VKPK1,
	a126.akt_gp_id  akt_gp_id,
	a134.akt_gp_name  akt_gp_name,
	a127.lactose_fg  lactose_fg,
	a131.art_id  art_id1,
	a131.mandant_id  mandant_id4,
	a131.VKPK4  VKPK4,
	a129.typ_ost_basis  kreistyp_gruppe_id,
	a129.art_id  art_id2,
	a129.typ_ost_basis  typ_ost_basis,
	a129.typ_ost_gross  kreistyp_gruppe_id0,
	a129.art_id  art_id3,
	a129.typ_ost_gross  typ_ost_gross,
	a129.typ_sued_ost  typ_sued_ost,
	a129.art_id  art_id4,
	a129.typ_sued_ost  typ_sued_ost0,
	a129.typ_sued_west  kreistyp_gruppe_id1,
	a129.art_id  art_id5,
	a129.typ_sued_west  typ_sued_west,
	a129.typ_west  kreistyp_gruppe_id2,
	a129.art_id  art_id6,
	a129.typ_west  typ_west,
	a129.typ_nord  kreistyp_gruppe_id3,
	a129.art_id  art_id7,
	a129.typ_nord  typ_nord,
	MAX(pa12.Sp_EKKB_01)  Sp_EKKB_01,
	MAX(pa13.stk_ek_kb_stamm)  stk_ek_kb_stamm,
	MAX(pa14.WJXBFS1)  WJXBFS1,
	MAX(pa14.absatz_gesamt)  absatz_gesamt,
	MAX(pa15.max_kjwo)  max_kjwo,
	MAX(pa15.min_kjwo)  min_kjwo,
	MAX(pa16.min_durchg_gelistet_sst)  min_durchg_gelistet_sst,
	MAX(pa12.Sp_EKKB_04)  Sp_EKKB_04,
	MAX(pa17.kassenumsatz_sk_1_bis_6)  kassenumsatz_sk_1_bis_6,
	MAX(pa18.absatz_sk1)  absatz_sk1,
	MAX(pa18.absatz_sk2)  absatz_sk2,
	MAX(pa18.absatz_sk3)  absatz_sk3,
	MAX(pa18.absatz_sk4)  absatz_sk4,
	MAX(pa18.absatz_sk5)  absatz_sk5,
	MAX(pa14.absatz_af_sk1_bis6)  absatz_af_sk1_bis6,
	MAX(pa14.anz_wo_mit_abs_af_sk1_bis6)  anz_wo_mit_abs_af_sk1_bis6,
	MAX(pa114.abschr_vk_o_werbung)  abschr_vk_o_werbung,
	MAX(pa115.absatz_nord)  absatz_nord,
	MAX(pa115.absatz_ost_basis)  absatz_ost_basis,
	MAX(pa115.absatz_ost_gross)  absatz_ost_gross,
	MAX(pa115.absatz_sued_ost)  absatz_sued_ost,
	MAX(pa115.absatz_sued_west)  absatz_sued_west,
	MAX(pa115.absatz_west)  absatz_west,
	
	SUM(pa201.absatz_sa_sk1_bis6)  absatz_sa_sk1_bis6,
	SUM(pa201.anz_tage_mit_abs_sa_sk1_bis6)  anz_tage_mit_abs_sa_sk1_bis6,
	
	MAX(pa17.kassenumsatz_af_sk_1_bis_6)  kassenumsatz_af_sk_1_bis_6,
	MAX(pa115.anz_wo_mit_abs_ost_basis)  anz_wo_mit_abs_ost_basis,
	MAX(pa115.anz_wo_mit_abs_sued_west)  anz_wo_mit_abs_sued_west,
	MAX(pa17.ek_mep_ums_sa_sk1_bis_6)  ek_mep_ums_sa_sk1_bis_6,
	MAX(pa14.anz_wo_listung_2)  anz_wo_listung_2,
	MAX(pa122.ek_mep_ums_sk1_bis_6_vj)  ek_mep_ums_sk1_bis_6_vj,
	MAX(pa115.anz_wo_mit_abs_west)  anz_wo_mit_abs_west,
	MAX(pa123.absatz_vj_sk1_bis_6)  absatz_vj_sk1_bis_6,
	MAX(pa18.anz_wo_mit_abs_sk2)  anz_wo_mit_abs_sk2,
	MAX(pa122.kassenumsatz_sk_1_bis_6_vj)  kassenumsatz_sk_1_bis_6_vj,
	MAX(pa115.anz_wo_mit_abs_nord)  anz_wo_mit_abs_nord,
	MAX(pa124.WJXBFS1_tot)  WJXBFS2_tot,
	MAX(pa124.WJXBFS1_af)  WJXBFS2_af,
	MAX(pa124.WJXBFS1_sa)  WJXBFS2_sa,
	--MAX(pa18.absatz_sa_sk1_bis6)  absatz_sa_sk1_bis6,
	MAX(pa14.anz_wo_mit_absatz)  anz_wo_mit_absatz,
	MAX(pa18.anz_wo_mit_abs_sk4)  anz_wo_mit_abs_sk4,
	MAX(pa18.anz_wo_mit_abs_sk1)  anz_wo_mit_abs_sk1,
	MAX(pa17.ek_mep_ums_sk1_bis_6)  ek_mep_ums_sk1_bis_6,
	MAX(pa17.kassenumsatz_sa_sk_1_bis_6)  kassenumsatz_sa_sk_1_bis_6,
	MAX(pa18.anz_wo_mit_abs_sk3)  anz_wo_mit_abs_sk3,
	MAX(pa115.anz_wo_mit_abs_sued_ost)  anz_wo_mit_abs_sued_ost,
	MAX(pa18.anz_wo_mit_abs_sk5)  anz_wo_mit_abs_sk5,
	MAX(pa115.anz_wo_mit_abs_ost_gross)  anz_wo_mit_abs_ost_gross,
	
	MAX(pa124.umsatz_brutto_tot)  umsatz_brutto_tot,
	MAX(pa124.umsatz_brutto_af)  umsatz_brutto_af,
	MAX(pa124.umsatz_brutto_sa)  umsatz_brutto_sa,
	MAX(pa14.anz_wo_mit_abs_tot_sk1_bis6) anz_wo_mit_abs_tot_sk1_bis6,
	MAX(pa14.anz_maerkte) AS anz_maerkte	
FROM	ZZOJ0K	pa11
	LEFT OUTER JOIN	ZZMD06	pa12
	  ON pa11.art_id = pa12.art_id AND 
	pa11.mandant_id = pa12.mandant_id and
    pa11.kjwo = pa12.kjwo
	LEFT OUTER JOIN	ZZMD02	pa13
	  ON pa11.art_id = pa13.art_id AND 
	pa11.mandant_id = pa13.mandant_id and
    pa11.kjwo = pa13.kjwo
	LEFT OUTER JOIN	ZZMD0A_xxx	pa14
	  ON pa11.art_id = pa14.art_id AND 
	pa11.mandant_id = pa14.mandant_id and
    pa11.kjwo = pa14.kjwo
	CROSS JOIN	ZZMD0B	pa15
	LEFT OUTER JOIN	ZZMD0C	pa16
      ON pa11.art_id = pa16.art_id AND 
	pa11.mandant_id = pa16.mandant_id and
    pa11.kjwo = pa16.kjwo
	LEFT OUTER JOIN	ZZMD0D	pa17
      ON pa11.art_id = pa17.art_id AND 
	pa11.mandant_id = pa17.mandant_id and
    pa11.kjwo = pa17.kjwo
	LEFT OUTER JOIN	ZZMD0E	pa18
      ON pa11.art_id = pa18.art_id AND 
	pa11.mandant_id = pa18.mandant_id and
    pa11.kjwo = pa18.kjwo
	LEFT OUTER JOIN	ZZMD0F	pa114
      ON pa11.art_id = pa114.art_id AND 
	pa11.mandant_id = pa114.mandant_id and
    pa11.kjwo = pa114.kjwo
	LEFT OUTER JOIN	ZZMD0G	pa115
      ON pa11.art_id = pa115.art_id AND 
	pa11.mandant_id = pa115.mandant_id and
    pa11.kjwo = pa115.kjwo
	LEFT OUTER JOIN	ZZMD0H	pa122
      ON pa11.art_id = pa122.art_id AND 
	pa11.mandant_id = pa122.mandant_id and
    pa11.kjwo = pa122.kjwo
	LEFT OUTER JOIN	ZZMD0I	pa123
      ON pa11.art_id = pa123.art_id AND 
	pa11.mandant_id = pa123.mandant_id and
    pa11.kjwo = pa123.kjwo
	LEFT OUTER JOIN	ZZMD0J	pa124
      ON pa11.art_id = pa124.art_id AND 
	pa11.mandant_id = pa124.mandant_id and
    pa11.kjwo = pa124.kjwo
	LEFT OUTER JOIN	ZZMDXY	pa201
      ON pa11.art_id = pa201.art_id AND 
	pa11.mandant_id = pa201.mandant_id and
    pa11.kjwo = pa201.kjwo
	LEFT JOIN	(SELECT mandant_id,
                    art_id,
                    MAX(gp_id) AS akt_gp_id
             FROM dbp_msi_view2.mv_art_gp_zu_per_2
             WHERE aktuell_fg = 'a'
             GROUP BY 1,2) a126
	  ON 	(pa11.art_id = a126.art_id AND 
	pa11.mandant_id = a126.mandant_id)
	LEFT JOIN	dbp_msi_view2.mv_art_2	a127
	  ON 	a126.art_id = a127.art_id AND 
	a126.mandant_id = a127.mandant_id
	LEFT JOIN	dbp_msi_view2.mv_kolli_faktor_dz_zl_2	a128
	  ON 	(a126.art_id = a128.art_id AND 
	a126.mandant_id = a128.mandant_id)
	LEFT JOIN	dbp_msi_view2.mv_sternchen_logik_kreistyp_2	a129
	  ON 	(a126.art_id = a129.art_id AND 
	a126.mandant_id = a129.mandant_id)
	LEFT JOIN	dbp_msi_view2.mv_art_herst_zu_2	a130
	  ON 	(a126.art_id = a130.art_id AND 
	a126.mandant_id = a130.mandant_id)
	LEFT JOIN	dbp_msi_view2.mv_art_pm_vw_akt_2	a131
	  ON 	(a126.art_id = a131.art_id AND 
	a126.mandant_id = a131.mandant_id)
	LEFT JOIN	dbp_msi_view2.mv_art_wg_zu_per_2	a132
	  ON 	a127.art_id = a132.art_id AND 
	a127.mandant_id = a132.mandant_id AND 
	a127.art_id = a132.art_id
	LEFT JOIN	dbp_msi_view2.mv_art_spr_zu_2	a133
	  ON 	a126.art_id = a133.art_id AND 
	a126.mandant_id = a133.mandant_id AND 
	a127.art_id = a133.art_id
	LEFT JOIN	dbp_msi_view2.mv_gp_aktuell_2	a134
	  ON 	(a126.akt_gp_id = a134.akt_gp_id)
	LEFT JOIN	dbp_msi_view2.mv_artkz_discount_2	a135
	  ON 	(a127.discount_id = a135.discount_id)
	LEFT JOIN	dbp_msi_view2.mv_wug_spr_zu_2	a136
	  ON 	(a132.mandant_id = a136.mandant_id AND 
	a132.wg_id = a136.wg_id AND 
	a132.wug_id = a136.wug_id)
	LEFT JOIN	dbp_msi_view2.mv_zek_2	a137
	  ON 	(a127.mandant_id = a137.mandant_id AND 
	a127.zek_id = a137.zek_id)
	LEFT JOIN	dbp_msi_view2.mv_wg_spr_zu_2	a138
	  ON 	(a132.mandant_id = a138.mandant_id AND 
	a132.wg_id = a138.wg_id)
    LEFT JOIN dbp_data.mwst_per_2 x
	  ON a132.mandant_id = x.mandant_id AND
	     a127.mwst_id = x.mwst_id AND
		 x.dat_bis = '9999-12-31'
GROUP BY pa11.kjwo,a132.wg_id,
	a132.mandant_id,
	a138.wg_bez,
	CAST(a132.wg_id AS VARCHAR (3)),
	a132.wug_id,
	a132.mandant_id,
	a132.wg_id,
	a136.wug_bez,
	CASE WHEN a132.wg_id < 10 THEN '00' || CAST(a132.wg_id AS VARCHAR(3)) WHEN a132.wg_id < 100 THEN '0' || CAST(a132.wg_id AS VARCHAR(3))  ELSE CAST(a132.wg_id AS VARCHAR(3)) end||CASE WHEN a132.wug_id < 10 THEN '00' || CAST(a132.wug_id AS VARCHAR(3)) WHEN a132.wug_id < 100 THEN '0' || CAST(a132.wug_id AS VARCHAR(3))  ELSE CAST(a132.wug_id AS VARCHAR(3)) end,
	a126.art_id,
	a126.mandant_id,
	a133.art_bez,
	CASE WHEN a127.art_id < 10000000 THEN '00' || CAST(floor(a127.art_id/100) AS VARCHAR(10)) WHEN a127.art_id < 100000000 THEN '0' || CAST(floor(a127.art_id/100) AS VARCHAR(10))  ELSE CAST(floor(a127.art_id/100) AS VARCHAR(10)) end,
	a127.loesch_id,
	a127.zek_id,
	a127.mandant_id,
	a137.zek_lang_bez,
	a127.eigenmarke_id,
	a127.bio_fg,
        a127.tierwohl_kz,
	a127.vegan_fg,
	posten_food,
	posten_nonfood,
	a127.gluten_fg,
	mwst,
	a127.aldi_id,
	a127.discount_id,
	a135.discount_bez,
	a128.kolli_faktor_dz,
	ROUND((1 / NULLIFZERO(a128.kolli_faktor_dz))),
	a128.koll_faktor_zl,
	ROUND((1 / NULLIFZERO(a128.koll_faktor_zl))),
	a130.mhd_zeitraum_dz,
	a130.mhd_zeitraum_dz,
	a127.mhd_zeitraum,
	a127.mhd_zeitraum,
	a131.art_id,
	a131.mandant_id,
	a131.VKPK1,
	a126.akt_gp_id,
	a134.akt_gp_name,
	a127.lactose_fg,
	a131.art_id,
	a131.mandant_id,
	a131.VKPK4,
	a129.typ_ost_basis,
	a129.art_id,
	a129.typ_ost_basis,
	a129.typ_ost_gross,
	a129.art_id,
	a129.typ_ost_gross,
	a129.typ_sued_ost,
	a129.art_id,
	a129.typ_sued_ost,
	a129.typ_sued_west,
	a129.art_id,
	a129.typ_sued_west,
	a129.typ_west,
	a129.art_id,
	a129.typ_west,
	a129.typ_nord,
	a129.art_id,
	a129.typ_nord
);

DELETE FROM dbp_etl.bf_sort_sal_aggregat_2
WHERE kjwo in (select kjwo from ZZMQ01)
;

INSERT INTO dbp_etl.bf_sort_sal_aggregat_2
SELECT *
FROM _step01_2
where kjwo in (select kjwo from ZZMQ01)
;

DELETE FROM dbp_etl.bf_sort_sal_export_2
;

INSERT INTO dbp_etl.bf_sort_sal_export_2
SELECT b.kjmo_sort AS monat_2,
       b.monate_anz AS anz_monate,
       wg_id,
       wug_id,
	   custcol_52 AS art_nr,
	   art_bez,
	   a.loesch_id AS art_status,
	   akt_gp_id||':'||akt_gp_name AS akt_lieferant,
	   zek_id0 AS zek_2,
	   a.eigenmarke_id AS eigenmarke,
	   a.bio_fg AS bio,
	   a.tierwohl_kz AS tierwohl,
	   a.vegan_fg AS vegan,
	   a.posten_food,
	   a.posten_nonfood,
	   a.gluten_fg AS gluten,
	   a.mwst AS mwst,
	   a.aldi_id AS disc_pe,
	   a.discount_id AS disc_marke,
	   a.lactose_fg AS lcf,
	   Coalesce(cast(min_durchg_gelistet_sst as varchar(38)),'N/A') AS k_listung,
	   typ_ost_basis AS ost_basis,
	   typ_ost_gross AS ost_gross,
	   typ_sued_ost AS sued_ost,
	   typ_sued_west AS sued_west,
	   typ_west AS west,
	   typ_nord AS nord,
	   kolli_faktor_dz0 AS kol_bst,
	   kolli_zl AS kol_la,
	   a.mhd_zeitraum_dz AS rlz_dz,
	   a.mhd_zeitraum AS rlz,
	   Sum(absatz_sk1) AS k1_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sk1)) AS k1_markt_wochen,
	   Sum(absatz_sk1)/NullIfZero(Sum(anz_wo_mit_abs_sk1)) AS k1_absatz_mt_wo,
	   Sum(absatz_sk2) AS k2_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sk2)) AS k2_markt_wochen,
	   Sum(absatz_sk2)/NullIfZero(Sum(anz_wo_mit_abs_sk2)) AS k2_absatz_mt_wo,
	   Sum(absatz_sk3) AS k3_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sk3)) AS k3_markt_wochen,
	   Sum(absatz_sk3)/NullIfZero(Sum(anz_wo_mit_abs_sk3)) AS k3_absatz_mt_wo,
	   Sum(absatz_sk4) AS k4_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sk4)) AS k4_markt_wochen,
	   Sum(absatz_sk4)/NullIfZero(Sum(anz_wo_mit_abs_sk4)) AS k4_absatz_mt_wo,
	   Sum(absatz_sk5) AS k5_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sk5)) AS k5_markt_wochen,
	   Sum(absatz_sk5)/NullIfZero(Sum(anz_wo_mit_abs_sk5)) AS k5_absatz_mt_wo,   
	   Sum(absatz_ost_basis) AS ost_basis_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_ost_basis)) AS ost_basis_markt_wochen,
	   Sum(absatz_ost_basis)/NullIfZero(Sum(anz_wo_mit_abs_ost_basis)) AS ost_basis_absatz_mt_wo,
	   Sum(absatz_ost_gross) AS ost_gross_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_ost_gross)) AS ost_gross_markt_wochen,
	   Sum(absatz_ost_gross)/NullIfZero(Sum(anz_wo_mit_abs_ost_gross)) AS ost_gross_absatz_mt_wo,
	   Sum(absatz_sued_ost) AS sued_ost_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sued_ost)) AS sued_ost_markt_wochen,
	   Sum(absatz_sued_ost)/NullIfZero(Sum(anz_wo_mit_abs_sued_ost)) AS sued_ost_absatz_mt_wo,
	   Sum(absatz_sued_west) AS sued_west_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_sued_west)) AS sued_west_markt_wochen,
	   Sum(absatz_sued_west)/NullIfZero(Sum(anz_wo_mit_abs_sued_west)) AS sued_west_absatz_mt_wo,
	   Sum(absatz_west) AS west_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_west)) AS west_markt_wochen,
	   Sum(absatz_west)/NullIfZero(Sum(anz_wo_mit_abs_west)) AS west_absatz_mt_wo,
	   Sum(absatz_nord) AS nord_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_nord)) AS nord_markt_wochen,
	   Sum(absatz_nord)/NullIfZero(Sum(anz_wo_mit_abs_nord)) AS nord_absatz_mt_wo,
	   Sum(absatz_gesamt) AS total_absatz,
	   Sum(absatz_gesamt)/NullIfZero(Sum(anz_wo_mit_abs_tot_sk1_bis6)) AS total_absatz_mt_wo,
	   Round(((Sum(absatz_gesamt)/NullIfZero(Sum(absatz_vj_sk1_bis_6)))-1)*100,1) AS stg_absatz_vj,
	   Round((Sum(anz_wo_mit_absatz)/NullIfZero(Sum(anz_wo_listung_2)))*100,1) AS schnelldreherquote,
	   Round(Sum(absatz_sa_sk1_bis6)/NullIfZero(Sum(absatz_gesamt))*100,1) AS aktion_absatz,
	   Sum(kassenumsatz_sk_1_bis_6) AS kassenumsatz,
	   Sum(wjxbfs2_tot)/NullIfZero(Sum(absatz_gesamt)) AS stueck_re_mep,
	   Sum(wjxbfs2_tot) AS total_re_mep,
	   Round(((Sum(wjxbfs2_tot)/NullIfZero((Sum(kassenumsatz_sk_1_bis_6_vj-ek_mep_ums_sk1_bis_6_vj))))-1)*100,1) AS stg_re_mep_vj,
	   Round((Sum(wjxbfs2_tot)/NullIfZero(Sum(kassenumsatz_sk_1_bis_6)))*100,1) AS avg_spanne_mep,
	   Round((Sum(wjxbfs2_af)/NullIfZero(Sum(kassenumsatz_af_sk_1_bis_6)))*100,1) AS avg_spanne_af_mep,
	   Round((Sum(kassenumsatz_sa_sk_1_bis_6-ek_mep_ums_sa_sk1_bis_6))/NullIfZero(Sum(kassenumsatz_sa_sk_1_bis_6))*100,1) AS avg_spanne_sa_mep,
	   Round(Sum(abschr_vk_o_werbung),1) AS abschr_o_werb,
	   Round((Sum(abschr_vk_o_werbung)/NullIfZero(Sum(kassenumsatz_sk_1_bis_6)))*100,1) AS abschr_o_werb_umsatz,
	   Round(Avg(stk_ek_kb_stamm),2) AS kb,
	   Round(Avg(vkpk1),2) AS vk_pk_1,
	   Round(Avg(vkpk4),2) AS vk_pk_4,
	   Round(Avg(sp_ekkb_01)*100,1) AS sp_kb_pk_1,
	   Round(Avg(sp_ekkb_04)*100,1) AS sp_kb_pk_4,
	   Sum(absatz_af_sk1_bis6) AS total_af_absatz,
	   NullIfZero(Sum(anz_wo_mit_abs_af_sk1_bis6)) AS absatz_af_markt_wochen,
	   Sum(absatz_af_sk1_bis6)/NullIfZero(Sum(anz_wo_mit_abs_af_sk1_bis6)) AS total_absatz_af_mt_wo,
	   Sum(absatz_sa_sk1_bis6) AS total_sa_absatz,
	   NullIfZero(Sum(anz_tage_mit_abs_sa_sk1_bis6)) AS absatz_sa_markt_tage,
	   Sum(absatz_sa_sk1_bis6)/NullIfZero(Sum(anz_tage_mit_abs_sa_sk1_bis6)) AS total_absatz_sa_mt_tag,
	   Sum(wjxbfs2_af)/NullIfZero(Sum(absatz_af_sk1_bis6)) AS stueck_re_mep_af,
	   Sum(wjxbfs2_sa)/NullIfZero(Sum(absatz_sa_sk1_bis6)) AS stueck_re_mep_sa,
	   Sum(wjxbfs2_af) AS af_re_mep,
	   Sum(wjxbfs2_sa) AS sa_re_mep,
	   Sum(umsatz_brutto_tot) AS total_umsatz_netto,
	   Sum(umsatz_brutto_tot)/NullIfZero(Sum(anz_wo_mit_abs_tot_sk1_bis6)) AS total_umsatz_netto_mt_wo,
	   Sum(umsatz_brutto_af) AS af_umsatz_netto,
	   Sum(umsatz_brutto_af)/NullIfZero(Sum(anz_wo_mit_abs_af_sk1_bis6)) AS af_umsatz_netto_mt_wo,
           Sum(umsatz_brutto_sa) AS sa_umsatz_netto,
	   Sum(umsatz_brutto_sa)/NullIfZero(Sum(anz_tage_mit_abs_sa_sk1_bis6)) AS sa_umsatz_netto_mt_tag,
	   Sum(wjxbfs2_tot)/NullIfZero(Sum(anz_wo_mit_abs_af_sk1_bis6)) AS total_re_mep_mt_wo,
	   Sum(wjxbfs2_af)/NullIfZero(Sum(anz_wo_mit_abs_af_sk1_bis6)) AS af_re_mep_mt_wo,
	   Sum(wjxbfs2_sa)/NullIfZero(Sum(anz_tage_mit_abs_sa_sk1_bis6)) AS sa_re_mep_mt_tag,
	   Sum(0) AS anz_maerkte,
	   Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
	   NullIfZero(Sum(anz_wo_listung_2)) AS anz_wo_listung_2,
	   Cast(CASE
	          WHEN Substr(Greatest(ost_basis,ost_gross,sued_ost,sued_west,west,nord),1,1) = ' ' OR
			       Substr(Greatest(ost_basis,ost_gross,sued_ost,sued_west,west,nord),1,1) = '*'
			  THEN '0'
			  ELSE Substr(Greatest(ost_basis,ost_gross,sued_ost,sued_west,west,nord),1,1)
			END AS INT) AS sl,
	   Max(CASE
	     WHEN sl IN (4,8) THEN kol_la
	     WHEN sl IN (1,5) THEN NULL
	     WHEN sl NOT IN (1,4,5,8) THEN 
	     CASE WHEN rlz <> 0 AND rlz_dz  = 0 THEN kol_la
	          WHEN rlz  = 0 AND rlz_dz <> 0 THEN NULL
	          WHEN rlz <> 0 AND rlz_dz <> 0 THEN kol_la
	          WHEN rlz  = 0 AND rlz_dz  = 0 THEN kol_la
	     END
	   END) AS kol_la_bzw,
	   Max(CASE
	     WHEN sl IN (4,8) THEN NULL
	     WHEN sl IN (1,5) THEN kol_bst
	     WHEN sl NOT IN (1,4,5,8) THEN 
	     CASE WHEN rlz <> 0 AND rlz_dz  = 0 THEN NULL
	          WHEN rlz  = 0 AND rlz_dz <> 0 THEN kol_bst
                              WHEN rlz <> 0 AND rlz_dz <> 0 THEN NULL
	          WHEN rlz  = 0 AND rlz_dz  = 0 THEN NULL
                         END
	   END) AS kol_bst_bzw,
	   Max(Cast(c.lager_prozent AS DECIMAL(18,3))/100) AS lagerprozent,
	   CURRENT_TIMESTAMP,
	   CURRENT_TIMESTAMP
FROM dbp_etl.bf_sort_sal_aggregat_2 a
JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 b
  ON a.kjwo BETWEEN b.kjwo_von AND b.kjwo_bis
JOIN dbp_data.art_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     c.dat_bis = '9999-12-31'
WHERE b.kjmo_sort in (select kjmo_sort from ZZMQ01) and
      try_to_number(custcol_52) is not null
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
         21,22,23,24,25,26,27,28,29,30,31
;

UPDATE dbp_etl.bf_sort_sal_export_2 SET anz_listung_as_is = 0
;

UPDATE dbp_etl.bf_sort_sal_export_2 FROM (SELECT floor(a.art_id/100) AS kl_art_id,
                                               SUM(a.listung_id) AS anz_listung_as_is
                                        FROM dbp_data.art_wup_zu_per_2 a
                                        JOIN dbp_data.wup_2 b
                                          ON a.mandant_id = b.mandant_id AND
                                             a.wup_id = b.wup_id AND
                                             a.mandant_id = b.mandant_id AND
                                             CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
                                        JOIN dbp_data.art_wg_zu_per_2 c
                                          ON a.mandant_id = c.mandant_id AND
                                             a.art_id = c.art_id AND
                                             c.arthiertyp_id = 2 AND
                                             c.dat_bis = '9999-12-31'
                                        WHERE a.mandant_id = 1 AND
                                              a.listung_id = 1 AND
                                              CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
                                        GROUP BY 1) b
									 
SET anz_listung_as_is = b.anz_listung_as_is

WHERE CAST(dbp_etl.bf_sort_sal_export.art_nr AS INTEGER) = b.kl_art_id
;

UPDATE dbp_etl.bf_sort_sal_export_2 FROM (SELECT x.kl_art_id,
                                               COUNT(DISTINCT x.wup_id) AS anz_maerkte
                                        FROM (SELECT floor(a.art_id/100) AS kl_art_id,
                                                     a.wup_id,
                                                     SUM(a.menge) AS menge
                                              FROM dbp_data.artbew_2 a
                                              JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 c
                                                ON a.dat BETWEEN c.dat_von AND c.dat_bis
                                              JOIN dbp_data.art_wg_zu_per_2 b
                                                ON a.mandant_id = b.mandant_id AND
                                                   a.art_id = b.art_id AND
                                                   b.arthiertyp_id = 2 AND
                                                   b.dat_bis = '9999-12-31'
                                              WHERE a.mandant_id = 1 AND
                                                    c.kjmo_sort in (select monat_2 from dbp_etl.bf_sort_sal_export_2)
                                              GROUP BY 1,2
                                              HAVING SUM(a.menge) > 0) x
                                        GROUP BY 1) b
									 
SET anz_maerkte = b.anz_maerkte

WHERE CAST(dbp_etl.bf_sort_sal_export.art_nr AS INTEGER) = b.kl_art_id
;
