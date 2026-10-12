--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _art_wup_ek_zu_per_w_${TRANSIENT_TABLE_SUFFIX}  (
  art_id INTEGER NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,wup_id INTEGER NOT NULL
 ,nb_id SMALLINT NOT NULL
 ,dat_relevant DATE NOT NULL
 ,ek_netto DECIMAL(18,4)
 ,ek_netto_bnk DECIMAL(18,4)
 ,ek_mep DECIMAL(18,4)
 ,einstandspreis DECIMAL(18,4)
 ,komponentenmenge DECIMAL(9,4) NOT NULL
 ,wrg_id CHAR(3) NOT NULL
 ,ek_nettonetto DECIMAL(18,4)
 ,kein_zekp_fg BYTEINT
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX}  (
  art_id INTEGER NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,wup_id INTEGER NOT NULL
 ,nb_id SMALLINT NOT NULL
 ,dat_relevant DATE NOT NULL
 ,ek_netto DECIMAL(18,4)
 ,ek_netto_bnk DECIMAL(18,4)
 ,ek_mep DECIMAL(18,4)
 ,einstandspreis DECIMAL(18,4)
 ,komponentenmenge DECIMAL(9,4) NOT NULL
 ,wrg_id CHAR(3) NOT NULL
 ,ek_nettonetto DECIMAL(18,4)
 ,kein_zekp_fg BYTEINT
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _art_wup_ek_zu_per_tmp_${TRANSIENT_TABLE_SUFFIX}  (
  art_id INTEGER NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,wup_id INTEGER NOT NULL
 ,nb_id SMALLINT NOT NULL
 ,dat_von DATE NOT NULL
 ,dat_bis DATE NOT NULL
 ,ek_netto DECIMAL(18,4)
 ,ek_netto_bnk DECIMAL(18,4)
 ,ek_mep DECIMAL(18,4)
 ,einstandspreis DECIMAL(18,4)
 ,komponentenmenge DECIMAL(9,4) NOT NULL
 ,wrg_id CHAR(3) NOT NULL
 ,ek_nettonetto DECIMAL(18,4)
 ,kein_zekp_fg BYTEINT
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}  (
  art_id INTEGER NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,wup_id INTEGER NOT NULL
 ,nb_id SMALLINT NOT NULL
 ,dat_von DATE NOT NULL
 ,dat_bis DATE NOT NULL
 ,ek_netto DECIMAL(18,4)
 ,ek_netto_bnk DECIMAL(18,4)
 ,ek_mep DECIMAL(18,4)
 ,einstandspreis DECIMAL(18,4)
 ,komponentenmenge DECIMAL(9,4) NOT NULL
 ,wrg_id CHAR(3) NOT NULL
 ,ek_nettonetto DECIMAL(18,4)
 ,kein_zekp_fg BYTEINT
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _hauptlieferant_${TRANSIENT_TABLE_SUFFIX}  (
  dat_relevant DATE NOT NULL
 ,mandant_id BYTEINT NOT NULL
 ,wup_id INTEGER NOT NULL
 ,nb_id SMALLINT NOT NULL
 ,art_id INTEGER NOT NULL
 ,gp_id INTEGER NOT NULL
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _mandant_artikel_kombi_${TRANSIENT_TABLE_SUFFIX}  (
  mandant_id BYTEINT NOT NULL,
  art_id INTEGER NOT NULL
) ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
INSERT INTO _hauptlieferant_${TRANSIENT_TABLE_SUFFIX} (dat_relevant,
                             mandant_id,
                             wup_id,
                             nb_id,
                             art_id,
                             gp_id)
SELECT b.dat_relevant,
       a.mandant_id,
       -1 AS wup_id,
       -1 AS nb_id,
       a.art_id,
       MAX(b.gp_id) AS gp_id
FROM DBP_ETL.art_gp_nm_zu_per_rb_kmo a
JOIN (SELECT x.dat_relevant,
             x.mandant_id,
             x.art_id,
             x.gp_id
      FROM (SELECT r.dat_relevant,
                   a.mandant_id,
                   a.art_id,
                   a.gp_id,
                   RANK() OVER (PARTITION BY a.mandant_id,a.art_id
                                ORDER BY COUNT(*) DESC) rang
            FROM DBP_ETL.art_gp_nm_zu_per_rb_kmo a
            JOIN DBP_ETL.art_wup_ek_datum_relevant_kmo r
              ON 1 = 1
            WHERE a.gp_id <> -1 AND
                  a.mandant_id > 1 AND
                  r.dat_relevant BETWEEN a.dat_von AND a.dat_bis
            GROUP BY 1,2,3,4) x
      WHERE x.rang = 1) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     b.dat_relevant BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2,5
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
INSERT INTO _mandant_artikel_kombi_${TRANSIENT_TABLE_SUFFIX} (mandant_id,
                                    art_id)
SELECT a.mandant_id,
       a.art_id
FROM DBP_ETL.art_gp_nm_zu_per_rb_kmo a
JOIN DBP_ETL.art_wup_ek_datum_relevant_kmo r
  ON 1 = 1
WHERE a.mandant_id > 1 AND
      r.dat_relevant BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
INSERT INTO _hauptlieferant_${TRANSIENT_TABLE_SUFFIX} (dat_relevant,
                             mandant_id,
                             wup_id,
                             nb_id,
                             art_id,
                             gp_id)
SELECT r.dat_relevant,
       a.mandant_id,
       -1 AS wup_id,
       -1 AS nb_id,
       a.art_id,
       -1 AS gp_id
FROM _mandant_artikel_kombi_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_ETL.art_wup_ek_datum_relevant_kmo r
  ON 1 = 1
LEFT JOIN _hauptlieferant_${TRANSIENT_TABLE_SUFFIX} b
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id
WHERE b.mandant_id IS NULL;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _art_wup_ek_zu_per_w_${TRANSIENT_TABLE_SUFFIX} (art_id,
                                  mandant_id,
                                  wup_id,
                                  nb_id,
                                  dat_relevant,
                                  ek_netto,
                                  ek_netto_bnk,
                                  ek_mep,
                                  einstandspreis,
                                  komponentenmenge,
                                  wrg_id,
                                  ek_nettonetto,
                                  kein_zekp_fg)
SELECT a.art_id,
       a.mandant_id,
       -1 AS wup_id,
       -1 AS nb_id,
       a.dat_relevant,
       COALESCE(CAST((b.ek_netto       ) AS DECIMAL (18,4)), 1) AS ek_netto,
       COALESCE(CAST((b.ek_netto_bnk   ) AS DECIMAL (18,4)), 1) AS ek_netto_bnk,
       COALESCE(CAST((b.ek_mep         ) AS DECIMAL (18,4)), 1) AS ek_mep,
       COALESCE(CAST((b.einstandspreis ) AS DECIMAL (18,4)), 1) AS einstandspreis,
       COALESCE(b.komponentenmenge,1) AS komponentenmenge,
       COALESCE(b.wrg_id,c.default_wrg) AS wrg_id,
       COALESCE(CAST((b.ek_nettonetto  ) AS DECIMAL (18,4)), 1) AS ek_nettonetto,
       CASE
         WHEN b.ek_netto IS NULL
         THEN 1
         ELSE 0
       END AS kein_zekp_fg
FROM (SELECT a.dat_relevant,
             a.mandant_id,
             a.art_id,
             a.gp_id
      FROM _hauptlieferant_${TRANSIENT_TABLE_SUFFIX} a
      GROUP BY 1,2,3,4) a
JOIN DBP_DATA.mandant c
  ON a.mandant_id = c.mandant_id
LEFT JOIN (SELECT *
           FROM DBP_ETL.art_gp_wup_zu_per_rb_kmo) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id     = b.art_id     AND
     a.gp_id      = b.gp_id      AND
     b.wup_id     = -1           AND
     a.dat_relevant BETWEEN b.dat_von AND b.dat_bis
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_ZU_PER_RB_KMO' does not exist or not authorized.
INSERT INTO _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX} (art_id,
                                  mandant_id,
                                  wup_id,
                                  nb_id,
                                  dat_relevant,
                                  ek_netto,
                                  ek_netto_bnk,
                                  ek_mep,
                                  einstandspreis,
                                  komponentenmenge,
                                  wrg_id,
                                  ek_nettonetto,
                                  kein_zekp_fg)
SELECT a.art_id,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.dat_relevant,
       a.ek_netto,
       a.ek_netto_bnk,
       a.ek_mep,
       a.einstandspreis,
       a.komponentenmenge,
       a.wrg_id,
       a.ek_nettonetto,
       a.kein_zekp_fg
FROM _art_wup_ek_zu_per_w_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_ETL.art_wup_ek_zu_per_rb_kmo z
  ON a.mandant_id = z.mandant_id AND 
     a.wup_id     = z.wup_id     AND
     a.art_id     = z.art_id     AND
     a.dat_relevant BETWEEN z.dat_von AND z.dat_bis
WHERE a.ek_netto         <> CAST((z.ek_netto       ) AS DECIMAL (18,4)) OR
      a.ek_netto_bnk     <> CAST((z.ek_netto_bnk   ) AS DECIMAL (18,4)) OR
      a.ek_mep           <> CAST((z.ek_mep         ) AS DECIMAL (18,4)) OR
      a.einstandspreis   <> CAST((z.einstandspreis ) AS DECIMAL (18,4)) OR
      a.komponentenmenge <> z.komponentenmenge                                            OR
      a.ek_nettonetto    <> CAST((z.ek_nettonetto  ) AS DECIMAL (18,4))
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_ZU_PER_RB_KMO' does not exist or not authorized.
INSERT INTO _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX} (art_id,
                                  mandant_id,
                                  wup_id,
                                  nb_id,
                                  dat_relevant,
                                  ek_netto,
                                  ek_netto_bnk,
                                  ek_mep,
                                  einstandspreis,
                                  komponentenmenge,
                                  wrg_id,
                                  ek_nettonetto,
                                  kein_zekp_fg)
SELECT a.art_id,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.dat_relevant,
       a.ek_netto,
       a.ek_netto_bnk,
       a.ek_mep,
       a.einstandspreis,
       a.komponentenmenge,
       a.wrg_id,
       a.ek_nettonetto,
       a.kein_zekp_fg
FROM _art_wup_ek_zu_per_w_${TRANSIENT_TABLE_SUFFIX} a
WHERE (mandant_id, wup_id, art_id) NOT IN (SELECT mandant_id,
                                                  wup_id,
                                                  art_id
                                           FROM DBP_ETL.art_wup_ek_zu_per_rb_kmo)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO _art_wup_ek_zu_per_tmp_${TRANSIENT_TABLE_SUFFIX} (art_id,
                                    mandant_id,
                                    wup_id,
                                    nb_id,
                                    dat_von,
                                    dat_bis,
                                    ek_netto,
                                    ek_netto_bnk,
                                    ek_mep,
                                    einstandspreis,
                                    komponentenmenge,
                                    wrg_id,
                                    ek_nettonetto,
                                    kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_relevant AS dat_von,
       to_date('9999-12-31','YYYY-MM-DD') AS dat_bis,
       ek_netto,
       ek_netto_bnk,
       ek_mep,
       einstandspreis,
       komponentenmenge,
       wrg_id,
       ek_nettonetto,
       kein_zekp_fg
FROM _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX}
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_ZU_PER_RB_KMO' does not exist or not authorized.
INSERT INTO _art_wup_ek_zu_per_tmp_${TRANSIENT_TABLE_SUFFIX} (art_id,
                                    mandant_id,
                                    wup_id,
                                    nb_id,
                                    dat_von,
                                    dat_bis,
                                    ek_netto,
                                    ek_netto_bnk,
                                    ek_mep,
                                    einstandspreis,
                                    komponentenmenge,
                                    wrg_id,
                                    ek_nettonetto,
                                    kein_zekp_fg)
SELECT z.art_id,
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       a.dat_relevant+1 AS dat_von_,
       to_date('9999-12-31','YYYY-MM-DD') AS dat_bis_,
       CAST((z.ek_netto       ) AS DECIMAL (18,4)) ek_netto_,
       CAST((z.ek_netto_bnk   ) AS DECIMAL (18,4)) ek_netto_bnk_,
       CAST((z.ek_mep         ) AS DECIMAL (18,4)) ek_mep_,
       CAST((z.einstandspreis ) AS DECIMAL (18,4)) einstandspreis_,
       z.komponentenmenge,
       z.wrg_id,
       CAST((z.ek_nettonetto  ) AS DECIMAL (18,4)) ek_nettonetto_,
       z.kein_zekp_fg
FROM _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_ETL.art_wup_ek_zu_per_rb_kmo z 
  ON a.mandant_id    = z.mandant_id AND 
     a.wup_id        = z.wup_id     AND 
     a.art_id        = z.art_id     AND 
     a.dat_relevant >= z.dat_von    AND /* innerhalb eines bestehenden Zeitraums */
     a.dat_relevant  < z.dat_bis    AND
     z.dat_bis       < 80991231     AND /* letzten Datesatz nicht einfuegen, dieser wird ersetzt */
    (a.ek_netto         <> CAST((z.ek_netto       ) AS DECIMAL (18,4)) OR
     a.ek_netto_bnk     <> CAST((z.ek_netto_bnk   ) AS DECIMAL (18,4)) OR
     a.ek_mep           <> CAST((z.ek_mep         ) AS DECIMAL (18,4)) OR
     a.einstandspreis   <> CAST((z.einstandspreis ) AS DECIMAL (18,4)) OR
     a.komponentenmenge <> z.komponentenmenge                                            OR
     a.ek_nettonetto    <> CAST((z.ek_nettonetto   ) AS DECIMAL (18,4)))
WHERE (z.mandant_id, z.art_id, z.wup_id, dat_von_) NOT IN (SELECT mandant_id,
                                                                  art_id,
                                                                  wup_id,
                                                                  dat_relevant
                                                           FROM _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX})
