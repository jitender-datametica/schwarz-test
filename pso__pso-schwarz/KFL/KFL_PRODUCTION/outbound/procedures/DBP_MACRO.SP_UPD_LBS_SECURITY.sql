CREATE OR REPLACE PROCEDURE dbp_macro.sp_upd_lbs_security(IN P_FUNC STRING, IN P_GRUPPEID INT64, IN P_GRUPPEBEZ STRING, IN P_GRUPPEBEZNEU STRING, IN P_LOESCHFLAG INT64, IN P_GRUPPEPARENTID INT64, IN P_PFLEGEFLAG INT64, IN P_ZEKID STRING, IN P_MANDANTID INT64, IN P_USERID STRING, IN P_DAT_GUELTIG_BIS DATE, OUT out_param STRING)
BEGIN

DECLARE v_temp_check_gruppe INT64;
DECLARE v_temp_check_gruppe_user_zu INT64;
DECLARE v_temp_check_gruppe_gruppe_zu INT64;
DECLARE v_temp_check_gruppe_zek_zu INT64;
DECLARE v_temp_anzahl_zeilen INT64;
BEGIN
BEGIN TRANSACTION;
/* ---- FUNC = GRUPPE START ------------------*/

CASE P_FUNC 
 WHEN 'Gruppe' THEN
    BEGIN
    -- Pruefen ob eine Gruppe mit dem Namen bereits exisitiert
    SET v_temp_check_gruppe  =  (SELECT COUNT(lbs_gruppe_bez)
FROM dbp_security.lbs_gruppe
WHERE UPPER(TRIM(lbs_gruppe_bez)) = UPPER(COALESCE(TRIM(P_GRUPPEBEZNEU), TRIM(P_GRUPPEBEZ))));
    -- Wenn diese noch kein Eintrag exisitert 

    IF v_temp_check_gruppe = 0 THEN
        BEGIN
        -- Security Tabelle updaten oder inserten; Merge deswegen da das Statemnt durch das MAX ein Komplexes ist; Upsert geht nicht.
        MERGE INTO dbp_security.lbs_gruppe AS SECGRP
USING (SELECT COALESCE((SELECT lbs_gruppe_id
                FROM dbp_security.lbs_gruppe
                WHERE lbs_gruppe_id = P_GRUPPEID), MAX(lbs_gruppe_id) + 1) AS gruppe_id
    FROM dbp_security.lbs_gruppe) AS usigrp
ON SECGRP.lbs_gruppe_id = usigrp.gruppe_id
WHEN MATCHED THEN UPDATE SET
    lbs_gruppe_bez = TRIM(P_GRUPPEBEZNEU)
WHEN NOT MATCHED THEN INSERT (lbs_gruppe_id, lbs_gruppe_bez) VALUES(usigrp.gruppe_id, TRIM(P_GRUPPEBEZ));
        END;
    ELSE
        SET out_param  =  'Gruppe vorhanden!';
        SELECT out_param;
        RETURN;
    END IF;

    /*---- FUNC = GRUPPE END ------------------*/
    /*---- FUNC = Gruppe loeschen START ------------------*/
    -- Logik für das Löschen von Gruppen
    END;
 WHEN 'Gruppe loeschen' THEN
    BEGIN
    -- Pruefung ob Gruppe bestehende Abhaengigkeiten zu Usern hat
    SET v_temp_check_gruppe_user_zu  =  (SELECT COUNT(lbs_gruppe_id)
FROM dbp_security.lbs_gruppe_user_zu
WHERE lbs_gruppe_id = P_GRUPPEID);
    -- Prüfung ob Gruppe bestehende Abhängigkeiten zu anderen Gruppen hat
    SET v_temp_check_gruppe_gruppe_zu  =  (SELECT COUNT(lbs_gruppe_parent_id)
FROM dbp_security.lbs_gruppe_gruppe_zu
WHERE lbs_gruppe_parent_id = P_GRUPPEID);
    -- Prüfung ob Gruppe bestehende Abhängigkeiten zu ZEK hat
    SET v_temp_check_gruppe_zek_zu  =  (SELECT COUNT(lbs_gruppe_id)
FROM dbp_security.lbs_gruppe_zek_zu
WHERE lbs_gruppe_id = P_GRUPPEID);

    IF v_temp_check_gruppe_user_zu = 0 AND v_temp_check_gruppe_gruppe_zu = 0 AND v_temp_check_gruppe_zek_zu = 0 THEN
        DELETE FROM dbp_security.lbs_gruppe
