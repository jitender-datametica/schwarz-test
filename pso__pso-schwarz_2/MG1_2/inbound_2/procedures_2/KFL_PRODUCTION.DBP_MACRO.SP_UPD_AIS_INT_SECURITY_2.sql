CREATE OR REPLACE PROCEDURE KFL_PRODUCTION.DBP_MACRO.SP_UPD_AIS_INT_SECURITY(P_FUNC VARCHAR, P_GRUPPEID NUMBER, P_GRUPPEBEZ VARCHAR, P_GRUPPEBEZNEU VARCHAR, P_LOESCHFLAG NUMBER, P_GRUPPEPARENTID NUMBER, P_PFLEGEFLAG NUMBER, P_ZEKID VARCHAR, P_MANDANTID NUMBER, P_USERID VARCHAR, P_DAT_GUELTIG_BIS DATE)
    RETURNS VARCHAR LANGUAGE SQL
    AS $$

DECLARE
    v_temp_check_gruppe NUMBER;
    v_temp_check_gruppe_user_zu NUMBER;
    v_temp_check_gruppe_gruppe_zu NUMBER;
    v_temp_check_gruppe_zek_zu NUMBER;
    v_temp_anzahl_zeilen NUMBER;
BEGIN

CASE :P_FUNC
/* ---- FUNC = GRUPPE_2 START ------------------*/
     WHEN 'Gruppe_2' THEN 	
        // Pruefen ob eine_2 Gruppe_2 mit dem Namen bereits exisitiert
        SELECT COUNT(gruppe_bez) INTO :v_temp_check_gruppe  FROM DBP_SECURITY.gruppe_2 WHERE Upper(Trim(gruppe_bez)) = Upper(Coalesce(Trim(:P_GRUPPEBEZNEU), Trim(:P_GRUPPEBEZ)));
        
        // Wenn diese noch kein Eintrag exisitert 
        IF(:v_temp_check_gruppe = 0 ) THEN 
        // Security Tabelle updaten oder inserten; Merge deswegen da das Statemnt durch das MAX ein Komplexes ist; Upsert geht nicht.
        MERGE INTO DBP_SECURITY.gruppe_2 AS secgrp 
            USING (
               SELECT 
                  COALESCE(
                     (
                        SELECT gruppe_id FROM DBP_SECURITY.gruppe_2 
                        WHERE gruppe_id = :P_GRUPPEID
                     ), Max(gruppe_id)+1
                  ) AS gruppe_id
               FROM DBP_SECURITY.gruppe_2
            ) AS usigrp 
            ON secgrp.gruppe_id = usigrp.gruppe_id
            WHEN MATCHED THEN
               UPDATE SET gruppe_bez = Trim(:P_GRUPPEBEZNEU)
            WHEN NOT MATCHED THEN
               INSERT (GRUPPE_ID, GRUPPE_BEZ)
               VALUES (usigrp.gruppe_id, Trim(:P_GRUPPEBEZ));
       ELSE 
            RETURN 'Gruppe_2 vorhanden!'; 
       END IF;
/*---- FUNC = GRUPPE_2 END ------------------*/

/*---- FUNC = Gruppe_2 loeschen START ------------------*/
   // Logik für das Löschen von Gruppen
    WHEN 'Gruppe_2 loeschen' THEN
        // Pruefung ob Gruppe_2 bestehende Abhaengigkeiten zu Usern hat
        SELECT COUNT(GRUPPE_ID)  INTO :v_temp_check_gruppe_user_zu FROM DBP_SECURITY.gruppe_user_zu_2 WHERE gruppe_id = :P_GRUPPEID;
        // Prüfung ob Gruppe_2 bestehende Abhängigkeiten zu anderen Gruppen hat
        SELECT COUNT(gruppe_parent_id) INTO :v_temp_check_gruppe_gruppe_zu FROM DBP_SECURITY.gruppe_gruppe_zu_2 WHERE gruppe_parent_id = :P_GRUPPEID;
         // Prüfung ob Gruppe_2 bestehende Abhängigkeiten zu ZEK_2 hat
        SELECT COUNT(gruppe_id) INTO :v_temp_check_gruppe_zek_zu FROM DBP_SECURITY.gruppe_zek_zu_2 WHERE gruppe_id = :P_GRUPPEID;
        IF (:v_temp_check_gruppe_user_zu = 0 AND :v_temp_check_gruppe_gruppe_zu = 0 AND :v_temp_check_gruppe_zek_zu= 0) THEN 
             DELETE FROM DBP_SECURITY.gruppe_2 WHERE gruppe_id = :P_GRUPPEID AND :P_LOESCHFLAG = 1;
        ELSE 
            RETURN 'Abhaengigkeiten vorhanden!'; 
        END IF;
