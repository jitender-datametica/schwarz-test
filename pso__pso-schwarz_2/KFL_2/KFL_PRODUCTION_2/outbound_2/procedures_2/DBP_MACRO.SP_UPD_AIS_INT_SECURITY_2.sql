CREATE OR REPLACE PROCEDURE dbp_macro.sp_upd_ais_int_security(IN P_FUNC STRING, IN P_GRUPPEID INT64, IN P_GRUPPEBEZ STRING, IN P_GRUPPEBEZNEU STRING, IN P_LOESCHFLAG INT64, IN P_GRUPPEPARENTID INT64, IN P_PFLEGEFLAG INT64, IN P_ZEKID STRING, IN P_MANDANTID INT64, IN P_USERID STRING, IN P_DAT_GUELTIG_BIS DATE, OUT out_param STRING)
BEGIN
DECLARE v_temp_check_gruppe INT64;
DECLARE v_temp_check_gruppe_user_zu INT64;
DECLARE v_temp_check_gruppe_gruppe_zu INT64;
DECLARE v_temp_check_gruppe_zek_zu INT64;
DECLARE v_temp_anzahl_zeilen INT64;
BEGIN TRANSACTION;

IF P_FUNC = 'Gruppe_2' THEN
    BEGIN
    /* ---- FUNC = GRUPPE_2 START ------------------*/
    ----// Pruefen ob eine_2 Gruppe_2 mit dem Namen bereits exisitiert
    SET v_temp_check_gruppe  =  (SELECT COUNT(gruppe_bez)
FROM dbp_security.gruppe_2
WHERE UPPER(TRIM(gruppe_bez)) = UPPER(COALESCE(TRIM(P_GRUPPEBEZNEU), TRIM(P_GRUPPEBEZ))));
    --// Wenn diese noch kein Eintrag exisitert 

    IF v_temp_check_gruppe = 0 THEN
        BEGIN
        --// Security Tabelle updaten oder inserten; Merge deswegen da das Statemnt durch das MAX ein Komplexes ist; Upsert geht nicht.
        MERGE INTO dbp_security.gruppe_2 AS SECGRP
USING (SELECT COALESCE((SELECT gruppe_id
                FROM dbp_security.gruppe_2
                WHERE gruppe_id = P_GRUPPEID), MAX(gruppe_id) + 1) AS gruppe_id
    FROM dbp_security.gruppe_2) AS usigrp
ON SECGRP.gruppe_id = usigrp.gruppe_id
WHEN MATCHED THEN UPDATE SET
    gruppe_bez = TRIM(P_GRUPPEBEZNEU)
WHEN NOT MATCHED THEN INSERT (gruppe_id, gruppe_bez) VALUES(usigrp.gruppe_id, TRIM(P_GRUPPEBEZ));
        END;
    ELSE
        SET out_param  =  'Gruppe_2 vorhanden!';
        SELECT out_param;
        RETURN;
    END IF;

    /*---- FUNC = GRUPPE_2 END ------------------*/
    /*---- FUNC = Gruppe_2 loeschen START ------------------*/
    --// Logik für das Löschen von Gruppen
    END;
ELSEIF P_FUNC = 'Gruppe_2 loeschen' THEN
    BEGIN
    --// Pruefung ob Gruppe_2 bestehende Abhaengigkeiten zu Usern hat
    SET v_temp_check_gruppe_user_zu  =  (SELECT COUNT(gruppe_id)
FROM dbp_security.gruppe_user_zu_2
WHERE gruppe_id = P_GRUPPEID);
    --// Prüfung ob Gruppe_2 bestehende Abhängigkeiten zu anderen Gruppen hat
    SET v_temp_check_gruppe_gruppe_zu  =  (SELECT COUNT(gruppe_parent_id)
FROM dbp_security.gruppe_gruppe_zu_2
WHERE gruppe_parent_id = P_GRUPPEID);
    --// Prüfung ob Gruppe_2 bestehende Abhängigkeiten zu ZEK_2 hat
    SET v_temp_check_gruppe_zek_zu  =  (SELECT COUNT(gruppe_id)
FROM dbp_security.gruppe_zek_zu_2
WHERE gruppe_id = P_GRUPPEID);

    IF v_temp_check_gruppe_user_zu = 0 AND v_temp_check_gruppe_gruppe_zu = 0 AND v_temp_check_gruppe_zek_zu = 0 THEN
        DELETE FROM dbp_security.gruppe_2
