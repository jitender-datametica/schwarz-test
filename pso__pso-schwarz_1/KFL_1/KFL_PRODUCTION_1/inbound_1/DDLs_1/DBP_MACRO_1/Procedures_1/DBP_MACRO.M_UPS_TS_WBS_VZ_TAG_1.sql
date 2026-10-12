CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_WBS_VZ_TAG(
	P_MANDANT_ID FLOAT, 
	P_WUP_ID FLOAT, 
	P_NB_ID FLOAT, 
	P_DAT VARCHAR, 
	P_NON_ADJUSTABLE_DAY_FG FLOAT, 
	P_KOMMENTAR VARCHAR(100), 
	P_TS_LOESCHEN FLOAT)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS $$
DECLARE 
    NOT_UPDATED_REC EXCEPTION(-20001,'Date is in the past. Please use a future date only.');
    var_currentDate date;

BEGIN 

SELECT current_date  INTO :var_currentDate;


IF ( TO_DATE(:P_DAT,'YYYY-MM_1-DD') < :var_currentDate AND :P_TS_LOESCHEN != 1 ) THEN
    RAISE NOT_UPDATED_REC;
    RETURN 'Nicht gespeichert - Datum liegt in der Vergangenheit';
ELSE 
IF (:P_TS_LOESCHEN = 1 ) THEN 
DELETE FROM DBP_DATA.ts_wbs_vz_tag_1
WHERE MANDANT_ID = :P_MANDANT_ID
    AND WUP_ID = :P_WUP_ID
    AND NB_ID = :P_NB_ID
    AND DAT = :P_DAT;

ELSE

MERGE INTO DBP_DATA.ts_wbs_vz_tag_1 as target
    USING (
	    SELECT
	    	:P_MANDANT_ID AS mandant_id
	    	, :P_WUP_ID AS wup_id
	    	, :P_NB_ID AS nb_id
    		, :P_DAT AS dat
    		, :P_NON_ADJUSTABLE_DAY_FG AS non_adjustable_day_fg
    		, :P_KOMMENTAR AS kommentar
    	) AS source
    	ON target.mandant_id = SOURCE.mandant_id
        	AND target.wup_id = SOURCE.wup_id
	    	AND target.nb_id = SOURCE.nb_id
	    	AND target.dat = SOURCE.dat
    	WHEN MATCHED THEN
    		UPDATE SET target.non_adjustable_day_fg = SOURCE.non_adjustable_day_fg
    			   , target.kommentar = SOURCE.kommentar
    	WHEN NOT MATCHED THEN
    		INSERT (mandant_id, wup_id, nb_id, dat, non_adjustable_day_fg, kommentar)
    		VALUES (
    			source.mandant_id
    			, source.wup_id
	    		, source.nb_id
		    	, source.dat
			    , source.non_adjustable_day_fg
    			, source.kommentar);
END IF;
COMMIT;

RETURN 'Wurde abgespeichert/geaendert';
END IF;
END;
$$
;