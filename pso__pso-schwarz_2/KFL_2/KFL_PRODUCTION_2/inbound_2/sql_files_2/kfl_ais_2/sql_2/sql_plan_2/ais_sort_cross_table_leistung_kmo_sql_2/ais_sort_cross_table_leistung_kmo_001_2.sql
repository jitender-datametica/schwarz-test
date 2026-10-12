--PARAMS
select ${mandant_id} as mandant_id;
select ${anz_tage} as anz_tage;

CREATE OR REPLACE VOLATILE TABLE _sort_ist2_1 AS (
SELECT a.*,
       b.sm_id,
       b.ksm_id
FROM DBP_ETL.sort_ist_kmo_2 a
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.wg_id,
             CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id,
             trim(a.ksm_id) as ksm_id
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 47 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
	   (a.sm_id BETWEEN 1 AND 6 OR trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) AND
	    b.nb_id = 0
      GROUP BY 1,2,3,4,5) b
  ON a.wg_id = b.wg_id AND
     a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_1 AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       d.sm_id,
       d.ksm_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.wg_id,
             CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id,
             trim(a.ksm_id) as ksm_id
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 47 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
           (a.sm_id BETWEEN 1 AND 6 OR trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) AND
            b.nb_id = 0
      GROUP BY 1,2,3,4,5) d
  ON b.wg_id = d.wg_id AND
     a.mandant_id = d.mandant_id AND
     a.wup_id = d.wup_id
WHERE trim(a.list_quelle_id) NOT IN ('2') AND
      a.nb_id = 0 AND
      a.mandant_id = ${mandant_id} AND
      a.list_komponente_fg = 0 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      a.art_id > 0
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_null_1 AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       d.sm_id,
       d.ksm_id
FROM DBP_DATA.art_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.wg_id,
             CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id,
             trim(a.ksm_id) as ksm_id
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 47 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
	    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
	   (a.sm_id BETWEEN 1 AND 6 OR trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) AND 
	    b.nb_id = 0
      GROUP BY 1,2,3,4,5) d
  ON b.wg_id = d.wg_id AND
     a.mandant_id = d.mandant_id AND
     a.wup_id = d.wup_id
WHERE a.mandant_id = ${mandant_id} AND
      a.listung_id = 0 AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      a.art_id > 0
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_article_1 AS (
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       COALESCE(b.kassenumsatz,0) AS kassenumsatz_artikel,
       COALESCE(b.anz_tage,0) AS anz_tage_artikel,
       COALESCE(b.preis,0) AS preis_artikel,
       COALESCE(b.list_kz,'A') AS list_kz,
       1 AS markt_zaehlung_fg
FROM _ist_listung_1 a
LEFT JOIN _sort_ist2_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id
);

INSERT INTO _ist_listung_article_1
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       b.sm_id,
       b.ksm_id,
       b.kassenumsatz AS kassenumsatz_artikel,
       b.anz_tage AS anz_tage_artikel,
       b.preis AS preis_artikel,
       b.list_kz,
       0 AS markt_zaehlung_fg
FROM _ist_listung_null_1 a
JOIN _sort_ist2_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id
WHERE (a.mandant_id,a.art_id,a.wup_id) NOT IN (SELECT mandant_id,art_id,wup_id FROM _ist_listung_article_1)
;

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_zu_per_1 AS (
SELECT a.art_id
      ,a.mandant_id
      ,a.wup_id
      ,trim(a.list_quelle_id) as list_quelle_id
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
JOIN DBP_DATA.wup_2 c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id
WHERE a.mandant_id = ${mandant_id} AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) NOT IN ('2') AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_kill_1_1 AS (
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
WHERE a.mandant_id = ${mandant_id} AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      a.list_komponente_fg = 1 AND
      trim(a.list_quelle_id) NOT IN ('2') AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE AND
     (a.wup_id,a.art_id,a.mandant_id) NOT IN (SELECT wup_id,art_id,mandant_id FROM _art_list_wup_zu_per_1)
);

