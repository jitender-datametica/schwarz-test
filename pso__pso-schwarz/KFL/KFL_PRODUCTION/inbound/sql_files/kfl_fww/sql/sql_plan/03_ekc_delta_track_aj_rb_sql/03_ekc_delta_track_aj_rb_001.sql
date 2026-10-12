--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _xxx_ums_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       Sum(a.umsatz_netto_ais) AS umsatz_netto_ais,
       Sum(a.betrag_kmep_km_ais) AS betrag_kmep_km_ais,
       Sum(a.betrag_kmep_kw_ais) AS betrag_kmep_kw_ais,
       Sum(a.betrag_kmep_ww_ais) AS betrag_kmep_ww_ais
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             a.dat,
             Sum(a.umsatz_netto_) AS umsatz_netto_ais,
             Sum(Cast(a.umsatz_netto_ AS FLOAT)-Cast(a.ek_mep_einstandspreis__ AS FLOAT)) AS betrag_kmep_km_ais,
             Sum(Cast(a.umsatz_netto_ AS FLOAT)-Cast(a.wa_kalk_kw_ AS FLOAT)) AS betrag_kmep_kw_ais,
             Sum(Cast(a.umsatz_netto_ AS FLOAT)-Cast(a.wa_kalk_ww_ AS FLOAT)) AS betrag_kmep_ww_ais
      FROM DBP_ETL_PROCESS.ekc_artbew a
      WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag WHERE akt_mo = (-1)*${MONAT}) AND (SELECT Max(dat) FROM DBP_DATA.tag WHERE akt_mo = (-1)*${MONAT}) AND
            a.dat >= '2019-01-01' AND
            a.dat < CURRENT_DATE
      GROUP BY 1,2,3,4
      HAVING umsatz_netto_ais <> 0 OR
             betrag_kmep_km_ais <> 0 OR
             betrag_kmep_kw_ais <> 0 OR
             betrag_kmep_ww_ais <> 0) a
LEFT JOIN (SELECT a.mandant_id,
                  a.wup_id,
                  a.art_id,
                  a.dat,
                  Max(a.zek_id) AS zek_id,
                  Sum(a.umsatz_netto) AS umsatz_netto_ekc,
                  Sum(a.betrag_kmep_km) AS betrag_kmep_km_ekc,
                  Sum(a.betrag_kmep_kw) AS betrag_kmep_kw_ekc,
                  Sum(a.betrag_kmep_ww) AS betrag_kmep_ww_ekc
           FROM DBP_DATA.artbew_dat_ek_cp_sum  a
           JOIN DBP_DATA.mandant b
             ON a.mandant_id = b.mandant_id AND
                a.wrg_id = b.default_wrg
           WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag WHERE akt_mo = (-1)*${MONAT}) AND (SELECT Max(dat) FROM DBP_DATA.tag WHERE akt_mo = (-1)*${MONAT}) AND
                 a.dat >= '2019-01-01' AND
                 a.dat < CURRENT_DATE AND
                 a.menge = 0 AND
                 a.wup_bereinigt_fg = 0
           GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
     Round(Cast(a.umsatz_netto_ais AS DECIMAL(18,4)),0) = Round(Cast(b.umsatz_netto_ekc AS DECIMAL(18,4)),0) AND
     a.betrag_kmep_kw_ais BETWEEN b.betrag_kmep_kw_ekc-0.10 AND b.betrag_kmep_kw_ekc+0.10 AND
     a.betrag_kmep_ww_ais BETWEEN b.betrag_kmep_ww_ekc-0.10 AND b.betrag_kmep_ww_ekc+0.10 AND
     a.betrag_kmep_km_ais BETWEEN b.betrag_kmep_km_ekc-0.10 AND b.betrag_kmep_km_ekc+0.10 
