UPDATE DBP_DATA.wg_verkettung_spr_zu_2
   SET wg_verkett_bez = s.RO_wg_verkett_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.wg_verkett_id  as wg_verkett_id, 
                a.spr_id        as SPR_ID,
                b.wg_verkett_bez as RO_wg_verkett_bez
          FROM  DBP_DATA.wg_verkettung_spr_zu_2 a
         INNER  JOIN DBP_DATA.wg_verkettung_spr_zu_2 b
            ON  a.wg_verkett_id=b.wg_verkett_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.wg_verkett_bez <>b.wg_verkett_bez
         GROUP  BY 1,2,3
) s
WHERE wg_verkettung_spr_zu.mandant_id =4 
  AND wg_verkettung_spr_zu.wg_verkett_id = s.wg_verkett_id
  AND wg_verkettung_spr_zu.spr_id = s.SPR_ID
  AND wg_verkettung_spr_zu.wg_verkett_bez <> s.RO_wg_verkett_bez
;