CREATE OR REPLACE VOLATILE TABLE _art_list_wup_kill_2_1 AS (
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
WHERE a.mandant_id = ${mandant_id} AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) IN ('2') AND
      a.nb_id = 0 AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE AND
     (a.wup_id,a.art_id,a.mandant_id) NOT IN (SELECT wup_id,art_id,mandant_id FROM _art_list_wup_zu_per_1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _einzel_markt_1 AS (
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
WHERE a.mandant_id = ${mandant_id} AND
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

CREATE OR REPLACE VOLATILE TABLE _sonstige_bst_1 AS (
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
WHERE a.mandant_id = ${mandant_id} AND
      b.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_2 WHERE wg_filter_id = 11) AND
      CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
      CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
      trim(a.list_quelle_id) IN ('3') AND
      a.list_komponente_fg = 0 AND
      a.nb_id = 0 AND
     (a.mandant_id,a.baustein_id) IN (SELECT mandant_id,baustein_id
	                              FROM DBP_ETL.baustein_wsop_2
                                      WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis AND
			                    mandant_id = ${mandant_id}) AND
      c.nb_id = 0 AND
      c.dat_eroeffnung <= CURRENT_DATE
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _soll_listung_1 AS (
SELECT a.mandant_id,
       a.art_id,
       c.wup_id,
       c.sm_id,
       c.ksm_id
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
             trim(a.ksm_id) as ksm_id
      FROM DBP_DATA.sm_wup_wg_zu_per_2 a
      JOIN DBP_DATA.wup_2 b
	ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
      JOIN DBP_DATA.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 47 AND 
           wfz.arthiertyp_id = 2
      WHERE a.mandant_id = ${mandant_id} AND
            a.arthiertyp_id = 2 AND
            CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
           (a.sm_id BETWEEN 1 AND 6 OR trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) AND
            b.nb_id = 0
      GROUP BY 1,2,3,4,5) c
  ON b.wg_id = c.wg_id AND
     b.mandant_id = c.mandant_id
WHERE a.mandant_id = ${mandant_id} AND
      a.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _markt_umsatz_gesamt_1 AS (
SELECT a11.wup_id,
       a11.mandant_id,
       SUM(a11.umsatz_netto+a11.umsatz_mwst_betrag) kassenumsatz,
       COUNT(DISTINCT a11.dat) anz_tage
FROM (SELECT mandant_id,
             wup_id,
             dat,
             umsatz_netto,
             umsatz_mwst_betrag
      FROM DBP_DATA.artbew_wg_tp2_sum_2
      WHERE mandant_id = ${mandant_id} AND 
            arthiertyp_id = 2 AND
            dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE-1 AND
            bewart_id IN (1001,1002)) a11
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _ist_listung_article_plus_gesamt_1 AS (
SELECT a.*,
       b.kassenumsatz AS kassenumsatz_gesamt,
       b.anz_tage AS anz_tage_gesamt
FROM _ist_listung_article_1 a
LEFT JOIN _markt_umsatz_gesamt_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

CREATE OR REPLACE VOLATILE TABLE _sort_ist4_1 AS (
SELECT a.mandant_id,
       a.art_id,
       a.list_kz,
       Count(DISTINCT a.wup_id) AS anz_markt,
       ZeroIfNull(Sum(CASE WHEN a.kassenumsatz_gesamt <> 0  AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.kassenumsatz_gesamt ELSE 0 END)/NullIfZero(Sum(CASE WHEN a.kassenumsatz_gesamt <> 0    AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.anz_tage_gesamt ELSE 0 END))) AS avg_umsatz_gesamt,
       ZeroIfNull(Sum(CASE WHEN a.kassenumsatz_artikel <> 0 AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.kassenumsatz_artikel ELSE 0 END)/NullIfZero(Sum(CASE WHEN a.kassenumsatz_artikel <> 0  AND Coalesce(b.markt_zaehlung_fg,0) = 1 THEN a.anz_tage_artikel ELSE 0 END))) AS avg_umsatz_artikel,
       Avg(preis_artikel) AS preis
FROM _ist_listung_article_plus_gesamt_1 a
LEFT JOIN (SELECT mandant_id,
                  art_id,
                  1 AS markt_zaehlung_fg
           FROM DBP_DATA.art_list_wup_zu_per_2
           WHERE dat_bis >= CURRENT_DATE-366 AND
                 mandant_id = ${mandant_id} AND
                 list_quelle_id NOT IN ('2')
           GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _differenz_soll_1 AS (
SELECT *
FROM _soll_listung_1
WHERE sm_id IS NOT NULL AND (mandant_id,art_id,wup_id,sm_id) NOT IN (SELECT mandant_id,art_id,wup_id,sm_id FROM _ist_listung_1 WHERE sm_id IS NOT NULL)
);

INSERT INTO _differenz_soll_1
SELECT * FROM _soll_listung_1
WHERE ksm_id IS NOT NULL AND (mandant_id,art_id,wup_id,ksm_id) NOT IN (SELECT mandant_id,art_id,wup_id,ksm_id FROM _ist_listung_1 WHERE ksm_id IS NOT NULL)
;

CREATE OR REPLACE VOLATILE TABLE _differenz_soll_1_1 AS (
SELECT a.*,
       b.kassenumsatz AS kassenumsatz_gesamt,
       b.anz_tage AS anz_tage_gesamt,
       ZEROIFNULL(b.kassenumsatz/NULLIFZERO(b.anz_tage)) AS avg_umsatz_gesamt
FROM _differenz_soll_1 a
LEFT JOIN _markt_umsatz_gesamt_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

CREATE OR REPLACE VOLATILE TABLE _list_extended_1 AS (
SELECT a.mandant_id,
       a.art_id,
	   1 AS sm_id_selected,
          '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id >= 1 
);

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
        '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id >= 2
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id >= 3
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id >= 4
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id >= 5
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K1' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K2' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K2','K3','K4','K5','K6','K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
            NULL AS sm_id_selected,
	   'K3' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K3','K4','K5','K6','K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
       NULL AS sm_id_selected,
       'K4' AS ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       b.list_kz,
       a.wup_id,
       a.avg_umsatz_gesamt,
       b.avg_umsatz_artikel,
       b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
       ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
       ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
       absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K4','K5','K6','K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K5' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K5','K6','K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K6' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K6','K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K7' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K7','K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K8' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K8','K9')
;

INSERT INTO _list_extended_1
SELECT a.mandant_id,
       a.art_id,
           NULL AS sm_id_selected,
	   'K9' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   a.avg_umsatz_gesamt,
	   b.avg_umsatz_artikel,
	   b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
	  ZEROIFNULL((b.avg_umsatz_artikel*a.avg_umsatz_gesamt/NULLIFZERO(b.avg_umsatz_gesamt)))*${anz_tage}*COALESCE(c.schnelldreherquote/100,0) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _differenz_soll_1_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K9')
;

CREATE OR REPLACE VOLATILE TABLE _sort_ist3_reduction_1 AS (
SELECT a.mandant_id,
       a.wup_id,
       a.art_id,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.kassenumsatz_artikel,
       a.anz_tage_artikel,
       CAST(0 AS INTEGER) AS anz_tage_listung_artikel
FROM _ist_listung_article_plus_gesamt_1 a
LEFT JOIN _markt_umsatz_gesamt_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id
);

CREATE OR REPLACE VOLATILE TABLE _sort_ist3_group AS (
SELECT mandant_id,
       wup_id,
       art_id
FROM _sort_ist3_reduction_1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _schnelldreherquote_day AS (
SELECT a.mandant_id,
       a.wup_id,
       a.art_id,
       MIN(a.dat_von) AS min_dat,
       MAX(a.dat_bis) AS max_dat
FROM dbp_data.art_list_wup_zu_per_2 a
JOIN _sort_ist3_group b
  ON a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id 
WHERE trim(a.list_quelle_id) <> '-2' AND
      a.nb_id = 0 AND
      a.list_komponente_fg = 0 AND
      a.mandant_id = ${mandant_id} AND
      a.dat_bis >= CURRENT_DATE-366
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _tage AS (
SELECT b.dat,
       a.mandant_id,
       a.wup_id,
       a.art_id
FROM _schnelldreherquote_day a
JOIN DBP_DATA.tag_2 b
  ON b.dat BETWEEN a.min_dat AND a.max_dat
WHERE b.dat BETWEEN CURRENT_DATE-366 AND CURRENT_DATE-1
);

UPDATE _sort_ist3_reduction_1 
SET anz_tage_listung_artikel = CASE WHEN b.anz_tage > ${anz_tage} THEN ${anz_tage} ELSE b.anz_tage END

FROM (SELECT mandant_id,
                                         wup_id,
                                         art_id,
                                         COUNT(DISTINCT dat) AS anz_tage
                                  FROM _tage
                                  GROUP BY 1,2,3) b
 WHERE _sort_ist3_reduction_1.mandant_id = b.mandant_id AND
      _sort_ist3_reduction_1.art_id = b.art_id AND
      _sort_ist3_reduction_1.wup_id = b.wup_id
;

CREATE OR REPLACE VOLATILE TABLE _list_reduced_1 AS (
SELECT a.mandant_id,
       a.art_id,
	   2 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id < 2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   3 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
	   trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id < 3
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   4 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id < 4
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   5 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE a.sm_id < 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K2' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K3' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K4' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K5' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K6' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K7' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K8' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_reduced_1
SELECT a.mandant_id,
       a.art_id,
	   NULL AS sm_id_selected,
           'K9' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   b.list_kz,
	   a.wup_id,
	   (-1)*ZEROIFNULL(a.kassenumsatz_artikel/NULLIFZERO(a.anz_tage_artikel))*${anz_tage}*(ZEROIFNULL(CAST(anz_tage_artikel AS FLOAT)/NULLIFZERO(CAST(anz_tage_listung_artikel AS FLOAT)))) AS umsatz_kpi,
	   ZEROIFNULL(umsatz_kpi/NULLIFZERO(b.preis)) AS absatz_kpi,
	   absatz_kpi*COALESCE((c.rohertrag_einheit ),0) AS rohertrag_kpi
FROM _sort_ist3_reduction_1 a
JOIN _sort_ist4_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN DBP_DATA.sal_kmo_2 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id AND
     c.kjmo IN (SELECT MAX(kjmo) 
                FROM DBP_DATA.sortiment_leistung_2
                WHERE mandant_id = ${mandant_id})
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

CREATE OR REPLACE VOLATILE TABLE _list_delisted_1 AS (
SELECT a.mandant_id,
       a.art_id,
	   0 AS sm_id_selected,
           '  ' AS ksm_id_selected,
	   a.sm_id,
           trim(a.ksm_id) as ksm_id,
	   a.list_kz,
	   a.wup_id,
	   a.umsatz_kpi,
	   a.absatz_kpi,
	   a.rohertrag_kpi
FROM _list_reduced_1 a
WHERE a.sm_id <= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

INSERT INTO _list_delisted_1
SELECT a.mandant_id,
       a.art_id,
       NULL AS sm_id_selected,
       'K0' AS ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.list_kz,
       a.wup_id,
       a.umsatz_kpi,
       a.absatz_kpi,
       a.rohertrag_kpi
FROM _list_reduced_1 a
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_delisted_1
SELECT a.mandant_id,
       a.art_id,
       -1 AS sm_id_selected,
       '  ' AS ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.list_kz,
       a.wup_id,
       a.umsatz_kpi,
       a.absatz_kpi,
       a.rohertrag_kpi
FROM _list_reduced_1 a
WHERE a.sm_id <= 5
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _list_delisted_1
SELECT a.mandant_id,
       a.art_id,
       NULL AS sm_id_selected,
       'KK' AS ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.list_kz,
       a.wup_id,
       a.umsatz_kpi,
       a.absatz_kpi,
       a.rohertrag_kpi
FROM _list_reduced_1 a
WHERE trim(a.ksm_id) IN ('K1','K2','K3','K4','K5','K6','K7','K8','K9')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

CREATE OR REPLACE VOLATILE TABLE _track_sst_1 AS (
SELECT mandant_id,
       kjwo_update,
       art_id,
       CASE
         WHEN listung_sst_mvke IN ('N/A','R')
         THEN NULL
         ELSE listung_sst_mvke
       END AS listung_sst_mvke
FROM DBP_DATA.sortiment_leistung_2
WHERE kjwo_update IN (SELECT MAX(kjwo_update) 
                      FROM DBP_DATA.sortiment_leistung_2
                      WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
     (anz_maerkte_k_sst <> 0 OR 
      anz_maerkte_sst <> 0 OR 
      anz_maerkte_baustein_sonstige <> 0 OR 
      anz_maerkte_listung_einzel <> 0 OR
      anz_maerkte_listung_gesamt <> 0)
group by 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _track_ksst_1 AS (
SELECT mandant_id,
       kjwo_update,
       art_id,
       CASE
         WHEN listung_k_sst_mvke IN ('N/A','R')
         THEN NULL
         ELSE listung_k_sst_mvke
       END AS listung_k_sst_mvke
FROM DBP_DATA.sortiment_leistung_2
WHERE kjwo_update IN (SELECT MAX(kjwo_update) 
                      FROM DBP_DATA.sortiment_leistung_2
                      WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
     (anz_maerkte_k_sst <> 0 OR 
      anz_maerkte_sst <> 0 OR 
      anz_maerkte_baustein_sonstige <> 0 OR 
      anz_maerkte_listung_einzel <> 0 OR
      anz_maerkte_listung_gesamt <> 0)
group by 1,2,3,4
);

UPDATE _list_reduced_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_1_1 GROUP BY 1,2,3) b
 WHERE _list_reduced_1.mandant_id = b.mandant_id AND
      _list_reduced_1.wup_id = b.wup_id AND
      _list_reduced_1.art_id = b.art_id
;

UPDATE _list_reduced_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2_1 GROUP BY 1,2,3) b
 WHERE _list_reduced_1.mandant_id = b.mandant_id AND
      _list_reduced_1.wup_id = b.wup_id AND
      _list_reduced_1.art_id = b.art_id
;

UPDATE _list_reduced_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT a.mandant_id,
                                  a.wup_id,
                                  a.art_id,
                                  COALESCE(b.listung_sst_mvke, 6) AS listung_sst_mvke
                           FROM _art_list_wup_zu_per_1 a
                           JOIN _track_sst_1 b 
                             ON a.mandant_id = b.mandant_id AND 
                                a.art_id = b.art_id 
                           where b.listung_sst_mvke is not null and
						         b.listung_sst_mvke not in ('R')
                           GROUP BY 1,2,3,4) b
 WHERE _list_reduced_1.mandant_id = b.mandant_id AND
      _list_reduced_1.wup_id = b.wup_id AND
      _list_reduced_1.art_id = b.art_id AND
      _list_reduced_1.sm_id < CAST(b.listung_sst_mvke AS INT)
;

UPDATE _list_reduced_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT a.mandant_id,
                                  a.wup_id,
                                  a.art_id,
                                  COALESCE(b.listung_k_sst_mvke, 'K9') AS listung_k_sst_mvke
                           FROM _art_list_wup_zu_per_1 a
                           JOIN _track_ksst_1 b 
                             ON a.mandant_id = b.mandant_id AND 
                                a.art_id = b.art_id
                           where b.listung_k_sst_mvke is not null and
						         b.listung_k_sst_mvke not in ('R')
                           GROUP BY 1,2,3,4) b
 WHERE _list_reduced_1.mandant_id = b.mandant_id AND
      _list_reduced_1.wup_id = b.wup_id AND
      _list_reduced_1.art_id = b.art_id AND
      SUBSTR(TRIM(_list_reduced_1.ksm_id),2,1) < SUBSTR(TRIM(b.listung_k_sst_mvke),2,1)
;

UPDATE _list_reduced_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst_1 GROUP BY 1,2,3) b
 WHERE _list_reduced_1.mandant_id = b.mandant_id AND
      _list_reduced_1.wup_id = b.wup_id AND
      _list_reduced_1.art_id = b.art_id
;

UPDATE _list_extended_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_1_1 GROUP BY 1,2,3) b
 WHERE _list_extended_1.mandant_id = b.mandant_id AND
      _list_extended_1.wup_id = b.wup_id AND
      _list_extended_1.art_id = b.art_id
;

UPDATE _list_extended_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2_1 GROUP BY 1,2,3) b
 WHERE _list_extended_1.mandant_id = b.mandant_id AND
      _list_extended_1.wup_id = b.wup_id AND
      _list_extended_1.art_id = b.art_id
;

UPDATE _list_extended_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT a.mandant_id,
                                   a.wup_id,
                                   a.art_id,
                                   COALESCE(b.listung_sst_mvke, 1) AS listung_sst_mvke
                            FROM _art_list_wup_zu_per_1 a
                            JOIN _track_sst_1 b 
                              ON a.mandant_id = b.mandant_id AND 
                                 a.art_id = b.art_id
                            where b.listung_sst_mvke is not null and
						          b.listung_sst_mvke not in ('R')
                            GROUP BY 1,2,3,4) b
 WHERE _list_extended_1.mandant_id = b.mandant_id AND
      _list_extended_1.wup_id = b.wup_id AND
      _list_extended_1.art_id = b.art_id AND
      _list_extended_1.sm_id >= CAST(b.listung_sst_mvke AS INT)
;

UPDATE _list_extended_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT a.mandant_id,
                                   a.wup_id,
                                   a.art_id,
                                   COALESCE(b.listung_k_sst_mvke, 'K1') AS listung_k_sst_mvke
                            FROM _art_list_wup_zu_per_1 a
                            JOIN _track_ksst_1 b 
                              ON a.mandant_id = b.mandant_id AND 
                                 a.art_id = b.art_id 
                            where b.listung_k_sst_mvke is not null and
						          b.listung_k_sst_mvke not in ('R')
                            GROUP BY 1,2,3,4) b
 WHERE _list_extended_1.mandant_id = b.mandant_id AND
      _list_extended_1.wup_id = b.wup_id AND
      _list_extended_1.art_id = b.art_id AND
      SUBSTR(TRIM(_list_extended_1.ksm_id),2,1) >= SUBSTR(TRIM(b.listung_k_sst_mvke),2,1)
;

UPDATE _list_extended_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst_1 GROUP BY 1,2,3) b
 WHERE _list_extended_1.mandant_id = b.mandant_id AND
      _list_extended_1.wup_id = b.wup_id AND
      _list_extended_1.art_id = b.art_id
;

UPDATE _list_delisted_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_1_1 GROUP BY 1,2,3) b
 WHERE _list_delisted_1.mandant_id = b.mandant_id AND
      _list_delisted_1.wup_id = b.wup_id AND
      _list_delisted_1.art_id = b.art_id AND
     (_list_delisted_1.sm_id_selected = -1 OR
      _list_delisted_1.ksm_id_selected = 'KK')
;

UPDATE _list_delisted_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2_1 GROUP BY 1,2,3) b
 WHERE _list_delisted_1.mandant_id = b.mandant_id AND
      _list_delisted_1.wup_id = b.wup_id AND
      _list_delisted_1.art_id = b.art_id AND
     (_list_delisted_1.sm_id_selected = -1 OR
      _list_delisted_1.ksm_id_selected = 'KK')
;

UPDATE _list_delisted_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT a.mandant_id,
                                   a.wup_id,
                                   a.art_id,
                                   COALESCE(b.listung_sst_mvke, 6) AS listung_sst_mvke
                            FROM _art_list_wup_zu_per_1 a
                            JOIN _track_sst_1 b 
                              ON a.mandant_id = b.mandant_id AND 
                                 a.art_id = b.art_id 
                            where b.listung_sst_mvke is not null and
						          b.listung_sst_mvke not in ('R')
                            GROUP BY 1,2,3,4) b
 WHERE _list_delisted_1.mandant_id = b.mandant_id AND
      _list_delisted_1.wup_id = b.wup_id AND
      _list_delisted_1.art_id = b.art_id AND
      _list_delisted_1.sm_id < CAST(b.listung_sst_mvke AS INT) AND
      _list_delisted_1.sm_id_selected = -1
;

UPDATE _list_delisted_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT a.mandant_id,
                                   a.wup_id,
                                   a.art_id,
                                   COALESCE(b.listung_k_sst_mvke, 'K9') AS listung_k_sst_mvke
                            FROM _art_list_wup_zu_per_1 a
                            JOIN _track_ksst_1 b 
                              ON a.mandant_id = b.mandant_id AND 
                                 a.art_id = b.art_id
                            where b.listung_k_sst_mvke is not null and
						          b.listung_k_sst_mvke not in ('R')
                            GROUP BY 1,2,3,4) b
 WHERE _list_delisted_1.mandant_id = b.mandant_id AND
      _list_delisted_1.wup_id = b.wup_id AND
      _list_delisted_1.art_id = b.art_id AND
      SUBSTR(TRIM(_list_delisted_1.ksm_id),2,1) < SUBSTR(TRIM(b.listung_k_sst_mvke),2,1) AND
      TRIM(_list_delisted_1.ksm_id_selected) = 'KK'
