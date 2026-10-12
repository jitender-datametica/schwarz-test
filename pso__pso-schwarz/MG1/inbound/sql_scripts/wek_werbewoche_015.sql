UPDATE DBP_DATA.werbewoche_kl SET akt_kjwo_ww_komplett = akt_kjwo_ww+1
WHERE akt_kjwo_ww <= -1 AND
      mandant_id IN (7,2,6)
;

UPDATE DBP_DATA.werbewoche_kl SET akt_kjwo_ww_komplett = 0
WHERE akt_kjwo_ww = 1 AND
      mandant_id IN (7,2,6) AND
      dat IN (SELECT dat 
              FROM DBP_DATA.tag 
              WHERE (dat = CURRENT_DATE+2 AND wtag_id = 3) OR
	            (dat = CURRENT_DATE+1 AND wtag_id = 3) OR
                    (dat = CURRENT_DATE   AND wtag_id = 3))
;
