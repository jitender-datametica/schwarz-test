DELETE FROM dbp_data.wup
WHERE ( mandant_id, wup_id) IN
  (SELECT  mandant_id, wup_id 
   FROM dbp_data.wup
   GROUP BY 1,2
   HAVING COUNT(*) > 1
   )
;