WHERE gruppe_id = P_GRUPPEID AND P_LOESCHFLAG = 1;
    ELSE
        SET out_param  =  'Abhaengigkeiten vorhanden!';
        SELECT out_param;
        RETURN;
    END IF;

    /*---- FUNC = Gruppe_2 loeschen END ------------------*/
    /*---- FUNC = Gruppe_2 zu Gruppe_2 START ------------------*/
    --// Logik von Zuordnung der Gruppen zueinander (Aendern und loeschen)
    END;
ELSEIF P_FUNC = 'Gruppe_2 zu Gruppe_2' THEN
    BEGIN
    --// Logik für das Ändern von Zuordnungen der Gruppen zueinander
    --// PflegeFlag ist 1 wenn eine_2 neue Zuordnung erfolgt; Punkt ist gesetzt

    IF P_PFLEGEFLAG = 1 THEN
        BEGIN
        --// Prüfung ob Parent Gruppe_2 bestehende Abhängigkeiten zu ZEK_2 hat
        SET v_temp_check_gruppe_zek_zu  =  (SELECT COUNT(gruppe_id)
FROM dbp_security.gruppe_zek_zu_2
WHERE gruppe_id = P_GRUPPEPARENTID);

        IF v_temp_check_gruppe_zek_zu = 0 THEN
            BEGIN
            --//Einfügen oder Updaten; muss erfolgen weil der Anwender den Punkt erst aus und dann wieder an machen kann innerhalb einer Transaktion
            --// Wenn eintrag vorhanden nichts machen 
            SET v_temp_anzahl_zeilen  =  (SELECT COUNT(gruppe_parent_id)
FROM dbp_security.gruppe_gruppe_zu_2
WHERE gruppe_parent_id = P_GRUPPEPARENTID AND gruppe_id = P_GRUPPEID);

            IF v_temp_anzahl_zeilen = 0 THEN
                INSERT INTO dbp_security.gruppe_gruppe_zu_2 (gruppe_parent_id, gruppe_id)
(SELECT CAST(P_GRUPPEPARENTID AS INTEGER) AS gruppe_parent_id, CAST(P_GRUPPEID AS INTEGER) AS gruppe_id);
            END IF;

            END;
        ELSE
            SET out_param  =  'Gruppe_2 nicht geaendert!';
            SELECT out_param;
            RETURN;
        END IF;

        --// Logik für das Löschen von Zuordnungen der Gruppen zueinander
        --// PflegeFlag ist 0 wenn die Zuordnung gelöscht werden soll; Punkt ist nicht gesetzt
        END;
    ELSEIF P_PFLEGEFLAG = 0 THEN
        DELETE FROM dbp_security.gruppe_gruppe_zu_2
WHERE gruppe_id = P_GRUPPEID AND gruppe_parent_id = P_GRUPPEPARENTID;
    END IF;

    /* ---- FUNC = Gruppe_2 zu Gruppe_2 END  check ------------------*/
    /* ---- FUNC = ZEK_2 START ------------------*/
    --// Logik von Zuordnung der ZEK_2  (Aendern und loeschen)
    END;
ELSEIF P_FUNC = 'ZEK_2 zuordnen' THEN
    BEGIN

    IF P_PFLEGEFLAG = 1 THEN
        BEGIN
        --// Überprüfung ob die Grupppe eine_2 Blatt Gruppe_2 ist
        --//falls nicht, darf eine_2 Zuordnung von ZEKs nicht erfolgen.
        SET v_temp_check_gruppe_gruppe_zu  =  (SELECT COUNT(gruppe_parent_id)
FROM dbp_security.gruppe_gruppe_zu_2
WHERE gruppe_parent_id = P_GRUPPEID);

        IF v_temp_check_gruppe_gruppe_zu = 0 AND P_ZEKID = '-1' THEN
            BEGIN
            --// Alle Zek_2 ist ausgewählt
            --// Security Tabelle updaten oder inserten; Merge deswegen da das Statemnt durch das ermitteln aller ZEKs ein Komplexes ist; Upsert geht nicht.
            --// Sollten vorher Einträge da sein wo alle_zek nicht ausgewählt ist, bestehende Einträge mit alle Zek_2 = 1 updaten
            --// Neue Einträge eintragen mit alle_zel = 1
            MERGE INTO dbp_security.gruppe_zek_zu_2 AS SECGRPZEK
USING (SELECT zek_id
    FROM dbp_view.v_zek_2
    WHERE mandant_id = P_MANDANTID AND wbl_id > 0) AS usizek
ON SECGRPZEK.gruppe_id = P_GRUPPEID AND SECGRPZEK.zek_id = usizek.zek_id AND SECGRPZEK.mandant_id = P_MANDANTID
WHEN MATCHED THEN UPDATE SET
    alle_zek_fg = 1
