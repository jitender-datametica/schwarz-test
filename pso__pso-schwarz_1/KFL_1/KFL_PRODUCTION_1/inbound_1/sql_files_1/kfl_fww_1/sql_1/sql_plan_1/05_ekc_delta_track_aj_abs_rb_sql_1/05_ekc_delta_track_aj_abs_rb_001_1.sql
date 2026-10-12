--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.EKC_PREIS_ABSCHRIFTEN_1' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _xxx_pa_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       Sum(a.pa_ais) AS pa_ais_,
       Sum(b.pa_ekc) AS pa_ekc_
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             a.dat,
             Sum(CASE
                   WHEN a.mandant_id = 1
                   THEN a.preis_abschrift_netto*(-1)
                   ELSE a.preis_abschrift_netto
                 END) AS pa_ais
      FROM DBP_ETL.ekc_preis_abschriften_1 a
      WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND (SELECT Max(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND
            a.dat >= '2019-01-01' AND
            a.dat < CURRENT_DATE
      GROUP BY 1,2,3,4) a
LEFT JOIN (SELECT a.mandant_id,
                  a.wup_id,
                  a.art_id,
                  a.dat,
                  Max(a.zek_id) AS zek_id,
                  Sum(a.preis_abschrift_netto) AS pa_ekc
           FROM DBP_DATA.artbew_dat_ek_cp_sum_1  a
           JOIN DBP_DATA.mandant_1 b
             ON a.mandant_id = b.mandant_id AND
                a.wrg_id = b.default_wrg
           WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND (SELECT Max(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND
                 a.dat >= '2019-01-01' AND
                 a.dat < CURRENT_DATE AND
                 a.menge = 1 AND
                 a.wup_bereinigt_fg = 0
           GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
    Cast(a.pa_ais AS DECIMAL(18,2)) BETWEEN b.pa_ekc-0.02 AND b.pa_ekc+0.02
WHERE b.zek_id IS NULL
GROUP BY 1,2,3,4
HAVING pa_ais_ <> Coalesce(pa_ekc_,0)
);

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _xxx_wa_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       Sum(a.wa_ais) AS wa_ais_,
       Sum(b.wa_ekc) AS wa_ekc_
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             a.dat,
             Sum(a.werbe_abschrift_netto) AS wa_ais
      FROM DBP_ETL.ekc_werbe_abschriften_1 a
      WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND (SELECT Max(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND
            a.dat >= '2019-01-01' AND
            a.dat < CURRENT_DATE
      GROUP BY 1,2,3,4) a
LEFT JOIN (SELECT a.mandant_id,
                  a.wup_id,
                  a.art_id,
                  a.dat,
                  Max(a.zek_id) AS zek_id,
                  Sum(a.werbe_abschrift_netto) AS wa_ekc
           FROM DBP_DATA.artbew_dat_ek_cp_sum_1  a
           JOIN DBP_DATA.mandant_1 b
             ON a.mandant_id = b.mandant_id AND
                a.wrg_id = b.default_wrg
           WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND (SELECT Max(dat) FROM DBP_DATA.tag_1 WHERE akt_mo = (-1)*${MONAT_1}) AND
                 a.dat >= '2019-01-01' AND
                 a.dat < CURRENT_DATE AND
                 a.menge = 1 AND
                 a.wup_bereinigt_fg = 0
           GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
     a.wa_ais = b.wa_ekc 
WHERE b.zek_id IS NULL
GROUP BY 1,2,3,4
HAVING wa_ais_ <> Coalesce(wa_ekc_,0)
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_XXX_PA_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _xxx_abs_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       art_id
FROM _xxx_pa_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4
UNION
SELECT mandant_id,
       wup_id,
       dat,
       art_id
FROM _xxx_wa_${TRANSIENT_TABLE_SUFFIX}
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
--FROM #xxx_abs_${TRANSIENT_TABLE_SUFFIX} a
--JOIN ${DWH_COMMON_DBX_DATA}.tag_1 b
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
FROM _xxx_abs_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.tag_1 b
  ON (a.dat/100 + 190000) = b.kjmo
WHERE a.dat < CURRENT_DATE
GROUP BY 1,2,3,4,5,6
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ekc_rb_abs_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.ekc_rb_abs_1  (
  mandant_id BYTEINT,
  wup_id INTEGER,
  dat DATE,
  art_id INTEGER
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.tag_wa_kalk_final_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.tag_wa_kalk_final_1  (
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
--Object '_XXX_ABS_7' does not exist or not authorized.
INSERT INTO DBP_ETL.ekc_rb_abs_1 (mandant_id,
                                               wup_id,
                                               dat,
                                               art_id)
SELECT a.mandant_id,
       a.wup_id,
       b.dat,
       a.art_id
FROM _xxx_abs_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.tag_1 b
  ON ((a.dat+365)/100 + 190000) = b.kjmo
GROUP BY 1,2,3,4
UNION
SELECT a.mandant_id,
       a.wup_id,
       c.dat,
       a.art_id
FROM _xxx_abs_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.tag_1 b
  ON ((a.dat+365)/100 + 190000) = b.kjmo
JOIN DBP_DATA.tag_1 c
  ON b.akt_mo-1 = c.akt_mo
GROUP BY 1,2,3,4
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _wabs_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.werbe_abschrift_netto
      ,Cast(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj
      ,Cast(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj_km
FROM DBP_ETL.ekc_werbe_abschriften_1 a
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _wabs_vj_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+364 AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.werbe_abschrift_netto AS werbe_abschrift_netto_vj
FROM DBP_ETL.ekc_werbe_abschriften_1 a
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat-364 AND
     a.art_id = b.art_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _wabs_vj_km_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+x.days_back AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,a.werbe_abschrift_netto AS werbe_abschrift_netto_vj_km
FROM DBP_ETL.ekc_werbe_abschriften_1 a
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} x
  ON a.dat = x.dat-x.days_back AND
     a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.art_id = x.art_id
WHERE a.dat+x.days_back NOT IN (1200229)
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_WABS_VJ_7' does not exist or not authorized.
MERGE INTO _wabs_${TRANSIENT_TABLE_SUFFIX} a USING (SELECT *
                          FROM _wabs_vj_${TRANSIENT_TABLE_SUFFIX}) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET werbe_abschrift_netto_vj = b.werbe_abschrift_netto_vj

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              werbe_abschrift_netto,
                              werbe_abschrift_netto_vj,
                              werbe_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              b.werbe_abschrift_netto_vj,
                              0)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_WABS_VJ_KM_7' does not exist or not authorized.
MERGE INTO _wabs_${TRANSIENT_TABLE_SUFFIX} a USING (SELECT *
                          FROM _wabs_vj_km_${TRANSIENT_TABLE_SUFFIX}) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET werbe_abschrift_netto_vj_km = b.werbe_abschrift_netto_vj_km

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              werbe_abschrift_netto,
                              werbe_abschrift_netto_vj,
                              werbe_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              0,
                              b.werbe_abschrift_netto_vj_km)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _pabs_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,CASE
         WHEN a.mandant_id = 1 
         THEN (-1) * a.preis_abschrift_netto
         ELSE a.preis_abschrift_netto
       END AS preis_abschrift_netto
      ,Cast(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj
      ,Cast(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj_km
FROM DBP_ETL.ekc_preis_abschriften_1 a
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _pabs_vj_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+364 AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,CASE
         WHEN a.mandant_id = 1 
         THEN (-1) * a.preis_abschrift_netto
         ELSE a.preis_abschrift_netto
       END AS preis_abschrift_netto_vj
FROM DBP_ETL.ekc_preis_abschriften_1 a
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat-364 AND
     a.art_id = b.art_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _pabs_vj_km_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat+x.days_back AS dat
      ,a.wrg_id
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.wup_bereinigt_fg
      ,CASE
         WHEN a.mandant_id = 1 
         THEN (-1) * a.preis_abschrift_netto
         ELSE a.preis_abschrift_netto
       END AS preis_abschrift_netto_vj_km
FROM DBP_ETL.ekc_preis_abschriften_1 a
JOIN _zeitraum_${TRANSIENT_TABLE_SUFFIX} x
  ON a.dat = x.dat-x.days_back AND
     a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.art_id = x.art_id
WHERE a.dat+x.days_back NOT IN (1200229)
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_PABS_VJ_7' does not exist or not authorized.
MERGE INTO _pabs_${TRANSIENT_TABLE_SUFFIX} a USING (SELECT *
                          FROM _pabs_vj_${TRANSIENT_TABLE_SUFFIX}) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET preis_abschrift_netto_vj = b.preis_abschrift_netto_vj

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              preis_abschrift_netto,
                              preis_abschrift_netto_vj,
                              preis_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              b.preis_abschrift_netto_vj,
                              0)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_PABS_VJ_KM_7' does not exist or not authorized.
MERGE INTO _pabs_${TRANSIENT_TABLE_SUFFIX} a USING (SELECT *
                          FROM _pabs_vj_km_${TRANSIENT_TABLE_SUFFIX}) b
                          
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.bewart_id = b.bewart_id AND
     a.dat = b.dat AND
     a.wrg_id = b.wrg_id

WHEN MATCHED THEN UPDATE SET preis_abschrift_netto_vj_km = b.preis_abschrift_netto_vj_km

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
                              bewart_id,
                              wup_id,
                              nb_id,
                              dat,
                              wrg_id,
                              wup_bereinigt_fg,
                              zek_id,
                              eigenmarke_fg,
                              preis_abschrift_netto,
                              preis_abschrift_netto_vj,
                              preis_abschrift_netto_vj_km)
                      VALUES (b.mandant_id,
                              b.art_id,
                              b.bewart_id,
                              b.wup_id,
                              b.nb_id,
                              b.dat,
                              b.wrg_id,
                              0,
                              b.zek_id,
                              b.eigenmarke_fg,
                              0,
                              0,
                              b.preis_abschrift_netto_vj_km)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_WABS_7' does not exist or not authorized.
INSERT INTO DBP_ETL.tag_wa_kalk_final_1 (mandant_id
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
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,0 AS umsatz_netto
      ,0 AS umsatz_netto_vj
      ,0 AS umsatz_netto_vj_km
      ,0 AS logkostenzuschlag
      ,0 AS logkostenzuschlag_vj
      ,0 AS logkostenzuschlag_vj_km
      ,0 AS betrag_kmep_km
      ,0 AS betrag_kmep_km_vj
      ,0 AS betrag_kmep_kw
      ,0 AS betrag_kmep_kw_vj
      ,0 AS betrag_kmep_ww
      ,0 AS betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.werbe_abschrift_netto_vj_km
      ,0 AS preis_abschrift_netto
      ,0 AS preis_abschrift_netto_vj
      ,0 AS preis_abschrift_netto_vj_km
FROM _wabs_${TRANSIENT_TABLE_SUFFIX} a
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_PABS_7' does not exist or not authorized.
INSERT INTO DBP_ETL.tag_wa_kalk_final_1 (mandant_id
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
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,0 AS umsatz_netto
      ,0 AS umsatz_netto_vj
      ,0 AS umsatz_netto_vj_km
      ,0 AS logkostenzuschlag
      ,0 AS logkostenzuschlag_vj
      ,0 AS logkostenzuschlag_vj_km
      ,0 AS betrag_kmep_km
      ,0 AS betrag_kmep_km_vj
      ,0 AS betrag_kmep_kw
      ,0 AS betrag_kmep_kw_vj
      ,0 AS betrag_kmep_ww
      ,0 AS betrag_kmep_ww_vj
      ,0 AS werbe_abschrift_netto
      ,0 AS werbe_abschrift_netto_vj
      ,0 AS werbe_abschrift_netto_vj_km
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.preis_abschrift_netto_vj_km
FROM _pabs_${TRANSIENT_TABLE_SUFFIX} a
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.tag_wa_kalk_final_1 (mandant_id
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
FROM DBP_ETL.tag_wa_kalk_final_1 a
JOIN DBP_DATA.tag_1 x1
  ON a.dat = x1.dat
JOIN DBP_DATA.wup_1 x2
  ON a.mandant_id = x2.mandant_id AND 
     a.nb_id = x2.nb_id AND 
     a.wup_id = x2.wup_id
WHERE x1.wo_dat_von >= Add_Months(x2.dat_von,12) AND
      x1.wo_dat_bis <= x2.dat_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.tag_wa_kalk_final_1 (mandant_id
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
FROM DBP_ETL.tag_wa_kalk_final_1 a
JOIN DBP_DATA.kurs_1 d1
  ON a.wrg_id = d1.von_wrg_id AND
     d1.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
     d1.nach_wrg_id = 'EUR' AND
     d1.kurstyp_id = 3
WHERE a.mandant_id IN (2,3,4,6,7,8)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
DELETE FROM DBP_DATA.artbew_dat_ek_cp_sum_1
WHERE (mandant_id,wup_id,art_id,dat) IN (SELECT mandant_id,wup_id,art_id,dat FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
       menge = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_dat_ek_cp_sum_1 (mandant_id
                                           ,art_id
                                           ,bewart_id
                                           ,wup_id
                                           ,nb_id
                                           ,dat
                                           ,wrg_id
                                           ,zek_id
                                           ,eigenmarke_fg
                                           ,wup_bereinigt_fg
                                           ,menge
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
                                           ,preis_abschrift_netto_vj)
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
      ,1 AS menge
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
FROM DBP_ETL.tag_wa_kalk_final_1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
DELETE FROM DBP_DATA.artbew_mo_ek_cp_sum_1
WHERE (mandant_id,wup_id,art_id,kjmo) IN (SELECT mandant_id,wup_id,art_id,kjmo FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      (preis_abschrift_netto <> 0 OR
       preis_abschrift_netto_vj <> 0 OR
       werbe_abschrift_netto <> 0 OR
       werbe_abschrift_netto_vj <> 0)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
INSERT INTO DBP_DATA.artbew_mo_ek_cp_sum_1 (mandant_id
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
      ,Sum(umsatz_netto_vj)
      ,Sum(betrag_kmep_km)
      ,Sum(betrag_kmep_km_vj)
      ,Sum(logkostenzuschlag)
      ,Sum(logkostenzuschlag_vj)
      ,Sum(werbe_abschrift_netto)
      ,Sum(werbe_abschrift_netto_vj_km)
      ,Sum(preis_abschrift_netto)
      ,Sum(preis_abschrift_netto_vj_km)
FROM DBP_ETL.tag_wa_kalk_final_1
WHERE (mandant_id,wup_id,art_id,kjmo) IN (SELECT mandant_id,wup_id,art_id,kjmo FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
       dat < CURRENT_DATE-1 AND
      (preis_abschrift_netto <> 0 OR
       preis_abschrift_netto_vj_km <> 0 OR
       werbe_abschrift_netto <> 0 OR
       werbe_abschrift_netto_vj_km <> 0)
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_7' does not exist or not authorized.
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
--Object '_ZEITRAUM_7' does not exist or not authorized.
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

