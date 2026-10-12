--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _zeitraum_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.dat,
       a.kjmo
FROM DBP_DATA.tag_2 a
WHERE a.dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag_2 WHERE akt_mo = (-1)*${MONAT_2}) AND (SELECT Max(dat) FROM DBP_DATA.tag_2 WHERE akt_mo = (-1)*${MONAT_2})
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_2' does not exist or not authorized.
DELETE FROM DBP_ETL_PROCESS.ekc_artbew_2
WHERE dat BETWEEN (SELECT Min(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT Max(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX})
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ARTBEW_KMEP_2' does not exist or not authorized.
INSERT INTO DBP_ETL_PROCESS.ekc_artbew_2 (mandant_id
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
       Sum(a.umsatz_netto) AS umsatz_netto_,
       Sum(a.logkostenzuschlag) AS logkostenzuschlag,
       Sum(a.ek_mep_einstandspreis) AS ek_mep_einstandspreis_,
       Sum(a.menge) AS menge_,
       Sum(Coalesce(b.bonus_stk,0)) AS bonus_stk_,
       Sum(Coalesce(c.bonus_stk,0)) AS bonus_stk_kw_,
       Sum(Coalesce(d.bonus_stk,0)) AS bonus_stk_ww_,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_) AS ek_mep_einstandspreis__,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_kw_) AS wa_kalk_kw_,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_ww_) AS wa_kalk_ww_
FROM (SELECT t1.mandant_id,
             t1.art_id,
             t1.bewart_id,
             t1.wup_id,
             t1.nb_id,
             t1.dat,
             Sum(t1.umsatz_netto) AS umsatz_netto,
             Sum(t1.logkostenzuschlag) AS logkostenzuschlag,
             Sum(CASE
                   WHEN t1.mandant_id = 1
                   THEN Cast((t1.ek_mep ) AS DECIMAL(18,4))
                   ELSE Coalesce(t1.ek_gld,0)
                 END) AS ek_mep_einstandspreis,
             Sum(t1.menge) AS menge
        FROM DBP_DATA.artbew_2 t1_2
        WHERE t1.dat BETWEEN (SELECT Min(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX}) AND (SELECT Max(dat) FROM _zeitraum_${TRANSIENT_TABLE_SUFFIX})
        GROUP BY 1,2,3,4,5,6) a
LEFT JOIN (SELECT x.mandant_id,
                  x.art_id,
                  x.dat_von,
                  x.dat_bis,
                  (x.betrag_kmep_einh ) AS bonus_stk
           FROM (SELECT u.*
                 FROM DBP_ETL_PROCESS.ekc_artbew_kmep_2 u
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
                 FROM DBP_ETL_PROCESS.ekc_artbew_kmep_2 u
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
                 FROM DBP_ETL_PROCESS.ekc_artbew_kmep_2 u
                 WHERE u.zeitraum_kz = 'WW') x) d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     a.dat BETWEEN d.dat_von AND d.dat_bis
  GROUP BY 1,2,3,4,5,6
;

