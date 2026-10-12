CREATE OR REPLACE PROCEDURE dbp_macro.sp_ups_wupcal_ereignis_zu(IN MANDANT_ID FLOAT64, IN WUP_ID FLOAT64, IN DAT DATE, IN EREIGNIS_ID FLOAT64, IN EREIGNISTYP_ID FLOAT64, IN EREIGNIS_BEZ_LANG STRING)
BEGIN
DECLARE var_new_ereignis_id STRING;
DECLARE var_mandant_id STRING;
DECLARE var_wup_id STRING;
DECLARE var_dat STRING;
DECLARE var_ereignis_id STRING;
DECLARE var_ereignistyp_id STRING;
DECLARE var_ereignis_bez_lang STRING;
DECLARE sql_stmt STRING;
BEGIN
/*
   ---------------------------------------------------------------
   -- 0. Deklarationen.
   ---------------------------------------------------------------
   */
SET var_mandant_id  =  CAST(MANDANT_ID AS STRING);
SET var_wup_id  =  CAST(WUP_ID AS STRING);
SET var_dat  =  CAST(DAT AS STRING);
SET var_ereignis_id  =  CAST(EREIGNIS_ID AS STRING);
SET var_ereignistyp_id  =  CAST(EREIGNISTYP_ID AS STRING);
SET var_ereignis_bez_lang  =  CAST(EREIGNIS_BEZ_LANG AS STRING);
--
-----------------------------------------------------------------
---- 1. Ein neuer Freitext wird vergeben
-----------------------------------------------------------------
--
-----------------------------------------------------
-- 1.0 Nächste freie ereignis_id
-----------------------------------------------------
-- Nur bei noch nicht existierenden Ereignis_1-Freitext (Typ 101) muss eine_1 neue Ereinis-ID vergeben werden
-- Der TransactionService Übergabeparamter ist NULL, bei nicht vorhandenem Freitext
-- In der View mv_wupcal_ereignis_zu_cross_1 werden für jeden Tag_1 Einträge mit ereignis_id = -1 vorgehalten
-- Ein 'echtes' Ereignis_1 bekommt eine_1 ID > 0

IF CAST(var_ereignis_id AS FLOAT64) <= 0 AND CAST(var_ereignistyp_id AS FLOAT64) = 101 THEN
    BEGIN
    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
SET sql_stmt  =  '''SELECT MAX(ereignis_id) + 1 FROM dbp_data.ereignis_1 AS V01 WHERE ereignistyp_id = @EREIGNISTYP_ID AND mandant_id = @MANDANT_ID  AND (mandant_id, ereignistyp_id, ereignis_id) NOT IN (SELECT (mandant_id, ereignistyp_id, ereignis_id)    FROM dbp_data.wupcal_ereignis_zu_1 AS V02    WHERE dat = @DAT     AND mandant_id = @MANDANT_ID_1     AND ereignistyp_id = @EREIGNISTYP_ID_1     AND wup_id = @WUP_ID     AND nb_id = 0) GROUP BY mandant_id,  ereignistyp_id ''';

    EXECUTE IMMEDIATE (sql_stmt) INTO var_new_ereignis_id  USING EREIGNISTYP_ID AS EREIGNISTYP_ID,  MANDANT_ID AS MANDANT_ID,  FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT,  MANDANT_ID AS MANDANT_ID_1,  EREIGNISTYP_ID AS EREIGNISTYP_ID_1,  WUP_ID AS WUP_ID;

    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