/*---- FUNC = Gruppe_2 loeschen END ------------------*/

/*---- FUNC = Gruppe_2 zu Gruppe_2 START ------------------*/
   // Logik von Zuordnung der Gruppen zueinander (Aendern und loeschen)
   WHEN 'Gruppe_2 zu Gruppe_2' THEN 
        // Logik für das Ändern von Zuordnungen der Gruppen zueinander
        // PflegeFlag ist 1 wenn eine_2 neue Zuordnung erfolgt; Punkt ist gesetzt
        CASE :P_PFLEGEFLAG 
            WHEN 1 THEN 
                // Prüfung ob Parent Gruppe_2 bestehende Abhängigkeiten zu ZEK_2 hat
                SELECT COUNT(gruppe_id) INTO :v_temp_check_gruppe_zek_zu FROM DBP_SECURITY.gruppe_zek_zu_2 WHERE gruppe_id = :P_GRUPPEPARENTID;
                
                IF (:v_temp_check_gruppe_zek_zu = 0 ) THEN 
                    //Einfügen oder Updaten; muss erfolgen weil der Anwender den Punkt erst aus und dann wieder an machen kann innerhalb einer Transaktion
                    
                    // Wenn eintrag vorhanden nichts machen 
                    SELECT COUNT(gruppe_parent_id) INTO :v_temp_anzahl_zeilen FROM DBP_SECURITY.gruppe_gruppe_zu_2
                    WHERE gruppe_parent_id = :P_GRUPPEPARENTID AND gruppe_id = :P_GRUPPEID;
                    
                   IF(:v_temp_anzahl_zeilen = 0) THEN 
                       INSERT INTO DBP_SECURITY.gruppe_gruppe_zu_2 (GRUPPE_PARENT_ID ,GRUPPE_ID)
                       VALUES (:P_GRUPPEPARENTID, :P_GRUPPEID);
                   END IF;
                    
                ELSE
                    RETURN 'Gruppe_2 nicht geaendert!';
                END IF;
            // Logik für das Löschen von Zuordnungen der Gruppen zueinander
            // PflegeFlag ist 0 wenn die Zuordnung gelöscht werden soll; Punkt ist nicht gesetzt
            WHEN 0 THEN
                DELETE FROM DBP_SECURITY.gruppe_gruppe_zu_2 WHERE gruppe_id = :P_GRUPPEID AND gruppe_parent_id = :P_GRUPPEPARENTID;
        END;
