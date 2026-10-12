CREATE OR REPLACE PROCEDURE dbp_macro.upd_bon_kopf_stp (MANDANT_ID FLOAT
, WUP_ID FLOAT)
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
   var sql_stmt = `INSERT INTO dbp_ods.ods_bon_kopf_1 (kasse_nr,
bon_beginn,
bon_ende,
umsatz_mwst,
bon_booking,
dat_booking,
turnover_fg,
kasse_typ_id,
reactivated_fg,
personal_id,
betrag_personal_rabatt,
wagen_nr,
wrg_id,
kunde_fg,
mandant_id,
bon_dat,
bon_id,
kpos_kasse_typ,
umsatz_brutto,
kassierer_nr,
bon_nr,
wup_id)

SELECT
kasse_nr,
bon_beginn,
bon_ende,
umsatz_mwst,
bon_booking,
dat_booking,
turnover_fg,
kasse_typ_id,
reactivated_fg,
personal_id,
betrag_personal_rabatt,
wagen_nr,
wrg_id,
kunde_fg,
mandant_id,
bon_dat,
bon_id,
kpos_kasse_typ,
umsatz_brutto,
kassierer_nr,
bon_nr,
wup_id
FROM dbp_ods."ods_bon_kopf_bu_prod_delta_190313#mrau"
where mandant_id=?
and wup_id=?`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [MANDANT_ID,WUP_ID]
   }).execute();
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;

