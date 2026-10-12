CREATE OR REPLACE PROCEDURE dbp_macro.sp_vis_puk_monat_kommentar (PUK_ID FLOAT
, MANDANT_ID FLOAT
, PUK_TYP_ID FLOAT
, KENNZAHL_ID FLOAT
, KJMO FLOAT
, PUK_PARENT_ID FLOAT
, URSACHE_KJMO STRING
, MASSNAHME_KJMO STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	// PUK - Pflege Kommentare pro Typ/Kennzahl/Monat_2
// puk_typ_id : 1=wup_id 2=vkl_id 3=gf_id 4=vs_id 5=mandant_id
// puk_id/puk_parent_id : wup_id/vkl_id vkl_id/gf_id gf_id/vs_id vs_id/mandant_id
// kennzahl_id : 10=Umsatz etc
// v0 UPSERT, Timestamp always created/updated
// 2020.01.24 : removed kum-columns, dat-termin
// 2020.02.11 : Finetuning
{

   var_zeit_aktualisierung = function () {
         var sql_stmt = `SELECT
Current_Timestamp(0)`;
         var stmt = snowflake.createStatement({
            sqlText : sql_stmt,
            binds : []
         });
         var res = stmt.execute();
         res.next();
         return res.getColumnValue(1);
      }();
   var sql_stmt = `MERGE INTO dbp_data.vis_puk_monat_kommentar_2 target USING (SELECT
                                                                           ? AS PUK_ID
                                                                           ,? AS  MANDANT_ID
                                                                           ,? AS PUK_TYP_ID
                                                                           ,? AS KENNZAHL_ID
                                                                           ,? AS KJMO
                                                                           ,? AS PUK_PARENT_ID
                                                                           ,? AS URSACHE_KJMO
                                                                           ,? AS MASSNAHME_KJMO) source
                  ON target.mandant_id   = source.mandant_id
                  AND target.kjmo        = source.kjmo
                  AND target.kennzahl_id = source.kennzahl_id
                  AND target.puk_typ_id  = source.puk_typ_id
                  AND target.puk_id  = source.puk_id
                  WHEN MATCHED THEN UPDATE 
                     SET target.puk_parent_id = source.puk_parent_id
                        , target.ursache_kjmo = source.ursache_kjmo
                        , target.massnahme_kjmo = source.massnahme_kjmo
                        , target.zeit_aktualisierung = ?
                  WHEN NOT MATCHED THEN 
                  INSERT (target.MANDANT_ID
                         ,target.KJMO
                         ,target.KENNZAHL_ID
                         ,target.PUK_TYP_ID
                         ,target.PUK_ID
                         ,target.PUK_PARENT_ID
                         ,target.URSACHE_KJMO
                         ,target.MASSNAHME_KJMO
                         ,target.ZEIT_AKTUALISIERUNG)
                  VALUES (
                     source.MANDANT_ID
                  , source.KJMO
                  , source.KENNZAHL_ID
                  , source.PUK_TYP_ID
                  , source.PUK_ID
                  , source.PUK_PARENT_ID
                  , source.URSACHE_KJMO
                  , source.MASSNAHME_KJMO
                  , ?)`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [PUK_ID, MANDANT_ID, PUK_TYP_ID, KENNZAHL_ID, KJMO, PUK_PARENT_ID, URSACHE_KJMO, MASSNAHME_KJMO, var_zeit_aktualisierung,var_zeit_aktualisierung]
      // Anpassung für Snowflake, um NULL ins SQL zu übergeben
      .map(function(x){return x === undefined ? null : x})
   }).execute();
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;

