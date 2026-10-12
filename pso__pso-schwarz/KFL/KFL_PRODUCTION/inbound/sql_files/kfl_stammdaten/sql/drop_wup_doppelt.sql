DELETE FROM DBP_DATA.wup
WHERE ( mandant_id, wup_id) IN
  (SELECT  mandant_id, wup_id 
   FROM DBP_DATA.wup
   GROUP BY 1,2
   HAVING COUNT(*) > 1
   )
;
COMMIT WORK;
