CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_wbs_vz_tag(IN P_MANDANT_ID FLOAT64, IN P_WUP_ID FLOAT64, IN P_NB_ID FLOAT64, IN P_DAT STRING, IN P_NON_ADJUSTABLE_DAY_FG FLOAT64, IN P_KOMMENTAR STRING, IN P_TS_LOESCHEN FLOAT64, OUT out_param STRING)
BEGIN
DECLARE var_currentDate DATE;
BEGIN
BEGIN TRANSACTION;
SET var_currentDate  =  (SELECT CURRENT_DATE("Europe/Berlin"));

IF PARSE_DATE('%F', P_DAT) < var_currentDate AND P_TS_LOESCHEN <> 1 THEN
    BEGIN
    RAISE USING MESSAGE = 'Date is in the past. Please use a future date only.';
    SET out_param  =  'Nicht gespeichert - Datum liegt in der Vergangenheit';
    SELECT out_param;
    RETURN;
    END;
ELSE
    BEGIN

    IF P_TS_LOESCHEN = 1 THEN
        DELETE FROM dbp_data.ts_wbs_vz_tag_1
WHERE mandant_id = P_MANDANT_ID AND wup_id = P_WUP_ID AND nb_id = P_NB_ID AND dat = CAST(P_DAT AS DATE);
    ELSE 
    
    MERGE INTO dbp_data.ts_wbs_vz_tag_1 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_WUP_ID AS wup_id, P_NB_ID AS nb_id, P_DAT AS dat, P_NON_ADJUSTABLE_DAY_FG AS non_adjustable_day_fg, P_KOMMENTAR AS kommentar) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.wup_id = source.wup_id AND TARGET.nb_id = source.nb_id AND TARGET.dat = CAST(source.dat AS DATE)
WHEN MATCHED THEN UPDATE SET
    non_adjustable_day_fg = CAST(source.non_adjustable_day_fg AS INTEGER),
    kommentar = source.kommentar
WHEN NOT MATCHED THEN INSERT (mandant_id, wup_id, nb_id, dat, non_adjustable_day_fg, kommentar) VALUES(CAST(source.mandant_id AS INTEGER), CAST(source.wup_id AS INTEGER), CAST(source.nb_id AS INTEGER), CAST(source.dat AS DATE), CAST(source.non_adjustable_day_fg AS INTEGER), source.kommentar);
    END IF;

    COMMIT TRANSACTION;
    SET out_param  =  'Wurde abgespeichert/geaendert';
    SELECT out_param;
    RETURN;
    END;
END IF;

END;
END;
