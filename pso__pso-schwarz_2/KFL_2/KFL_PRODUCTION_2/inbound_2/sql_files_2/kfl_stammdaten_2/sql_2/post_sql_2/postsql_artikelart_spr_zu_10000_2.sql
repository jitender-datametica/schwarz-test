INSERT INTO DBP_DATA.artikelart_spr_zu_2
(
  artikelart_id,
  mandant_id,
  spr_id,
  artikelart_bez
)
SELECT
  artikelart_id,
  mandant_id,
  22 AS spr_id,
  artikelart_bez
FROM ${TEMP_TABLE} /*DBP_ETL.artikelart_spr_zu_temp*/  t1_2

WHERE NOT EXISTS
(
  SELECT  * FROM   DBP_DATA.artikelart_spr_zu_2 t2
   WHERE   t1.artikelart_id = t2.artikelart_id
     AND   t1.mandant_id    = t2.mandant_id
     AND   t1.spr_id        = t2.spr_id
);

INSERT INTO DBP_DATA.artikelart_spr_zu_2
(
  artikelart_id,
  mandant_id,
  spr_id,
  artikelart_bez
)
SELECT
  artikelart_id,
  mandant_id,
  22 AS spr_id,
  artikelart_bez
FROM ${TEMP_TABLE} /*DBP_ETL.artikelart_spr_zu_temp*/  t1_2

WHERE NOT EXISTS
(
  SELECT  * FROM   DBP_DATA.artikelart_spr_zu_2 t2
   WHERE   t1.artikelart_id = t2.artikelart_id
     AND   t1.mandant_id    = t2.mandant_id
     AND   t1.spr_id        = t2.spr_id
);

  UPDATE DBP_DATA.artikelart_spr_zu_2
     SET artikelart_bez = s.RO_ARTIKELART_BEZ
   FROM (
 SELECT a.artikelart_id  as ARTIKELART_ID, 
        a.spr_id  as SPR_ID,
        b.artikelart_bez as RO_ARTIKELART_BEZ
   FROM DBP_DATA.artikelart_spr_zu_2 a
  INNER JOIN DBP_DATA.artikelart_spr_zu_2 b
     ON  a.artikelart_id=b.artikelart_id and a.spr_id= b.spr_id
  WHERE a.mandant_id =4 and a.spr_id <>22 
    AND b.mandant_id =7 and b.spr_id <>22
    AND a.artikelart_bez <>b.artikelart_bez
  GROUP BY 1,2,3
) s
WHERE artikelart_spr_zu.mandant_id =4 
  AND artikelart_spr_zu.artikelart_id = s.ARTIKELART_ID
  AND artikelart_spr_zu.spr_id = s.SPR_ID
;