/* ---- FUNC = Gruppe_2 zu Gruppe_2 END  check ------------------*/

 
/* ---- FUNC = ZEK_2 START ------------------*/
   // Logik von Zuordnung der ZEK_2  (Aendern und loeschen)
   WHEN 'ZEK_2 zuordnen' THEN             
        CASE :P_PFLEGEFLAG 
            WHEN 1 THEN
                // Überprüfung ob die Grupppe eine_2 Blatt Gruppe_2 ist
                //falls nicht, darf eine_2 Zuordnung von ZEKs nicht erfolgen.
                SELECT COUNT(gruppe_parent_id) INTO :v_temp_check_gruppe_gruppe_zu FROM DBP_SECURITY.gruppe_gruppe_zu_2 WHERE gruppe_parent_id = :P_GRUPPEID;

                IF (:v_temp_check_gruppe_gruppe_zu = 0 AND :P_ZEKID = '-1') THEN 
                    // Alle Zek_2 ist ausgewählt
                    // Security Tabelle updaten oder inserten; Merge deswegen da das Statemnt durch das ermitteln aller ZEKs ein Komplexes ist; Upsert geht nicht.
                    // Sollten vorher Einträge da sein wo alle_zek nicht ausgewählt ist, bestehende Einträge mit alle Zek_2 = 1 updaten
                    // Neue Einträge eintragen mit alle_zel = 1
                    MERGE INTO DBP_SECURITY.gruppe_zek_zu_2 AS secgrpzek 
                       USING (
                          SELECT zek_id
                          FROM DBP_VIEW.v_zek_2 
                          WHERE mandant_id = :P_MANDANTID AND wbl_id > 0 ) AS usizek 
                       ON secgrpzek.gruppe_id = :P_GRUPPEID
                       AND secgrpzek.zek_id = usizek.zek_id 
                       AND secgrpzek.mandant_id = :P_MANDANTID
                       WHEN MATCHED THEN
                          UPDATE SET alle_zek_fg = 1
                       WHEN NOT MATCHED THEN
                          INSERT (GRUPPE_ID, ZEK_ID, MANDANT_ID, ALLE_ZEK_FG)
                          VALUES (:P_GRUPPEID, usizek.zek_id, :P_MANDANTID, 1);
                ELSEIF (:v_temp_check_gruppe_gruppe_zu = 0 AND :P_ZEKID != '-1') THEN
                    //Einfügen oder Updaten; muss erfolgen weil der Anwender den Punkt erst aus und dann wieder an machen kann innerhalb einer Transaktion
                    
                    // Wenn eintrag vorhanden nichts machen 
                    SELECT COUNT(gruppe_id) INTO :v_temp_anzahl_zeilen FROM DBP_SECURITY.gruppe_zek_zu_2
                    WHERE mandant_id = :P_MANDANTID AND gruppe_id = :P_GRUPPEID AND zek_id = :P_ZEKID;
                    
                    IF (:v_temp_anzahl_zeilen = 0) THEN 
                        INSERT INTO DBP_SECURITY.gruppe_zek_zu_2 (GRUPPE_ID, ZEK_ID, MANDANT_ID, ALLE_ZEK_FG) VALUES (:P_GRUPPEID, :P_ZEKID, :P_MANDANTID, 0);
                    END IF;
                   
               ELSE
                  RETURN 'Gruppe_2 eine_2 Blatt Gruppe_2 NICHT geaendert!';
               END IF;               
            WHEN 0 THEN
                IF (:P_ZEKID = '-1') THEN
                    // Zuordnung löschen für die gesamte Gruppe_2 und Mandant_2 (alle_zek ist ausgewählt)
                    DELETE FROM DBP_SECURITY.gruppe_zek_zu_2 WHERE gruppe_id = :P_GRUPPEID AND mandant_id = :P_MANDANTID;
                ELSE 
                    // Zuordnung löschen nur gewählter ZEK_2 
                    DELETE FROM DBP_SECURITY.gruppe_zek_zu_2 WHERE gruppe_id = :P_GRUPPEID AND zek_id = :P_ZEKID AND mandant_id = :P_MANDANTID;
                    // Jetzt prüfen ob vor dem Delete Alle_Zek usgewählt war.
                    SELECT COUNT(gruppe_id) INTO :v_temp_check_gruppe_zek_zu FROM DBP_SECURITY.gruppe_zek_zu_2 WHERE gruppe_id = :P_GRUPPEID AND zek_id = '-1' AND mandant_id = :P_MANDANTID;
                    IF (:v_temp_check_gruppe_zek_zu>0) THEN
                        // Wenn alle Zek_2 ausgewählt war, jetzt den Eintrag mit Zek_ID -1 löschen
                        DELETE FROM DBP_SECURITY.gruppe_zek_zu_2 WHERE gruppe_id = :P_GRUPPEID AND mandant_id = :P_MANDANTID  AND zek_id = '-1';
                        //Ausserdem alle bestehenden Einträge ändern auf alle_zek = 0
                        UPDATE DBP_SECURITY.gruppe_zek_zu_2 SET alle_zek_fg = 0 WHERE gruppe_id = :P_GRUPPEID AND mandant_id = :P_MANDANTID;
                    END IF;
                END IF;
            END;
/*---- FUNC = ZEK_2 END ------------------*/

   WHEN 'User Gruppe_2 zuordnen' THEN
        // Wenn eintrag vorhanden nichts machen 
        SELECT COUNT(gruppe_id) INTO :v_temp_anzahl_zeilen FROM DBP_SECURITY.gruppe_user_zu_2
        WHERE  gruppe_id = :P_GRUPPEID AND user_id = :P_USERID;
        //Einfügen der neuen Zuordnung 
        IF ( :v_temp_anzahl_zeilen = 0 AND :P_DAT_GUELTIG_BIS >= CURRENT_DATE()) THEN 
            INSERT INTO DBP_SECURITY.gruppe_user_zu_2 (GRUPPE_ID, USER_ID, DAT_GUELTIG_BIS, TD_UPDATE) VALUES (:P_GRUPPEID, :P_USERID, :P_DAT_GUELTIG_BIS, CURRENT_DATE());
        END IF;
        
      
   WHEN 'User Gruppe_2 ändern' THEN
   
        //Fall 1: Zuordnung loeschen
        IF (:P_LOESCHFLAG = 1) THEN
            DELETE FROM DBP_SECURITY.gruppe_user_zu_2
                WHERE gruppe_id = :P_GRUPPEID
                AND user_id = :P_USERID
                AND :P_LOESCHFLAG = 1;
            
        //Fall 2: Gültigkeitsdatum ändern
        ELSEIF (:P_DAT_GUELTIG_BIS >= CURRENT_DATE()) THEN
            UPDATE DBP_SECURITY.gruppe_user_zu_2
                SET dat_gueltig_bis = :P_DAT_GUELTIG_BIS, td_update = CURRENT_DATE()
                WHERE gruppe_id = :P_GRUPPEID
                AND user_id = :P_USERID;

        END IF;
         