-- Falls mehrere neue Zuordnungen in ein bestehendes Intervall fallen
GROUP BY z.art_id,z.mandant_id,z.wup_id,z.nb_id,dat_von_,dat_bis_,ek_netto_,ek_netto_bnk_,ek_mep_,
         einstandspreis_,z.komponentenmenge,z.wrg_id,ek_nettonetto_,z.kein_zekp_fg
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MDIFF is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: expr - SUM(expr) OVER (ORDER BY expr ROWS BETWEEN width PRECEDING AND width PRECEDING)
--original statement
--INSERT INTO #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX} (art_id,
--                                     mandant_id,
--                                     wup_id,
--                                     nb_id,
--                                     dat_von,
--                                     dat_bis,
--                                     ek_netto,
--                                     ek_netto_bnk,
--                                     ek_mep,
--                                     einstandspreis,
--                                     komponentenmenge,
--                                     wrg_id,
--                                     ek_nettonetto,
--                                     kein_zekp_fg)
--SELECT art_id,
--       mandant_id,
--       wup_id,
--       nb_id,
--       dat_von,
--       dat_bis,
--       ek_netto,
--       ek_netto_bnk,
--       ek_mep,
--       einstandspreis,
--       komponentenmenge,
--       wrg_id,
--       ek_nettonetto,
--       kein_zekp_fg
--FROM (SELECT art_id,
--             mandant_id,
--             wup_id,
--             nb_id,
--             dat_von,
--             dat_bis,
--             ek_netto,
--             ek_netto_bnk,
--             ek_mep,
--             einstandspreis,
--             komponentenmenge,
--             wrg_id,
--             ek_nettonetto,
--             kein_zekp_fg,
--             -- Alle Datensätze markieren, die entweder keinen Wechsel haben, weil
--             -- kein Vorgänger da ist, oder die einen EK-Wechsel im Vergleich zum 
--             -- Vorgänger aufweisen.
--             COALESCE(MDIFF(ek_netto, 1, dat_von ASC), 1) AS ek_netto_wechsel_fg,
--             COALESCE(MDIFF(ek_netto_bnk, 1, dat_von ASC), 1) AS ek_netto_bnk_wechsel_fg,            
--             COALESCE(MDIFF(ek_mep, 1, dat_von ASC), 1) AS ek_mep_wechsel_fg,
--             COALESCE(MDIFF(einstandspreis, 1, dat_von ASC), 1) AS einstandspreis_wechsel_fg,
--             COALESCE(MDIFF(komponentenmenge, 1, dat_von ASC), 1) AS komp_wechsel_fg,  
--             COALESCE(MDIFF(ek_nettonetto, 1, dat_von ASC), 1) AS ek_nettonetto_wechsel_fg
--      FROM #art_wup_ek_zu_per_tmp_${TRANSIENT_TABLE_SUFFIX}
--      GROUP BY mandant_id,art_id,wup_id) a
--WHERE ek_netto_wechsel_fg       <> 0 OR
--      ek_netto_bnk_wechsel_fg   <> 0 OR
--      ek_mep_wechsel_fg         <> 0 OR
--      einstandspreis_wechsel_fg <> 0 OR
--      komp_wechsel_fg           <> 0 OR
--      ek_nettonetto_wechsel_fg  <> 0
--;
--
--Comment from validation checker
--error line 46 at position 49 unexpected 'ASC'.
--             COALESCE(MDIFF(ek_netto, 1, dat_von  ^^^> ASC), 1) AS ek_netto_wechsel_fg,
--syntax error line 47 at position 21 unexpected '('.
--             COALESCE ^^^> (MDIFF(ek_netto_bnk, 1, dat_von ASC), 1) AS ek_netto_bnk_wechsel_fg,            
--syntax error line 47 at position 42 unexpected '1'.
--             COALESCE(MDIFF(ek_netto_bnk,  ^^^> 1, dat_von ASC), 1) AS ek_netto_bnk_wechsel_fg,            
--syntax error line 47 at position 56 unexpected ')'.
--             COALESCE(MDIFF(ek_netto_bnk, 1, dat_von ASC ^^^> ), 1) AS ek_netto_bnk_wechsel_fg,            
--translated statement
INSERT INTO _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX} (art_id,
                                     mandant_id,
                                     wup_id,
                                     nb_id,
                                     dat_von,
                                     dat_bis,
                                     ek_netto,
                                     ek_netto_bnk,
                                     ek_mep,
                                     einstandspreis,
                                     komponentenmenge,
                                     wrg_id,
                                     ek_nettonetto,
                                     kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       dat_bis,
       ek_netto,
       ek_netto_bnk,
       ek_mep,
       einstandspreis,
       komponentenmenge,
       wrg_id,
       ek_nettonetto,
       kein_zekp_fg
FROM (SELECT art_id,
             mandant_id,
             wup_id,
             nb_id,
             dat_von,
             dat_bis,
             ek_netto,
             ek_netto_bnk,
             ek_mep,
             einstandspreis,
             komponentenmenge,
             wrg_id,
             ek_nettonetto,
             kein_zekp_fg,
             -- Alle Datensätze markieren, die entweder keinen Wechsel haben, weil
             -- kein Vorgänger da ist, oder die einen EK-Wechsel im Vergleich zum 
             -- Vorgänger aufweisen.
             COALESCE(MDIFF(ek_netto, 1, dat_von ASC), 1) AS ek_netto_wechsel_fg,
             COALESCE(MDIFF(ek_netto_bnk, 1, dat_von ASC), 1) AS ek_netto_bnk_wechsel_fg,            
             COALESCE(MDIFF(ek_mep, 1, dat_von ASC), 1) AS ek_mep_wechsel_fg,
             COALESCE(MDIFF(einstandspreis, 1, dat_von ASC), 1) AS einstandspreis_wechsel_fg,
             COALESCE(MDIFF(komponentenmenge, 1, dat_von ASC), 1) AS komp_wechsel_fg,  
             COALESCE(MDIFF(ek_nettonetto, 1, dat_von ASC), 1) AS ek_nettonetto_wechsel_fg
      FROM _art_wup_ek_zu_per_tmp_${TRANSIENT_TABLE_SUFFIX}
      GROUP BY mandant_id,art_id,wup_id) a
WHERE ek_netto_wechsel_fg       <> 0 OR
      ek_netto_bnk_wechsel_fg   <> 0 OR
      ek_mep_wechsel_fg         <> 0 OR
      einstandspreis_wechsel_fg <> 0 OR
      komp_wechsel_fg           <> 0 OR
      ek_nettonetto_wechsel_fg  <> 0
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--original statement
--UPDATE #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX} FROM (SELECT mandant_id,
--                                            wup_id,
--                                            art_id,
--                                            dat_von,
--                                            CASE 
--                                              WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) = 0
--                                              THEN CAST(80991231 AS DATE)
--                                              ELSE CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) AS DATE) -1
--                                            END AS dat_bis_
--                                     FROM #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}
--                                     QUALIFY dat_bis_ <> dat_bis
--                                     GROUP BY mandant_id,wup_id,art_id) dt1
--
--SET dat_bis = dt1.dat_bis_
--
--WHERE #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.mandant_id = dt1.mandant_id AND 
--      #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.wup_id     = dt1.wup_id     AND 
--      #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.art_id     = dt1.art_id     AND 
--      #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.dat_von    = dt1.dat_von    AND 
--      #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.dat_bis   <> dt1.dat_bis_
--;
--
--Comment from validation checker
--error line 9 at position 94 unexpected 'DESC'.
--                                              WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von  ^^^> DESC) - CAST(dat_von AS INTEGER)) = 0
--syntax error line 9 at position 126 unexpected ')'.
--                                              WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER) ^^^> ) = 0
--syntax error line 9 at position 128 unexpected '='.
--                                              WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER))  ^^^> = 0
--syntax error line 10 at position 84 unexpected ')'.
--                                              THEN to_date('9999-12-31','YYYY-MM-DD' ^^^> )
--translated statement
UPDATE _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX} 
SET dat_bis = dt1.dat_bis_

