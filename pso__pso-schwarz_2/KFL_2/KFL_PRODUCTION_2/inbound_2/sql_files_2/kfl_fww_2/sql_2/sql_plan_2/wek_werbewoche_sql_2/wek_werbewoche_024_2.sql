/* AW check 2021-05-17*/
UPDATE DBP_DATA.werbewoche_kl_2 SET akt_kjwo_ww_komplett = akt_kjwo_ww+1
WHERE akt_kjwo_ww <= -1 AND
      mandant_id IN (4,1,3,5)
;

UPDATE DBP_DATA.werbewoche_kl_2 SET akt_kjwo_ww_komplett = 0
WHERE akt_kjwo_ww = 1 AND
      mandant_id IN (4,1,3,5) AND
      dat IN (SELECT dat 
              FROM DBP_DATA.tag_2 
              WHERE (dat = CURRENT_DATE+3 AND wtag_id = 4) OR
	            (dat = CURRENT_DATE+2 AND wtag_id = 4) OR
   	            (dat = CURRENT_DATE+1 AND wtag_id = 4) OR
  	            (dat = CURRENT_DATE   AND wtag_id = 4))
;
