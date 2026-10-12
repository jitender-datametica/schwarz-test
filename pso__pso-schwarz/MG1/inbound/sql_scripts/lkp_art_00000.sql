SELECT kl_art_id, art_id,mandant_id,wg_art_fg,dat_von,dat_bis FROM DBP_DATA.art QUALIFY ROW_NUMBER() OVER (PARTITION BY kl_art_id, mandant_id ORDER BY art_id DESC) = 1