FROM (SELECT mandant_id,
                                            wup_id,
                                            art_id,
                                            dat_von,
                                            CASE 
                                              WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) = 0
                                              THEN to_date('9999-12-31','YYYY-MM-DD')
                                              ELSE CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von DESC) - CAST(dat_von AS INTEGER)) AS DATE) -1
                                            END AS dat_bis_
                                     FROM _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}
                                     QUALIFY dat_bis_ <> dat_bis
                                     GROUP BY mandant_id,wup_id,art_id) dt1
 WHERE _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.mandant_id = dt1.mandant_id AND 
      _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.wup_id     = dt1.wup_id     AND 
      _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.art_id     = dt1.art_id     AND 
      _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.dat_von    = dt1.dat_von    AND 
      _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}.dat_bis   <> dt1.dat_bis_
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_ZU_PER_RB_KMO' does not exist or not authorized.
DELETE FROM DBP_ETL.art_wup_ek_zu_per_rb_kmo a
WHERE (mandant_id, wup_id, art_id) IN (SELECT mandant_id,
                                              wup_id,
                                              art_id
                                       FROM _art_wup_ek_zu_per_x_${TRANSIENT_TABLE_SUFFIX}) AND
       dat_von >= (SELECT dat_relevant FROM DBP_ETL.art_wup_ek_datum_relevant_kmo)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Table 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_ZU_PER_RB_KMO' does not exist or not authorized.
