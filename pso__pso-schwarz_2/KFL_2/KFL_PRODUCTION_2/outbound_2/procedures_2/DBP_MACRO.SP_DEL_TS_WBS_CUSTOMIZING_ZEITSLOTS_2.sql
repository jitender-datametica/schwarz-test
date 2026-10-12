-- vorher DBP_MACRO.SP_DEL_TS_PROCESSBORD_ZEITSLOTS



--P_AUSLIEFERUNGSGRUPPE_ID STRING(10) , 



-- P_ZEITSLOT_ID FLOAT



CREATE OR REPLACE PROCEDURE dbp_macro.sp_del_ts_wbs_customizing_zeitslots(IN P_MANDANT_ID FLOAT64, IN P_KJWO FLOAT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
-- Auf Standardwerte zuruecksetzen 
DELETE FROM dbp_msi_data.ts_wbs_zeitslots_aenderung_2
WHERE dat IN (SELECT dat
            FROM dbp_view.v_tag_2
            WHERE kjwo = P_KJWO) AND mandant_id = P_MANDANT_ID;
COMMIT TRANSACTION;
SET out_param  =  'Zeitslot zurueckgesetzt! ';
SELECT out_param;
RETURN;
END;
