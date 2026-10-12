UPDATE DBP_DATA.kreistyp_gruppe_spr_zu_2
   SET kreistyp_gruppe_bez = s.RO_kreistyp_gruppe_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.kreistyp_gruppe_id  as kreistyp_gruppe_id, 
                a.spr_id        as SPR_ID,
                b.kreistyp_gruppe_bez as RO_kreistyp_gruppe_bez
          FROM  DBP_DATA.kreistyp_gruppe_spr_zu_2 a
         INNER  JOIN DBP_DATA.kreistyp_gruppe_spr_zu_2 b
            ON  a.kreistyp_gruppe_id=b.kreistyp_gruppe_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.kreistyp_gruppe_bez <>b.kreistyp_gruppe_bez
         GROUP  BY 1,2,3
) s
WHERE kreistyp_gruppe_spr_zu.mandant_id =4 
  AND kreistyp_gruppe_spr_zu.kreistyp_gruppe_id = s.kreistyp_gruppe_id
  AND kreistyp_gruppe_spr_zu.spr_id = s.SPR_ID
  AND kreistyp_gruppe_spr_zu.kreistyp_gruppe_bez <> s.RO_kreistyp_gruppe_bez
;
