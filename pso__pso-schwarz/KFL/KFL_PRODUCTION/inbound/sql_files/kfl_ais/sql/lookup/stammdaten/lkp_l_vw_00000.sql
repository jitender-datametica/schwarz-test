--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id, trim( sap_vw_id) as sap_vw_id, vw_id FROM DBP_DATA.l_vw ORDER BY 1,2;

