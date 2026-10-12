UPDATE DBP_DATA.sap_steuersatz_spr_zu_2
   SET sap_steuer_bez = s.RO_sap_steuer_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.sap_steuer_id  as sap_steuer_id, 
                a.steuer_typ_id  as steuer_typ_id,
                a.spr_id         as SPR_ID,
                b.sap_steuer_bez as RO_sap_steuer_bez
          FROM  DBP_DATA.sap_steuersatz_spr_zu_2 a
         INNER  JOIN DBP_DATA.sap_steuersatz_spr_zu_2 b
            ON  a.sap_steuer_id = b.sap_steuer_id 
           AND  a.steuer_typ_id = b.steuer_typ_id 
           AND  a.spr_id        = b.spr_id
           AND  a.sap_steuer_id = b.sap_steuer_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.sap_steuer_bez <>b.sap_steuer_bez 
         GROUP  BY 1,2,3,4
) s
WHERE sap_steuersatz_spr_zu.mandant_id =4 
  AND sap_steuersatz_spr_zu.sap_steuer_id = s.sap_steuer_id
  AND sap_steuersatz_spr_zu.steuer_typ_id = s.steuer_typ_id
  AND sap_steuersatz_spr_zu.spr_id = s.SPR_ID
  AND sap_steuersatz_spr_zu.sap_steuer_bez <> s.RO_sap_steuer_bez
;
