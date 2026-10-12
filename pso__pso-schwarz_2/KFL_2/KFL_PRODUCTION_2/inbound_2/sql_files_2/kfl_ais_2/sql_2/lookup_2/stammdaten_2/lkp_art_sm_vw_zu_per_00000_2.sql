--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT  mandant_id, art_id, vw_id, sm_id FROM DBP_DATA.art_sm_vw_zu_per_2  WHERE dat_bis = (SELECT MAX(dat_bis) FROM DBP_DATA.art_sm_vw_zu_per_2) ORDER BY 1,2,3,4;