WHERE lbs_gruppe_id = P_GRUPPEID AND P_LOESCHFLAG = 1;
    ELSE
        SET out_param  =  'Abhaengigkeiten vorhanden!';
        SELECT out_param;
        RETURN;
    END IF;

    /*---- FUNC = Gruppe loeschen END ------------------*/
    /*---- FUNC = Gruppe zu Gruppe START ------------------*/
    -- Logik von Zuordnung der Gruppen zueinander (Aendern und loeschen)
    END;
 WHEN 'Gruppe zu Gruppe' THEN
    BEGIN
    -- Logik für das Ändern von Zuordnungen der Gruppen zueinander
    -- PflegeFlag ist 1 wenn eine neue Zuordnung erfolgt; Punkt ist gesetzt

    CASE P_PFLEGEFLAG 
    WHEN 1 THEN
        BEGIN
        -- Prüfung ob Parent Gruppe bestehende Abhängigkeiten zu ZEK hat
        SET v_temp_check_gruppe_zek_zu  =  (SELECT COUNT(lbs_gruppe_id)
FROM dbp_security.lbs_gruppe_zek_zu
WHERE lbs_gruppe_id = P_GRUPPEPARENTID);

        IF v_temp_check_gruppe_zek_zu = 0 THEN
            BEGIN
            --Einfügen oder Updaten; muss erfolgen weil der Anwender den Punkt erst aus und dann wieder an machen kann innerhalb einer Transaktion
            -- Wenn eintrag vorhanden nichts machen 
            SET v_temp_anzahl_zeilen  =  (SELECT COUNT(lbs_gruppe_parent_id)
FROM dbp_security.lbs_gruppe_gruppe_zu
WHERE lbs_gruppe_parent_id = P_GRUPPEPARENTID AND lbs_gruppe_id = P_GRUPPEID);

            IF v_temp_anzahl_zeilen = 0 THEN
                INSERT INTO dbp_security.lbs_gruppe_gruppe_zu (lbs_gruppe_id, lbs_gruppe_parent_id)
(SELECT P_GRUPPEID  AS lbs_gruppe_id, P_GRUPPEPARENTID AS lbs_gruppe_parent_id);
            END IF;

            END;
        ELSE
            SET out_param  =  'Gruppe nicht geaendert!';
            SELECT out_param;
            RETURN;
        END IF;

        -- Logik für das Löschen von Zuordnungen der Gruppen zueinander
        -- PflegeFlag ist 0 wenn die Zuordnung gelöscht werden soll; Punkt ist nicht gesetzt
        END;
    WHEN 0 THEN
        DELETE FROM dbp_security.lbs_gruppe_gruppe_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND lbs_gruppe_parent_id = P_GRUPPEPARENTID;
    END CASE;

    /* ---- FUNC = Gruppe zu Gruppe END  check ------------------*/
    /* ---- FUNC = ZEK START ------------------*/
    -- Logik von Zuordnung der ZEK  (Aendern und loeschen)
    END;
 WHEN 'ZEK zuordnen' THEN
    BEGIN

    CASE P_PFLEGEFLAG 
    WHEN 1 THEN
        BEGIN
        -- Überprüfung ob die Grupppe eine Blatt Gruppe ist
        --falls nicht, darf eine Zuordnung von ZEKs nicht erfolgen.
        SET v_temp_check_gruppe_gruppe_zu  =  (SELECT COUNT(lbs_gruppe_parent_id)
FROM dbp_security.lbs_gruppe_gruppe_zu
WHERE lbs_gruppe_parent_id = P_GRUPPEID);

        IF v_temp_check_gruppe_gruppe_zu = 0 AND P_ZEKID = '-1' THEN
            BEGIN
            -- Alle Zek ist ausgewählt
            -- Security Tabelle updaten oder inserten; Merge deswegen da das Statemnt durch das ermitteln aller ZEKs ein Komplexes ist; Upsert geht nicht.
            -- Sollten vorher Einträge da sein wo alle_zek nicht ausgewählt ist, bestehende Einträge mit alle Zek = 1 updaten
            -- Neue Einträge eintragen mit alle_zel = 1
            MERGE INTO dbp_security.lbs_gruppe_zek_zu AS SECGRPZEK
USING (SELECT zek_id
    FROM dbp_view.v_zek
    WHERE mandant_id = P_MANDANTID AND wbl_id > 0) AS usizek
ON SECGRPZEK.lbs_gruppe_id = P_GRUPPEID AND SECGRPZEK.zek_id = usizek.zek_id AND SECGRPZEK.mandant_id = P_MANDANTID
WHEN MATCHED THEN UPDATE SET
    alle_zek_fg = 1
