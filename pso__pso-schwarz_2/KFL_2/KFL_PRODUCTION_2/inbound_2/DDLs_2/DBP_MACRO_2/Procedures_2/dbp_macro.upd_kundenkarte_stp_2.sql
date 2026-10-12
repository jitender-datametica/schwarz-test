CREATE OR REPLACE PROCEDURE dbp_macro.upd_kundenkarte_stp (WUP_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
   /* 
   call dbp_ods.upd_kundenkarte_stp (wup_id);
   Beispiel:
   call dbp_ods.upd_kundenkarte_stp (2300);
   */
   //UPDATE  t1_2
   //--sel *
   //FROM
   //dbp_ods_archiv.ods_bon_kopf_2 t1_2,
   //(
   //SELECT 
   //	bku.mandant_id
   //	, bku.wup_id
   //	, bku.bon_dat
   //	, bku.bon_id
   //	, 	bku.kundenkarte_id 
   //	FROM dbp_ods.ods_bon_kopf_upd_kundenkarte_2 bku
   //	JOIN dbp_ods_archiv.ods_bon_kopf_2 bk
   //		ON bk.wup_id=bku.wup_id
   //		AND bk.mandant_id=bku.mandant_id
   //		AND bk.bon_dat=bku.bon_dat
   //		AND bk.bon_id=bku.bon_id
   //where bku.bon_dat > 1181201
   //and bku.mandant_id=7
   //and bku.wup_id= :wup_id
   //--and bk.kundenkarte_id is null
   //) erg
   //--erg (mandant_id, wup_id, bon_dat, bon_id, kundenkarte_id)
   //SET kundenkarte_id = erg.kundenkarte_id
   //WHERE 	t1.wup_id=erg.wup_id
   //AND 	t1.mandant_id=erg.mandant_id
   //AND 	t1.bon_dat=erg.bon_dat
   //AND 	t1.bon_id=erg.bon_id
   //;
   var sql_stmt = `UPDATE dbp_ods_archiv.ods_bon_kopf_2 AS bk SET bk.kundenkarte_typ_id = 2
where bk.bon_dat > 1181201
and bk.mandant_id=7
and wup_id=?
and kundenkarte_id is not null
and kundenkarte_typ_id =0`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [WUP_ID]
   }).execute();
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;

