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
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_AGG_WT_BACKLOG' does not exist or not authorized.
INSERT INTO dbp_etl_data_cloud_sync.t_cdc_artbew_dat_ek_cp_sum (mandant_id,
                                                                wup_id,
                                                                dat,
                                                                log_operation,
                                                                log_ts)
SELECT mandant_id,
       wup_id,
       dat,
       'D' AS log_operation,
       CURRENT_TIMESTAMP AS log_ts
FROM DBP_ETL_PROCESS.ekc_artbew_agg_wt_backlog
GROUP BY 1,2,3,4,5
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_AGG_WT_BACKLOG' does not exist or not authorized.
INSERT INTO dbp_etl_data_cloud_sync.t_cdc_artbew_mo_ek_cp_sum (mandant_id,
                                                               wup_id,
                                                               kjmo,
                                                               log_operation,
                                                               log_ts)
SELECT a.mandant_id,
       a.wup_id,
       b.kjmo,
       'D' AS log_operation,
       CURRENT_TIMESTAMP AS log_ts
FROM DBP_ETL_PROCESS.ekc_artbew_agg_wt_backlog a
JOIN DBP_DATA.tag b
  ON a.dat = b.dat
GROUP BY 1,2,3,4,5
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
--original statement
--CREATE SET VOLATILE TABLE #zeitraum_${TRANSIENT_TABLE_SUFFIX} AS (
--SELECT a.dat,
--       a.kjmo,
--       CASE
--         WHEN Extract(YEAR From a.dat) MOD 4 = 0 AND
--              Extract(MONTH From a.dat) >= 3
--         THEN 366
--         ELSE 365
--       END AS days_back
--FROM DBX_DATA.tag a
--JOIN (SELECT kjmo
--      FROM DBX_DATA.tag
--      WHERE dat IN (SELECT MIN(dat) FROM DBX_PROCESS.ekc_artbew_agg_wt_backlog)
--      UNION
--      SELECT kjmo
--      FROM DBX_DATA.tag
--      WHERE dat IN (SELECT MAX(dat) FROM DBX_PROCESS.ekc_artbew_agg_wt_backlog)) b
--  ON a.kjmo = b.kjmo
--WHERE a.dat < DATE
--) WITH DATA
--  PRIMARY INDEX (dat,kjmo)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--error line 5 at position 39 unexpected 'MOD'.
--         WHEN Extract(YEAR From a.dat)  ^^^> MOD 4 = 0 AND
--syntax error line 5 at position 43 unexpected '4'.
--         WHEN Extract(YEAR From a.dat) MOD  ^^^> 4 = 0 AND
--syntax error line 17 at position 90 unexpected ')'.
--
--translated statement
CREATE OR REPLACE TRANSIENT TABLE _zeitraum_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.dat,
       a.kjmo,
       CASE
         WHEN Extract(YEAR From a.dat) MOD 4 = 0 AND
              Extract(MONTH From a.dat) >= 3
         THEN 366
         ELSE 365
       END AS days_back
FROM DBP_DATA.tag a
JOIN (SELECT kjmo
      FROM DBP_DATA.tag
      WHERE dat IN (SELECT MIN(dat) FROM DBP_ETL_PROCESS.ekc_artbew_agg_wt_backlog)
      UNION
      SELECT kjmo
      FROM DBP_DATA.tag
      WHERE dat IN (SELECT MAX(dat) FROM DBP_ETL_PROCESS.ekc_artbew_agg_wt_backlog)) b
  ON a.kjmo = b.kjmo
WHERE a.dat < CURRENT_DATE
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW' does not exist or not authorized.
DELETE FROM DBP_ETL_PROCESS.ekc_artbew
WHERE dat BETWEEN (SELECT MIN(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT MAX(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX})
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_32' does not exist or not authorized.
INSERT INTO DBP_ETL_PROCESS.ekc_artbew (mandant_id
                                                 ,art_id
                                                 ,bewart_id
                                                 ,wup_id
                                                 ,nb_id
                                                 ,dat
                                                 ,umsatz_netto_
                                                 ,logkostenzuschlag
                                                 ,ek_mep_einstandspreis_
                                                 ,menge_
                                                 ,bonus_stk_
                                                 ,bonus_stk_kw_
                                                 ,bonus_stk_ww_
                                                 ,ek_mep_einstandspreis__
                                                 ,wa_kalk_kw_
                                                 ,wa_kalk_ww_ )
SELECT a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       SUM(a.umsatz_netto) AS umsatz_netto_,
       SUM(a.logkostenzuschlag) AS logkostenzuschlag,
       SUM(a.ek_mep_einstandspreis) AS ek_mep_einstandspreis_,
       SUM(a.menge) AS menge_,
       SUM(COALESCE(b.bonus_stk,0)) AS bonus_stk_,
       SUM(COALESCE(c.bonus_stk,0)) AS bonus_stk_kw_,
       SUM(COALESCE(d.bonus_stk,0)) AS bonus_stk_ww_,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_) AS ek_mep_einstandspreis__,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_kw_) AS wa_kalk_kw_,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_ww_) AS wa_kalk_ww_