WHEN NOT MATCHED THEN INSERT (mandant_id, lbs_gruppe_id, zek_id, alle_zek_fg) VALUES(P_MANDANTID , P_GRUPPEID , usizek.zek_id, 1);
            END;
        ELSEIF v_temp_check_gruppe_gruppe_zu = 0 AND P_ZEKID <> '-1' THEN
            BEGIN
            --Einfügen oder Updaten; muss erfolgen weil der Anwender den Punkt erst aus und dann wieder an machen kann innerhalb einer Transaktion
            -- Wenn eintrag vorhanden nichts machen 
            SET v_temp_anzahl_zeilen  =  (SELECT COUNT(lbs_gruppe_id)
FROM dbp_security.lbs_gruppe_zek_zu
WHERE mandant_id = P_MANDANTID AND lbs_gruppe_id = P_GRUPPEID AND zek_id = P_ZEKID);

            IF v_temp_anzahl_zeilen = 0 THEN
                INSERT INTO dbp_security.lbs_gruppe_zek_zu (mandant_id, lbs_gruppe_id, zek_id, alle_zek_fg)
(SELECT P_MANDANTID  AS mandant_id, P_GRUPPEID  AS lbs_gruppe_id, P_ZEKID AS zek_id, 0 AS alle_zek_fg);
            END IF;

            END;
        ELSE
            SET out_param  =  'Gruppe eine Blatt Gruppe NICHT geaendert!';
            SELECT out_param;
            RETURN;
        END IF;

        END;
    WHEN 0 THEN

        IF P_ZEKID = '-1' THEN
            BEGIN
            -- Zuordnung löschen für die gesamte Gruppe und Mandant (alle_zek ist ausgewählt)
            DELETE FROM dbp_security.lbs_gruppe_zek_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND mandant_id = P_MANDANTID;
            END;
        ELSE
            BEGIN
            -- Zuordnung löschen nur gewählter ZEK 
            DELETE FROM dbp_security.lbs_gruppe_zek_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND zek_id = P_ZEKID AND mandant_id = P_MANDANTID;
            -- Jetzt prüfen ob vor dem Delete Alle_Zek usgewählt war.
            SET v_temp_check_gruppe_zek_zu  =  (SELECT COUNT(lbs_gruppe_id)
FROM dbp_security.lbs_gruppe_zek_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND zek_id = '-1' AND mandant_id = P_MANDANTID);

            IF v_temp_check_gruppe_zek_zu > 0 THEN
                BEGIN
                -- Wenn alle Zek ausgewählt war, jetzt den Eintrag mit Zek_ID -1 löschen
                DELETE FROM dbp_security.lbs_gruppe_zek_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND mandant_id = P_MANDANTID AND zek_id = '-1';
                --Ausserdem alle bestehenden Einträge ändern auf alle_zek = 0
                UPDATE dbp_security.lbs_gruppe_zek_zu SET
    alle_zek_fg = 0
WHERE lbs_gruppe_id = P_GRUPPEID AND mandant_id = P_MANDANTID;
                END;
            END IF;

            END;
        END IF;

    END CASE;

    /*---- FUNC = ZEK END ------------------*/
    END;
 WHEN 'User Gruppe zuordnen' THEN
    BEGIN
    -- Wenn eintrag vorhanden nichts machen 
    SET v_temp_anzahl_zeilen  =  (SELECT COUNT(lbs_gruppe_id)
FROM dbp_security.lbs_gruppe_user_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND user_id = P_USERID);
    --Einfügen der neuen Zuordnung 

    IF v_temp_anzahl_zeilen = 0 AND P_DAT_GUELTIG_BIS >= CURRENT_DATE("Europe/Berlin") THEN
        INSERT INTO dbp_security.lbs_gruppe_user_zu (lbs_gruppe_id, user_id, dat_gueltig_bis, td_update)
(SELECT P_GRUPPEID  AS lbs_gruppe_id, P_USERID AS user_id, P_DAT_GUELTIG_BIS AS dat_gueltig_bis, CAST(CURRENT_DATE("Europe/Berlin") AS TIMESTAMP) AS td_update);
    END IF;

    END;
 WHEN 'User Gruppe ändern' THEN
    BEGIN
    --Fall 1: Zuordnung loeschen

    IF P_LOESCHFLAG = 1 THEN
        BEGIN
        DELETE FROM dbp_security.lbs_gruppe_user_zu
WHERE lbs_gruppe_id = P_GRUPPEID AND user_id = P_USERID AND P_LOESCHFLAG = 1;
        --Fall 2: Gültigkeitsdatum ändern
        END;
    ELSEIF P_DAT_GUELTIG_BIS >= CURRENT_DATE("Europe/Berlin") THEN
        UPDATE dbp_security.lbs_gruppe_user_zu SET
    dat_gueltig_bis = P_DAT_GUELTIG_BIS,
    td_update = CAST(CURRENT_DATE("Europe/Berlin") AS TIMESTAMP)
