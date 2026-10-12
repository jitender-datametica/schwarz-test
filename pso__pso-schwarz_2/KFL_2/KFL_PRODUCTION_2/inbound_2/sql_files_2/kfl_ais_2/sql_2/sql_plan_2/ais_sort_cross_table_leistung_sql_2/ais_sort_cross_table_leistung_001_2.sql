CREATE OR REPLACE VOLATILE TABLE _sort_ist2 AS (
SELECT a.*,
       b.sm_id
FROM DBP_ETL.sort_ist_2 a
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.wg_id,
             CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
	    a.arthiertyp_id = 2 AND
	    a.sm_id BETWEEN 1 AND 6 AND
	    b.nb_id = 0 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
	   (a.mandant_id,a.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11 AND mandant_id = 1)
      GROUP BY 1,2,3,4) b
  ON a.wg_id = b.wg_id AND
     a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

create or replace volatile table _perf1 as (
SELECT a.mandant_id,
       a.wup_id,
       a.wg_id,
       CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id
FROM DBP_DATA.sm_wup_wg_zu_per_2 a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE a.mandant_id = 1 AND
      a.spr_id = 22 AND
	  a.arthiertyp_id = 2 AND
	  a.sm_id BETWEEN 1 AND 6 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
	  b.nb_id = 0 AND
	 (a.mandant_id,a.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11 AND mandant_id = 1)
GROUP BY 1,2,3,4
);


CREATE OR REPLACE VOLATILE TABLE _ist_listung AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       c.kreistyp_gruppe_id,
       d.sm_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
	 b.dat_bis = '9999-12-31' AND
	 b.arthiertyp_id = 2
JOIN DBP_DATA.wup_2 c
  ON a.wup_id = c.wup_id AND
     a.mandant_id = c.mandant_id
JOIN (SELECT *
      from _perf1) d
  ON b.wg_id = d.wg_id AND
     a.mandant_id = d.mandant_id AND
     a.wup_id = d.wup_id
WHERE trim(a.list_quelle_id) <> '2' AND
      a.nb_id = 0 AND
      a.mandant_id = 1 AND
      a.list_komponente_fg = 0 AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
     (b.mandant_id,b.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11 AND mandant_id = 1) AND
      a.art_id > 0
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_null AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       c.kreistyp_gruppe_id,
       d.sm_id
FROM DBP_DATA.art_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
	 b.dat_bis = '9999-12-31' AND
	 b.arthiertyp_id = 2
JOIN DBP_DATA.wup_2 c
  ON a.wup_id = c.wup_id AND
     a.mandant_id = c.mandant_id
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.wg_id,
             CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
            a.sm_id BETWEEN 1 AND 6 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            b.nb_id = 0 AND
           (a.mandant_id,a.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11 AND mandant_id = 1)
      GROUP BY 1,2,3,4) d
  ON b.wg_id = d.wg_id AND
     a.mandant_id = d.mandant_id AND
     a.wup_id = d.wup_id
WHERE a.mandant_id = 1 AND
      a.listung_id = 0 AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
     (b.mandant_id,b.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11 AND mandant_id = 1) AND
      a.art_id > 0
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_article AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       b.kreistyp_gruppe_id,
       b.sm_id,
       b.kassenumsatz AS kassenumsatz_artikel,
       b.anz_tage AS anz_tage_artikel,
       b.preis AS preis_artikel,
       b.list_kz,
       1 AS markt_zaehlung_fg
FROM _ist_listung a
JOIN _sort_ist2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id
);

INSERT INTO _ist_listung_article
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       b.kreistyp_gruppe_id,
       b.sm_id,
       b.kassenumsatz AS kassenumsatz_artikel,
       b.anz_tage AS anz_tage_artikel,
       b.preis AS preis_artikel,
       b.list_kz,
       0 AS markt_zaehlung_fg