-----------------------------------------------------
-- 1.1 Befüllen der Lookup Tabelle dbx.ereignis_1
-----------------------------------------------------
SET sql_stmt  =  '''INSERT INTO dbp_data.ereignis_1 (ereignis_id, ereignistyp_id, mandant_id, default_offen, sap_ereignis_id) (SELECT CAST(t1.ereignis_id AS INTEGER) AS ereignis_id,   CAST(t1.ereignistyp_id AS INTEGER) AS ereignistyp_id,   CAST(t1.mandant_id AS INTEGER) AS mandant_id,   t2.offen,   CAST(t1.sap_ereignis_id AS INTEGER) AS sap_ereignis_id  FROM (SELECT  @EREIGNIS_ID  AS ereignis_id,     @EREIGNISTYP_ID AS ereignistyp_id,     @MANDANT_ID AS mandant_id,     NULL AS sap_ereignis_id) AS t1_1   INNER JOIN (SELECT offen    FROM dbp_data.wupcal_1 AS V01    WHERE mandant_id = @MANDANT_ID_1     AND wup_id = @WUP_ID     AND dat = @DAT) AS t2 ON TRUE) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING EREIGNIS_ID AS EREIGNIS_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  MANDANT_ID AS MANDANT_ID,  MANDANT_ID AS MANDANT_ID_1,  WUP_ID AS WUP_ID,  FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT;

    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
-----------------------------------------------------
-- 1.2 Befüllen der Sprachtabelle Tabelle dbx.ereignis_spr_zu_1
-----------------------------------------------------
SET sql_stmt  =  '''INSERT INTO dbp_data.ereignis_spr_zu_1 (ereignis_id, ereignistyp_id, spr_id, mandant_id, ereignis_bez_lang  , ereignis_bez_mittel, ereignis_bez_kurz) (SELECT CAST(t1.ereignis_id AS INTEGER) AS ereignis_id,   CAST(t1.ereignistyp_id AS INTEGER) AS ereignistyp_id,   t2.spr_id,   CAST(t1.mandant_id AS INTEGER) AS mandant_id,   t1.ereignis_bez_lang,   t1.ereignis_bez_mittel,   t1.ereignis_bez_kurz  FROM (SELECT @EREIGNIS_ID AS ereignis_id,     @EREIGNISTYP_ID AS ereignistyp_id,     @MANDANT_ID AS mandant_id,     @var_ereignis_bez_lang AS ereignis_bez_lang,     @var_ereignis_bez_lang_1 AS ereignis_bez_mittel,     @var_ereignis_bez_lang_1_2 AS ereignis_bez_kurz) AS t1_1   INNER JOIN (SELECT spr_id    FROM dbp_data.mandant_spr_zu_1 AS V01    WHERE mandant_id = CAST(@var_mandant_id AS FLOAT64)) AS t2 ON TRUE) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING EREIGNIS_ID AS EREIGNIS_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  MANDANT_ID AS MANDANT_ID,  var_ereignis_bez_lang AS var_ereignis_bez_lang,  var_ereignis_bez_lang AS var_ereignis_bez_lang_1,  var_ereignis_bez_lang AS var_ereignis_bez_lang_1_2,  var_mandant_id AS var_mandant_id;

    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
