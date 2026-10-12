create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

CREATE OR REPLACE VOLATILE TABLE _sal_1 AS (
SELECT a.*,
       b.art_id,
       COALESCE((1+(NULLIFZERO(c.mwst)/100.0000)),1.19) AS multi_mwst
FROM DBP_ETL.bf_sort_sal_export_2 a
JOIN DBP_DATA.art_2 b
  ON CAST(a.art_nr AS varchar(20)) = cast(b.kl_art_id as varchar(20)) AND
     b.mandant_id = 1 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN DBP_DATA.mwst_per_2 c
  ON c.mandant_id = 1 AND
     CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
     b.mwst_id = c.mwst_id
WHERE b.artikeltyp_id <> 12 AND
      TRIM(a.art_status) NOT IN ('L','R')
);

CREATE OR REPLACE VOLATILE TABLE _sal_2 AS (
SELECT b.art_matching_id,
       a.art_id,
       TRIM(a.k_listung) AS k_listung,
       a.vk_pk_1,
       b.kl_art_kat_id,
       b.kl_wg_id,
       b.kl_owg_id,
       b.kl_uwg_id,
       COALESCE(a.total_umsatz_netto,0)*a.multi_mwst AS umsatz_brutto,
       COALESCE(a.af_umsatz_netto,0)*multi_mwst AS umsatz_brutto_af,
       COALESCE(a.sa_umsatz_netto,0)*multi_mwst AS umsatz_brutto_sa,
       COALESCE(a.total_absatz,0) AS menge,
       COALESCE(a.total_af_absatz,0) AS menge_af,
       COALESCE(a.total_sa_absatz,0) AS menge_sa,
       COUNT(a.art_id) OVER (PARTITION BY b.art_matching_id ORDER BY a.art_id) AS anz_artikel
FROM _sal_1 a
JOIN DBP_ETL.art_matching_nielsen_per_2 b
  ON a.art_id = b.art_id
);

CREATE OR REPLACE VOLATILE TABLE _sal_3 AS (
SELECT art_matching_id,
       MAX(kl_art_kat_id) AS kl_art_kat_id,
       MAX(kl_wg_id) AS kl_wg_id,
       MAX(kl_owg_id) AS kl_owg_id,
       MAX(kl_uwg_id) AS kl_uwg_id,
       MAX(CASE WHEN k_listung = 'N/A' THEN '' ELSE k_listung END) AS k_listung,
       AVG(vk_pk_1) AS vk_pk_1,
       SUM(umsatz_brutto) AS umsatz_brutto,
       SUM(umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(umsatz_brutto_sa) AS umsatz_brutto_sa,
       SUM(menge) AS menge,
       SUM(menge_af) AS menge_af,
       SUM(menge_sa) AS menge_sa,
       MAX(anz_artikel) AS anz_artikel
FROM _sal_2
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _chk AS (
SELECT 1 AS k
);

INSERT INTO _chk VALUES (2);
INSERT INTO _chk VALUES (3);
INSERT INTO _chk VALUES (4);
INSERT INTO _chk VALUES (5);

DELETE FROM DBP_DATA.art_kl_preislage_zu_per_2
WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                     WHERE mandant_id = 1) a
	       JOIN DBP_DATA.tag_2 b
	         ON a.kjwo = b.kjwo) AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO DBP_DATA.art_kl_preislage_zu_per_2 (mandant_id
                                                           ,art_matching_id
                                                           ,kjmo
                                                           ,kjwo_update
                                                           ,wrg_id
                                                           ,sm_id
                                                           ,ksm_id
                                                           ,owg_id
                                                           ,wg_id
                                                           ,wug_id
                                                           ,vk_brutto_pk_1
                                                           ,durchschnitt_preis_kasse
                                                           ,umsatz_brutto
                                                           ,umsatz_brutto_af
                                                           ,umsatz_brutto_sa
                                                           ,menge
                                                           ,menge_af
                                                           ,menge_sa)
