CREATE OR REPLACE PROCEDURE DBP_MACRO.M_VIS_BENCHMARK (AKTION_2 VARCHAR(100), MANDANT_ID FLOAT, HIERARCHIE_EBENE_ID VARCHAR(10), HIERARCHIE_ELEMENT_ID FLOAT, USER_ID VARCHAR(30), UPD_HIERARCHIE_EBENE_ID VARCHAR(10), UPD_HIERARCHIE_ELEMENT_ID FLOAT)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
 	// REGION_2 SnowConvert Helpers Code
	var HANDLE_NOTFOUND;
	var fetch = (count,rows,stmt) => (count && rows.next() && Array.apply(null,Array(stmt.getColumnCount())).map((_,i) => rows.getColumnValue(i + 1))) || [];
	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT = 0, INTO, _OUTQUERIES = [], DYNAMIC_RESULTS = -1;
	var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
	var fixBind = function (arg) {
	   arg = arg == undefined ? null : arg instanceof Date ? formatDate(arg) : arg;
	   return arg;
	};
	var EXEC = function (stmt,binds,noCatch,catchFunction,opts) {
	   try {
	      binds = binds ? binds.map(fixBind) : binds;
	      _RS = snowflake.createStatement({
	            sqlText : stmt,
	            binds : binds
	         });
	      _ROWS = _RS.execute();
	      ROW_COUNT = _RS.getRowCount();
	      ACTIVITY_COUNT = _RS.getNumRowsAffected();
	      HANDLE_NOTFOUND && HANDLE_NOTFOUND(_RS);
	      if (INTO) return {
	         INTO : function () {
	            return INTO();
	         }
	      };
	      if (_OUTQUERIES.length < DYNAMIC_RESULTS) _OUTQUERIES.push(_ROWS.getQueryId());
	      if (opts && opts.temp) return _ROWS.getQueryId();
	   } catch(error) {
	      MESSAGE_TEXT = error.message;
	      SQLCODE = error.code;
	      SQLSTATE = error.state;
	      var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
	      if (catchFunction) catchFunction(error);
	      if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
	   }
	};
	var procname = `dbp_macro.m_vis_benchmark`;
	var temptable_prefix, tablelist = [];
	var INSERT_TEMP = function (query,parameters) {
	   if (!temptable_prefix) {
	      var sql_stmt = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
	      var rs_2 = snowflake.createStatement({
	         sqlText : sql_stmt,
	         binds : []
	      }).execute();
	      temptable_prefix = rs.next() && (procname + '_TEMP_' + rs.getColumnValue(1) + '_');
	   }
	   var tablename = temptable_prefix + tablelist.length;
	   tablelist.push(tablename);
	   var sql_stmt = `CREATE OR REPLACE TEMPORARY TABLE ${tablename} AS ${query}`;
	   snowflake.execute({
	      sqlText : sql_stmt,
	      binds : parameters
	   });
	   return tablename;
	};
	var INTO = () => fetch(ROW_COUNT,_ROWS,_RS);
	// END REGION_2
	
	try {
		if (![`INS`,`DEL`,`UPD`].includes(AKTION_2)) {
			throw new Error('Ungültige Aktion_2');
		}

		if ((MANDANT_ID > 127 || MANDANT_ID < -128 || MANDANT_ID == null) && ([`INS`,`UPD`].includes(AKTION_2) || AKTION_2 == `DEL` && MANDANT_ID != null)) {
		throw new Error('Ungültiger Mandant_2,  zulässige Werte: mandant_id von -128 bis 127');
		}

		if (HIERARCHIE_EBENE_ID == `land_2` && (HIERARCHIE_ELEMENT_ID > 127 || HIERARCHIE_ELEMENT_ID < -128)) {
		throw new Error(`Ungültiger Wert fuer das Element der Hierarchiestufe ''land_2'',  zulässige Werte: mandant_id von -128 bis 127`);
		}

		EXEC(`SELECT mandant_id
				FROM dbp_data.mandant_2
			   WHERE mandant_id = :1`,[MANDANT_ID]);
		var subQueryVariable0;
		[subQueryVariable0] = INTO();

		if (!subQueryVariable0 == MANDANT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && MANDANT_ID))) {
			throw new Error('Der eingegebene Mandant_2 existiert nicht');
		}

		if (HIERARCHIE_EBENE_ID == 'UNDEFINED' && [`INS`,`UPD`].includes(AKTION_2)) {
		throw new Error('Bitte geben Sie eine_2 Hierarchieebene an');
		}

		if (HIERARCHIE_ELEMENT_ID== 'UNDEFINED' && ([`INS`,`UPD`].includes(AKTION_2) || AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID)) {
			throw new Error('Bitte geben Sie ein Hierarchieelement an');
		}

		if (![`land_2`,`gf_2`,`vs_2`,`vkl_2`,`hl_2`,`fm`].includes(HIERARCHIE_EBENE_ID) && ([`INS`,`UPD`].includes(AKTION_2) || AKTION_2 == `DEL` && HIERARCHIE_EBENE_ID)) {
		throw new Error ('Ungültige Hierarchieebene, zulässige Werte: land_2 (vorstand), gf_2, vs_2, vkl_2, hl_2, fm');
		}

		EXEC(`SELECT gf_gbl_vertrieb_id AS gf_id
				FROM dbp_msi_data.wup_denorm_2
				WHERE mandant_id = :1
				AND gf_gbl_vertrieb_id = :2`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID]);
		var subQueryVariable1;
		[subQueryVariable1] = INTO();
		if (HIERARCHIE_EBENE_ID == `gf_2` 
			&& !subQueryVariable1 == HIERARCHIE_ELEMENT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID))) {
			throw new Error('GF_2 ID existiert für diesen Mandanten nicht');
		}

		EXEC(`SELECT vkl_id AS vkl_id
				FROM dbp_msi_data.wup_denorm_2
				WHERE mandant_id = :1
				AND vkl_id = :2`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID]);
		var subQueryVariable2;
		[subQueryVariable2] = INTO();
		if (HIERARCHIE_EBENE_ID == `vkl_2` 
			&& !subQueryVariable2 == HIERARCHIE_ELEMENT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID))) {
			throw new Error('VKL_2 ID existiert für diesen Mandanten nicht')
		}

		EXEC(`SELECT wup_id AS hl_id
				FROM dbp_msi_data.wup_denorm_2
				WHERE mandant_id = :1
				AND hl_id = :2`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID]);
		var subQueryVariable3;
		[subQueryVariable3] = INTO();
		if (HIERARCHIE_EBENE_ID == `hl_2` 
			&& !subQueryVariable3 == HIERARCHIE_ELEMENT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID))) {
			throw new Error(`HL_2 ID existiert für diesen Mandanten nicht`);
		}

		EXEC(`SELECT vs_id
				FROM dbp_data.vs_2
				WHERE mandant_id = :1
				AND vs_id = :2`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID]);
		var subQueryVariable4;
		[subQueryVariable4] = INTO();
		if (HIERARCHIE_EBENE_ID == `vs_2` 
			&& !subQueryVariable4 == HIERARCHIE_ELEMENT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID))) {
			throw new Error(`VS_2 ID existiert für diesen Mandanten nicht`);
		}

		EXEC(`SELECT frische_manager_id AS fm_id
				FROM dbp_msi_data.wup_denorm_2
				WHERE mandant_id = :1
				AND frische_manager_id = :2`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID]);
		var subQueryVariable5;
		[subQueryVariable5] = INTO();
		if (HIERARCHIE_EBENE_ID == `fm` 
			&& !subQueryVariable4 == HIERARCHIE_ELEMENT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID))) {
			throw new Error(`FM ID existiert für diesen Mandanten nicht`);
		}

		EXEC(`SELECT mandant_id
				FROM dbp_data.mandant_2
				WHERE :1 = :2`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID]);
		var subQueryVariable6;
		[subQueryVariable6] = INTO();
		if (HIERARCHIE_EBENE_ID == `land_2` 
			&& ![-1,-2].includes(HIERARCHIE_ELEMENT_ID) 
			&& !subQueryVariable6 == HIERARCHIE_ELEMENT_ID 
			&& ([`INS`,`UPD`].includes(AKTION_2) || (AKTION_2 == `DEL` && HIERARCHIE_ELEMENT_ID))) {
			throw new Error(`Kein zulässiger Wert für die Hierarchiestufe Land_2 (Vorstand)`);
		}

		if (!USER_ID) {
		 throw new Error (`Bitte geben Sie einen MSI User an`);
		}

		if (AKTION_2 == 'UPD' 
			&& !EXEC( `SELECT user_id FROM dbp_msi_data.user_vis_benchmark_zu_2
				WHERE mandant_id = :1
				AND :2 = :3
				AND :4 = :5
				AND :6 = TRIM(:7)`,
				[MANDANT_ID,HIERARCHIE_EBENE_ID,UPD_HIERARCHIE_EBENE_ID,HIERARCHIE_ELEMENT_ID,UPD_HIERARCHIE_ELEMENT_ID,USER_ID,USER_ID]).INTO().includes(USER_ID.trim())) {
			throw new Error(`Der Datensatz, den Sie aktualisieren möchten, existiert nicht`);
		}

		// Sollte das INS sein?
		if (AKTION_2 == `UPD` 
			&& EXEC( `SELECT user_id
				FROM dbp_msi_data.user_vis_benchmark_zu_2
				WHERE mandant_id = :1
				AND hierarchie_ebene_id = :2
				AND hierarchie_element_id = :3
				AND :4 = TRIM(:5)`,[MANDANT_ID,HIERARCHIE_EBENE_ID,HIERARCHIE_ELEMENT_ID,USER_ID,USER_ID]).INTO().includes(USER_ID)) {
			throw new Error(`Der Datensatz, den Sie aktualisieren möchten, existiert schon`);
		}

	}
	catch (err) {
		throw new Error(err)
	}

	EXEC(`INSERT INTO dbp_msi_data.user_vis_benchmark_zu_2 (
			 mandant_id
			,hierarchie_element_id
			,hierarchie_ebene_id
			,user_id) 
		SELECT 
			COALESCE(:1, 0),
			COALESCE(:2, 0),
			COALESCE(:3, ''),
			TRIM(COALESCE(:4, ''))
		FROM (SELECT CURRENT_DATE AS dat_akt) d
	WHERE :5 = 'INS'`,[MANDANT_ID,HIERARCHIE_ELEMENT_ID,HIERARCHIE_EBENE_ID,USER_ID,AKTION_2]);

	// Loeschen aller Eintraege für einen User
	EXEC(`DELETE FROM dbp_msi_data.user_vis_benchmark_zu_2
			WHERE USER_ID = TRIM(:1)
			AND :2 = 'DEL'
			AND :3 IS NULL
			AND :4 IS NULL
			AND :5 IS NULL`,[USER_ID,AKTION_2,HIERARCHIE_EBENE_ID,HIERARCHIE_ELEMENT_ID,MANDANT_ID]);
	// Loeschen aller Eintraege für einen User und Land_2
	EXEC(`DELETE FROM dbp_msi_data.user_vis_benchmark_zu_2
			WHERE USER_ID = TRIM(:1)
			AND mandant_id = :2
			AND :3 = 'DEL'
			AND :4 IS NULL
			AND :5 IS NULL`,[USER_ID,MANDANT_ID,AKTION_2,HIERARCHIE_EBENE_ID,HIERARCHIE_ELEMENT_ID]);

	// Loeschen aller Eintraege für einen User und Land_2 und einer Hierarchiestufe
	EXEC(`DELETE FROM dbp_msi_data.user_vis_benchmark_zu_2
			WHERE USER_ID = TRIM(:1)
			AND mandant_id = :2
			AND hierarchie_ebene_id = :3
			AND :4 = 'DEL'
			AND :5 IS NULL`,[USER_ID,MANDANT_ID,HIERARCHIE_EBENE_ID,AKTION_2,HIERARCHIE_ELEMENT_ID]);
	// Loeschen aller Eintraege für einen User und Land_2 und einer Hierarchiestufe
	EXEC(`DELETE FROM dbp_msi_data.user_vis_benchmark_zu_2
			WHERE USER_ID = TRIM(:1)
			AND mandant_id = :2
			AND hierarchie_ebene_id = :3
			AND hierarchie_element_id = :4
			AND :5 = 'DEL'`,[USER_ID,MANDANT_ID,HIERARCHIE_EBENE_ID,HIERARCHIE_ELEMENT_ID,AKTION_2]);
	EXEC(`UPDATE dbp_msi_data.user_vis_benchmark_zu_2
				SET HIERARCHIE_ELEMENT_ID = COALESCE(:1, 0)
				  , HIERARCHIE_EBENE_ID = COALESCE(:2, '')
			WHERE mandant_id = :3
			AND USER_ID = TRIM(:4)
			AND HIERARCHIE_EBENE_ID = :5
			AND HIERARCHIE_ELEMENT_ID = :6
			AND :7 = 'UPD'`,[HIERARCHIE_ELEMENT_ID,HIERARCHIE_EBENE_ID,MANDANT_ID,USER_ID,UPD_HIERARCHIE_EBENE_ID,UPD_HIERARCHIE_ELEMENT_ID,AKTION_2]);

	var retval = "";
	switch (AKTION_2) {
		case 'INS':
			retval = 'Der Benutzer ' + USER_ID + ' wurde der Hierarchiestufe ' + HIERARCHIE_EBENE_ID 
				   + ', Element ' + HIERARCHIE_ELEMENT_ID.toString() + ' erfolgreich zugeordnet.';
			break;
		case 'DEL':
			if (HIERARCHIE_EBENE_ID == 'UNDEFINED' && HIERARCHIE_ELEMENT_ID== 'UNDEFINED' && !MANDANT_ID) {
				retval = `Es wurden alle Zuordnungen für den Benutzer '` + USER_ID + `' gelöscht.`;
			} else if (HIERARCHIE_EBENE_ID == 'UNDEFINED' && HIERARCHIE_ELEMENT_ID== 'UNDEFINED' && MANDANT_ID) {
				retval = `Es wurden alle Zuordnungen für den Benutzer '` + USER_ID + `' und den Mandanten '` + MANDANT_ID.toString() + `' gelöscht.`
			} else if (HIERARCHIE_EBENE_ID && HIERARCHIE_ELEMENT_ID== 'UNDEFINED' && MANDANT_ID) {
				retval = `Es wurden alle Zuordnungen für den Benutzer '` + USER_ID + `' und den Mandanten '` + MANDANT_ID.toString() + `' der Hierarchiestufe '` + HIERARCHIE_EBENE_ID + `' gelöscht.`;
			} else if (HIERARCHIE_EBENE_ID && HIERARCHIE_ELEMENT_ID && MANDANT_ID) {
				retval = `Die Zuordnung des Benutzers '` + USER_ID + `' zur Hierarchiestufe '` + HIERARCHIE_EBENE_ID + `', Element '` + UPD_HIERARCHIE_ELEMENT_ID.toString() + `' wurde gelöscht.`;
			}
			break;
		default:
			retval = `Die Zuordnung Benutzer '`  + USER_ID + `', Hierarchiestufe '` + UPD_HIERARCHIE_EBENE_ID + `', Element '` + UPD_HIERARCHIE_ELEMENT_ID.toString();
			retval += `' wurde auf Hierarchiestufe '` + HIERARCHIE_EBENE_ID + `', Element '` + HIERARCHIE_ELEMENT_ID.toString() + `' aktualisiert.`;
	}
	return retval;
$$;