-----------------------------------------------------
-- 1.3 Befüllen der Zuordnungs Tabelle dbx.wupcal_ereignis_zu_1
-----------------------------------------------------
SET sql_stmt  =  '''INSERT INTO dbp_data.wupcal_ereignis_zu_1 (dat, wup_id, nb_id, mandant_id, ereignistyp_id, ereignis_id,  offen) (SELECT t1.dat,   CAST(t1.wup_id AS INTEGER) AS wup_id,   t1.nb_id,   CAST(t1.mandant_id AS INTEGER) AS mandant_id,   CAST(t1.ereignistyp_id AS INTEGER) AS ereignistyp_id,   CAST(t1.ereignis_id AS INTEGER) AS ereignis_id,   t2.offen  FROM (SELECT CAST(@DAT AS DATE) AS dat,     @WUP_ID AS wup_id,     0 AS nb_id,     @MANDANT_ID AS mandant_id,     @EREIGNISTYP_ID AS ereignistyp_id,     @EREIGNIS_ID AS ereignis_id) AS t1_1   INNER JOIN (SELECT offen    FROM dbp_data.wupcal_1 AS V01    WHERE mandant_id = CAST(@var_mandant_id AS FLOAT64)     AND wup_id = CAST(@var_wup_id AS FLOAT64)     AND dat = CAST(@var_dat AS DATE)) AS t2 ON TRUE) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING FORMAT_DATE('%F', DAT) AS DAT,  WUP_ID AS WUP_ID,  MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNIS_ID AS EREIGNIS_ID,  var_mandant_id AS var_mandant_id,  var_wup_id AS var_wup_id,  var_dat AS var_dat;

    END;
END IF;

--
-----------------------------------------------------------------
---- 2. Freitext wird aktualisiert
-----------------------------------------------------------------
--
-- Update von Ereignis_1-Freitext (Typ 101)
-- In der View mv_wupcal_ereignis_zu_cross_1 werden für jeden Tag_1 Einträge mit ereignis_id = -1 vorgehalten
-- Ein 'echtes' Ereignis_1 bekommt eine_1 ID > 0

IF CAST(var_ereignis_id AS FLOAT64) > 0 AND CAST(var_ereignistyp_id AS FLOAT64) = 101 AND var_ereignis_bez_lang IS NOT NULL THEN
    BEGIN
    SET sql_stmt  =  '''UPDATE dbp_data.ereignis_spr_zu_1 SET  ereignis_bez_lang = @EREIGNIS_BEZ_LANG,  ereignis_bez_mittel = @EREIGNIS_BEZ_LANG_1,  ereignis_bez_kurz = @EREIGNIS_BEZ_LANG_1_2 WHERE mandant_id = @MANDANT_ID AND ereignistyp_id = @EREIGNISTYP_ID AND ereignis_id = @EREIGNIS_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING EREIGNIS_BEZ_LANG AS EREIGNIS_BEZ_LANG,  EREIGNIS_BEZ_LANG AS EREIGNIS_BEZ_LANG_1,  EREIGNIS_BEZ_LANG AS EREIGNIS_BEZ_LANG_1_2,  MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNIS_ID AS EREIGNIS_ID;

    END;
END IF;

--
-----------------------------------------------------------------
---- 3. Freitext wird gelöscht
-----------------------------------------------------------------
--
-- Löschen von Ereignis_1-Freitext (Typ 101) Einträgen
-- Im TransactionService Bericht gibt es kein 'Löschen-Knopf'.
-- Ein Eintrag gilt als gelöscht, wenn eine_1 ID vorhanden ist (es gibt einen Freitext) und das Feld Freitext leer ist
-- In der View mv_wupcal_ereignis_zu_cross_1 werden für jeden Tag_1 Einträge mit ereignis_id = -1 vorgehalten
-- Ein 'echtes' Ereignis_1 bekommt eine_1 ID > 0

IF CAST(var_ereignis_id AS FLOAT64) > 0 AND CAST(var_ereignistyp_id AS FLOAT64) = 101 AND var_ereignis_bez_lang IS NULL THEN
    BEGIN
    SET sql_stmt  =  '''DELETE FROM dbp_data.ereignis_spr_zu_1 WHERE mandant_id = @MANDANT_ID AND ereignistyp_id = @EREIGNISTYP_ID AND ereignis_id = @EREIGNIS_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNIS_ID AS EREIGNIS_ID;

    SET sql_stmt  =  '''DELETE FROM dbp_data.ereignis_1 WHERE mandant_id = @MANDANT_ID AND ereignistyp_id = @EREIGNISTYP_ID AND ereignis_id = @EREIGNIS_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNIS_ID AS EREIGNIS_ID;

    SET sql_stmt  =  '''DELETE FROM dbp_data.wupcal_ereignis_zu_1 WHERE mandant_id = @MANDANT_ID AND ereignistyp_id = @EREIGNISTYP_ID AND ereignis_id = @EREIGNIS_ID AND dat =    @DAT AND wup_id = @WUP_ID ''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNIS_ID AS EREIGNIS_ID,  FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT,  WUP_ID AS WUP_ID;

    END;
END IF;

END;
END;