WHERE b.zek_id IS NULL
GROUP BY 1,2,3,4
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
--original statement
--CREATE MULTISET VOLATILE TABLE #zeitraum_${TRANSIENT_TABLE_SUFFIX} AS (
--SELECT a.mandant_id,
--       a.wup_id,
--       b.dat,
--       a.art_id,
--      (b.dat/100 + 190000) AS kjmo,
--       CASE
--         WHEN Extract(YEAR From b.dat) MOD 4 = 0 AND
--              Extract(MONTH From b.dat) >= 3
--         THEN 366
--         ELSE 365
--       END AS days_back
--FROM #xxx_ums_${TRANSIENT_TABLE_SUFFIX} a
--JOIN ${DWH_COMMON_DBX_DATA}.tag b
--  ON (a.dat/100 + 190000) = b.kjmo
--WHERE a.dat < DATE
--GROUP BY 1,2,3,4,5,6
--) WITH DATA
--  PRIMARY INDEX (dat,kjmo)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--error line 8 at position 39 unexpected 'MOD'.
--         WHEN Extract(YEAR From b.dat)  ^^^> MOD 4 = 0 AND
--syntax error line 8 at position 43 unexpected '4'.
--         WHEN Extract(YEAR From b.dat) MOD  ^^^> 4 = 0 AND
--syntax error line 15 at position 5 unexpected '('.
--  ON  ^^^> (a.dat/100 + 190000) = b.kjmo
--translated statement
CREATE OR REPLACE TRANSIENT TABLE _zeitraum_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       b.dat,
       a.art_id,
      (b.dat/100 + 190000) AS kjmo,
       CASE
         WHEN Extract(YEAR From b.dat) MOD 4 = 0 AND
              Extract(MONTH From b.dat) >= 3
         THEN 366
         ELSE 365
       END AS days_back
FROM _xxx_ums_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.tag b
  ON (a.dat/100 + 190000) = b.kjmo