INSERT INTO DBP_ETL.art_wup_ek_zu_per_rb_kmo (art_id,
                                         mandant_id,
                                         wup_id,
                                         nb_id,
                                         dat_von,
                                         dat_bis,
                                         ek_netto,
                                         ek_netto_bnk,
                                         ek_mep,
                                         einstandspreis,
                                         komponentenmenge,
                                         wrg_id,
                                         ek_nettonetto,
                                         kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       dat_bis,
       (ek_netto       ) AS ek_netto,
       (ek_netto_bnk   ) AS ek_netto_bnk,
       (ek_mep         ) AS ek_mep,
       (einstandspreis ) AS einstandspreis,
       komponentenmenge,
       wrg_id,
       (ek_nettonetto  ) AS ek_nettonetto,
       kein_zekp_fg
FROM _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX}
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--original statement
--UPDATE ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo FROM (SELECT a.mandant_id,
--                                                       a.wup_id,
--                                                       a.art_id,
--                                                       a.dat_von,
--                                                       CASE 
--                                                         WHEN (MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von DESC) - CAST(a.dat_von AS INTEGER)) = 0
--                                                         THEN CAST(80991231 AS DATE)
--                                                         ELSE CAST((MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von DESC) - CAST(a.dat_von AS INTEGER)) AS DATE) -1
--                                                       END AS dat_bis_
--                                                FROM ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo a
--		        JOIN #art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX} b
--		          ON a.mandant_id = b.mandant_id AND
--		             a.wup_id = b.wup_id AND
--		             a.art_id = b.art_id
--		        WHERE b.dat_von = (SELECT dat_relevant FROM ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant_kmo)
--                                                QUALIFY dat_bis_ <> a.dat_bis
--                                                GROUP BY a.mandant_id,a.wup_id,a.art_id) dt1
--
--SET dat_bis = dt1.dat_bis_
--
--WHERE ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo.mandant_id = dt1.mandant_id AND 
--      ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo.wup_id     = dt1.wup_id     AND 
--      ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo.art_id     = dt1.art_id     AND 
--      ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo.dat_von    = dt1.dat_von    AND 
--      ${DWH_COMMON_DBX_LOAD}.art_wup_ek_zu_per_rb_kmo.dat_bis   <> dt1.dat_bis_
--;
--
--Comment from validation checker
--error line 9 at position 109 unexpected 'DESC'.
--                                                         WHEN (MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von  ^^^> DESC) - CAST(a.dat_von AS INTEGER)) = 0
--syntax error line 9 at position 109 unexpected 'DESC'.
--                                                         WHEN (MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von  ^^^> DESC) - CAST(a.dat_von AS INTEGER)) = 0
--syntax error line 9 at position 115 unexpected '\-'.
--                                                         WHEN (MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von DESC)  ^^^> - CAST(a.dat_von AS INTEGER)) = 0
--syntax error line 10 at position 95 unexpected ')'.
--                                                         THEN to_date('9999-12-31','YYYY-MM-DD' ^^^> )
--translated statement
UPDATE DBP_ETL.art_wup_ek_zu_per_rb_kmo 
SET dat_bis = dt1.dat_bis_

