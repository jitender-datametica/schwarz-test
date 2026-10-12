CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wup_stunden_tag_FIL (
-- Makro zur Pflege der Tabelle wup_stunden_tag - Variante Filiale (FIL)
-- (Variante Zentrale = m_ups_wup_stunden_tag_ZEN)
-- Wenn Sperre (sperre = 1) gesetzt, wird immer der vorhandene Originalwert aus der Tabelle genommen, ansonsten der Eingabewert
-- Sperre Monat > Stunden IST (AUSL) + Stunden IST Sonst (INT) + Stunden Versetzung (AUSL)
-- Sperre Woche > Umsatz Pflege (INT) + Stunden Plan (INT) + Stunden Plan sonst (INT)
-- Die anderen Inhalte der Tabelle werden nicht per Transaction gepflegt. Wichtig: Insert benoetigt Waehrung aus vorhanden Daten, daher kein Parameter.
-- 2017.0116 ssch0611 : neuer Parameter (3. Eingabesperre) + CASE fuer Stunden Plan (DE) ergaenzt + Anpassung stunden_plan_sonstige (analog stunden_sonstige)
-- 2017.0516 ssch0611 : Review Leistung = zwei Sperren (andere Inhalte) + CASE Logik International + neue Spalten/Felder
-- 2017.0710 ssch0611 : neues Macro-Objekt (FIL). 3 Sperren (Zeit) + 1 Sperre (Land) + Unterscheidung DE/Ausland
 MANDANT_ID FLOAT
, WUP_ID FLOAT
, NB_ID FLOAT
, DAT STRING
, UMS_NETTO_PLAN_MAN FLOAT
, STUNDEN_MARKT FLOAT
, STUNDEN_SONSTIGE FLOAT
, STUNDEN_VERSETZUNG FLOAT
, STUNDEN_PLAN FLOAT
, STUNDEN_SONSTIGE_PLAN FLOAT
, SPERRE_WOCHE_SO FLOAT
, SPERRE_MONAT_7 FLOAT
, SPERRE_MONAT_15 FLOAT
, SPERRE_LAND FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.


if(MANDANT_ID != undefined){
    mandant_id = MANDANT_ID
}
else{
    mandant_id = 'NULL'
}

if(WUP_ID != undefined){
    wup_id = WUP_ID
}
else{
    wup_id = 'NULL'
}

if(NB_ID != undefined){
    nb_id = NB_ID
}
else{
    nb_id = 'NULL'
}


if(DAT != undefined){
    dat = DAT
}
else{
    dat = 'NULL'
}


if(UMS_NETTO_PLAN_MAN != undefined){
    ums_netto_plan_man = UMS_NETTO_PLAN_MAN
}
else{
    ums_netto_plan_man = 'NULL'
} 

if(STUNDEN_MARKT != undefined){
    stunden_markt = STUNDEN_MARKT
}
else{
    stunden_markt = 'NULL'
}    


if(STUNDEN_SONSTIGE != undefined){
    stunden_sonstige = STUNDEN_SONSTIGE
}
else{
    stunden_sonstige = 'NULL'
}    


if(STUNDEN_VERSETZUNG != undefined){
    stunden_versetzung = STUNDEN_VERSETZUNG
}
else{
    stunden_versetzung = 'NULL'
}    

if(STUNDEN_PLAN != undefined){
    stunden_plan = STUNDEN_PLAN
}

else{
    stunden_plan = 'NULL'
}



if(STUNDEN_SONSTIGE_PLAN != undefined){
    stunden_sonstige_plan = STUNDEN_SONSTIGE_PLAN
}

else{
    stunden_sonstige_plan = 'NULL'
}



if(SPERRE_WOCHE_SO != undefined){
    sperre_woche_so = SPERRE_WOCHE_SO
}

else{
    sperre_woche_so = 'NULL'
}




if(SPERRE_MONAT_7 != undefined){
    sperre_monat_7 = SPERRE_MONAT_7
}

else{
    sperre_monat_7 = 'NULL'
}



if(SPERRE_MONAT_15 != undefined){
    sperre_monat_15 = SPERRE_MONAT_15
}

else{
    sperre_monat_15 = 'NULL'
}



if(SPERRE_LAND != undefined){
    sperre_land = SPERRE_LAND
}

else{
    mandasperre_landnt_id = 'NULL'
}

if (mandant_id == 1) {mandant_krz = 'DE'}
else if (mandant_id == 2) {mandant_krz = 'CZ'}
else if (mandant_id == 3) {mandant_krz = 'PL'}
else if (mandant_id == 4) {mandant_krz = 'MD'}
else if (mandant_id == 5) {mandant_krz = 'SK'}
else if (mandant_id == 6) {mandant_krz = 'HR'}
else if (mandant_id == 7) {mandant_krz = 'RO'}
else if (mandant_id == 8) {mandant_krz = 'BG'}


 sql_stmt = `CALL dbp_macro.m_ups_wup_stunden_tag_FIL_` + mandant_krz + ` (` + mandant_id + `
               , ` + wup_id + `
               , ` + nb_id + `
               , '` + dat + `'
               , ` + ums_netto_plan_man + `
               , ` + stunden_markt + `
               , ` + stunden_sonstige + `
               , ` + stunden_versetzung + `
               , ` + stunden_plan + `
               , ` + stunden_sonstige_plan + `
               , ` + sperre_woche_so + `
               , ` + sperre_monat_7 + `
               , ` + sperre_monat_15 + `
               , ` + sperre_land + `); `




snowflake.createStatement({
	   sqlText : sql_stmt
	}).execute();

$$;