WHERE a.dat < CURRENT_DATE
GROUP BY 1,2,3,4,5,6
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ekc_rb;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.ekc_rb  (
  mandant_id BYTEINT,
  wup_id INTEGER,
  dat DATE,
  art_id INTEGER
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.tag_wa_kalk_final;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.tag_wa_kalk_final  (
      mandant_id BYTEINT,
      art_id INTEGER,
      bewart_id SMALLINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      dat DATE,
      wrg_id CHAR(3) COLLATE 'en-ci',
      zek_id SMALLINT,
      eigenmarke_fg BYTEINT,
      wup_bereinigt_fg BYTEINT,
      umsatz_netto DECIMAL(18,4),
      umsatz_netto_vj DECIMAL(18,4),
      umsatz_netto_vj_km DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      logkostenzuschlag_vj DECIMAL(18,4),
      logkostenzuschlag_vj_km DECIMAL(18,4),
      betrag_kmep_km FLOAT,
      betrag_kmep_km_vj FLOAT,
      betrag_kmep_kw FLOAT,
      betrag_kmep_kw_vj FLOAT,
      betrag_kmep_ww FLOAT,
      betrag_kmep_ww_vj FLOAT,
      werbe_abschrift_netto DECIMAL(18,4) NOT NULL,
      werbe_abschrift_netto_vj DECIMAL(18,4) NOT NULL,
      werbe_abschrift_netto_vj_km DECIMAL(18,4) NOT NULL,
      preis_abschrift_netto DECIMAL(18,4) NOT NULL,
      preis_abschrift_netto_vj DECIMAL(18,4) NOT NULL,
      preis_abschrift_netto_vj_km DECIMAL(18,4) NOT NULL)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_XXX_UMS_5' does not exist or not authorized.
INSERT INTO DBP_ETL.ekc_rb (mandant_id,
                                           wup_id,
                                           dat,
                                           art_id)
SELECT a.mandant_id,
       a.wup_id,
       b.dat,
       a.art_id
FROM _xxx_ums_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.tag b
  ON ((a.dat+365)/100 + 190000) = b.kjmo
GROUP BY 1,2,3,4
UNION
SELECT a.mandant_id,
       a.wup_id,
       c.dat,
       a.art_id
FROM _xxx_ums_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.tag b
  ON ((a.dat+365)/100 + 190000) = b.kjmo
JOIN DBP_DATA.tag c
  ON b.akt_mo-1 = c.akt_mo
GROUP BY 1,2,3,4
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW' does not exist or not authorized.
INSERT INTO DBP_ETL.tag_wa_kalk_final (mandant_id
                                                     ,art_id
                                                     ,bewart_id
                                                     ,wup_id
                                                     ,nb_id
                                                     ,dat
                                                     ,wrg_id
                                                     ,zek_id
                                                     ,eigenmarke_fg
                                                     ,wup_bereinigt_fg
                                                     ,umsatz_netto
                                                     ,umsatz_netto_vj
                                                     ,umsatz_netto_vj_km
                                                     ,logkostenzuschlag
                                                     ,logkostenzuschlag_vj
                                                     ,logkostenzuschlag_vj_km
                                                     ,betrag_kmep_km
                                                     ,betrag_kmep_km_vj
                                                     ,betrag_kmep_kw
                                                     ,betrag_kmep_kw_vj
                                                     ,betrag_kmep_ww
                                                     ,betrag_kmep_ww_vj
                                                     ,werbe_abschrift_netto
                                                     ,werbe_abschrift_netto_vj
                                                     ,werbe_abschrift_netto_vj_km
                                                     ,preis_abschrift_netto
                                                     ,preis_abschrift_netto_vj
                                                     ,preis_abschrift_netto_vj_km)
SELECT z.mandant_id
      ,z.art_id
      ,z.bewart_id
      ,z.wup_id
      ,z.nb_id
      ,z.dat
      ,z.wrg_id
      ,z.zek_id
      ,z.eigenmarke_fg
      ,z.wup_bereinigt_fg
      ,Sum(z.umsatz_netto)
      ,Sum(z.umsatz_netto_vj)
      ,Sum(z.umsatz_netto_vj_km)
      ,Sum(z.logkostenzuschlag)
      ,Sum(z.logkostenzuschlag_vj)
      ,Sum(z.logkostenzuschlag_vj_km)
      ,Sum(z.betrag_kmep_km)
      ,Sum(z.betrag_kmep_km_vj)
      ,Sum(z.betrag_kmep_kw)
      ,Sum(z.betrag_kmep_kw_vj)
      ,Sum(z.betrag_kmep_ww)
      ,Sum(z.betrag_kmep_ww_vj)
      ,Sum(z.werbe_abschrift_netto)
      ,Sum(z.werbe_abschrift_netto_vj)
      ,Sum(z.werbe_abschrift_netto_vj_km)
      ,Sum(z.preis_abschrift_netto)
      ,Sum(z.preis_abschrift_netto_vj)
      ,Sum(z.preis_abschrift_netto_vj_km)
FROM (
SELECT a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       b.default_wrg AS wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       a.umsatz_netto_ AS umsatz_netto,
       Cast(0 AS DECIMAL(18,4)) AS umsatz_netto_vj,
       Cast(0 AS DECIMAL(18,4)) AS umsatz_netto_vj_km,
       a.logkostenzuschlag,
       Cast(0 AS DECIMAL(18,4)) AS logkostenzuschlag_vj,
       Cast(0 AS DECIMAL(18,4)) AS logkostenzuschlag_vj_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis__ AS betrag_kmep_km,
       Cast(0 AS FLOAT) AS betrag_kmep_km_vj,
       a.umsatz_netto_-a.wa_kalk_kw_ AS betrag_kmep_kw,
       Cast(0 AS FLOAT) AS betrag_kmep_kw_vj,
       a.umsatz_netto_-a.wa_kalk_ww_ AS betrag_kmep_ww,
       Cast(0 AS FLOAT) AS betrag_kmep_ww_vj,
       Cast(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto,
       Cast(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj,
       Cast(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj_km,
       Cast(0 AS DECIMAL(18,4)) AS preis_abschrift_netto,
       Cast(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj,
       Cast(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj_km
FROM DBP_ETL_PROCESS.ekc_artbew a
JOIN DBP_DATA.mandant b
  ON a.mandant_id = b.mandant_id
JOIN DBP_ETL_PROCESS.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.dat = x.dat AND
     a.art_id = x.art_id
UNION ALL
SELECT a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat+364 AS dat,
       b.default_wrg AS wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       0 AS umsatz_netto,
       a.umsatz_netto_ AS umsatz_netto_vj,
       0 AS umsatz_netto_vj_km,
       0 AS logkostenzuschlag,
       a.logkostenzuschlag AS logkostenzuschlag_vj,
       0 AS logkostenzuschlag_vj_km,
       0 AS betrag_kmep_km,
       0 AS betrag_kmep_km_vj,
       0 AS betrag_kmep_kw,
       a.umsatz_netto_-a.wa_kalk_kw_ AS betrag_kmep_kw_vj,
       0 AS betrag_kmep_ww,
       a.umsatz_netto_-a.wa_kalk_ww_ AS betrag_kmep_ww_vj,
       0 AS werbe_abschrift_netto,
       0 AS werbe_abschrift_netto_vj,
       0 AS werbe_abschrift_netto_vj_km,
       0 AS preis_abschrift_netto,
       0 AS preis_abschrift_netto_vj,
       0 AS preis_abschrift_netto_vj_km
FROM DBP_ETL_PROCESS.ekc_artbew a
JOIN DBP_DATA.mandant b
  ON a.mandant_id = b.mandant_id
JOIN DBP_ETL_PROCESS.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.dat = x.dat-364 AND
     a.art_id = x.art_id
UNION ALL
SELECT a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat+x.days_back AS dat,
       b.default_wrg AS wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       0 AS umsatz_netto,
       0 AS umsatz_netto_vj,
       a.umsatz_netto_ AS umsatz_netto_vj_km,
       0 AS logkostenzuschlag,
       0 AS logkostenzuschlag_vj,
       a.logkostenzuschlag AS logkostenzuschlag_vj_km,
       0 AS betrag_kmep_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis__ AS betrag_kmep_km_vj,
       0 AS betrag_kmep_kw,
       0 AS betrag_kmep_kw_vj,
       0 AS betrag_kmep_ww,
       0 AS betrag_kmep_ww_vj,
       0 AS werbe_abschrift_netto,
       0 AS werbe_abschrift_netto_vj,
       0 AS werbe_abschrift_netto_vj_km,
       0 AS preis_abschrift_netto,
       0 AS preis_abschrift_netto_vj,
       0 AS preis_abschrift_netto_vj_km
FROM DBP_ETL_PROCESS.ekc_artbew a
JOIN DBP_DATA.mandant b
  ON a.mandant_id = b.mandant_id
JOIN DBP_ETL_PROCESS.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.dat = x.dat-x.days_back AND
     a.art_id = x.art_id
WHERE a.dat+x.days_back NOT IN (1200229)) z
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.TAG_WA_KALK_FINAL' does not exist or not authorized.
INSERT INTO DBP_ETL.tag_wa_kalk_final (mandant_id
                                        ,art_id
                                        ,bewart_id
                                        ,wup_id
                                        ,nb_id
                                        ,dat
                                        ,wrg_id
                                        ,wup_bereinigt_fg
                                        ,zek_id
                                        ,eigenmarke_fg
                                        ,umsatz_netto
                                        ,umsatz_netto_vj
                                        ,umsatz_netto_vj_km
                                        ,logkostenzuschlag
                                        ,logkostenzuschlag_vj
                                        ,logkostenzuschlag_vj_km
                                        ,betrag_kmep_km
                                        ,betrag_kmep_km_vj
                                        ,betrag_kmep_kw
                                        ,betrag_kmep_kw_vj
                                        ,betrag_kmep_ww
                                        ,betrag_kmep_ww_vj
                                        ,werbe_abschrift_netto
                                        ,werbe_abschrift_netto_vj
                                        ,werbe_abschrift_netto_vj_km
                                        ,preis_abschrift_netto
                                        ,preis_abschrift_netto_vj
                                        ,preis_abschrift_netto_vj_km)
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,1 AS wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.umsatz_netto_vj_km
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.logkostenzuschlag_vj_km
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.werbe_abschrift_netto_vj_km
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.preis_abschrift_netto_vj_km
FROM DBP_ETL.tag_wa_kalk_final a
JOIN DBP_DATA.tag x1
  ON a.dat = x1.dat
JOIN DBP_DATA.wup x2
  ON a.mandant_id = x2.mandant_id AND 
     a.nb_id = x2.nb_id AND 
     a.wup_id = x2.wup_id
WHERE x1.wo_dat_von >= Add_Months(x2.dat_von,12) AND
      x1.wo_dat_bis <= x2.dat_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.tag_wa_kalk_final (mandant_id
                                        ,art_id
                                        ,bewart_id
                                        ,wup_id
                                        ,nb_id
                                        ,dat
                                        ,wrg_id
                                        ,wup_bereinigt_fg
                                        ,zek_id
                                        ,eigenmarke_fg
                                        ,umsatz_netto
                                        ,umsatz_netto_vj
                                        ,umsatz_netto_vj_km
                                        ,logkostenzuschlag
                                        ,logkostenzuschlag_vj
                                        ,logkostenzuschlag_vj_km
                                        ,betrag_kmep_km
                                        ,betrag_kmep_km_vj
                                        ,betrag_kmep_kw
                                        ,betrag_kmep_kw_vj
                                        ,betrag_kmep_ww
                                        ,betrag_kmep_ww_vj
                                        ,werbe_abschrift_netto
                                        ,werbe_abschrift_netto_vj
                                        ,werbe_abschrift_netto_vj_km
                                        ,preis_abschrift_netto
                                        ,preis_abschrift_netto_vj
                                        ,preis_abschrift_netto_vj_km)
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,'EUR' AS wrg_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.umsatz_netto*d1.umrechnungskurs
      ,a.umsatz_netto_vj*d1.umrechnungskurs
      ,a.umsatz_netto_vj_km*d1.umrechnungskurs
      ,a.logkostenzuschlag*d1.umrechnungskurs
      ,a.logkostenzuschlag_vj*d1.umrechnungskurs
      ,a.logkostenzuschlag_vj_km*d1.umrechnungskurs
      ,a.betrag_kmep_km*d1.umrechnungskurs
      ,a.betrag_kmep_km_vj*d1.umrechnungskurs
      ,a.betrag_kmep_kw*d1.umrechnungskurs
      ,a.betrag_kmep_kw_vj*d1.umrechnungskurs
      ,a.betrag_kmep_ww*d1.umrechnungskurs
      ,a.betrag_kmep_ww_vj*d1.umrechnungskurs
      ,a.werbe_abschrift_netto*d1.umrechnungskurs
      ,a.werbe_abschrift_netto_vj*d1.umrechnungskurs
      ,a.werbe_abschrift_netto_vj_km*d1.umrechnungskurs
      ,a.preis_abschrift_netto*d1.umrechnungskurs
      ,a.preis_abschrift_netto_vj*d1.umrechnungskurs
      ,a.preis_abschrift_netto_vj_km*d1.umrechnungskurs
FROM DBP_ETL.tag_wa_kalk_final a
JOIN DBP_DATA.kurs d1
  ON a.wrg_id = d1.von_wrg_id AND
     d1.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
     d1.nach_wrg_id = 'EUR' AND
     d1.kurstyp_id = 3
WHERE a.mandant_id IN (2,3,4,6,7,8)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_5' does not exist or not authorized.
DELETE FROM DBP_DATA.artbew_dat_ek_cp_sum
WHERE (mandant_id,wup_id,art_id,dat) IN (SELECT mandant_id,wup_id,art_id,dat FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      menge = 0
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_dat_ek_cp_sum (mandant_id
                                           ,art_id
                                           ,bewart_id
                                           ,wup_id
                                           ,nb_id
                                           ,dat
                                           ,wrg_id
                                           ,zek_id
                                           ,eigenmarke_fg
                                           ,wup_bereinigt_fg
                                           ,umsatz_netto
                                           ,umsatz_netto_vj
                                           ,logkostenzuschlag
                                           ,logkostenzuschlag_vj
                                           ,betrag_kmep_kw
                                           ,betrag_kmep_kw_vj
                                           ,betrag_kmep_ww
                                           ,betrag_kmep_ww_vj
                                           ,werbe_abschrift_netto
                                           ,werbe_abschrift_netto_vj
                                           ,preis_abschrift_netto
                                           ,preis_abschrift_netto_vj
                                           ,betrag_kmep_km
                                           ,betrag_kmep_km_vj)
SELECT mandant_id
      ,art_id
      ,bewart_id
      ,wup_id
      ,nb_id
      ,dat
      ,wrg_id
      ,zek_id
      ,eigenmarke_fg
      ,wup_bereinigt_fg
      ,umsatz_netto
      ,umsatz_netto_vj
      ,logkostenzuschlag
      ,logkostenzuschlag_vj
      ,betrag_kmep_kw
      ,betrag_kmep_kw_vj
      ,betrag_kmep_ww
      ,betrag_kmep_ww_vj
      ,werbe_abschrift_netto
      ,werbe_abschrift_netto_vj
      ,preis_abschrift_netto
      ,preis_abschrift_netto_vj
      ,betrag_kmep_km
      ,betrag_kmep_km_vj
FROM DBP_ETL.tag_wa_kalk_final
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_5' does not exist or not authorized.
DELETE FROM DBP_DATA.artbew_mo_ek_cp_sum
WHERE (mandant_id,wup_id,art_id,kjmo) IN (SELECT mandant_id,wup_id,art_id,kjmo FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      preis_abschrift_netto = 0 AND
      preis_abschrift_netto_vj = 0 AND
      werbe_abschrift_netto = 0 AND
      werbe_abschrift_netto_vj = 0
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.artbew_mo_ek_cp_sum (mandant_id
--                                          ,art_id
--                                          ,bewart_id
--                                          ,wup_id
--                                          ,nb_id
--                                          ,kjmo
--                                          ,wrg_id
--                                          ,wup_bereinigt_fg
--                                          ,zek_id
--                                          ,eigenmarke_fg
--                                          ,umsatz_netto
--                                          ,umsatz_netto_vj
--                                          ,betrag_kmep
--                                          ,betrag_kmep_vj
--                                          ,logkostenzuschlag
--                                          ,logkostenzuschlag_vj
--                                          ,werbe_abschrift_netto
--                                          ,werbe_abschrift_netto_vj
--                                          ,preis_abschrift_netto
--                                          ,preis_abschrift_netto_vj)
--SELECT mandant_id
--      ,art_id
--      ,bewart_id
--      ,wup_id
--      ,nb_id
--      ,(dat/100 + 190000) AS kjmo
--      ,wrg_id
--      ,wup_bereinigt_fg
--      ,zek_id
--      ,eigenmarke_fg
--      ,Sum(umsatz_netto)
--      ,Sum(umsatz_netto_vj_km)
--      ,Sum(betrag_kmep_km)
--      ,Sum(betrag_kmep_km_vj)
--      ,Sum(logkostenzuschlag)
--      ,Sum(logkostenzuschlag_vj_km)
--      ,Sum(werbe_abschrift_netto)
--      ,Sum(werbe_abschrift_netto_vj_km)
--      ,Sum(preis_abschrift_netto)
--      ,Sum(preis_abschrift_netto_vj_km)
--FROM ${DWH_COMMON_DBX_LOAD}.tag_wa_kalk_final
--WHERE preis_abschrift_netto = 0 AND
--      preis_abschrift_netto_vj_km = 0 AND
--      werbe_abschrift_netto = 0 AND
--      werbe_abschrift_netto_vj_km = 0 AND
--      dat < DATE-1
--GROUP BY 1,2,3,4,5,6,7,8,9,10
--;
--
--Comment from validation checker
--error line 26 at position 11
--      ,(dat ^^^> /100 + 190000) AS kjmo
--Invalid argument types for function '/': (DATE, NUMBER(3,0))
--translated statement
INSERT INTO DBP_DATA.artbew_mo_ek_cp_sum (mandant_id
                                          ,art_id
                                          ,bewart_id
                                          ,wup_id
                                          ,nb_id
                                          ,kjmo
                                          ,wrg_id
                                          ,wup_bereinigt_fg
                                          ,zek_id
                                          ,eigenmarke_fg
                                          ,umsatz_netto
                                          ,umsatz_netto_vj
                                          ,betrag_kmep
                                          ,betrag_kmep_vj
                                          ,logkostenzuschlag
                                          ,logkostenzuschlag_vj
                                          ,werbe_abschrift_netto
                                          ,werbe_abschrift_netto_vj
                                          ,preis_abschrift_netto
                                          ,preis_abschrift_netto_vj)
SELECT mandant_id
      ,art_id
      ,bewart_id
      ,wup_id
      ,nb_id
      ,(dat/100 + 190000) AS kjmo
      ,wrg_id
      ,wup_bereinigt_fg
      ,zek_id
      ,eigenmarke_fg
      ,Sum(umsatz_netto)
      ,Sum(umsatz_netto_vj_km)
      ,Sum(betrag_kmep_km)
      ,Sum(betrag_kmep_km_vj)
      ,Sum(logkostenzuschlag)
      ,Sum(logkostenzuschlag_vj_km)
      ,Sum(werbe_abschrift_netto)
      ,Sum(werbe_abschrift_netto_vj_km)
      ,Sum(preis_abschrift_netto)
      ,Sum(preis_abschrift_netto_vj_km)
FROM DBP_ETL.tag_wa_kalk_final
WHERE preis_abschrift_netto = 0 AND
      preis_abschrift_netto_vj_km = 0 AND
      werbe_abschrift_netto = 0 AND
      werbe_abschrift_netto_vj_km = 0 AND
      dat < CURRENT_DATE-1
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_5' does not exist or not authorized.
INSERT INTO DBP_ETL_DATA_CLOUD_SYNC.t_cdc_artbew_dat_ek_cp_sum (mandant_id,
                                                                          wup_id,
                                                                          dat,
                                                                          art_id,
                                                                          log_operation,
                                                                          log_ts)
SELECT mandant_id,
       wup_id,
       dat,
       art_id,
       'D' AS log_operation,
       CURRENT_TIMESTAMP AS log_ts
FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_5' does not exist or not authorized.
INSERT INTO DBP_ETL_DATA_CLOUD_SYNC.t_cdc_artbew_mo_ek_cp_sum (mandant_id,
                                                                         wup_id,
                                                                         kjmo,
                                                                         art_id,
                                                                         log_operation,
                                                                         log_ts)
SELECT mandant_id,
       wup_id,
      (dat/100 + 190000) AS kjmo,
       art_id,
       'D' AS log_operation,
       CURRENT_TIMESTAMP AS log_ts
FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6
;

