--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COALESCE(a.mandant_id,b.mandant_id) AS var, 
       COALESCE(MAX(wup_cluster_id),0) AS wup_cluster_id
FROM DBP_DATA.mandant b
LEFT JOIN DBP_DATA.l_back_wup_cluster a
  ON a.mandant_id = b.mandant_id
GROUP BY 1;