END;


 // Wenn es neue ZEKs / bei Mandanten gibt und Gruppen bei denen ALLE_ZEG ausgewählt ist füge die neuen ZEKs jetzt in Gruppe_Zek_zu_2 hinzu 
 // Neue Einträge eintragen mit alle_zel = 1
     
 MERGE INTO DBP_SECURITY.gruppe_zek_zu_2 AS secgrpzek 
 USING (
    SELECT
        g.gruppe_id
      , z.zek_id
      , g.mandant_id
    FROM DBP_SECURITY.gruppe_zek_zu_2 g
    JOIN DBP_VIEW.v_zek_2 z
    ON (g.mandant_id = z.mandant_id)
    WHERE z.wbl_id > 0 AND g.zek_id = '-1' AND z.zek_id <> '-1'
    MINUS
    SELECT
        gruppe_id
      , zek_id
      , mandant_id
    FROM DBP_SECURITY.gruppe_zek_zu_2
    WHERE alle_zek_fg = 1  AND zek_id <> '-1') AS usizek 
 ON secgrpzek.gruppe_id = usizek.gruppe_id 
 AND secgrpzek.zek_id = usizek.zek_id 
 AND secgrpzek.mandant_id = usizek.mandant_id
 WHEN NOT MATCHED THEN
 INSERT (secgrpzek.GRUPPE_ID, secgrpzek.ZEK_ID, secgrpzek.MANDANT_ID, secgrpzek.ALLE_ZEK_FG)
 VALUES (usizek.gruppe_id, usizek.zek_id, usizek.mandant_id, 1);
      
 // Erstellen USER_ZEK_ZU_2
 // Löschen der bestehenden Sätze in user_zek_zu_2
 DELETE FROM DBP_SECURITY.user_zek_zu_2;
 
 -- Kompletter Neuaufbau der Tabelle anhand der gepflegten Tabellen
 INSERT INTO DBP_SECURITY.user_zek_zu_2 (
     mandant_id
   , zek_id
   , user_id) 
 SELECT DISTINCT 
     mandant_id
   , zek_id
   , user_id
 FROM (

 -- Zek_2 und User sind direkt einer Gruppe_2 zugeordnet
    SELECT
        z.mandant_id
      , z.zek_id
      , u.user_id 
    FROM DBP_SECURITY.gruppe_user_zu_2 u
    INNER JOIN DBP_SECURITY.gruppe_zek_zu_2 z
    ON u.gruppe_id = z.gruppe_id
    AND u.dat_gueltig_bis >= current_date()
    UNION -- Zek_2 und User der ersten Gruppen-Gruppen Zuordnung
    SELECT
       z.mandant_id
    , z.zek_id
    , u.user_id
    FROM DBP_SECURITY.gruppe_gruppe_zu_2 g
    INNER JOIN DBP_SECURITY.gruppe_user_zu_2 u 

    /*User koennen jeder Ebene zugeordnet sein*/
    ON (g.gruppe_id          = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (g.gruppe_parent_id = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
    INNER JOIN DBP_SECURITY.gruppe_zek_zu_2 z

    /*zeks koennen nur auf Blattebene zugeordnet sein*/
    ON g.gruppe_id = z.gruppe_id 
    UNION -- Zek_2 und User der zweiten Gruppen-Gruppen Zuordnung
    SELECT
       z.mandant_id
    , z.zek_id
    , u.user_id
    FROM DBP_SECURITY.gruppe_gruppe_zu_2 g
    INNER JOIN DBP_SECURITY.gruppe_gruppe_zu_2 gg
    ON g.gruppe_id = gg.gruppe_parent_id
    INNER JOIN DBP_SECURITY.gruppe_user_zu_2 u 

    /*User koennen jeder Ebene zugeordnet sein*/
    ON (g.gruppe_id          = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (g.gruppe_parent_id = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (gg.gruppe_id       = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
    INNER JOIN DBP_SECURITY.gruppe_zek_zu_2 z

    /*zeks koennen nur auf Blattebene zugeordnet sein*/
    ON gg.gruppe_id = z.gruppe_id 
 ) a;
  

COMMIT;

RETURN 'Erfolgreich';
END;
    $$