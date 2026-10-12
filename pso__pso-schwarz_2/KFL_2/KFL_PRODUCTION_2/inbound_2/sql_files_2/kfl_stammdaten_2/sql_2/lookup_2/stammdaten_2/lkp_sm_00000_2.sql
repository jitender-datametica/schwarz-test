--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT sm.mandant_id,trim(sm.sap_sm_id) as sap_sm_id,sm.sm_id FROM DBP_DATA.sm_2 sm_2 INNER JOIN DBP_DATA.mandant_spr_zu_2 ma ON ma.mandant_id = sm.mandant_id AND ma.spr_id = sm.spr_id;

