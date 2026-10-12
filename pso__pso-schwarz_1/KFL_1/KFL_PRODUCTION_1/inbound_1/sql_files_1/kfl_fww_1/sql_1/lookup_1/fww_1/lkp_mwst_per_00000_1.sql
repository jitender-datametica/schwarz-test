SELECT mandant_id,  mwst_id, dat_von, dat_bis, mwst 
FROM DBP_DATA.mwst_per_1 
GROUP BY 1,2,3,4,5
 ORDER BY 1,2,3