SELECT 1 AS mandant_id,
       a.art_matching_id,
       x.kjmo,
       z.kjwo AS kjwo_update,
       'EUR' AS wrg_id,
       CASE WHEN k_listung = '' THEN 'N/A' ELSE k_listung END AS sm_id,
       '' AS ksm_id,
       a.kl_wg_id AS owg_id,
       a.kl_owg_id AS wg_id,
       a.kl_uwg_id AS wug_id,
       a.vk_pk_1 AS vk_brutto_pk_1,
       CASE
	 WHEN a.umsatz_brutto_af > 0 AND a.menge_af <> 0
	 THEN a.umsatz_brutto_af/NULLIFZERO(a.menge_af)
	 WHEN a.umsatz_brutto_af = 0 AND a.umsatz_brutto_sa > 0 AND a.menge_sa <> 0
	 THEN a.umsatz_brutto_sa/NULLIFZERO(a.menge_sa)
	 ELSE ZEROIFNULL(a.umsatz_brutto/NULLIFZERO(a.menge))
       END AS durchschnitt_preis_kasse,
       a.umsatz_brutto,
       a.umsatz_brutto_af,
       a.umsatz_brutto_sa,
       a.menge,
       a.menge_af,
       a.menge_sa
FROM _sal_3 a
JOIN (SELECT MIN(b.kjmo) AS kjmo
      FROM (SELECT MAX(kjwo) AS kjwo
            FROM DBP_DATA.art_nielsen_fakten_kjwo_2
            WHERE mandant_id = 1) a
	  JOIN DBP_DATA.tag_2 b
	    ON a.kjwo = b.kjwo) x
  ON 1 = 1
JOIN DBP_DATA.woche_2 z
  ON 1 = 1
WHERE a.umsatz_brutto > 0 AND
      a.menge > 0 AND
      z.akt_wo = 1
;

INSERT INTO DBP_DATA.art_kl_preislage_zu_per_2 (mandant_id
                                                           ,art_matching_id
                                                           ,kjmo
                                                           ,kjwo_update
                                                           ,wrg_id
                                                           ,sm_id
                                                           ,ksm_id
                                                           ,owg_id
                                                           ,wg_id
                                                           ,wug_id
                                                           ,vk_brutto_pk_1
                                                           ,durchschnitt_preis_kasse
                                                           ,umsatz_brutto
                                                           ,umsatz_brutto_af
                                                           ,umsatz_brutto_sa
                                                           ,menge
                                                           ,menge_af
                                                           ,menge_sa)
SELECT a.mandant_id,
       a.art_matching_id,
       a.kjmo,
       a.kjwo_update,
       'EUR' AS wrg_id,
       CAST(b.k AS VARCHAR(10)) AS sm_id,
       a.ksm_id,
       a.owg_id,
       a.wg_id,
       a.wug_id,
       a.vk_brutto_pk_1,
       a.durchschnitt_preis_kasse,
       a.umsatz_brutto,
       a.umsatz_brutto_af,
       a.umsatz_brutto_sa,
       a.menge,
       a.menge_af,
       a.menge_sa
FROM DBP_DATA.art_kl_preislage_zu_per_2 a
JOIN _chk b
  ON CAST(a.sm_id AS INT) < b.k
WHERE a.sm_id NOT IN ('N/A','-1') AND
      a.mandant_id = 1 AND
     (a.mandant_id,a.art_matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT),kjwo_update
	                                                               FROM DBP_DATA.art_kl_preislage_zu_per_2
							               WHERE sm_id NOT IN ('N/A','-1'))
;

DELETE FROM DBP_DATA.art_kl_preislage_zu_per_neu_2
WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                     WHERE mandant_id = 1) a
	       JOIN DBP_DATA.tag_2 b
	         ON a.kjwo = b.kjwo) AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

INSERT INTO DBP_DATA.art_kl_preislage_zu_per_neu_2 (mandant_id
                                                               ,art_matching_id
                                                               ,kjmo
                                                               ,kjwo_update
                                                               ,wrg_id
                                                               ,sm_id
                                                               ,ksm_id
                                                               ,owg_id
                                                               ,wg_id
                                                               ,wug_id
                                                               ,vk_brutto_pk_1
                                                               ,durchschnitt_preis_kasse
                                                               ,umsatz_brutto
                                                               ,umsatz_brutto_af
                                                               ,umsatz_brutto_sa
                                                               ,menge
                                                               ,menge_af
                                                               ,menge_sa)