FROM (SELECT a.mandant_id,
                                                       a.wup_id,
                                                       a.art_id,
                                                       a.dat_von,
                                                       CASE 
                                                         WHEN (MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von DESC) - CAST(a.dat_von AS INTEGER)) = 0
                                                         THEN to_date('9999-12-31','YYYY-MM-DD')
                                                         ELSE CAST((MSUM(CAST(a.dat_von AS INTEGER), 2, a.dat_von DESC) - CAST(a.dat_von AS INTEGER)) AS DATE) -1
                                                       END AS dat_bis_
                                                FROM DBP_ETL.art_wup_ek_zu_per_rb_kmo a
		        JOIN _art_wup_ek_zu_per_tmp2_${TRANSIENT_TABLE_SUFFIX} b
		          ON a.mandant_id = b.mandant_id AND
		             a.wup_id = b.wup_id AND
		             a.art_id = b.art_id
		        WHERE b.dat_von = (SELECT dat_relevant FROM DBP_ETL.art_wup_ek_datum_relevant_kmo)
                                                QUALIFY dat_bis_ <> a.dat_bis
                                                GROUP BY a.mandant_id,a.wup_id,a.art_id) dt1
 WHERE DBP_ETL.art_wup_ek_zu_per_rb_kmo.mandant_id = dt1.mandant_id AND 
      DBP_ETL.art_wup_ek_zu_per_rb_kmo.wup_id     = dt1.wup_id     AND 
      DBP_ETL.art_wup_ek_zu_per_rb_kmo.art_id     = dt1.art_id     AND 
      DBP_ETL.art_wup_ek_zu_per_rb_kmo.dat_von    = dt1.dat_von    AND 
      DBP_ETL.art_wup_ek_zu_per_rb_kmo.dat_bis   <> dt1.dat_bis_
;

