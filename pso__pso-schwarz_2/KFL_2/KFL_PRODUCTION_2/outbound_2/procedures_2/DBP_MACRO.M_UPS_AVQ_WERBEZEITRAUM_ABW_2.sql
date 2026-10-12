CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_avq_werbezeitraum_abw(IN mandant_id FLOAT64,  IN werbe_typ_id FLOAT64, IN dat_von STRING, IN dat_bis STRING, IN kommentar STRING, IN ts_loeschen_fg FLOAT64, OUT out_param STRING)


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
      WHEN ? > ? THEN -1
      /* Wenn DatumVon <= DatumBis then  we must test_2 for week day*/
      ELSE CASE
        WHEN (
          SELECT
              count(*) 
            FROM
              dbp_view.v_tag_2
            WHERE akt_wo >= -1
             AND dat = ?
        ) = 0 THEN 0
        ELSE 1
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
  SET transaction_sql_text = ''' INSERT INTO dbp_data.ts_avq_werbezeitraum_abw_2 (mandant_id, werbe_typ_id, dat_von, dat_bis, kommentar)
  SELECT
      CAST(? AS INTEGER),
      CAST(? AS INTEGER), 
      CAST(? AS DATE),
      CAST(? AS DATE),
      ?
''';

EXECUTE IMMEDIATE (transaction_sql_text) using MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS, KOMMENTAR ;
END IF;

ELSEIF TS_LOESCHEN_FG = 0.0 THEN
  EXECUTE IMMEDIATE '''
    UPDATE dbp_data.ts_avq_werbezeitraum_abw_2
    SET kommentar = ?
    WHERE mandant_id = ? AND werbe_typ_id = ? AND dat_von = ? AND dat_bis = ?'''
  USING KOMMENTAR, MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS;

ELSEIF TS_LOESCHEN_FG = 1.0 THEN
  EXECUTE IMMEDIATE '''
    DELETE FROM dbp_data.ts_avq_werbezeitraum_abw_2
    WHERE mandant_id = ? AND werbe_typ_id = ? AND dat_von = ? AND dat_bis = ?'''
  USING MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS;


ELSE RAISE USING MESSAGE = 'TS_LOESCHEN_FG ist nicht definiert oder anderer Fehler'; 

END IF;

EXECUTE IMMEDIATE (commit_statement);



SET out_param  =  'Success';
SELECT out_param;
RETURN;
END;

