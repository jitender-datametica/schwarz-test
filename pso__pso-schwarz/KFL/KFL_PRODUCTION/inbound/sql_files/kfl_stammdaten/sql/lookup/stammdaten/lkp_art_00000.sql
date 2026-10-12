SELECT kl_art_id, art_id,mandant_id,wg_art_fg,dat_von,dat_bis 
FROM DBP_DATA.art 
QUALIFY row_number() over (partition by kl_art_id, mandant_id order by art_id DESC)=1
;