FROM (SELECT t1.mandant_id,
             t1.art_id,
             t1.bewart_id,
             t1.wup_id,
             t1.nb_id,
             t1.dat,
             SUM(t1.umsatz_netto) AS umsatz_netto,
             SUM(t1.logkostenzuschlag) AS logkostenzuschlag,
             SUM(CASE
                   WHEN t1.mandant_id = 1
                   THEN CAST((t1.ek_mep ) AS DECIMAL(18,4))
                   ELSE COALESCE(t1.ek_gld,0)
                 END) AS ek_mep_einstandspreis,
             SUM(t1.menge) AS menge
        FROM DBP_DATA.artbew t1
        WHERE t1.dat BETWEEN (SELECT MIN(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT MAX(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX})
        GROUP BY 1,2,3,4,5,6) a
LEFT JOIN (SELECT x.mandant_id,
                  x.art_id,
                  x.dat_von,
                  x.dat_bis,
                  (x.betrag_kmep_einh ) AS bonus_stk
           FROM (SELECT u.*
                 FROM DBP_ETL_PROCESS.ekc_artbew_kmep u
                 WHERE u.zeitraum_kz = 'KM') x) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.dat BETWEEN b.dat_von AND b.dat_bis
LEFT JOIN (SELECT x.mandant_id,
                  x.art_id,
                  x.dat_von,
                  x.dat_bis,
                  (x.betrag_kmep_einh ) AS bonus_stk
           FROM (SELECT u.*
                 FROM DBP_ETL_PROCESS.ekc_artbew_kmep u
                 WHERE u.zeitraum_kz = 'KW') x) c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     a.dat BETWEEN c.dat_von AND c.dat_bis
LEFT JOIN (SELECT x.mandant_id,
                  x.art_id,
                  x.dat_von,
                  x.dat_bis,
                  (x.betrag_kmep_einh ) AS bonus_stk
           FROM (SELECT u.*
                 FROM DBP_ETL_PROCESS.ekc_artbew_kmep u
                 WHERE u.zeitraum_kz = 'WW') x) d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     a.dat BETWEEN d.dat_von AND d.dat_bis
  GROUP BY 1,2,3,4,5,6
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK' does not exist or not authorized.
MERGE INTO DBP_ETL_PROCESS.ekc_zek a USING (SELECT a.mandant_id,
                                                             a.art_id,
                                                             a.zek_id,
                                                             CASE WHEN a.zek_id <> a.zek_vat_id THEN 1 ELSE 0 END AS eigenmarke_fg
                                                      FROM DBP_DATA.art a
                                                      JOIN DBP_DATA.art_wg_zu_per b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           b.arthiertyp_id = 2 AND
                                                           b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
                                                      JOIN DBP_DATA.wg_per c
                                                        ON a.mandant_id = c.mandant_id AND
                                                           b.wg_id = c.wg_id AND 
                                                           c.arthiertyp_id = 2 AND
                                                           c.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
						      WHERE a.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
                                                            a.mandant_id = 1 AND
                                                            c.abt_id NOT IN (8)
						      GROUP BY 1,2,3,4) b
									  
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
	 
WHEN MATCHED THEN UPDATE SET zek_id = b.zek_id,
                             eigenmarke_fg = b.eigenmarke_fg

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
			      zek_id,
                              eigenmarke_fg)
                      VALUES (b.mandant_id,
			      b.art_id,
			      b.zek_id,
                              b.eigenmarke_fg)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK' does not exist or not authorized.