WHEN NOT MATCHED THEN INSERT (gruppe_id, zek_id, mandant_id, alle_zek_fg) VALUES(CAST(P_GRUPPEID AS INTEGER), usizek.zek_id, CAST(P_MANDANTID AS INTEGER), 1);
            END;
        ELSEIF v_temp_check_gruppe_gruppe_zu = 0 AND P_ZEKID <> '-1' THEN
            BEGIN
            --//Einfügen oder Updaten; muss erfolgen weil der Anwender den Punkt erst aus und dann wieder an machen kann innerhalb einer Transaktion
            --// Wenn eintrag vorhanden nichts machen 
            SET v_temp_anzahl_zeilen  =  (SELECT COUNT(gruppe_id)
FROM dbp_security.gruppe_zek_zu_2
WHERE mandant_id = P_MANDANTID AND gruppe_id = P_GRUPPEID AND zek_id = P_ZEKID);

            IF v_temp_anzahl_zeilen = 0 THEN
                INSERT INTO dbp_security.gruppe_zek_zu_2 (gruppe_id, zek_id, mandant_id, alle_zek_fg)
(SELECT CAST(P_GRUPPEID AS INTEGER) AS gruppe_id, P_ZEKID AS zek_id, CAST(P_MANDANTID AS INTEGER) AS mandant_id, 0 AS alle_zek_fg);
            END IF;

            END;
        ELSE
            SET out_param  =  'Gruppe_2 eine_2 Blatt Gruppe_2 NICHT geaendert!';
            SELECT out_param;
            RETURN;
        END IF;

        END;
    ELSEIF P_PFLEGEFLAG = 0 THEN

        IF P_ZEKID = '-1' THEN
            BEGIN
            --// Zuordnung löschen für die gesamte Gruppe_2 und Mandant_2 (alle_zek ist ausgewählt)
            DELETE FROM dbp_security.gruppe_zek_zu_2
WHERE gruppe_id = P_GRUPPEID AND mandant_id = P_MANDANTID;
            END;
        ELSE
            BEGIN
            --// Zuordnung löschen nur gewählter ZEK_2 
            DELETE FROM dbp_security.gruppe_zek_zu_2
WHERE gruppe_id = P_GRUPPEID AND zek_id = P_ZEKID AND mandant_id = P_MANDANTID;
            --// Jetzt prüfen ob vor dem Delete Alle_Zek usgewählt war.
            SET v_temp_check_gruppe_zek_zu  =  (SELECT COUNT(gruppe_id)
FROM dbp_security.gruppe_zek_zu_2
WHERE gruppe_id = P_GRUPPEID AND zek_id = '-1' AND mandant_id = P_MANDANTID);

            IF v_temp_check_gruppe_zek_zu > 0 THEN
                BEGIN
                --// Wenn alle Zek_2 ausgewählt war, jetzt den Eintrag mit Zek_ID -1 löschen
                DELETE FROM dbp_security.gruppe_zek_zu_2
WHERE gruppe_id = P_GRUPPEID AND mandant_id = P_MANDANTID AND zek_id = '-1';
                --//Ausserdem alle bestehenden Einträge ändern auf alle_zek = 0
                UPDATE dbp_security.gruppe_zek_zu_2 SET
    alle_zek_fg = 0
WHERE gruppe_id = P_GRUPPEID AND mandant_id = P_MANDANTID;
                END;
            END IF;

            END;
        END IF;

    END IF;

    /*---- FUNC = ZEK_2 END ------------------*/
    END;
ELSEIF P_FUNC = 'User Gruppe_2 zuordnen' THEN
    BEGIN
    --// Wenn eintrag vorhanden nichts machen 
    SET v_temp_anzahl_zeilen  =  (SELECT COUNT(gruppe_id)
FROM dbp_security.gruppe_user_zu_2
WHERE gruppe_id = P_GRUPPEID AND user_id = P_USERID);
    --//Einfügen der neuen Zuordnung 

    IF v_temp_anzahl_zeilen = 0 AND P_DAT_GUELTIG_BIS >= CURRENT_DATE("Europe/Berlin") THEN
        INSERT INTO dbp_security.gruppe_user_zu_2 (gruppe_id, user_id, dat_gueltig_bis, td_update)
(SELECT CAST(P_GRUPPEID AS INTEGER) AS gruppe_id, P_USERID AS user_id, P_DAT_GUELTIG_BIS AS dat_gueltig_bis, CAST(CURRENT_DATE("Europe/Berlin") AS TIMESTAMP) AS td_update);
    END IF;

    END;
ELSEIF P_FUNC = 'User Gruppe_2 ändern' THEN
    BEGIN
    --//Fall 1: Zuordnung loeschen

    IF P_LOESCHFLAG = 1 THEN
        BEGIN
        DELETE FROM dbp_security.gruppe_user_zu_2