;

UPDATE _list_delisted_1 
SET umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0

FROM (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst_1 GROUP BY 1,2,3) b
 WHERE _list_delisted_1.mandant_id = b.mandant_id AND
      _list_delisted_1.wup_id = b.wup_id AND
      _list_delisted_1.art_id = b.art_id AND
     (_list_delisted_1.sm_id_selected = -1 OR
      _list_delisted_1.ksm_id_selected = 'KK')
;

DELETE FROM DBP_MSI_DATA.kl_listung_kmo_2 
WHERE mandant_id = ${mandant_id} AND 
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2  (kl_listung_kmo_id
                                      ,listung_art
                                      ,mandant_id
                                      ,art_id
                                      ,sm_id_selected
                                      ,ksm_id_selected
                                      ,sm_id
                                      ,ksm_id
                                      ,wup_id
                                      ,umsatz_hr
                                      ,absatz_hr
                                      ,rohertrag_hr
                                      ,erweiterung_fg
                                      ,reduktion_fg
                                      ,kjwo_update
                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        'Listung reduzieren'
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,ksm_id_selected
       ,sm_id
       ,ksm_id
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0
       ,0
       ,b.kjwo
       ,list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id
       ,'Listung reduzieren' AS listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,ksm_id_selected
       ,sm_id
       ,ksm_id
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0 AS erweiterung_fg
       ,0 AS reduktion_fg
       ,b.kjwo AS kjwo_update
       ,list_kz
FROM _list_reduced_1
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2  (kl_listung_kmo_id
                                      ,listung_art
                                      ,mandant_id
                                      ,art_id
                                      ,sm_id_selected
                                      ,ksm_id_selected
                                      ,sm_id
                                      ,ksm_id
                                      ,wup_id
                                      ,umsatz_hr
                                      ,absatz_hr
                                      ,rohertrag_hr
                                      ,erweiterung_fg
                                      ,reduktion_fg
                                      ,kjwo_update
                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        'Listung erweitern'
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,ksm_id_selected
       ,sm_id
       ,ksm_id
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0
       ,0
       ,b.kjwo
       ,list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id
       ,'Listung erweitern' AS listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,ksm_id_selected
       ,sm_id
       ,ksm_id
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0 AS erweiterung_fg
       ,0 AS reduktion_fg
       ,b.kjwo AS kjwo_update
       ,list_kz
FROM _list_extended_1
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2  (kl_listung_kmo_id
                                      ,listung_art
                                      ,mandant_id
                                      ,art_id
                                      ,sm_id_selected
                                      ,ksm_id_selected
                                      ,sm_id
                                      ,ksm_id
                                      ,wup_id
                                      ,umsatz_hr
                                      ,absatz_hr
                                      ,rohertrag_hr
                                      ,erweiterung_fg
                                      ,reduktion_fg
                                      ,kjwo_update
                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        'Auslistung'
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,ksm_id_selected
       ,sm_id
       ,ksm_id
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0
       ,0
       ,b.kjwo
       ,list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id
       ,'Auslistung' AS listung_art
       ,mandant_id
       ,art_id
       ,sm_id_selected
       ,ksm_id_selected
       ,sm_id
       ,ksm_id
       ,wup_id
       ,umsatz_kpi
       ,absatz_kpi
       ,rohertrag_kpi
       ,0 AS erweiterung_fg
       ,0 AS reduktion_fg
       ,b.kjwo AS kjwo_update
       ,list_kz
FROM _list_delisted_1
JOIN DBP_DATA.woche_2 b
  ON 1 = 1
WHERE b.kjwo IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _track_soll_1 AS (
SELECT mandant_id,
       wup_id,
       art_id,
       sm_id,
       ksm_id
FROM _differenz_soll_1
GROUP BY 1,2,3,4,5
);

DELETE FROM _track_soll_1
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2_1);

DELETE FROM _track_soll_1
WHERE (mandant_id,wup_id,art_id,sm_id) IN (SELECT a.mandant_id,
                                                  a.wup_id,
                                                  a.art_id,
                                                  c.sm_id
                                           FROM _art_list_wup_zu_per_1 a
                                           JOIN _track_sst_1 b 
                                             ON a.mandant_id = b.mandant_id AND 
                                                a.art_id = b.art_id
                                           JOIN _track_soll_1 c
                                             ON a.mandant_id = c.mandant_id AND
                                                a.wup_id = c.wup_id AND
                                                a.art_id = c.art_id AND
                                                c.sm_id >= CAST(COALESCE(b.listung_sst_mvke,1) AS INT)
                                           GROUP BY 1,2,3,4)
;

DELETE FROM _track_soll_1
WHERE (mandant_id,wup_id,art_id,ksm_id) IN (SELECT a.mandant_id,
                                                   a.wup_id,
                                                   a.art_id,
                                                   c.ksm_id
                                            FROM _art_list_wup_zu_per_1 a
                                            JOIN _track_ksst_1 b 
                                              ON a.mandant_id = b.mandant_id AND 
                                                 a.art_id = b.art_id
                                            JOIN _track_soll_1 c
                                              ON a.mandant_id = c.mandant_id AND
                                                 a.wup_id = c.wup_id AND
                                                 a.art_id = c.art_id AND
                                                 SUBSTR(TRIM(c.ksm_id),2,1) >= SUBSTR(COALESCE(TRIM(b.listung_k_sst_mvke),'K1'),2,1)
                                            GROUP BY 1,2,3,4)
;

DELETE FROM _track_soll_1
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst_1);

CREATE OR REPLACE VOLATILE TABLE _track_ist_1 AS (
SELECT mandant_id,
       wup_id,
       art_id,
       sm_id,
       ksm_id
FROM _ist_listung_article_1
WHERE markt_zaehlung_fg = 1
);

DELETE FROM _track_ist_1
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _art_list_wup_kill_2_1);

