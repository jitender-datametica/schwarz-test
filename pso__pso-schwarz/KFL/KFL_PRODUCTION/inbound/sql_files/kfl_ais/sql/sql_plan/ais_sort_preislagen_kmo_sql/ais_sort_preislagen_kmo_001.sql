create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen where DAT_BIS='9999-12-31'
) ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _sal_1 AS (
SELECT a.*,
       COALESCE((1+(NULLIFZERO(c.mwst)/100.0000)),1.19) AS multi_mwst,
       COALESCE(x.ksm_id,'') AS ksm_id
FROM DBP_DATA.sal_kmo a
JOIN DBP_DATA.art b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
JOIN DBP_DATA.mwst_per c
  ON c.mandant_id = a.mandant_id AND
     CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis AND
     b.mwst_id = c.mwst_id
LEFT JOIN DBP_ETL_process.art_sm_vw_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     CURRENT_DATE BETWEEN x.dat_von AND x.dat_bis
WHERE b.artikeltyp_id <> 12 AND
      TRIM(a.art_status) NOT IN ('L','R') AND
      CASE
        WHEN a.mandant_id = 3 AND
             TRIM(a.eigenmarke_id) = ''
        THEN 1
        WHEN a.mandant_id <> 3
        THEN 1
        ELSE 0
      END = 1 AND
      a.mandant_id = ${mandant_id} AND
      a.kjmo IN (SELECT MAX(kjmo) AS kjmo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id})
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _sal_2 AS (
SELECT a.mandant_id,
       a.kjmo,
       b.art_matching_id,
       a.art_id,
       TRIM(a.k_listung) AS k_listung,
       TRIM(a.ksm_id) AS ksm_id,
       a.vk_brutto_pk1 AS vk_pk_1,
       0 AS kl_art_kat_id,
       b.kl_wg_id,
       b.kl_owg_id,
       b.kl_uwg_id,
       COALESCE(a.total_umsatz_netto,0)*a.multi_mwst AS umsatz_brutto,
       COALESCE(a.total_umsatz_netto_af,0)*multi_mwst AS umsatz_brutto_af,
       COALESCE(a.total_umsatz_netto_sa,0)*multi_mwst AS umsatz_brutto_sa,
       COALESCE(a.total_artbew_menge,0) AS menge,
       COALESCE(a.total_artbew_menge_af,0) AS menge_af,
       COALESCE(a.total_artbew_menge_sa,0) AS menge_sa,
       COUNT(a.art_id) OVER (PARTITION BY b.art_matching_id ORDER BY a.art_id) AS anz_artikel
FROM _sal_1 a
JOIN DBP_ETL.art_matching_nielsen_per_kmo b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _sal_3 AS (
SELECT mandant_id,
       kjmo,
       art_matching_id,
       MAX(kl_art_kat_id) AS kl_art_kat_id,
       MAX(kl_wg_id) AS kl_wg_id,
       MAX(kl_owg_id) AS kl_owg_id,
       MAX(kl_uwg_id) AS kl_uwg_id,
       MAX(CASE WHEN k_listung = 'N/A' THEN '' ELSE k_listung END) AS k_listung,
       MAX(ksm_id) AS ksm_id,
       AVG(vk_pk_1) AS vk_pk_1,
       SUM(umsatz_brutto) AS umsatz_brutto,
       SUM(umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(umsatz_brutto_sa) AS umsatz_brutto_sa,
       SUM(menge) AS menge,
       SUM(menge_af) AS menge_af,
       SUM(menge_sa) AS menge_sa,
       MAX(anz_artikel) AS anz_artikel
FROM _sal_2
GROUP BY 1,2,3
);

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE  OR REPLACE VOLATILE TABLE _chk AS (
SELECT 1 AS k
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk VALUES (2);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk VALUES (3);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk VALUES (4);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk VALUES (5);

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE  OR REPLACE VOLATILE TABLE _chk2 AS (
SELECT 1 AS k
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (2);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (3);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (4);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (5);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (6);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (7);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (8);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _chk2 VALUES (9);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_kl_preislage_zu_per
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
               FROM DBP_DATA.art_nielsen_fakten_kjmo
               WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id}
      AND kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_kl_preislage_zu_per (mandant_id
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
       z.kjwo AS kjwo_update,
       b.default_wrg AS wrg_id,
       CASE WHEN k_listung = '' THEN 'N/A' ELSE k_listung END AS sm_id,
       a.ksm_id,
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
JOIN DBP_DATA.mandant b
  ON a.mandant_id = b.mandant_id
JOIN DBP_DATA.woche z
  ON 1 = 1
WHERE a.umsatz_brutto > 0 AND
      a.menge > 0 AND
      z.akt_wo = 1      
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_kl_preislage_zu_per (mandant_id
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
       a.art_matching_id AS art_matching_id,
       a.kjmo,
       a.kjwo_update,
       a.wrg_id,
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
FROM DBP_DATA.art_kl_preislage_zu_per a
JOIN _chk b
  ON CAST(a.sm_id AS INT) < b.k
WHERE a.sm_id NOT IN ('N/A','-1') AND
     (a.mandant_id,a.art_matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT),kjwo_update
	                                                               FROM DBP_DATA.art_kl_preislage_zu_per
							               WHERE sm_id NOT IN ('N/A','-1') AND
                                                                             mandant_id = ${mandant_id}) AND
      a.mandant_id = ${mandant_id}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_kl_preislage_zu_per (mandant_id
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
       a.art_matching_id AS art_matching_id,
       a.kjmo,
       a.kjwo_update,
       a.wrg_id,
       a.sm_id,
       'K'||CAST(b.k AS VARCHAR(10)) AS ksm_id,
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
FROM DBP_DATA.art_kl_preislage_zu_per a
JOIN _chk2 b
  ON CAST(SUBSTR(a.ksm_id,2,1) AS INT) < b.k
WHERE a.sm_id NOT IN ('N/A','-1') AND
     (a.mandant_id,a.art_matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT mandant_id,art_matching_id,kjmo,
                                                                                --mfialkiewicz
                                                                                --CAST(SUBSTR(ksm_id,2,1) AS INT),
                                                                                try_to_number(SUBSTR(ksm_id,2,1)),
                                                                                kjwo_update
	                                                                   FROM DBP_DATA.art_kl_preislage_zu_per
							                                           WHERE --ksm_id NOT IN ('') AND
                                                                                                         ksm_id is not null and        
                                                                             mandant_id = ${mandant_id}) AND
      a.mandant_id = ${mandant_id}
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_kl_preislage_zu_per_neu
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
               FROM DBP_DATA.art_nielsen_fakten_kjmo
               WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id}
      AND kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_kl_preislage_zu_per_neu (mandant_id
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
FROM DBP_DATA.art_kl_preislage_zu_per
WHERE (mandant_id,kjmo) IN (SELECT mandant_id,kjmo FROM _sal_3) AND
      mandant_id = ${mandant_id} AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE  OR REPLACE VOLATILE TABLE _nielsen_preise_1 AS (
SELECT a.mandant_id
      ,c.art_matching_id
      ,MAX(0) AS kl_art_kat_id
      ,MAX(c.kl_wg_id) AS kl_wg_id
      ,MAX(c.kl_owg_id) AS kl_owg_id
      ,MAX(c.kl_uwg_id) AS kl_uwg_id
      ,SUM(a.menge) AS menge
      ,SUM(a.menge_af) AS menge_af
      ,SUM(a.menge_sa) AS menge_sa
      ,SUM(a.umsatz_brutto) AS umsatz_brutto
      ,SUM(a.umsatz_brutto_af) AS umsatz_brutto_af
      ,SUM(a.umsatz_brutto_sa) AS umsatz_brutto_sa
FROM DBP_DATA.art_nielsen_fakten_kjmo a
JOIN _art_nielsen b
  ON a.art_nielsen_id = b.art_nielsen_id AND
     a.mandant_id = b.mandant_id 
JOIN DBP_ETL.art_matching_nielsen_per_kmo c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              RANK() OVER (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      a.mandant_id = ${mandant_id} AND
      d.nielsen_market_cluster_id = 1 -- muss angepasst werden, wenn Wessam mit den Maerkten (oder Clustern!) um die Ecke kommt!
GROUP BY 1,2
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_nielsen_preislage_zu_per
WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
                     FROM DBP_DATA.art_nielsen_fakten_kjmo
                     WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_nielsen_preislage_zu_per (mandant_id
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
SELECT a.mandant_id,
       a.art_matching_id,
       x.kjmo,
       c.default_wrg AS wrg_id,
       a.kl_art_kat_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       a.kl_art_kat_id AS hwg_id,
       a.kl_wg_id AS owg_id,
       a.kl_owg_id AS wg_id,
       a.kl_uwg_id AS wug_id,
       a.umsatz_brutto/NULLIFZERO(a.menge) AS durchschnitt_preis_kasse,
--       CASE
--         WHEN a.umsatz_brutto_af > 0
--         THEN a.umsatz_brutto_af/NULLIFZERO(a.menge_af)
--         WHEN a.umsatz_brutto_af = 0 AND a.umsatz_brutto_sa > 0
--         THEN a.umsatz_brutto_sa/NULLIFZERO(a.menge_sa)
--         ELSE 0
--       END AS durchschnitt_preis_kasse,
       a.umsatz_brutto,
       a.umsatz_brutto_af,
       a.umsatz_brutto_sa,
       a.menge,
       a.menge_af,
       a.menge_sa
FROM _nielsen_preise_1 a
JOIN DBP_DATA.mandant c
  ON a.mandant_id = c.mandant_id
JOIN (SELECT MAX(kjmo) AS kjmo
            FROM DBP_DATA.art_nielsen_fakten_kjmo
            WHERE mandant_id = ${mandant_id}) x
  ON 1 = 1
WHERE a.umsatz_brutto > 0 AND
      a.menge > 0
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.art_kl_preislage_zu_per SET sm_id = 'N/A'
WHERE sm_id = '-1'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_kl_preislage_zu_per (mandant_id
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
      ,k.nach_wrg_id AS wrg_id
      ,sm_id
      ,ksm_id
      ,owg_id
      ,wg_id
      ,wug_id
      ,vk_brutto_pk_1 * k.umrechnungskurs
      ,durchschnitt_preis_kasse * k.umrechnungskurs
      ,umsatz_brutto * k.umrechnungskurs
      ,umsatz_brutto_af * k.umrechnungskurs
      ,umsatz_brutto_sa * k.umrechnungskurs
      ,menge
      ,menge_af
      ,menge_sa 
FROM DBP_DATA.art_kl_preislage_zu_per p
INNER JOIN (SELECT  von_wrg_id,nach_wrg_id,MAX(umrechnungskurs) umrechnungskurs FROM DBP_DATA.kurs WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD') GROUP BY 1,2) k
ON k.von_wrg_id = p.wrg_id
AND k.nach_wrg_id = 'EUR'

WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
      mandant_id IN (2,3,4,6,7,8) AND
      kjwo_update IN (SELECT kjwo FROM DBP_DATA.woche WHERE akt_wo = 1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_nielsen_preislage_zu_per (mandant_id
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
SELECT mandant_id
      ,art_matching_id
      ,kjmo
      ,k.nach_wrg_id AS wrg_id
      ,kl_art_kat_id
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,hwg_id
      ,owg_id
      ,wg_id
      ,wug_id
      ,durchschnitt_preis_kasse * k.umrechnungskurs
      ,umsatz_brutto * k.umrechnungskurs
      ,umsatz_brutto_af * k.umrechnungskurs
      ,umsatz_brutto_sa * k.umrechnungskurs
      ,menge
      ,menge_af
      ,menge_sa
FROM DBP_DATA.art_nielsen_preislage_zu_per p
INNER JOIN (SELECT von_wrg_id,nach_wrg_id,MAX(umrechnungskurs) umrechnungskurs FROM DBP_DATA.kurs WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD') GROUP BY 1,2) k
ON k.von_wrg_id = p.wrg_id
AND k.nach_wrg_id = 'EUR'

WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
                       FROM DBP_DATA.art_nielsen_fakten_kjmo
                       WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
      mandant_id IN (2,3,4,6,7,8)
;

