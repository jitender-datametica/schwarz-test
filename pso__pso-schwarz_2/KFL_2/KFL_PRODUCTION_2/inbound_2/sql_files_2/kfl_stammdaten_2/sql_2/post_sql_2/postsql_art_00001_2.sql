/*SPEC0258520*/
UPDATE dbp_data.art_2 
   SET int_art_id = kl_art_id
 WHERE int_art_id is null 
    OR TRIM(int_art_id) =''
;