DELETE FROM _track_ist_1
WHERE (mandant_id,wup_id,art_id,sm_id) IN (SELECT a.mandant_id,
                                            a.wup_id,
                                            a.art_id,
                                            c.sm_id
                                     FROM _art_list_wup_zu_per_1 a
                                     JOIN _track_sst_1 b 
                                       ON a.mandant_id = b.mandant_id AND 
                                          a.art_id = b.art_id
                                     JOIN _track_ist_1 c
                                       ON a.mandant_id = c.mandant_id AND
                                          a.wup_id = c.wup_id AND
                                          a.art_id = c.art_id AND
                                          c.sm_id < CAST(COALESCE(b.listung_sst_mvke, 6) AS INT)
                                     GROUP BY 1,2,3,4)
;

DELETE FROM _track_ist_1
WHERE (mandant_id,wup_id,art_id,ksm_id) IN (SELECT a.mandant_id,
                                            a.wup_id,
                                            a.art_id,
                                            c.ksm_id
                                     FROM _art_list_wup_zu_per_1 a
                                     JOIN _track_ksst_1 b 
                                       ON a.mandant_id = b.mandant_id AND 
                                          a.art_id = b.art_id
                                     JOIN _track_ist_1 c
                                       ON a.mandant_id = c.mandant_id AND
                                          a.wup_id = c.wup_id AND
                                          a.art_id = c.art_id AND
                                          SUBSTR(TRIM(c.ksm_id),2,1) < SUBSTR(COALESCE(TRIM(b.listung_k_sst_mvke),'K9'),2,1)
                                     GROUP BY 1,2,3,4)
