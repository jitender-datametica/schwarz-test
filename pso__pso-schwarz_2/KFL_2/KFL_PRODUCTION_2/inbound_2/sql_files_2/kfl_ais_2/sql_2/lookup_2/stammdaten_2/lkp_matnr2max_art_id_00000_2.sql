SELECT  mandant_id, kl_art_id AS matnr, art_id, dat_bis, wg_art_fg, gewart_id,mwst_id,zek_id
  FROM  DBP_DATA.art_2  
 WHERE (mandant_id, art_id) IN 
        (SELECT mandant_id,MAX(art_id) 
           FROM DBP_DATA.art_2 
          GROUP BY mandant_id ,kl_art_id
        )
;