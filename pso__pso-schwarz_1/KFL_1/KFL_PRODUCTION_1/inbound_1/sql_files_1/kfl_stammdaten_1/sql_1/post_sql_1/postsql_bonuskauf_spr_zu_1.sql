UPDATE DBP_DATA.bonuskauf_spr_zu_1
   SET bonuskauf_bez = s.RO_BONUSKAUF_BEZ
FROM (
        SELECT  a.bonuskauf_id  as BONUSKAUF_ID, 
                a.spr_id        as SPR_ID,
                b.bonuskauf_bez as RO_BONUSKAUF_BEZ
          FROM  DBP_DATA.bonuskauf_spr_zu_1 a
         INNER  JOIN DBP_DATA.bonuskauf_spr_zu_1 b
            ON  a.bonuskauf_id=b.bonuskauf_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.bonuskauf_bez <>b.bonuskauf_bez
         GROUP  BY 1,2,3
) s
WHERE bonuskauf_spr_zu.mandant_id =4 
  AND bonuskauf_spr_zu.bonuskauf_id = s.BONUSKAUF_ID
  AND bonuskauf_spr_zu.spr_id = s.SPR_ID
;