WHERE lbs_gruppe_id = P_GRUPPEID AND user_id = P_USERID;
    END IF;

    END;
END CASE;

-- Wenn es neue ZEKs / bei Mandanten gibt und Gruppen bei denen ALLE_ZEG ausgewählt ist füge die neuen ZEKs jetzt in Gruppe_Zek_zu hinzu 
-- Neue Einträge eintragen mit alle_zel = 1
MERGE INTO dbp_security.lbs_gruppe_zek_zu AS SECGRPZEK
USING (SELECT G.lbs_gruppe_id, Z.zek_id, G.mandant_id
        FROM dbp_security.lbs_gruppe_zek_zu AS G
            INNER JOIN dbp_view.v_zek AS Z ON G.mandant_id = Z.mandant_id
        WHERE Z.wbl_id > 0 AND G.zek_id = '-1' AND Z.zek_id <> '-1'
        EXCEPT DISTINCT
        SELECT lbs_gruppe_id, zek_id, mandant_id
        FROM dbp_security.lbs_gruppe_zek_zu
        WHERE alle_zek_fg = 1 AND zek_id <> '-1') AS t3
ON SECGRPZEK.lbs_gruppe_id = t3.lbs_gruppe_id AND SECGRPZEK.zek_id = t3.zek_id AND SECGRPZEK.mandant_id = t3.mandant_id
WHEN NOT MATCHED THEN INSERT (mandant_id, lbs_gruppe_id, zek_id, alle_zek_fg) VALUES(t3.mandant_id, t3.lbs_gruppe_id, t3.zek_id, 1);
-- Erstellen USER_ZEK_ZU
-- Löschen der bestehenden Sätze in user_zek_zu
-- Kompletter Neuaufbau der Tabelle anhand der gepflegten Tabellen
-- Zek und User sind direkt einer Gruppe zugeordnet
-- Zek und User der ersten Gruppen-Gruppen Zuordnung
/*User koennen jeder Ebene zugeordnet sein*/
/*zeks koennen nur auf Blattebene zugeordnet sein*/
-- Zek und User der zweiten Gruppen-Gruppen Zuordnung
/*User koennen jeder Ebene zugeordnet sein*/
/*zeks koennen nur auf Blattebene zugeordnet sein*/
INSERT INTO dbp_security.lbs_user_zek_zu (mandant_id, zek_id, user_id)
SELECT Z.mandant_id, Z.zek_id, U.user_id
    FROM dbp_security.lbs_gruppe_user_zu AS U
        INNER JOIN dbp_security.lbs_gruppe_zek_zu AS Z ON U.lbs_gruppe_id = Z.lbs_gruppe_id AND U.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin")
    UNION DISTINCT
    (SELECT Z0.mandant_id, Z0.zek_id, U0.user_id
        FROM dbp_security.lbs_gruppe_gruppe_zu AS G
            INNER JOIN dbp_security.lbs_gruppe_user_zu AS U0 ON G.lbs_gruppe_id = U0.lbs_gruppe_id AND U0.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin") OR G.lbs_gruppe_parent_id = U0.lbs_gruppe_id AND U0.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin")
            INNER JOIN dbp_security.lbs_gruppe_zek_zu AS Z0 ON G.lbs_gruppe_id = Z0.lbs_gruppe_id
        UNION DISTINCT
        SELECT Z1.mandant_id, Z1.zek_id, U1.user_id
        FROM dbp_security.lbs_gruppe_gruppe_zu AS G0
            INNER JOIN dbp_security.lbs_gruppe_gruppe_zu AS GG ON G0.lbs_gruppe_id = GG.lbs_gruppe_parent_id
            INNER JOIN dbp_security.lbs_gruppe_user_zu AS U1 ON G0.lbs_gruppe_id = U1.lbs_gruppe_id AND U1.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin") OR G0.lbs_gruppe_parent_id = U1.lbs_gruppe_id AND U1.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin") OR GG.lbs_gruppe_id = U1.lbs_gruppe_id AND U1.dat_gueltig_bis >= CURRENT_DATE("Europe/Berlin")
            INNER JOIN dbp_security.lbs_gruppe_zek_zu AS Z1 ON GG.lbs_gruppe_id = Z1.lbs_gruppe_id);
COMMIT TRANSACTION;
SET out_param  =  'Erfolgreich';
SELECT out_param;
RETURN;
END;
END;
