--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id,MAX(aktion_id) as max_aktion_id FROM DBP_DATA.aktion_2 GROUP BY mandant_id ORDER BY mandant_id;

