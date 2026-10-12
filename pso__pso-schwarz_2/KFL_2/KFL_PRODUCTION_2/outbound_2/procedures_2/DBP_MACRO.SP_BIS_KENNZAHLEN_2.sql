CREATE OR REPLACE PROCEDURE dbp_macro.sp_bis_kennzahlen(IN GJQU FLOAT64, IN BIS_KENNZAHL_ID FLOAT64, IN MANDANT_ID FLOAT64, IN BIS_KENNZAHL_BETRAG FLOAT64)
BEGIN
DECLARE var_mandant_id FLOAT64;
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;
BEGIN TRANSACTION;
--
---- 18.08.16 twie: SPEC0008548 Pflegebericht für BIS Management Kennzahlen, werden nur in diesem Produkt genutzt.
----                        Die Werte pro Land_2 werden in Tabelle ts_bis_kennzahl_2 gespeichert mit Mandant_2
----                        INTEGER Kennzahlen kommen aus MSI mit Mandant_2 99, da es diesen aber im Datenmodell nicht gibt, wird ohne Mandant_2 in Tabelle ts_bis_kennzahl_int_2 gespeichert
----                        Mittels dieser stored procedure kann man mittels IF die beiden Fälle voneinander trennen.
--
BEGIN
SET var_mandant_id  =  MANDANT_ID;

IF CAST(var_mandant_id AS FLOAT64) <> 99 THEN
    BEGIN
    -- Aller Länder ausser INTEGER

 SET sql_stmt  =  '''MERGE INTO dbp_msi_view_bis.ts_bis_kennzahl_2 AS TARGET USING (SELECT @GJQU AS gjqu,
  @BIS_KENNZAHL_ID AS bis_kennzahl_id,
  @MANDANT_ID AS mandant_id,
  @BIS_KENNZAHL_BETRAG AS bis_kennzahl_betrag) AS t
ON TARGET.gjqu = t.gjqu AND TARGET.bis_kennzahl_id = t.bis_kennzahl_id AND TARGET.mandant_id = t.mandant_id
WHEN MATCHED THEN UPDATE SET
 bis_kennzahl_betrag = CAST(CAST(t.bis_kennzahl_betrag AS BIGNUMERIC) AS NUMERIC)
WHEN NOT MATCHED THEN INSERT VALUES(CAST(@GJQU AS INTEGER), CAST(@BIS_KENNZAHL_ID AS INTEGER), CAST(@MANDANT_ID AS INTEGER), CAST(@BIS_KENNZAHL_BETRAG AS NUMERIC))''';

    EXECUTE IMMEDIATE (sql_stmt) USING GJQU AS GJQU,  BIS_KENNZAHL_ID AS BIS_KENNZAHL_ID,  MANDANT_ID AS MANDANT_ID,  BIS_KENNZAHL_BETRAG AS BIS_KENNZAHL_BETRAG,  GJQU AS GJQU_1,  BIS_KENNZAHL_ID AS BIS_KENNZAHL_ID_1,  MANDANT_ID AS MANDANT_ID_1,  BIS_KENNZAHL_BETRAG AS BIS_KENNZAHL_BETRAG_1;

    END;
END IF;


IF CAST(var_mandant_id AS FLOAT64) = 99 THEN
    BEGIN
    -- INTEGER ohne Mandant_2 speichern

SET sql_stmt  =  '''MERGE INTO dbp_msi_view_bis.ts_bis_kennzahl_int_2 AS TARGET
USING (SELECT @GJQU AS gjqu,
  @BIS_KENNZAHL_ID AS bis_kennzahl_id,
  @BIS_KENNZAHL_BETRAG AS bis_kennzahl_betrag) AS t
ON TARGET.gjqu = t.gjqu AND TARGET.bis_kennzahl_id = t.bis_kennzahl_id
WHEN MATCHED THEN UPDATE SET
 bis_kennzahl_betrag = CAST(CAST(t.bis_kennzahl_betrag AS BIGNUMERIC) AS NUMERIC)
WHEN NOT MATCHED THEN INSERT VALUES(CAST(@GJQU AS INTEGER), CAST(@BIS_KENNZAHL_ID AS INTEGER),CAST(@BIS_KENNZAHL_BETRAG AS NUMERIC))''';

    EXECUTE IMMEDIATE (sql_stmt) USING GJQU AS GJQU,  BIS_KENNZAHL_ID AS BIS_KENNZAHL_ID,  BIS_KENNZAHL_BETRAG AS BIS_KENNZAHL_BETRAG,  GJQU AS GJQU_1,  BIS_KENNZAHL_ID AS BIS_KENNZAHL_ID_1,  BIS_KENNZAHL_BETRAG AS BIS_KENNZAHL_BETRAG_1;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
END;



CALL dbp_macro.sp_bis_kennzahlen(202401, 10, 99, 500);