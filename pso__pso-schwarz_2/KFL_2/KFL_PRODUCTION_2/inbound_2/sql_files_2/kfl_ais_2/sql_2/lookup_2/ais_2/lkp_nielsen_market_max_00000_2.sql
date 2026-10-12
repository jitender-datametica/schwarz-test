--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COALESCE(a.mandant_id,b.mandant_id) AS var, 
       COALESCE(MAX(a.nielsen_market_id),0) AS nielsen_market_id
FROM DBP_DATA.mandant_2 b
LEFT JOIN (SELECT *
           FROM DBP_DATA.nielsen_market_2
           WHERE mandant_id IN (1,3)) a
  ON a.mandant_id = b.mandant_id
WHERE b.mandant_id IN (1,3)
GROUP BY 1;

