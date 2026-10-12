--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT  a.mandant_id mandant_id,
 a.mwst_id mwst_id,
 b.dat dat,
 a.mwst mwst, 
 a.sap_mwst_id sap_mwst_id,
 a.dat_von dat_von,  
 a.dat_bis dat_bis 
FROM DBP_DATA.mwst_per_1  a , DBP_DATA.tag_1 b 
WHERE b.dat between a.dat_von and a.dat_bis
and (a.mandant_id, a.mwst, a.mwst_id) in 
(select mandant_id, mwst, min(mwst_id) mwst_id from DBP_DATA.mwst_per_1 group by 1,2);

