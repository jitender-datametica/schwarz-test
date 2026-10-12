/* AW check 2021-05-17*/
DELETE FROM DBP_ETL_PROCESS.ekc_artbew_flagging_1
WHERE (mandant_id,wup_id,dat) IN (SELECT mandant_id,wup_id,dat FROM DBP_ETL_PROCESS.ekc_artbew_agg_wt_1)
;

INSERT INTO DBP_ETL_PROCESS.ekc_artbew_flagging_1 (mandant_id
                                                          ,wup_id
                                                          ,art_id
                                                          ,dat
                                                          ,bewart_id
                                                          ,bewart_det_id
                                                          ,menge
                                                          ,menge_sum
                                                          ,anteil)
SELECT x.mandant_id,
       x.wup_id,
       x.art_id,
       x.dat,
       x.bewart_id,
       x.bewart_det_id,
       x.menge,
       SUM(ABS(x.menge)) OVER (PARTITION BY x.mandant_id,x.wup_id,x.art_id,x.dat) AS menge_sum,
       ZEROIFNULL(CAST(ABS(x.menge) AS FLOAT)/NULLIFZERO(CAST(menge_sum AS FLOAT))) AS anteil
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             a.dat,
             a.bewart_id,
             a.bewart_det_id,
             SUM(a.menge) AS menge
      FROM DBP_DATA.artbew_1 a
      JOIN DBP_ETL_PROCESS.ekc_artbew_agg_wt_1 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.nb_id = b.nb_id AND
           a.dat = b.dat
      WHERE a.bewart_id IN (1001,1002)
      GROUP BY 1,2,3,4,5,6
      HAVING SUM(a.menge) <> 0) x
;
