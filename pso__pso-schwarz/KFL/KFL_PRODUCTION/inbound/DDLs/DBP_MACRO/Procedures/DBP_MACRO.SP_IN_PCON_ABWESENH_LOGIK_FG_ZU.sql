CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_IN_PCON_ABWESENH_LOGIK_FG_ZU(
	P_MANDANT_ID FLOAT, 
	P_ABWESENHEIT_ID VARCHAR, 
	P_KJMO_VON FLOAT,
	P_LOGIK_KZ VARCHAR, 
	P_LANGZEIT_ABWESEND_FG FLOAT, 
	P_GRUND VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
   // Bevor neuer Datensatz hinzugefuegt wird 
   // Wird, falls es zu dieser ABWESENHEIT_ID & MANDANT_ID schon ein Eintrag vorhanden ist, 
   // wird in diesem das Gueltig bis geaendert.
   
   var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
		SET KJMO_BIS = ? -1
		WHERE MANDANT_ID = ?
		AND ABWESENHEIT_ID = ? 
		AND KJMO_BIS = '999912'`;
	snowflake.createStatement({
		sqlText : sql_stmt,
		binds : [P_KJMO_VON,P_MANDANT_ID,P_ABWESENHEIT_ID]
	}).execute();	
	
	
	if(P_LOGIK_KZ == "Ausgrenzen"){
	// neuer Datensatz hinzufuegen
    var sql_stmt = 	`INSERT INTO dbp_data.pcon_abwesenh_logik_fg_zu 
							(MANDANT_ID
							,ABWESENHEIT_ID
							,KJMO_BIS
							,KJMO_VON
							,LOGIK_KZ
							,LANGZEIT_ABWESEND_FG
							,PFLEGE_FG
							,BESCHAEFTIGUNGS_VERBOT_FG
							,KRANKHEIT_UNFALL_FG
							,SONSTIGE_ABWESENHEIT_FG
							,FREIGESTELLT_FG
							,MUTTERSCHUTZ_FG
							,ELTERNZEIT_FG)
					values (?
							,?
							,'999912'
							,?
							,?
							,'0'
							,'0'
							,'0'
							,'0'
							,'0'
							,'0'
							,'0'
							,'0')`;
	snowflake.createStatement({
		sqlText : sql_stmt,
		binds : [P_MANDANT_ID,P_ABWESENHEIT_ID,P_KJMO_VON,P_LOGIK_KZ]
	}).execute();	
	
	}else{
	
	
	
	
   // neuer Datensatz hinzufuegen
   var sql_stmt = 	`INSERT INTO dbp_data.pcon_abwesenh_logik_fg_zu 
   							(MANDANT_ID
							,ABWESENHEIT_ID
							,KJMO_BIS
							,KJMO_VON
							,LOGIK_KZ
							,LANGZEIT_ABWESEND_FG
							,PFLEGE_FG
							,BESCHAEFTIGUNGS_VERBOT_FG
							,KRANKHEIT_UNFALL_FG
							,SONSTIGE_ABWESENHEIT_FG
							,FREIGESTELLT_FG
							,MUTTERSCHUTZ_FG
							,ELTERNZEIT_FG)
						values (?,
								?,
								'999912',
								?,
								?,
								?,
								'0',
								'0',
								'0',
								'0',
								'0',
								'0',
								'0')`;
	snowflake.createStatement({
		sqlText : sql_stmt,
		binds : [P_MANDANT_ID,P_ABWESENHEIT_ID,P_KJMO_VON,P_LOGIK_KZ,P_LANGZEIT_ABWESEND_FG]
	}).execute();	
	
	// Pruefen welcher Grund angegeben wurden ist 
	var sql_stmt = "";

	//if (P_GRUND = "Mutterschutz") 
	switch (P_GRUND){ 
		case "Mutterschutz": 
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET MUTTERSCHUTZ_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		case "Elternzeit":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET ELTERNZEIT_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		case "Pflege":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET PFLEGE_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		case "Beschaeftigungsverbot":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET BESCHAEFTIGUNGS_VERBOT_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		case "Krankheit Unfall":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET KRANKHEIT_UNFALL_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		case "Sonstige":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET SONSTIGE_ABWESENHEIT_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		case "Freigestellt":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu 
			SET FREIGESTELLT_FG = '1'
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_BIS = '999912'`;
			break;
		default:
			break;
	}
	
	snowflake.createStatement({
		sqlText : sql_stmt,
		binds : [P_MANDANT_ID,P_ABWESENHEIT_ID]
	}).execute();	
	}
	
	var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
	
   $$;
