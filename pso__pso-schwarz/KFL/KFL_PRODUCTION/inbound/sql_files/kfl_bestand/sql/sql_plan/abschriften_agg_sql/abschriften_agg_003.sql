INSERT INTO DBP_ETL.useg_agg_dat
(
   wup_id
  ,nb_id
  ,dat
  ,mandant_id
)
SELECT
   t1.wup_id
  ,t1.nb_id
  ,t1.dat_umbew
  ,t1.mandant_id
FROM DBP_ETL.art_umbewertung_temp t1

INNER JOIN DBP_DATA.abschriftart_abschriftgrp_zu t2

ON      t2.mandant_id           = t1.mandant_id
AND     t2.abschriftart_id      = t1.preis_aend_grund_id
AND     t2.abschriftgruppe_id   = 400
GROUP BY 1,2,3,4
;

