UPDATE DBP_DATA.konditionsart_spr_zu_1
   SET konditionsart_bez = s.RO_konditionsart_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.konditionsart_id  as konditionsart_id, 
                a.spr_id        as SPR_ID,
                b.konditionsart_bez as RO_konditionsart_bez
          FROM  DBP_DATA.konditionsart_spr_zu_1 a
         INNER  JOIN DBP_DATA.konditionsart_spr_zu_1 b
            ON  a.konditionsart_id=b.konditionsart_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.konditionsart_bez <>b.konditionsart_bez
         GROUP  BY 1,2,3
) s
WHERE konditionsart_spr_zu.mandant_id =4 
  AND konditionsart_spr_zu.konditionsart_id = s.konditionsart_id
  AND konditionsart_spr_zu.spr_id = s.SPR_ID
  AND konditionsart_spr_zu.konditionsart_bez <> s.RO_konditionsart_bez
;
