CREATE OR REPLACE PROCEDURE dbp_macro.sp_bis_kennzahlen (GJQU FLOAT, BIS_KENNZAHL_ID FLOAT, MANDANT_ID FLOAT, BIS_KENNZAHL_BETRAG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//
//-- 18.08.16 twie: SPEC0008548 Pflegebericht für BIS Management Kennzahlen, werden nur in diesem Produkt genutzt.
//--                        Die Werte pro Land werden in Tabelle ts_bis_kennzahl gespeichert mit Mandant
//--                        INT Kennzahlen kommen aus MSI mit Mandant 99, da es diesen aber im Datenmodell nicht gibt, wird ohne Mandant in Tabelle ts_bis_kennzahl_int gespeichert
//--                        Mittels dieser stored procedure kann man mittels IF die beiden Fälle voneinander trennen.
//
{
   var var_mandant_id;
   var_mandant_id = MANDANT_ID;
   if (var_mandant_id != 99) {
      // Aller Länder ausser INT
      var sql_stmt = `MERGE INTO dbp_msi_view_bis.ts_bis_kennzahl AS target
                     USING (VALUES
                              (? , ? , ? , ?)
                           ) AS tab (gjqu, bis_kennzahl_id, mandant_id, bis_kennzahl_betrag)
                         ON target.gjqu            = tab.gjqu
                        AND target.bis_kennzahl_id = tab.bis_kennzahl_id
                        AND target.mandant_id      = tab.mandant_id 
                     WHEN MATCHED THEN 
                        UPDATE SET target.bis_kennzahl_betrag =  tab.bis_kennzahl_betrag
                     WHEN NOT MATCHED THEN 
                        INSERT (GJQU, BIS_KENNZAHL_ID, MANDANT_ID, BIS_KENNZAHL_BETRAG)
                        VALUES (?, ?, ?, ?)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [GJQU, BIS_KENNZAHL_ID, MANDANT_ID, BIS_KENNZAHL_BETRAG,
                  GJQU, BIS_KENNZAHL_ID, MANDANT_ID, BIS_KENNZAHL_BETRAG]
      }).execute();
   }

   if (var_mandant_id == 99) {
      // INT ohne Mandant speichern
      var sql_stmt = `MERGE INTO dbp_msi_view_bis.ts_bis_kennzahl_int AS target
                     USING (VALUES
                              (? , ? , ?)
                           ) AS tab (gjqu, bis_kennzahl_id, bis_kennzahl_betrag)
                         ON target.gjqu            = tab.gjqu
                        AND target.bis_kennzahl_id = tab.bis_kennzahl_id
                     WHEN MATCHED THEN 
                        UPDATE SET target.bis_kennzahl_betrag = tab.bis_kennzahl_betrag
                     WHEN NOT MATCHED THEN 
                        INSERT (GJQU, BIS_KENNZAHL_ID, BIS_KENNZAHL_BETRAG)
                        VALUES (?, ?, ?)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [GJQU, BIS_KENNZAHL_ID, BIS_KENNZAHL_BETRAG,
                  GJQU, BIS_KENNZAHL_ID, BIS_KENNZAHL_BETRAG]
      }).execute();
   }
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;