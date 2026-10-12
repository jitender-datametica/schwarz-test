--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id, spr_id FROM (SELECT mandant_id, spr_id  FROM DBP_DATA.mandant_spr_zu  UNION SELECT mandant_id, 22 AS spr_id  FROM DBP_DATA.mandant )x;

