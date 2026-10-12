-- vorher DBP_MACRO.SP_UPS_TS_PROCESSBORD_ZEITSLOTS



CREATE OR REPLACE PROCEDURE dbp_macro.sp_ups_ts_wbs_customizing_zeitslots(IN P_MANDANT_ID FLOAT64, IN P_AUSLIEFERUNGSGRUPPE_ID STRING, IN P_dat STRING, IN P_ZEITSLOT_ID FLOAT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_msi_data.ts_wbs_zeitslots_aenderung_1 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_AUSLIEFERUNGSGRUPPE_ID AS auslieferungsgruppe_id, P_dat AS dat, P_ZEITSLOT_ID AS zeitslot_id) AS SOURCE
ON TARGET.mandant_id = SOURCE.mandant_id AND TARGET.auslieferungsgruppe_id = SOURCE.auslieferungsgruppe_id AND TARGET.dat = CAST(SOURCE.dat AS DATE)
WHEN MATCHED THEN UPDATE SET
    zeitslot_id = CAST(SOURCE.zeitslot_id AS INTEGER)
WHEN NOT MATCHED THEN INSERT (mandant_id, auslieferungsgruppe_id, dat, zeitslot_id) VALUES(CAST(SOURCE.mandant_id AS INTEGER), SOURCE.auslieferungsgruppe_id, CAST(SOURCE.dat AS DATE), CAST(SOURCE.zeitslot_id AS INTEGER));
COMMIT TRANSACTION;
SET out_param  =  'Zeitslot abgespeichert! ';
SELECT out_param;
RETURN;
END;
