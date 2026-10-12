CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_WBS_REFMARKT_MASSENBEARBEITUNG(
    "P_MANDANT_ID" FLOAT, 
    "P_WUPs" VARCHAR, 
    "P_NBs" VARCHAR, 
    --"P_ESTIMATION_FG" FLOAT, 
   -- "P_ADJUSTMENT_FG" FLOAT,
    "P_CLEAR_STOCK_AUSSCHLUSS_FG" FLOAT

)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE 
    dummy_1 FLOAT;
BEGIN

------ STEP 1 UPDATE ------
/*IF (:P_ADJUSTMENT_FG IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_MSI_DATA.TS_WBS_REFMARKT_1
set ADJUSTMENT_ID =  :P_ADJUSTMENT_FG  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPs, ',')) AS table1)
AND NB_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_NBs, ',')) AS table1);
END IF;

IF (:P_ESTIMATION_FG IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_MSI_DATA.TS_WBS_REFMARKT_1
set ESTIMATION_ID =  :P_ESTIMATION_FG  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPs, ',')) AS table1)
AND NB_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_NBs, ',')) AS table1);
END IF;*/

IF (:P_CLEAR_STOCK_AUSSCHLUSS_FG IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_MSI_DATA.TS_WBS_REFMARKT_1
set CLEAR_STOCK_AUSSCHLUSS_FG =  :P_CLEAR_STOCK_AUSSCHLUSS_FG  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPs, ',')) AS table1 )
AND NB_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_NBs, ',')) AS table1 );
END IF;

------ STEP 2 INSERT ------


 INSERT INTO DBP_MSI_DATA.TS_WBS_REFMARKT_1 (
        MANDANT_ID, 
        WUP_ID, 
        NB_ID,
        WUP_ID_REF,
        NB_ID_REF,
        REF_FAKTOR_FALLBACK,
        MANDANT_ID_VZ_FALLBACK,
        WUP_ID_VZ_FALLBACK,
        NB_ID_VZ_FALLBACK,
        --ESTIMATION_ID,
       -- ADJUSTMENT_ID,
        MIN_PLATZIERUNG_MARKT_CLUSTER_ID,
        CLEAR_STOCK_AUSSCHLUSS_FG,
        TD_UPDATE,
        TD_INSERT
    )

    WITH WUP_UPDATE AS
    (SELECT * FROM DBP_MSI_DATA.TS_WBS_REFMARKT_1
     WHERE MANDANT_ID = :P_MANDANT_ID 
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPs, ',')) AS table1 )
AND NB_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_NBs, ',')) AS table1 )
    )
SELECT
        MANDANT_ID, 
        WUP_ID, 
        NB_ID, 
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        --:P_ESTIMATION_FG,
       -- :P_ADJUSTMENT_FG,
        NULL,
        :P_CLEAR_STOCK_AUSSCHLUSS_FG,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
FROM DBP_VIEW.V_WUP_1 wup_1 
 WHERE MANDANT_ID = :P_MANDANT_ID 
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPs, ',')) AS table1 )
AND NB_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_NBs, ',')) AS table1 )
        AND NOT (MANDANT_ID, WUP_ID, NB_ID) IN (SELECT MANDANT_ID, WUP_ID, NB_ID FROM WUP_UPDATE)
;
COMMIT;
RETURN 'WUP_1 gespeichert';
END;
$$;
