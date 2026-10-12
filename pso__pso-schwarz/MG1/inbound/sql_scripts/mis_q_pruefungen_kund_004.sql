--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mis_q_kunden_join_tag  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      dat_vgl DATE NOT NULL,
      Kundengleich_fg BYTEINT NOT NULL,
      KundenAvg_fg BYTEINT NOT NULL,
      Kunden_fg BYTEINT NOT NULL
       )
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.KUNDENANZ_AGG_WT' does not exist or not authorized.
INSERT INTO DBP_ETL.mis_q_kunden_join_tag
(
      mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
      ,Kundengleich_fg
      ,KundenAvg_fg
      ,Kunden_fg
)
SELECT
      mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
      ,SUM(Kundengleich_fg)
      ,SUM(KundenAvg_fg)
      ,SUM(Kunden_fg)
FROM
(
    SELECT
      t3.mandant_id
      ,t3.wup_id
      ,t3.nb_id
      ,t1.dat as dat
      ,t2.dat as dat_vgl
      ,CASE
        WHEN 
          (t1.dat = t2.dat)
        THEN
          1
        ELSE
          0
      END as Kunden_fg
      ,CASE 
        WHEN
          (t1.dat = t2.dat)
        THEN
          0
        ELSE
          1
      END as KundenAvg_fg
      ,0 as Kundengleich_fg
    FROM
      DBP_DATA.tag t1
    INNER JOIN
    (SELECT *
     FROM DBP_ETL_PROCESS.kundenanz_agg_wt
     WHERE dat BETWEEN CURRENT_DATE-365 AND CURRENT_DATE) t3
    ON
      t1.dat=t3.dat
    INNER JOIN
      DBP_DATA.tag t2
    ON
      t2.dat between t1.dat-30 and t1.dat
    AND
      t2.wtag_id=t1.wtag_id
    WHERE
      t3.calc_fg=0
  UNION
    SELECT
      t4.mandant_id
      ,t4.wup_id
      ,t4.nb_id
      ,t4.dat
      ,t5.dat as dat_vgl
      ,0 as Kunden_fg
      ,0 as KundenAvg_fg
      ,1 as Kundengleich_fg
    FROM
    (SELECT *
     FROM DBP_ETL_PROCESS.kundenanz_agg_wt
     WHERE dat BETWEEN CURRENT_DATE-365 AND CURRENT_DATE) t4
    INNER JOIN
      DBP_DATA.tag t5
    ON
      t5.dat BETWEEN t4.dat-3 AND t4.dat-1
    WHERE
      t4.calc_fg=0
  GROUP BY             
    1,2,3,4,5,6,7
)dt1
WHERE
  EXISTS
  (SELECT * FROM 
    DBP_DATA.wupcal t6
  WHERE
    t6.dat=dt1.dat_vgl
  AND
    t6.wup_id=dt1.wup_id
  AND
    t6.nb_id=dt1.nb_id
  AND
    t6.mandant_id=dt1.mandant_id
  AND
    t6.datenlieferung_bonanzahl = 1
  AND
    t6.offen = 1
  )
AND
  EXISTS
  (SELECT * FROM 
    DBP_DATA.wupcal t7
  WHERE
    t7.dat=dt1.dat
  AND
    t7.wup_id=dt1.wup_id
  AND
    t7.nb_id=dt1.nb_id
  AND
    t7.mandant_id=dt1.mandant_id
  AND
    t7.datenlieferung_bonanzahl = 1
  AND
    t7.offen = 1
  )
GROUP BY
       mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
;

