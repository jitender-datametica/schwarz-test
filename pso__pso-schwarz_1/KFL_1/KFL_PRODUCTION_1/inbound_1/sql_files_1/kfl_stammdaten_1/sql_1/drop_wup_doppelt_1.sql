DELETE FROM DBP_DATA.wup_1
WHERE ( mandant_id, wup_id) IN
  (SELECT  mandant_id, wup_id 
   FROM DBP_DATA.wup_1
   GROUP BY 1,2
   HAVING COUNT(*) > 1
   )
;
COMMIT WORK;
