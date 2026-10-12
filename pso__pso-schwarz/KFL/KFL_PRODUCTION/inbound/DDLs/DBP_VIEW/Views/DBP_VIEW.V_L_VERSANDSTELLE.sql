CREATE OR REPLACE VIEW DBP_VIEW.V_L_VERSANDSTELLE AS 
    SELECT 
        mandant_id
        ,versandstelle_id
        ,artikelsortiment_id
		,td_update
		,td_insert
FROM DBP_DATA.L_VERSANDSTELLE;