SELECT mandant_id
      ,art_matching_id
      ,kjmo
      ,kjwo_update
      ,wrg_id
      ,sm_id
      ,ksm_id
      ,owg_id
      ,wg_id
      ,wug_id
      ,vk_brutto_pk_1
      ,durchschnitt_preis_kasse
      ,umsatz_brutto
      ,umsatz_brutto_af
      ,umsatz_brutto_sa
      ,menge
      ,menge_af
      ,menge_sa
FROM DBP_DATA.art_kl_preislage_zu_per_2
WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                     WHERE mandant_id = 1) a
	       JOIN DBP_DATA.tag_2 b
	         ON a.kjwo = b.kjwo) AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche_2 WHERE akt_wo = 1)
;

CREATE OR REPLACE VOLATILE TABLE _nielsen_preise_1 AS (
SELECT c.art_matching_id,
       MAX(c.kl_art_kat_id) AS kl_art_kat_id,
       MAX(c.kl_wg_id) AS kl_wg_id,
       MAX(c.kl_owg_id) AS kl_owg_id,
       MAX(c.kl_uwg_id) AS kl_uwg_id,
       SUM(a.menge) AS menge,
       SUM(a.menge_af) AS menge_af,
       SUM(a.menge_sa) AS menge_sa,
       SUM(a.umsatz_brutto) AS umsatz_brutto,
       SUM(a.umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(a.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM DBP_DATA.art_nielsen_fakten_kjwo_2 a
JOIN _art_nielsen b
  ON a.art_nielsen_id = b.art_nielsen_id AND
     a.mandant_id = b.mandant_id 
JOIN DBP_ETL.art_matching_nielsen_per_2 c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 3 AND
      a.mandant_id = 1
GROUP BY 1
);

DELETE FROM DBP_DATA.art_nielsen_preislage_zu_per_2
WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo_2
                     WHERE mandant_id = 1) a
	       JOIN DBP_DATA.tag_2 b
	         ON a.kjwo = b.kjwo) AND
      mandant_id = 1
;

INSERT INTO DBP_DATA.art_nielsen_preislage_zu_per_2 (mandant_id
                                                                ,art_matching_id
                                                                ,kjmo
                                                                ,wrg_id
                                                                ,kl_art_kat_id
                                                                ,kl_wg_id
                                                                ,kl_owg_id
                                                                ,kl_uwg_id
                                                                ,hwg_id
                                                                ,owg_id
                                                                ,wg_id
                                                                ,wug_id
                                                                ,durchschnitt_preis_kasse
                                                                ,umsatz_brutto
                                                                ,umsatz_brutto_af
                                                                ,umsatz_brutto_sa
                                                                ,menge
                                                                ,menge_af
                                                                ,menge_sa)
SELECT 1 AS mandant_id,
       a.art_matching_id,
       x.kjmo,
       'EUR' AS wrg_id,
       a.kl_art_kat_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       a.kl_art_kat_id AS hwg_id,
       a.kl_wg_id AS owg_id,
       a.kl_owg_id AS wg_id,
       a.kl_uwg_id AS wug_id,
       CASE
         WHEN a.umsatz_brutto_af > 0
         THEN a.umsatz_brutto_af/NULLIFZERO(a.menge_af)
         WHEN a.umsatz_brutto_af = 0 AND a.umsatz_brutto_sa > 0
         THEN a.umsatz_brutto_sa/NULLIFZERO(a.menge_sa)
         ELSE 0
       END AS durchschnitt_preis_kasse,
       a.umsatz_brutto,
       a.umsatz_brutto_af,
       a.umsatz_brutto_sa,
       a.menge,
       a.menge_af,
       a.menge_sa
FROM _nielsen_preise_1 a
JOIN (SELECT MIN(b.kjmo) AS kjmo
      FROM (SELECT MAX(kjwo) AS kjwo
            FROM DBP_DATA.art_nielsen_fakten_kjwo_2
            WHERE mandant_id = 1) a
	  JOIN DBP_DATA.tag_2 b
	    ON a.kjwo = b.kjwo) x
  ON 1 = 1
WHERE a.umsatz_brutto > 0 AND
      a.menge > 0
;

UPDATE DBP_DATA.art_kl_preislage_zu_per_2 SET sm_id = 'N/A'
WHERE sm_id = '-1'
;