;

DELETE FROM _track_ist_1
WHERE (mandant_id,wup_id,art_id) IN (SELECT mandant_id,wup_id,art_id FROM _sonstige_bst_1);

UPDATE DBP_MSI_DATA.kl_listung_kmo_2  
SET erweiterung_fg = 1

FROM (SELECT *
                                                       FROM _track_soll_1) b
                                      WHERE DBP_MSI_DATA.kl_listung_kmo.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung_kmo.wup_id = b.wup_id AND
      DBP_MSI_DATA.kl_listung_kmo.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung_kmo.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

UPDATE DBP_MSI_DATA.kl_listung_kmo_2 
SET reduktion_fg = 1

FROM (SELECT *
                                                       FROM _track_ist_1) b
                                      WHERE DBP_MSI_DATA.kl_listung_kmo.mandant_id = b.mandant_id AND
      DBP_MSI_DATA.kl_listung_kmo.wup_id = b.wup_id AND
      DBP_MSI_DATA.kl_listung_kmo.art_id = b.art_id AND
      DBP_MSI_DATA.kl_listung_kmo.kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

DELETE FROM DBP_MSI_DATA.kl_listung_kmo_2
WHERE (mandant_id,art_id) IN (SELECT DISTINCT mandant_id,art_id FROM DBP_ETL.kl_basis_listung_kmo_2 WHERE list_kz <> 'A') AND
       listung_art IN ('Auslistung','Listung reduzieren') AND
       kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _red_step1_1 AS (
SELECT mandant_id,
       kjwo_update,
       listung_art,
       art_id,
       MAX(sm_id_selected) AS sm_id_selected
FROM DBP_MSI_DATA.kl_listung_kmo_2
WHERE ksm_id IS NULL AND
      listung_art = 'Listung reduzieren' AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1) AND
      mandant_id = ${mandant_id}