MERGE INTO DBP_ETL_PROCESS.ekc_zek a USING (SELECT a.mandant_id,
                                                             a.art_id,
                                                             a.zek_id,
                                                             CASE WHEN a.eigenmarke_id <> '' THEN 1 ELSE 0 END AS eigenmarke_fg
                                                      FROM DBP_DATA.art a
                                                      JOIN DBP_DATA.art_wg_zu_per b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           b.arthiertyp_id = 2 AND
                                                           b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
                                                      JOIN DBP_DATA.wg_per c
                                                        ON a.mandant_id = c.mandant_id AND
                                                           b.wg_id = c.wg_id AND 
                                                           c.arthiertyp_id = 2 AND
                                                           c.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
						      WHERE a.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
                                                            a.mandant_id = 1 AND
                                                            c.abt_id IN (8)
						      GROUP BY 1,2,3,4) b
									  
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
	 
WHEN MATCHED THEN UPDATE SET zek_id = b.zek_id,
                             eigenmarke_fg = b.eigenmarke_fg

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
			      zek_id,
                              eigenmarke_fg)
                      VALUES (b.mandant_id,
			      b.art_id,
			      b.zek_id,
                              b.eigenmarke_fg)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK' does not exist or not authorized.
MERGE INTO DBP_ETL_PROCESS.ekc_zek a USING (SELECT a.mandant_id,
                                                             a.art_id,
                                                             a.zek_id,
                                                             CASE WHEN a.eigenmarke_id <> '' THEN 1 ELSE 0 END AS eigenmarke_fg
                                                      FROM DBP_DATA.art a
                                                      WHERE a.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
                                                            a.mandant_id > 1
						      GROUP BY 1,2,3,4) b
									  
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
	 
