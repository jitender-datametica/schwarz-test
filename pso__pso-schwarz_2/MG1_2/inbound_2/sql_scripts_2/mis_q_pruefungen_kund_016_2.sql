--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mis_q_Kunden_gleich_2  (
          mandant_id BYTEINT,
          wup_id INTEGER NOT NULL,
          nb_id SMALLINT NOT NULL,
          dat DATE NOT NULL,
          dat_gleich DATE,
          Bonanzahl Decimal(18,2)
      )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.mis_q_Kunden_gleich_2
(
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,dat_gleich
        ,Bonanzahl
)
SELECT
  t1.mandant_id
  ,t1.wup_id
  ,t1.nb_id
  ,t1.dat as dat
  ,t2.dat_vgl as dat_gleich
  ,t1.Bonanzahl
FROM  DBP_ETL.mis_q_kunden_2 t1_2
INNER JOIN  DBP_ETL.mis_q_kunden_2 t2
ON  t1.mandant_id=t2.mandant_id
AND  t1.wup_id=t2.wup_id
AND  t1.nb_id=t2.nb_id
AND  t1.dat=t2.dat
AND  t1.Bonanzahl=t2.Bonanzahl
WHERE  t1.Kunden_fg=1
AND  t2.Kundengleich_fg=1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.KUNDENANZ_AGG_WT_2' does not exist or not authorized.
UPDATE   DBP_DATA.wupcal_2

SET
  pruef_grund_id_kunde = dt1.pruef_grund_id_kunde_
  ,pruef_status_id_kunde   = CASE WHEN pruef_status_id_kunde IS NULL THEN dt1.pruef_status_id_kunde_ ELSE dt1.pruef_status_id_kunde_reload_ END
FROM
(
SELECT
  t1.mandant_id mandant_id_
  ,t1.wup_id wup_id_
  ,t1.nb_id nb_id_
  ,t1.dat dat_
  ,MAX(CASE WHEN t2.wup_id IS NULL THEN  ' ' ELSE  'D' END  || CASE WHEN t3.wup_id IS NULL THEN  ' '  ELSE  'G'  END || ' ') AS pruef_grund_id_kunde_
  ,CASE WHEN pruef_grund_id_kunde_= '   ' THEN 1 ELSE 0 END AS pruef_status_id_kunde_
  ,CASE WHEN pruef_grund_id_kunde_= '   ' THEN 2 ELSE -1 END AS pruef_status_id_kunde_reload_

FROM
   (SELECT *
    FROM DBP_ETL_PROCESS.kundenanz_agg_wt_2
    WHERE dat BETWEEN CURRENT_DATE-365 AND CURRENT_DATE) t1_2
LEFT OUTER JOIN
  DBP_ETL.mis_q_kunden_abw_avg_2 t2
ON   t1.dat=t2.dat
AND  t1.mandant_id=t2.mandant_id
AND  t1.wup_id=t2.wup_id
AND  t1.nb_id=t2.nb_id
LEFT OUTER JOIN  DBP_ETL.mis_q_kunden_gleich_2 t3
ON   t1.dat=t3.dat
AND  t1.mandant_id=t3.mandant_id
AND  t1.wup_id=t3.wup_id
AND  t1.nb_id=t3.nb_id
WHERE  t1.calc_fg=0
GROUP BY 1,2,3,4
)dt1 WHERE  mandant_id = dt1.mandant_id_
AND  wup_id = dt1.wup_id_
AND  nb_id = dt1.nb_id_
AND  dat = dt1.dat_
;