FROM _ist_listung_null a
JOIN _sort_ist2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id
WHERE (a.art_id,a.wup_id) NOT IN (SELECT art_id,wup_id FROM _ist_listung_article)
;

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_zu_per AS (
SELECT a.art_id
      ,a.mandant_id
      ,a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) NOT IN ('2') AND
      --a.list_komponente_fg = 0 AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_kill_1 AS (
SELECT a.art_id
      ,a.mandant_id
      ,a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      a.list_komponente_fg = 1 AND
      trim(a.list_quelle_id) NOT IN ('2') AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE AND
     (a.wup_id,a.art_id,a.mandant_id) NOT IN (SELECT wup_id,art_id,mandant_id FROM _art_list_wup_zu_per)
);

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_kill_2 AS (
SELECT a.art_id
      ,a.mandant_id
      ,a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) IN ('2') AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE AND
     (a.wup_id,a.art_id,a.mandant_id) NOT IN (SELECT wup_id,art_id,mandant_id FROM _art_list_wup_zu_per)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _einzel_markt AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) IN ('C') AND
      a.list_komponente_fg = 0 AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _sonstige_bst AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) IN ('3') AND
      a.list_komponente_fg = 0 AND
      a.nb_id = 0 AND
      a.baustein_id IN (SELECT baustein_id
	                FROM DBP_ETL.baustein_wsop_2
                        WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis AND
			      mandant_id = 1) AND
      a.baustein_id NOT IN (SELECT baustein_id
	                    FROM DBP_ETL.baustein_region_zu_2) AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _soll_listung AS (
SELECT a.mandant_id,
       a.art_id,
       c.wup_id,
       c.sm_id,
       c.kreistyp_gruppe_id
FROM DBP_DATA.art_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.wg_id,
             CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id,
             b.kreistyp_gruppe_id
	  FROM DBP_DATA.sm_wup_wg_zu_per_2 a
	  JOIN DBP_DATA.wup_2 b
	    ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id
      WHERE a.mandant_id = 1 AND
            a.spr_id = 22 AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
            CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis AND
            a.sm_id BETWEEN 1 AND 6 AND
            b.nb_id = 0 AND
           (a.mandant_id,a.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11 AND mandant_id = 1)
      GROUP BY 1,2,3,4,5) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.mandant_id = 1 AND
      a.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _markt_umsatz_gesamt AS (
SELECT a11.wup_id,
       a11.mandant_id,
       SUM(a11.umsatz_netto+a11.umsatz_mwst_betrag) kassenumsatz,
       COUNT(DISTINCT a11.dat) anz_tage
FROM DBP_MSI_VIEW2.mv_artbew_wg_tag_sum_2 a11
WHERE a11.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE-1 AND
      a11.mandant_id = 1 
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_article_plus_gesamt AS (
SELECT a.*,
       b.kassenumsatz AS kassenumsatz_gesamt,
       b.anz_tage AS anz_tage_gesamt
FROM _ist_listung_article a
LEFT JOIN _markt_umsatz_gesamt b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

CREATE OR REPLACE VOLATILE TABLE _sort_ist4 AS (
SELECT a.mandant_id,
       a.art_id,
       a.list_kz,
       Count(DISTINCT a.wup_id) AS anz_markt,
       ZeroIfNull(Sum(CASE WHEN a.kassenumsatz_gesamt <> 0  AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.kassenumsatz_gesamt ELSE 0 END)/NullIfZero(Sum(CASE WHEN a.kassenumsatz_gesamt <> 0    AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.anz_tage_gesamt ELSE 0 END))) AS avg_umsatz_gesamt,
       ZeroIfNull(Sum(CASE WHEN a.kassenumsatz_artikel <> 0 AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.kassenumsatz_artikel ELSE 0 END)/NullIfZero(Sum(CASE WHEN a.kassenumsatz_artikel <> 0  AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.anz_tage_artikel ELSE 0 END))) AS avg_umsatz_artikel,
       Avg(preis_artikel) AS preis
FROM _ist_listung_article_plus_gesamt a
LEFT JOIN (SELECT mandant_id,
                  art_id,
                  1 AS markt_zaehlung_fg
           FROM DBP_DATA.art_list_wup_zu_per_2
           WHERE dat_bis >= CURRENT_DATE-366 AND
                 mandant_id = 1 AND
                 trim(list_quelle_id) NOT IN ('2')
           GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _differenz_soll AS (
SELECT *
FROM _soll_listung
WHERE (mandant_id,art_id,wup_id,sm_id) NOT IN (SELECT mandant_id,art_id,wup_id,sm_id FROM _ist_listung)
);

CREATE OR REPLACE VOLATILE TABLE _differenz_soll_1 AS (
SELECT a.*,
       COALESCE(b.kassenumsatz,0) AS kassenumsatz_gesamt,
       COALESCE(b.anz_tage,0) AS anz_tage_gesamt,
       ZEROIFNULL(COALESCE(b.kassenumsatz,0)/NULLIFZERO(b.anz_tage)) AS avg_umsatz_gesamt
FROM _differenz_soll a
LEFT JOIN _markt_umsatz_gesamt b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

CREATE OR REPLACE VOLATILE TABLE _list_extended AS (
SELECT a.mandant_id,
       a.art_id,
       1 AS sm_id_selected,
       a.sm_id,
       b.list_kz,
       trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
       '-' AS nord,
       '-' AS ost_basis,
       '-' AS ost_gross,
       '-' AS sued_ost,
       '-' AS sued_west,
       '-' AS west,
       a.wup_id,
       a.avg_umsatz_gesamt,
       b.avg_umsatz_artikel,
       b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
       ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*300*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
       ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
       absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _differenz_soll_1 a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id >= 1 
);

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*300*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _differenz_soll_1 a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id >= 2
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*300*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _differenz_soll_1 a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id >= 3
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*300*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _differenz_soll_1 a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id >= 4
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*300*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _differenz_soll_1 a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id >= 5
;

CREATE OR REPLACE VOLATILE TABLE _list_extended_region_only AS (
SELECT a.mandant_id,
       a.art_id,
	   0 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'N' THEN 'x' ELSE '-' END AS nord,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'M' THEN 'x' ELSE '-' END AS sued_west,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'W' THEN 'x' ELSE '-' END AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
JOIN (SELECT mandant_id,
             art_id,
             wup_id,
             kreistyp_gruppe_id
      FROM _list_extended
      GROUP BY 1,2,3,4) x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.wup_id = x.wup_id AND
     trim(trim(a.kreistyp_gruppe_id)) = trim(x.kreistyp_gruppe_id)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
);

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_extended a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_extended
SELECT *
FROM _list_extended_region_only
;

CREATE OR REPLACE VOLATILE TABLE _sort_ist3_reduction AS (
SELECT a.mandant_id,
       a.wup_id,
       a.art_id,
       a.sm_id,
       trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
       a.kassenumsatz_artikel,
       a.preis_artikel,
       COALESCE(b.kassenumsatz,0) AS kassenumsatz_gesamt,
       COALESCE(b.anz_tage,0) AS anz_tage_gesamt,
       a.anz_tage_artikel,
       ZEROIFNULL(b.kassenumsatz/NULLIFZERO(b.anz_tage)) AS avg_umsatz_gesamt,
       ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_gesamt)) AS avg_umsatz_artikel,
       CAST(0 AS INTEGER) AS anz_tage_listung_artikel
FROM _ist_listung_article_plus_gesamt a
LEFT JOIN _markt_umsatz_gesamt b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE sm_id <> -1
);

CREATE OR REPLACE VOLATILE TABLE _test AS (
SELECT mandant_id,
       wup_id,
       art_id
FROM _sort_ist3_reduction
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _help_me AS (
SELECT a.mandant_id,
       a.wup_id,
       a.art_id,
       MIN(a.dat_von) AS min_dat,
       MAX(a.dat_bis) AS max_dat
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN _test b
  ON a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id 
WHERE trim(a.list_quelle_id) <> '-2' AND
      a.nb_id = 0 AND
      a.list_komponente_fg = 0 AND
      a.mandant_id = 1 AND
      a.dat_bis >= CURRENT_DATE-366
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _tage AS (
SELECT b.dat,
       a.mandant_id,
       a.wup_id,
       a.art_id
FROM _help_me a
JOIN DBP_DATA.tag_2 b
  ON b.dat BETWEEN a.min_dat AND a.max_dat
WHERE b.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE-1
);

UPDATE _sort_ist3_reduction 
SET anz_tage_listung_artikel = CASE WHEN b.anz_tage > 300 THEN 300 ELSE b.anz_tage END

FROM (SELECT mandant_id,
                                         wup_id,
                                         art_id,
                                         COUNT(DISTINCT dat) AS anz_tage
                                  FROM _tage
                                  GROUP BY 1,2,3) b
 WHERE _sort_ist3_reduction.mandant_id = b.mandant_id AND
      _sort_ist3_reduction.art_id = b.art_id AND
      _sort_ist3_reduction.wup_id = b.wup_id
;

CREATE OR REPLACE VOLATILE TABLE _list_reduced AS (
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
           (-1)*(ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*300)*(ZEROIFNULL(CAST(a.anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(a.anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(a.preis_artikel)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _sort_ist3_reduction a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id < 2 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
);

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	   (-1)*(ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*300)*(ZEROIFNULL(CAST(a.anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(a.anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(a.preis_artikel)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _sort_ist3_reduction a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	   (-1)*(ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*300)*(ZEROIFNULL(CAST(a.anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(a.anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(a.preis_artikel)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _sort_ist3_reduction a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	   (-1)*(ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*300)*(ZEROIFNULL(CAST(a.anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(a.anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(a.preis_artikel)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _sort_ist3_reduction a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id <= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

CREATE OR REPLACE VOLATILE TABLE _list_reduced_region_only AS (
SELECT a.mandant_id,
       a.art_id,
	   0 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'N' THEN 'x' ELSE '-' END AS nord,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'M' THEN 'x' ELSE '-' END AS sued_west,
	   CASE WHEN trim(trim(a.kreistyp_gruppe_id)) = 'W' THEN 'x' ELSE '-' END AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
JOIN (SELECT mandant_id,
             art_id,
	     wup_id,
	     kreistyp_gruppe_id
      FROM _list_reduced
      GROUP BY 1,2,3,4) x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.wup_id = x.wup_id AND
     trim(trim(a.kreistyp_gruppe_id)) = trim(x.kreistyp_gruppe_id)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
);

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id >= 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id >= 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id >= 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   'x' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('N') AND
      a.sm_id >= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id >= 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id >= 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id >= 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   'x' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('O') AND
      a.sm_id >= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id >= 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id >= 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id >= 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   'x' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('Q') AND
      a.sm_id >= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id >= 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id >= 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id >= 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   'x' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('G') AND
      a.sm_id >= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id >= 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id >= 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id >= 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   'x' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('M') AND
      a.sm_id >= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id >= 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id >= 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id >= 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
	   a.sm_id,
	   a.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   'x' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   a.avg_umsatz_artikel,
	   a.avg_umsatz_gesamt_list,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced a
WHERE trim(a.kreistyp_gruppe_id) IN ('W') AND
      a.sm_id >= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;

INSERT INTO _list_reduced
SELECT *
FROM _list_reduced_region_only
;

CREATE OR REPLACE VOLATILE TABLE _list_delisted AS (
SELECT a.mandant_id,
       a.art_id,
	   0 AS sm_id_selected,
	   a.sm_id,
	   b.list_kz,
	   trim(a.kreistyp_gruppe_id) as kreistyp_gruppe_id,
	   '-' AS nord,
	   '-' AS ost_basis,
	   '-' AS ost_gross,
	   '-' AS sued_ost,
	   '-' AS sued_west,
	   '-' AS west,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
           (-1)*(ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*300)*(ZEROIFNULL(CAST(a.anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(a.anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(a.preis_artikel)) AS absatz_kpi,
	   absatz_kpi*COALESCE(c.stueck_re_mep,0) AS rohertrag_kpi
FROM _sort_ist3_reduction a
JOIN _sort_ist4 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_ETL.bf_sort_sal_export_2 c
  ON floor(a.art_id/100) = cast(c.art_nr as int)
WHERE a.sm_id <= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
);

UPDATE _list_reduced 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_1 GROUP BY 1,2,3) b
 WHERE _list_reduced.mandant_id = b.mandant_id AND
      _list_reduced.wup_id = b.wup_id AND
      _list_reduced.art_id = b.art_id
;

UPDATE _list_reduced 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2 GROUP BY 1,2,3) b
 WHERE _list_reduced.mandant_id = b.mandant_id AND
      _list_reduced.wup_id = b.wup_id AND
      _list_reduced.art_id = b.art_id
;

UPDATE _list_reduced 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _einzel_markt  GROUP BY 1,2,3) b
 WHERE _list_reduced.mandant_id = b.mandant_id AND
      _list_reduced.wup_id = b.wup_id AND
      _list_reduced.art_id = b.art_id
;

UPDATE _list_reduced 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst GROUP BY 1,2,3) b
 WHERE _list_reduced.mandant_id = b.mandant_id AND
      _list_reduced.wup_id = b.wup_id AND
      _list_reduced.art_id = b.art_id
;

UPDATE _list_extended 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2 GROUP BY 1,2,3) b
 WHERE _list_extended.mandant_id = b.mandant_id AND
      _list_extended.wup_id = b.wup_id AND
      _list_extended.art_id = b.art_id
;

UPDATE _list_extended 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _einzel_markt GROUP BY 1,2,3) b
 WHERE _list_extended.mandant_id = b.mandant_id AND
      _list_extended.wup_id = b.wup_id AND
      _list_extended.art_id = b.art_id
;

UPDATE _list_extended 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst GROUP BY 1,2,3) b
 WHERE _list_extended.mandant_id = b.mandant_id AND
      _list_extended.wup_id = b.wup_id AND
      _list_extended.art_id = b.art_id
;

DELETE FROM dbp_msi_data.kl_listung_2
WHERE kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO dbp_msi_data.kl_listung_2 (kl_listung_id
                                                  ,listung_art
                                                  ,mandant_id
                                                  ,art_id
                                                  ,sm_id_selected
                                                  ,sm_id
                                                  ,nord
                                                  ,ost_basis
                                                  ,ost_gross
                                                  ,sued_ost
                                                  ,sued_west
                                                  ,west
                                                  ,wup_id
                                                  ,umsatz_hr
                                                  ,absatz_hr
                                                  ,rohertrag_hr
                                                  ,erweiterung_fg
                                                  ,reduktion_fg
                                                  ,kjwo_update
                                                  ,list_kz)
SELECT (ROW_NUMBER() OVER (
      		ORDER BY mandant_id
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,b.kjwo
       ,list_kz
      		) + COALESCE((SELECT MAX(kl_listung_id) FROM dbp_msi_data.kl_listung_2 WHERE kl_listung_id <> 0),0) ) AS kl_listung_id
       ,'Listung reduzieren' AS listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0 AS erweiterung_fg
       ,0 AS reduktion_fg
       ,b.kjwo AS kjwo_update
       ,list_kz
FROM _list_reduced a
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO dbp_msi_data.kl_listung_2 (kl_listung_id
                                                  ,listung_art
                                                  ,mandant_id
                                                  ,art_id
                                                  ,sm_id_selected
                                                  ,sm_id
                                                  ,nord
                                                  ,ost_basis
                                                  ,ost_gross
                                                  ,sued_ost
                                                  ,sued_west
                                                  ,west
                                                  ,wup_id
                                                  ,umsatz_hr
                                                  ,absatz_hr
                                                  ,rohertrag_hr
                                                  ,erweiterung_fg
                                                  ,reduktion_fg
                                                  ,kjwo_update
                                                  ,list_kz)
SELECT (ROW_NUMBER() OVER (
      		ORDER BY mandant_id
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,b.kjwo
       ,list_kz
      		) + COALESCE((SELECT MAX(kl_listung_id) FROM dbp_msi_data.kl_listung_2 WHERE kl_listung_id <> 0),0) ) AS kl_listung_id
       ,'Listung erweitern' AS listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0 AS erweiterung_fg
       ,0 AS reduktion_fg
       ,b.kjwo AS kjwo_update
       ,list_kz
FROM _list_extended a
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO dbp_msi_data.kl_listung_2 (kl_listung_id
                                                  ,listung_art
                                                  ,mandant_id
                                                  ,art_id
                                                  ,sm_id_selected
                                                  ,sm_id
                                                  ,nord
                                                  ,ost_basis
                                                  ,ost_gross
                                                  ,sued_ost
                                                  ,sued_west
                                                  ,west
                                                  ,wup_id
                                                  ,umsatz_hr
                                                  ,absatz_hr
                                                  ,rohertrag_hr
                                                  ,erweiterung_fg
                                                  ,reduktion_fg
                                                  ,kjwo_update
                                                  ,list_kz)
SELECT (ROW_NUMBER() OVER (
      		ORDER BY mandant_id
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,b.kjwo
       ,list_kz
      		) + COALESCE((SELECT MAX(kl_listung_id) FROM dbp_msi_data.kl_listung_2 WHERE kl_listung_id <> 0),0) ) AS kl_listung_id
       ,'Auslistung' AS listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0 AS erweiterung_fg
       ,0 AS reduktion_fg
       ,b.kjwo AS kjwo_update
       ,list_kz
FROM _list_delisted a
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET nord = 'u'
WHERE listung_art = 'Listung reduzieren' AND
      nord = 'x' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET west = 'u'
WHERE listung_art = 'Listung reduzieren' AND
      west = 'x' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET ost_basis = 'u'
WHERE listung_art = 'Listung reduzieren' AND
      ost_basis = 'x' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET ost_gross = 'u'
WHERE listung_art = 'Listung reduzieren' AND
      ost_gross = 'x' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET sued_ost = 'u'
WHERE listung_art = 'Listung reduzieren' AND
      sued_ost = 'x' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET sued_west = 'u'
WHERE listung_art = 'Listung reduzieren' AND
      sued_west = 'x' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 SET sm_id_selected = -1
WHERE listung_art = 'Auslistung' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _track_soll AS (
SELECT mandant_id,
       wup_id,
       art_id
FROM _differenz_soll
GROUP BY 1,2,3
);

DELETE FROM _track_soll
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2)
;

DELETE FROM _track_soll
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _einzel_markt)
;

DELETE FROM _track_soll
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst)
;

CREATE OR REPLACE VOLATILE TABLE _track_ist AS (
SELECT mandant_id,
       wup_id,
       art_id
FROM _ist_listung_article
WHERE markt_zaehlung_fg = 1
);

DELETE FROM _track_ist
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2)
;

DELETE FROM _track_ist
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _einzel_markt)
;

DELETE FROM _track_ist
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst)
;

UPDATE dbp_msi_data.kl_listung_2 
SET erweiterung_fg = 1

FROM (SELECT *
                                  FROM _track_soll) b
                                      WHERE dbp_msi_data.kl_listung.mandant_id = b.mandant_id AND
      dbp_msi_data.kl_listung.wup_id = b.wup_id AND
      dbp_msi_data.kl_listung.art_id = b.art_id AND
      dbp_msi_data.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE dbp_msi_data.kl_listung_2 
SET reduktion_fg = 1

FROM (SELECT *
                                  FROM _track_ist) b
                                      WHERE dbp_msi_data.kl_listung.mandant_id = b.mandant_id AND
      dbp_msi_data.kl_listung.wup_id = b.wup_id AND
      dbp_msi_data.kl_listung.art_id = b.art_id AND
      dbp_msi_data.kl_listung.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

DELETE FROM dbp_msi_data.kl_listung_2
WHERE art_id IN (SELECT distinct art_id FROM DBP_ETL.kl_basis_listung_2 WHERE list_kz <> 'A') AND
      listung_art IN ('Auslistung','Listung reduzieren') AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;
/*
CREATE OR REPLACE VOLATILE TABLE _extensions AS (
SELECT a.mandant_id,
      'Listung erweitern' AS listung_art,
       0 AS sm_id_selected,
       a.art_id,
       a.wup_id,
       a.sm_id,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'M' THEN 'x' ELSE '-' END AS sued_west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'W' THEN 'x' ELSE '-' END AS west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'N' THEN 'x' ELSE '-' END AS nord,
       (-1)*a.umsatz_hr AS umsatz_hr,
       (-1)*a.absatz_hr AS absatz_hr,
       (-1)*a.rohertrag_hr AS rohertrag_hr,
       1 AS erweiterung_fg,
       0 AS reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM dbp_msi_data.kl_listung_2 a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE a.mandant_id = 1 AND
      a.listung_art = 'Auslistung' AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1) AND
      a.sm_id < 5
);

INSERT INTO _extensions
SELECT a.mandant_id,
      'Listung erweitern' AS listung_art,
       0 AS sm_id_selected,
       a.art_id,
       a.wup_id,
       a.sm_id,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'M' THEN 'x' ELSE '-' END AS sued_west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'W' THEN 'x' ELSE '-' END AS west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'N' THEN 'x' ELSE '-' END AS nord,
       (-1)*a.umsatz_hr,
       (-1)*a.absatz_hr,
       (-1)*a.rohertrag_hr,
       1 AS erweiterung_fg,
       0 AS reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM dbp_msi_data.kl_listung_2 a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE a.mandant_id = 1 AND
      a.listung_art = 'Auslistung' AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1) AND
      a.sm_id < 4
;

INSERT INTO _extensions
SELECT a.mandant_id,
      'Listung erweitern' AS listung_art,
       0 AS sm_id_selected,
       a.art_id,
       a.wup_id,
       a.sm_id,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'M' THEN 'x' ELSE '-' END AS sued_west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'W' THEN 'x' ELSE '-' END AS west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'N' THEN 'x' ELSE '-' END AS nord,
       (-1)*a.umsatz_hr,
       (-1)*a.absatz_hr,
       (-1)*a.rohertrag_hr,
       1 AS erweiterung_fg,
       0 AS reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM dbp_msi_data.kl_listung_2 a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE a.mandant_id = 1 AND
      a.listung_art = 'Auslistung' AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1) AND
      a.sm_id < 3
;

INSERT INTO _extensions
SELECT a.mandant_id,
      'Listung erweitern' AS listung_art,
       0 AS sm_id_selected,
       a.art_id,
       a.wup_id,
       a.sm_id,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'M' THEN 'x' ELSE '-' END AS sued_west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'W' THEN 'x' ELSE '-' END AS west,
       CASE WHEN trim(b.kreistyp_gruppe_id) = 'N' THEN 'x' ELSE '-' END AS nord,
       (-1)*a.umsatz_hr,
       (-1)*a.absatz_hr,
       (-1)*a.rohertrag_hr,
       1 AS erweiterung_fg,
       0 AS reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM dbp_msi_data.kl_listung_2 a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
WHERE a.mandant_id = 1 AND
      a.listung_art = 'Auslistung' AND
      a.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1) AND
      a.sm_id < 2
;

INSERT INTO dbp_msi_data.kl_listung_2 (kl_listung_id
                                                  ,listung_art
                                                  ,mandant_id
                                                  ,art_id
                                                  ,sm_id_selected
                                                  ,sm_id
                                                  ,nord
                                                  ,ost_basis
                                                  ,ost_gross
                                                  ,sued_ost
                                                  ,sued_west
                                                  ,west
                                                  ,wup_id
                                                  ,umsatz_hr
                                                  ,absatz_hr
                                                  ,rohertrag_hr
                                                  ,erweiterung_fg
                                                  ,reduktion_fg
                                                  ,kjwo_update
                                                  ,list_kz)
SELECT (ROW_NUMBER() OVER (
      	ORDER BY mandant_id
       ,listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,sm_id
       ,nord
       ,ost_basis
       ,ost_gross
       ,sued_ost
       ,sued_west
       ,west
       ,wup_id
       ,umsatz_hr
       ,absatz_hr
       ,rohertrag_hr
       ,erweiterung_fg
       ,reduktion_fg
       ,kjwo_update
       ,list_kz
      		) + COALESCE((SELECT MAX(kl_listung_id) FROM dbp_msi_data.kl_listung_2 WHERE kl_listung_id <> 0),0) ) AS kl_listung_id
      ,listung_art
      ,mandant_id
      ,art_id
      ,sm_id_selected
      ,sm_id
      ,nord
      ,ost_basis
      ,ost_gross
      ,sued_ost
      ,sued_west
      ,west
      ,wup_id
      ,umsatz_hr
      ,absatz_hr
      ,rohertrag_hr
      ,erweiterung_fg
      ,reduktion_fg
      ,kjwo_update
      ,list_kz
FROM (SELECT DISTINCT 
       listung_art
      ,mandant_id
      ,art_id
      ,sm_id_selected
      ,sm_id
      ,nord
      ,ost_basis
      ,ost_gross
      ,sued_ost
      ,sued_west
      ,west
      ,wup_id
      ,umsatz_hr
      ,absatz_hr
      ,rohertrag_hr
      ,erweiterung_fg
      ,reduktion_fg
      ,kjwo_update
      ,list_kz
     FROM _extensions) x
;

*/
