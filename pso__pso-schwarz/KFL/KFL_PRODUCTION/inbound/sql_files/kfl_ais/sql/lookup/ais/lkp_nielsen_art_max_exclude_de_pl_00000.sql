--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COALESCE(a.mandant_id,b.mandant_id) AS var, 
       COALESCE(MAX(a.art_nielsen_id),0) AS art_nielsen_id
FROM DBP_DATA.mandant b
LEFT JOIN (SELECT *
           FROM DBP_DATA.art_nielsen
           WHERE DAT_BIS='9999-12-31' and mandant_id NOT IN (1)) a
  ON a.mandant_id = b.mandant_id
WHERE b.mandant_id NOT IN (1)
GROUP BY 1;

