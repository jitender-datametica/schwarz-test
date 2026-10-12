UPDATE DBP_MSI_DATA.vis_monat_bestand_wg_2 t1_2

SET abt_id = tmp.abt_id

FROM  
(SELECT mandant_id
       ,wg_id
       ,abt_id
       ,arthiertyp_id
 FROM DBP_DATA.wg_per_2
 WHERE dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
   AND arthiertyp_id = 2
) tmp 

WHERE t1.mandant_id    = tmp.mandant_id
  AND t1.wg_id         = tmp.wg_id
  AND t1.arthiertyp_id = tmp.arthiertyp_id
  AND t1.abt_id       <> tmp.abt_id
;

