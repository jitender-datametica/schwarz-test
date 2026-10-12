CREATE OR REPLACE PROCEDURE DBP_MACRO.m_ups_ts_mengenaenderungen_writeback_massenbearbeitung(P_MANDANT_ID NUMBER(38,0), P_DAT_BELADUNG VARCHAR(16777216),
 P_ART_IDS VARCHAR(16777216), P_ANGEBOTE VARCHAR(16777216), P_AKTIONEN VARCHAR(16777216),
 P_MENGE_OHNE_BESTAND_GENEHMIGT_FG NUMBER(38,0), P_MENGE_MIT_BESTAND_GENEHMIGT_FG NUMBER(38,0), P_WFL_MENGE_GEPRUEFT_FG NUMBER(38,0),P_ESTIMATION_ID NUMBER(38,0), P_ADJUSTMENT_ID NUMBER (38,0))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
COMMENT='Massenbearbeitung auf Freeze Write Back'
EXECUTE AS OWNER 
AS
$$
BEGIN 
---------------------------
------ STEP 1 UPDATE ------
IF (:P_MENGE_OHNE_BESTAND_GENEHMIGT_FG IS NOT NULL) THEN 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_DATA.ts_mengenaenderungen_writeback 
																			   
SET menge_ohne_bestand_genehmigt_fg =  :P_MENGE_OHNE_BESTAND_GENEHMIGT_FG , TD_UPDATE =  CURRENT_TIMESTAMP
WHERE MANDANT_ID = :P_MANDANT_ID 
AND ART_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.VALUE) > 1 )
AND ANGEBOT_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1)
AND AKTION_ID IN ( SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
AND DAT_BELADUNG = :P_DAT_BELADUNG

;

END IF;

IF (:P_MENGE_MIT_BESTAND_GENEHMIGT_FG IS NOT NULL) THEN 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_DATA.ts_mengenaenderungen_writeback 
SET menge_mit_bestand_genehmigt_fg =  :P_MENGE_MIT_BESTAND_GENEHMIGT_FG , TD_UPDATE =  CURRENT_TIMESTAMP
WHERE MANDANT_ID = :P_MANDANT_ID 
AND ART_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.VALUE) > 1 )
AND ANGEBOT_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1)
AND AKTION_ID IN (SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
AND DAT_BELADUNG = :P_DAT_BELADUNG

;

END IF;

IF (:P_WFL_MENGE_GEPRUEFT_FG IS NOT NULL) THEN 

UPDATE  DBP_DATA.ts_mengenaenderungen_writeback 
					  
SET wfl_menge_geprueft_fg =  :P_WFL_MENGE_GEPRUEFT_FG , TD_UPDATE =  CURRENT_TIMESTAMP
WHERE MANDANT_ID = :P_MANDANT_ID 
AND ART_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.VALUE) > 1 )
AND ANGEBOT_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1)
AND AKTION_ID IN (SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
AND DAT_BELADUNG = :P_DAT_BELADUNG

;

END IF;

IF (:P_ESTIMATION_ID IS NOT NULL) THEN 

UPDATE  DBP_DATA.ts_mengenaenderungen_writeback 
					  
SET estimation_id =  :P_ESTIMATION_ID , TD_UPDATE =  CURRENT_TIMESTAMP
WHERE MANDANT_ID = :P_MANDANT_ID 
AND ART_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.VALUE) > 1 )
AND ANGEBOT_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1)
AND AKTION_ID IN (SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
AND DAT_BELADUNG = :P_DAT_BELADUNG

;

END IF;

IF (:P_ADJUSTMENT_ID IS NOT NULL) THEN 

UPDATE  DBP_DATA.ts_mengenaenderungen_writeback 
					  
SET adjustment_id =  :P_ADJUSTMENT_ID , TD_UPDATE =  CURRENT_TIMESTAMP
WHERE MANDANT_ID = :P_MANDANT_ID 
AND ART_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.VALUE) > 1 )
AND ANGEBOT_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1)
AND AKTION_ID IN (SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
AND DAT_BELADUNG = :P_DAT_BELADUNG

;

END IF;

---------------------------
------ STEP 2 INSERT ------
--- Alle Artikel die vorhanden sind 

INSERT INTO DBP_DATA.ts_mengenaenderungen_writeback 
    (mandant_id, 
    aktion_id,
    art_id,
    dat_von,
    dat_bis,
    angebot_id, 
    dat_beladung, 
    menge_ohne_bestand_genehmigt_fg,
    menge_mit_bestand_genehmigt_fg,
    wfl_menge_geprueft_fg,
    estimation_id,
    adjustment_id,
    TD_UPDATE,
    TD_INSERT)
WITH Art_UPDATE AS
    (SELECT DISTINCT MANDANT_ID, AKTION_ID, ART_ID, DAT_VON, DAT_BIS, ANGEBOT_ID, DAT_BELADUNG FROM DBP_DATA.ts_mengenaenderungen_writeback  
     WHERE MANDANT_ID = :P_MANDANT_ID --AND KJWO IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO, '','')) AS table1 )
         AND ART_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 )
         AND ANGEBOT_ID IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1)
         AND AKTION_ID IN ( SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
         AND DAT_BELADUNG = :P_DAT_BELADUNG
    )
SELECT DISTINCT
        mandant_id
        , aktion_id
        , art_id
        , dat_ab 
        , dat_bis
        , offer_id
        , dat_beladung
        , :P_MENGE_OHNE_BESTAND_GENEHMIGT_FG
        , :P_MENGE_MIT_BESTAND_GENEHMIGT_FG
        , :P_WFL_MENGE_GEPRUEFT_FG
        --, :P_ESTIMATION_ID
        , CASE WHEN :P_ESTIMATION_ID=COALESCE (estimation_id,0) THEN NULL ELSE :P_ESTIMATION_ID END
        , CASE WHEN :P_ADJUSTMENT_ID=COALESCE (adjustment_id,0) THEN NULL ELSE :P_ADJUSTMENT_ID END
        , CURRENT_TIMESTAMP
        , CURRENT_TIMESTAMP
        FROM DBP_VIEW.v_wbs_werbeaenderungen
   WHERE mandant_id =  :P_MANDANT_ID  
        AND ART_ID IN  ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.VALUE) > 1)        
        AND offer_id IN ( SELECT table1.VALUE FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1 )
        AND AKTION_ID IN (SELECT LPAD(VALUE,10,'0') FROM (SELECT table1.VALUE FROM TABLE(split_to_table(:P_AKTIONEN, ',')) AS table1))
        AND DAT_BELADUNG = :P_DAT_BELADUNG
        AND NOT (MANDANT_ID, AKTION_ID, ART_ID, DAT_AB, DAT_BIS, OFFER_ID) IN (SELECT MANDANT_ID, AKTION_ID, ART_ID, DAT_VON, DAT_BIS, ANGEBOT_ID FROM ART_UPDATE);
        
        

COMMIT;
RETURN 'gefreezt';
END;
$$;