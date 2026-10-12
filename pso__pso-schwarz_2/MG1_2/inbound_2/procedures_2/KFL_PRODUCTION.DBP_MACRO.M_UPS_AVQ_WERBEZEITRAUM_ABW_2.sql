CREATE OR REPLACE PROCEDURE KFL_PRODUCTION.DBP_MACRO.M_UPS_AVQ_WERBEZEITRAUM_ABW(MANDANT_ID FLOAT, WERBE_TYP_ID FLOAT, DAT_VON VARCHAR, DAT_BIS VARCHAR, KOMMENTAR VARCHAR, TS_LOESCHEN_FG FLOAT)
    RETURNS VARCHAR(16777216) LANGUAGE JAVASCRIPT
    AS $$

var res, result, sql_stmt_test, stmt_test,transaction_stmt,transaction_sql_text,variable_binds;
var commit_statement = "COMMIT";
switch (TS_LOESCHEN_FG) {
    case undefined:
        sql_stmt_test = `
        SELECT
        CASE WHEN ? > ? THEN -1
         /* Wenn DatumVon <= DatumBis then  we must test_2 for week day*/
        ELSE CASE WHEN
                                           ( Select count(*)
                            From   dbp_view.v_tag_2
                            Where  akt_wo >= -1
                              And   dat = ?  ) = 0
                                            THEN 0
                                            ELSE 1
                                    END END FROM DUAL`;
        stmt_test = snowflake.createStatement({
            sqlText: sql_stmt_test,
            binds: [DAT_VON, DAT_BIS, DAT_VON ]
        });
        res = stmt_test.execute();
        res.next();
        result = res.getColumnValue(1)
        
            if (result === -1) {
                throw 'ACHTUNG: Startdatum muss vor Enddatum liegen! / Start date has to be prior to end date!';
            }
            if (result === 0) {
                throw 'ACHTUNG: Eintraege koennen nur fuer die laufende und die Vorwoche sowie in die Zukunft gemacht werden! / Only current and previous week can be edited!'
            }
            if (result === 1) {
                transaction_sql_text = `INSERT INTO  dbp_data.ts_avq_werbezeitraum_abw_2 (MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS, KOMMENTAR)
                    SELECT   ?
                            ,?
                            ,?
                            ,?
                            ,?`;
                variable_binds = [MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS, KOMMENTAR];
            }
       
        break;
    case 0:
        transaction_sql_text = `UPDATE  dbp_data.ts_avq_werbezeitraum_abw_2
                    SET kommentar = ?
                    WHERE mandant_id = ?
                    AND werbe_typ_id = ?
                    AND dat_von = ?
                    AND dat_bis = ?`
        variable_binds = [KOMMENTAR, MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS];
        break;
    case 1:
        transaction_sql_text = `DELETE FROM  dbp_data.ts_avq_werbezeitraum_abw_2
                    WHERE mandant_id = ?
                    AND werbe_typ_id = ?
                    AND dat_von = ?
                    AND dat_bis = ?`
        variable_binds = [MANDANT_ID, WERBE_TYP_ID, DAT_VON, DAT_BIS];
        break;
    default:
        throw 'TS_LOESCHEN_FG ist nicht definiert oder anderer Fehler'
}
transaction_stmt = snowflake.createStatement({
    sqlText: transaction_sql_text,
    binds: variable_binds
});
transaction_stmt.execute();
commit = snowflake.createStatement({
    sqlText: commit_statement
});
commit.execute();

return 'Success';
    $$
   