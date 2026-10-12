CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UP_PCON_ABWESENH_LOGIK_FG_ZU(
	P_MANDANT_ID FLOAT, 
	P_ABWESENHEIT_ID VARCHAR, 
	P_KJMO_BIS FLOAT, 
	P_KJMO_VON FLOAT, 
	P_LOGIK_KZ VARCHAR, 
	P_LANGZEIT_ABWESEND_FG FLOAT, 
	P_GRUND VARCHAR,
	P_ALT_KJMO_VON FLOAT)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS 
$$   // Vorhandener Datensatz aendern.
   
   
   if(P_LOGIK_KZ == "Ausgrenzen"){
	   var sql_stmt = 	
		`UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = '0',
				PFLEGE_FG = '0',
				BESCHAEFTIGUNGS_VERBOT_FG = '0',
				KRANKHEIT_UNFALL_FG = '0',
				SONSTIGE_ABWESENHEIT_FG = '0',
				FREIGESTELLT_FG = '0',
				MUTTERSCHUTZ_FG = '0',
				ELTERNZEIT_FG = '0' 
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? 
			AND KJMO_VON = ?`;
		snowflake.createStatement({
			sqlText : sql_stmt,
			binds : [P_KJMO_BIS,P_KJMO_VON,P_LOGIK_KZ, P_MANDANT_ID,P_ABWESENHEIT_ID,P_ALT_KJMO_VON]
		}).execute();
   }else{
	   

		// Fallunterscheidung Grund 
		switch (P_GRUND){ 
		case "Mutterschutz": 
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 0,
				BESCHAEFTIGUNGS_VERBOT_FG = 0,
				KRANKHEIT_UNFALL_FG = 0,
				SONSTIGE_ABWESENHEIT_FG = 0,
				FREIGESTELLT_FG = 0,
				MUTTERSCHUTZ_FG = 1,
				ELTERNZEIT_FG = 0
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		case "Elternzeit":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 0,
				BESCHAEFTIGUNGS_VERBOT_FG = 0,
				KRANKHEIT_UNFALL_FG = 0,
				SONSTIGE_ABWESENHEIT_FG = 0,
				FREIGESTELLT_FG = 0,
				MUTTERSCHUTZ_FG = 0,
				ELTERNZEIT_FG = 1
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		case "Pflege":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 1,
				BESCHAEFTIGUNGS_VERBOT_FG = 0,
				KRANKHEIT_UNFALL_FG = 0,
				SONSTIGE_ABWESENHEIT_FG = 0,
				FREIGESTELLT_FG = 0,
				MUTTERSCHUTZ_FG = 0,
				ELTERNZEIT_FG = 0
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		case "Beschaeftigungsverbot":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 0,
				BESCHAEFTIGUNGS_VERBOT_FG = 1,
				KRANKHEIT_UNFALL_FG = 0,
				SONSTIGE_ABWESENHEIT_FG = 0,
				FREIGESTELLT_FG = 0,
				MUTTERSCHUTZ_FG = 0,
				ELTERNZEIT_FG = 0
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		case "Krankheit Unfall":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 0,
				BESCHAEFTIGUNGS_VERBOT_FG = 0,
				KRANKHEIT_UNFALL_FG = 1,
				SONSTIGE_ABWESENHEIT_FG = 0,
				FREIGESTELLT_FG = 0,
				MUTTERSCHUTZ_FG = 0,
				ELTERNZEIT_FG = 0
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		case "Sonstige":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 0,
				BESCHAEFTIGUNGS_VERBOT_FG = 0,
				KRANKHEIT_UNFALL_FG = 0,
				SONSTIGE_ABWESENHEIT_FG = 1,
				FREIGESTELLT_FG = 0,
				MUTTERSCHUTZ_FG = 0,
				ELTERNZEIT_FG = 0
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		case "Freigestellt":
			var sql_stmt = `UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_2
			SET KJMO_BIS = ? ,
				KJMO_VON = ?,
				LOGIK_KZ = ?,
				LANGZEIT_ABWESEND_FG = ?,
				PFLEGE_FG = 0,
				BESCHAEFTIGUNGS_VERBOT_FG = 0,
				KRANKHEIT_UNFALL_FG = 0,
				SONSTIGE_ABWESENHEIT_FG = 0,
				FREIGESTELLT_FG = 1,
				MUTTERSCHUTZ_FG = 0,
				ELTERNZEIT_FG = 0
			WHERE MANDANT_ID = ?
			AND ABWESENHEIT_ID = ? AND KJMO_VON = ?`;
			break;
		default:
			break;
	}
	
	snowflake.createStatement({
		sqlText : sql_stmt,
		binds : [P_KJMO_BIS,P_KJMO_VON,P_LOGIK_KZ,P_LANGZEIT_ABWESEND_FG,P_MANDANT_ID,P_ABWESENHEIT_ID,P_ALT_KJMO_VON]
	}).execute();	
	
   }
   
   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
		
	
   	
   $$;