WHEN MATCHED THEN UPDATE SET zek_id = b.zek_id,
                             eigenmarke_fg = b.eigenmarke_fg

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              art_id,
			      zek_id,
                              eigenmarke_fg)
                      VALUES (b.mandant_id,
			      b.art_id,
			      b.zek_id,
                              b.eigenmarke_fg)
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
      ,SUM(z.umsatz_netto)
      ,SUM(z.umsatz_netto_vj)
      ,SUM(z.umsatz_netto_vj_km)
      ,SUM(z.logkostenzuschlag)
      ,SUM(z.logkostenzuschlag_vj)
      ,SUM(z.logkostenzuschlag_vj_km)
      ,SUM(z.betrag_kmep_km)
      ,SUM(z.betrag_kmep_km_vj)
      ,SUM(z.betrag_kmep_kw)
      ,SUM(z.betrag_kmep_kw_vj)
      ,SUM(z.betrag_kmep_ww)
      ,SUM(z.betrag_kmep_ww_vj)
      ,SUM(z.werbe_abschrift_netto)
      ,SUM(z.werbe_abschrift_netto_vj)
      ,SUM(z.werbe_abschrift_netto_vj_km)
      ,SUM(z.preis_abschrift_netto)
      ,SUM(z.preis_abschrift_netto_vj)
      ,SUM(z.preis_abschrift_netto_vj_km)
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
       CAST(0 AS DECIMAL(18,4)) AS umsatz_netto_vj,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_netto_vj_km,
       a.logkostenzuschlag,
       CAST(0 AS DECIMAL(18,4)) AS logkostenzuschlag_vj,
       CAST(0 AS DECIMAL(18,4)) AS logkostenzuschlag_vj_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis__ AS betrag_kmep_km,
       CAST(0 AS FLOAT) AS betrag_kmep_km_vj,
       a.umsatz_netto_-a.wa_kalk_kw_ AS betrag_kmep_kw,
       CAST(0 AS FLOAT) AS betrag_kmep_kw_vj,
       a.umsatz_netto_-a.wa_kalk_ww_ AS betrag_kmep_ww,
       CAST(0 AS FLOAT) AS betrag_kmep_ww_vj,
       CAST(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto,
       CAST(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj,
       CAST(0 AS DECIMAL(18,4)) AS werbe_abschrift_netto_vj_km,
       CAST(0 AS DECIMAL(18,4)) AS preis_abschrift_netto,
       CAST(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj,
       CAST(0 AS DECIMAL(18,4)) AS preis_abschrift_netto_vj_km
FROM DBP_ETL_PROCESS.ekc_artbew a
JOIN DBP_DATA.mandant b
  ON a.mandant_id = b.mandant_id
JOIN DBP_ETL_PROCESS.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.dat BETWEEN (SELECT MIN(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT MAX(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX})
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
WHERE a.dat BETWEEN (SELECT MIN(dat)-364 FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT MAX(dat)-364 FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX})
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
  ON a.dat = x.dat-x.days_back
WHERE a.dat+x.days_back NOT IN (1200229)) z
GROUP BY 1,2,3,4,5,6,7,8,9,10
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
WHERE x1.wo_dat_von >= ADD_MONTHS(x2.dat_von,12) AND
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
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_32' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _track_missings_dat_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.art_id,
       a.wup_bereinigt_fg,
       a.wrg_id,
       a.eigenmarke_fg
FROM DBP_DATA.artbew_dat_ek_cp_sum a
LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  dat,
                  art_id,
                  Max(zek_id) AS zek_id
           FROM DBP_ETL.tag_wa_kalk_final
           GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id
WHERE a.dat BETWEEN (SELECT Min(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT Max(dat)FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      b.zek_id IS NULL AND
      a.preis_abschrift_netto = 0 AND
      a.preis_abschrift_netto_vj = 0 AND
      a.werbe_abschrift_netto = 0 AND
      a.werbe_abschrift_netto_vj = 0 AND
      a.zek_id <> -9
GROUP BY 1,2,3,4,5,6,7
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_32' does not exist or not authorized.
CREATE OR REPLACE TRANSIENT TABLE _track_missings_kjmo_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.kjmo,
       a.art_id,
       a.wup_bereinigt_fg,
       a.wrg_id,
       a.eigenmarke_fg
FROM DBP_DATA.artbew_mo_ek_cp_sum a
LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  (dat/100 + 190000) AS kjmo,
                  art_id,
                  Max(zek_id) AS zek_id
           FROM DBP_ETL.tag_wa_kalk_final
           GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.kjmo = b.kjmo AND
     a.art_id = b.art_id
WHERE a.kjmo BETWEEN (SELECT Min(kjmo) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT Max(kjmo)FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      b.zek_id IS NULL AND
      a.preis_abschrift_netto = 0 AND
      a.preis_abschrift_netto_vj = 0 AND
      a.werbe_abschrift_netto = 0 AND
      a.werbe_abschrift_netto_vj = 0 AND
      a.zek_id <> -9
GROUP BY 1,2,3,4,5,6,7
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Table 'KFL_DEVELOPMENT.DBP_ETL_DATA_CLOUD_SYNC.T_CDC_ARTBEW_DAT_EK_CP_SUM' does not exist or not authorized.
INSERT INTO dbp_etl_data_cloud_sync.t_cdc_artbew_dat_ek_cp_sum (mandant_id
                                                               ,art_id
                                                               ,wup_id
                                                               ,dat
                                                               ,log_operation
                                                               ,log_ts)
SELECT mandant_id,
       art_id,
       wup_id,
       dat,
       'D' AS log_operation,
       Current_Timestamp AS log_ts
FROM DBP_ETL.tag_wa_kalk_final
GROUP BY 1,2,3,4,5,6
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_TRACK_MISSINGS_DAT_32' does not exist or not authorized.
INSERT INTO dbp_etl_data_cloud_sync.t_cdc_artbew_dat_ek_cp_sum (mandant_id
                                                               ,art_id
                                                               ,wup_id
                                                               ,dat
                                                               ,log_operation
                                                               ,log_ts)
SELECT mandant_id,
       art_id,
       wup_id,
       dat,
       'X' AS log_operation,
       CURRENT_TIMESTAMP AS log_ts
FROM _track_missings_dat_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Table 'KFL_DEVELOPMENT.DBP_ETL_DATA_CLOUD_SYNC.T_CDC_ARTBEW_MO_EK_CP_SUM' does not exist or not authorized.
INSERT INTO dbp_etl_data_cloud_sync.t_cdc_artbew_mo_ek_cp_sum (mandant_id
                                                              ,art_id
                                                              ,wup_id
                                                              ,kjmo
                                                              ,log_operation
                                                              ,log_ts)
SELECT mandant_id,
       art_id,
       wup_id,
       (dat/100 + 190000) AS kjmo,
       'D',
       Current_Timestamp
FROM DBP_ETL.tag_wa_kalk_final
GROUP BY 1,2,3,4,5,6
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_TRACK_MISSINGS_KJMO_32' does not exist or not authorized.
INSERT INTO dbp_etl_data_cloud_sync.t_cdc_artbew_mo_ek_cp_sum (mandant_id
                                                              ,art_id
                                                              ,wup_id
                                                              ,kjmo
                                                              ,log_operation
                                                              ,log_ts)
SELECT mandant_id,
       art_id,
       wup_id,
       kjmo,
       'X' AS log_operation,
       CURRENT_TIMESTAMP AS log_ts
FROM _track_missings_kjmo_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_ZEITRAUM_32' does not exist or not authorized.
DELETE FROM DBP_DATA.artbew_dat_ek_cp_sum
WHERE dat BETWEEN (SELECT MIN(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT MAX(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      preis_abschrift_netto = 0 AND
      preis_abschrift_netto_vj = 0 AND
      werbe_abschrift_netto = 0 AND
      werbe_abschrift_netto_vj = 0 AND
      zek_id <> -9
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
--Object '_ZEITRAUM_32' does not exist or not authorized.
DELETE FROM DBP_DATA.artbew_mo_ek_cp_sum
WHERE kjmo BETWEEN (SELECT MIN(kjmo) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT MAX(kjmo) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND
      preis_abschrift_netto = 0 AND
      preis_abschrift_netto_vj = 0 AND
      werbe_abschrift_netto = 0 AND
      werbe_abschrift_netto_vj = 0 AND
      zek_id <> -9
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.artbew_mo_ek_cp_sum (mandant_id
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
--      ,SUM(umsatz_netto)
--      ,SUM(umsatz_netto_vj_km)
--      ,SUM(betrag_kmep_km)
--      ,SUM(betrag_kmep_km_vj)
--      ,SUM(logkostenzuschlag)
--      ,SUM(logkostenzuschlag_vj_km)
--      ,SUM(werbe_abschrift_netto)
--      ,SUM(werbe_abschrift_netto_vj_km)
--      ,SUM(preis_abschrift_netto)
--      ,SUM(preis_abschrift_netto_vj_km)
--FROM DBX_LOAD.tag_wa_kalk_final
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
      ,SUM(umsatz_netto)
      ,SUM(umsatz_netto_vj_km)
      ,SUM(betrag_kmep_km)
      ,SUM(betrag_kmep_km_vj)
      ,SUM(logkostenzuschlag)
      ,SUM(logkostenzuschlag_vj_km)
      ,SUM(werbe_abschrift_netto)
      ,SUM(werbe_abschrift_netto_vj_km)
      ,SUM(preis_abschrift_netto)
      ,SUM(preis_abschrift_netto_vj_km)
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
--Object '_TRACK_MISSINGS_DAT_32' does not exist or not authorized.
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
SELECT mandant_id,
       art_id,
       1001 AS bewart_id,
       wup_id,
       0 AS nb_id,
       dat,
       wrg_id,
       -9 AS zek_id,
       eigenmarke_fg,
       wup_bereinigt_fg,
       0 AS umsatz_netto,
       0 AS umsatz_netto_vj,
       0 AS logkostenzuschlag,
       0 AS logkostenzuschlag_vj,
       0 AS betrag_kmep_kw,
       0 AS betrag_kmep_kw_vj,
       0 AS betrag_kmep_ww,
       0 AS betrag_kmep_ww_vj,
       0 AS werbe_abschrift_netto,
       0 AS werbe_abschrift_netto_vj,
       0 AS preis_abschrift_netto,
       0 AS preis_abschrift_netto_vj,
       0 AS betrag_kmep_km,
       0 AS betrag_kmep_km_vj
FROM _track_missings_dat_${TRANSIENT_TABLE_SUFFIX}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object '_TRACK_MISSINGS_KJMO_32' does not exist or not authorized.
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
SELECT mandant_id,
       art_id,
       1001 AS bewart_id,
       wup_id,
       0 AS nb_id,
       kjmo,
       wrg_id,
       wup_bereinigt_fg,
       -9 AS zek_id,
       eigenmarke_fg,
       0 AS umsatz_netto,
       0 AS umsatz_netto_vj,
       0 AS betrag_kmep,
       0 AS betrag_kmep_vj,
       0 AS logkostenzuschlag,
       0 AS logkostenzuschlag_vj,
       0 AS werbe_abschrift_netto,
       0 AS werbe_abschrift_netto_vj,
       0 AS preis_abschrift_netto,
       0 AS preis_abschrift_netto_vj
FROM _track_missings_kjmo_${TRANSIENT_TABLE_SUFFIX}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_AGG_WT_BACKLOG' does not exist or not authorized.
DELETE FROM DBP_ETL_PROCESS.ekc_artbew_agg_wt_backlog
;

