--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id,coalesce(haupt_wup_id,wup_id) as haupt_wup_id,nb_id,wup_id from DBP_DATA.wup_2;

