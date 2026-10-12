--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT  a.mandant_id mandant_id,
 a.mwst_id mwst_id,
 b.dat dat,
 a.mwst mwst, 
 a.sap_mwst_id sap_mwst_id,
 a.dat_von dat_von,  
 a.dat_bis dat_bis 
FROM DBP_DATA.mwst_per_2  a , DBP_DATA.tag_2 b 
WHERE b.dat between a.dat_von and a.dat_bis;