WHERE gruppe_id = P_GRUPPEID AND user_id = P_USERID AND P_LOESCHFLAG = 1;
        --//Fall 2: Gültigkeitsdatum ändern
        END;
    ELSEIF P_DAT_GUELTIG_BIS >= CURRENT_DATE("Europe/Berlin") THEN
        UPDATE dbp_security.gruppe_user_zu_2 SET
    dat_gueltig_bis = P_DAT_GUELTIG_BIS,
    td_update = CAST(CURRENT_DATE("Europe/Berlin") AS TIMESTAMP)
WHERE gruppe_id = P_GRUPPEID AND user_id = P_USERID;
    END IF;

    END;
END IF;

--// Wenn es neue ZEKs / bei Mandanten gibt und Gruppen bei denen ALLE_ZEG ausgewählt ist füge die neuen ZEKs jetzt in Gruppe_Zek_zu_2 hinzu 
--// Neue Einträge eintragen mit alle_zel = 1
MERGE INTO dbp_security.gruppe_zek_zu_2 AS SECGRPZEK
USING (SELECT G.gruppe_id, Z.zek_id, G.mandant_id
        FROM dbp_security.gruppe_zek_zu_2 AS G
            INNER JOIN dbp_view.v_zek_2 AS Z ON G.mandant_id = Z.mandant_id
        WHERE Z.wbl_id > 0 AND G.zek_id = '-1' AND Z.zek_id <> '-1'
        EXCEPT DISTINCT
        SELECT gruppe_id, zek_id, mandant_id
        FROM dbp_security.gruppe_zek_zu_2
        WHERE alle_zek_fg = 1 AND zek_id <> '-1') AS t3
ON SECGRPZEK.gruppe_id = t3.gruppe_id AND SECGRPZEK.zek_id = t3.zek_id AND SECGRPZEK.mandant_id = t3.mandant_id
WHEN NOT MATCHED THEN INSERT (gruppe_id, zek_id, mandant_id, alle_zek_fg) VALUES(t3.gruppe_id, t3.zek_id, t3.mandant_id, 1);
--// Erstellen USER_ZEK_ZU_2
--// Löschen der bestehenden Sätze in user_zek_zu_2
-- Kompletter Neuaufbau der Tabelle anhand der gepflegten Tabellen
-- Zek_2 und User sind direkt einer Gruppe_2 zugeordnet
-- Zek_2 und User der ersten Gruppen-Gruppen Zuordnung
/*User koennen jeder Ebene zugeordnet sein*/
/*zeks koennen nur auf Blattebene zugeordnet sein*/
-- Zek_2 und User der zweiten Gruppen-Gruppen Zuordnung
/*User koennen jeder Ebene zugeordnet sein*/
/*zeks koennen nur auf Blattebene zugeordnet sein*/
INSERT INTO dbp_security.user_zek_zu_2 (user_id, zek_id, mandant_id)
(SELECT user_id, zek_id, mandant_id
    FROM ((SELECT Z.mandant_id, Z.zek_id, U.user_id
                    FROM dbp_security.gruppe_user_zu_2 AS U
                        INNER JOIN dbp_security.gruppe_zek_zu_2 AS Z ON U.gruppe_id = Z.gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin")
                    UNION DISTINCT
                    SELECT Z.mandant_id, Z.zek_id, U.user_id
                    FROM dbp_security.gruppe_gruppe_zu_2 AS G
                        INNER JOIN dbp_security.gruppe_user_zu_2 AS U ON G.gruppe_id = U.gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin") OR G.gruppe_parent_id = U.gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin")
                        INNER JOIN dbp_security.gruppe_zek_zu_2 AS Z ON G.gruppe_id = Z.gruppe_id)
                UNION DISTINCT
                SELECT Z.mandant_id, Z.zek_id, U.user_id
                FROM dbp_security.gruppe_gruppe_zu_2 AS G
                    INNER JOIN dbp_security.gruppe_gruppe_zu_2 AS GG ON G.gruppe_id = GG.gruppe_parent_id
                    INNER JOIN dbp_security.gruppe_user_zu_2 AS U ON G.gruppe_id = U.gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin") OR G.gruppe_parent_id = U.gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin") OR GG.gruppe_id = U.gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin")
                    INNER JOIN dbp_security.gruppe_zek_zu_2 AS Z ON GG.gruppe_id = Z.gruppe_id) AS a);
COMMIT TRANSACTION;
SET out_param  =  'Erfolgreich';
SELECT out_param;
RETURN;
END;
END;
