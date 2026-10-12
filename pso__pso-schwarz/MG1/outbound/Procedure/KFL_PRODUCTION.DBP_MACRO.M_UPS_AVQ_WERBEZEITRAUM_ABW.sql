CREATE OR REPLACE PROCEDURE KFL_PRODUCTION.DBP_MACRO.M_UPS_AVQ_WERBEZEITRAUM_ABW(IN MANDANT_ID FLOAT64,  IN WERBE_TYP_ID FLOAT64, IN DAT_VON STRING, IN DAT_BIS STRING, IN KOMMENTAR STRING, IN TS_LOESCHEN_FG FLOAT64, OUT out_param STRING)


BEGIN

DECLARE result NUMERIC;
DECLARE transaction_sql_text STRING;
DECLARE commit_statement STRING;
DECLARE sql_stmt_test STRING;



BEGIN TRANSACTION;
SET commit_statement = "COMMIT";

IF TS_LOESCHEN_FG  IS NULL THEN 
SET sql_stmt_test = '''SELECT
    CASE
      WHEN ? > ? THEN -NUMERIC '1'
      /* Wenn DatumVon <= DatumBis then  we must test for week day*/
      ELSE CASE
        WHEN (
          SELECT
              CAST(count(*) as BIGNUMERIC)
            FROM
              DBP_VIEW.V_TAG
            WHERE AKT_WO >= -NUMERIC '1'
             AND DAT = ?
        ) = NUMERIC '0' THEN NUMERIC '0'
        ELSE NUMERIC '1'
      END
    END
 ; 
''';

EXECUTE IMMEDIATE (sql_stmt_test) into result using DAT_VON, DAT_BIS, DAT_VON ;


IF result = -1 THEN
  RAISE USING MESSAGE = 'ACHTUNG: Startdatum muss vor Enddatum liegen! / Start date has to be prior to end date!';
ELSEIF result = 0 THEN
  RAISE USING MESSAGE = 'ACHTUNG: Eintraege koennen nur fuer die laufende und die Vorwoche sowie in die Zukunft gemacht werden! / Only current and previous week can be edited!';
ELSEIF result = 1 THEN
  SET transaction_sql_text = ''' INSERT INTO DBP_DATA.TS_AVQ_WERBEZEITRAUM_ABW (MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS, KOMMENTAR)
  SELECT
      ?,
      ?,
      ?,
      ?,
      ?
''';

EXECUTE IMMEDIATE (transaction_sql_text) using MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS, KOMMENTAR ;
END IF;

ELSEIF TS_LOESCHEN_FG = 0.0 THEN
  EXECUTE IMMEDIATE '''
    UPDATE DBP_DATA.TS_AVQ_WERBEZEITRAUM_ABW
    SET KOMMENTAR = ?
    WHERE MANDANT_ID = ? AND WERBE_TYP_ID = ? AND DAT_VON = ? AND DAT_BIS = ?'''
  USING KOMMENTAR, MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS;

ELSEIF TS_LOESCHEN_FG = 1.0 THEN
  EXECUTE IMMEDIATE '''
    DELETE FROM DBP_DATA.TS_AVQ_WERBEZEITRAUM_ABW
    WHERE MANDANT_ID = ? AND WERBE_TYP_ID = ? AND DAT_VON = ? AND DAT_BIS = ?'''
  USING MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS;


ELSE EXECUTE IMMEDIATE '''SELECT 'TS_LOESCHEN_FG ist nicht definiert oder anderer Fehler'; ''';

END IF;

EXECUTE IMMEDIATE (commit_statement);

SELECT 'Success';
end
;