GROUP BY 1,2,3,4
);

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2 (kl_listung_kmo_id
                                                      ,mandant_id
                                                      ,listung_art
                                                      ,art_id
                                                      ,wup_id
                                                      ,sm_id_selected
                                                      ,ksm_id_selected
                                                      ,sm_id
                                                      ,ksm_id
                                                      ,umsatz_hr
                                                      ,absatz_hr
                                                      ,rohertrag_hr
                                                      ,erweiterung_fg
                                                      ,reduktion_fg
                                                      ,kjwo_update
                                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       6,
       a.ksm_id_selected,
       a.sm_id,
       a.ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id,
       a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       6 AS sm_id_selected,
       a.ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM DBP_MSI_DATA.kl_listung_kmo_2 a
JOIN _red_step1_1 b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo_update = b.kjwo_update AND
     a.art_id = b.art_id AND
     a.sm_id_selected = b.sm_id_selected AND
     a.listung_art = b.listung_art
;

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2 (kl_listung_kmo_id
                                                      ,mandant_id
                                                      ,listung_art
                                                      ,art_id
                                                      ,wup_id
                                                      ,sm_id_selected
                                                      ,ksm_id_selected
                                                      ,sm_id
                                                      ,ksm_id
                                                      ,umsatz_hr
                                                      ,absatz_hr
                                                      ,rohertrag_hr
                                                      ,erweiterung_fg
                                                      ,reduktion_fg
                                                      ,kjwo_update
                                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       7,
       a.ksm_id_selected,
       a.sm_id,
       a.ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id,
       a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       7 AS sm_id_selected,
       a.ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM DBP_MSI_DATA.kl_listung_kmo_2 a
JOIN _red_step1_1 b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo_update = b.kjwo_update AND
     a.art_id = b.art_id AND
     a.sm_id_selected = b.sm_id_selected AND
     a.listung_art = b.listung_art
;

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2 (kl_listung_kmo_id,
                                                       mandant_id
                                                      ,listung_art
                                                      ,art_id
                                                      ,wup_id
                                                      ,sm_id_selected
                                                      ,ksm_id_selected
                                                      ,sm_id
                                                      ,ksm_id
                                                      ,umsatz_hr
                                                      ,absatz_hr
                                                      ,rohertrag_hr
                                                      ,erweiterung_fg
                                                      ,reduktion_fg
                                                      ,kjwo_update
                                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       8,
       a.ksm_id_selected,
       a.sm_id,
       a.ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id,
       a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       8 AS sm_id_selected,
       a.ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM DBP_MSI_DATA.kl_listung_kmo_2 a
JOIN _red_step1_1 b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo_update = b.kjwo_update AND
     a.art_id = b.art_id AND
     a.sm_id_selected = b.sm_id_selected AND
     a.listung_art = b.listung_art
;

INSERT INTO DBP_MSI_DATA.kl_listung_kmo_2 (kl_listung_kmo_id,
                                                       mandant_id
                                                      ,listung_art
                                                      ,art_id
                                                      ,wup_id
                                                      ,sm_id_selected
                                                      ,ksm_id_selected
                                                      ,sm_id
                                                      ,ksm_id
                                                      ,umsatz_hr
                                                      ,absatz_hr
                                                      ,rohertrag_hr
                                                      ,erweiterung_fg
                                                      ,reduktion_fg
                                                      ,kjwo_update
                                                      ,list_kz)
SELECT (ROW_NUMBER() OVER (
		ORDER BY        
        a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       9,
       a.ksm_id_selected,
       a.sm_id,
       a.ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
		) + COALESCE((SELECT MAX(kl_listung_kmo_id) FROM dbp_msi_data.kl_listung_kmo_2 WHERE kl_listung_kmo_id <> 0),0) ) AS kl_listung_kmo_id,
       a.mandant_id,
       a.listung_art,
       a.art_id,
       a.wup_id,
       9 AS sm_id_selected,
       a.ksm_id_selected,
       a.sm_id,
       trim(a.ksm_id) as ksm_id,
       a.umsatz_hr,
       a.absatz_hr,
       a.rohertrag_hr,
       a.erweiterung_fg,
       a.reduktion_fg,
       a.kjwo_update,
       a.list_kz
FROM DBP_MSI_DATA.kl_listung_kmo_2 a
JOIN _red_step1_1 b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo_update = b.kjwo_update AND
     a.art_id = b.art_id AND
     a.sm_id_selected = b.sm_id_selected AND
     a.listung_art = b.listung_art
;
