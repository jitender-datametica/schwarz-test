--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT CASE WHEN mandant_kbez='D' THEN 'DE' ELSE mandant_kbez END land_id,mandant_id FROM DBP_DATA.mandant_2;

