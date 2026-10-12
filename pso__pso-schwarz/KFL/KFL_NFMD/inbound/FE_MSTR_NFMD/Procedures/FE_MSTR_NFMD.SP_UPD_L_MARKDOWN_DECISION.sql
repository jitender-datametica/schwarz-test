CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_UPD_L_MARKDOWN_DECISION(
	P_MANDANT_ID FLOAT,
	P_MARKDOWN_DECISION_ID FLOAT,
	P_MARKDOWN_DECISION VARCHAR,
	P_MARKDOWN_DECISION_EN VARCHAR ,
	P_MARKDOWN_DECISION_LANDESSPRACHE VARCHAR,
	P_FLAG_AKTIV FLOAT
	)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
   // Vorhandener Datensatz updaten
   if ( P_MARKDOWN_DECISION_ID == 99 | P_MARKDOWN_DECISION_ID == 98 | P_MARKDOWN_DECISION_ID == 0){
        P_FLAG_AKTIV = 2;
    }
    


    // Pruefen welcher mandant wegen der Landessprache
    var sql_stmt = "";


  switch (P_MANDANT_ID) {
    case 1: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :4,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;
    case 2: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :5,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :4,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;

    case 3: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :5,
                        markdown_decision_ro = :4,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;

    case 4: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :5,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;

    case 5: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :4,
                        markdown_decision_sk = :5,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;

    case 6: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :5,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :4,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;

    case 7: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :4,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :5,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;

    case 8: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_MARKDOWN_DECISION
                SET markdown_decision = :3 ,
                        markdown_decision_bg = :5,
                        markdown_decision_cz = :4,
                        markdown_decision_en = :4,
                        markdown_decision_hr = :4,
                        markdown_decision_pl = :4,
                        markdown_decision_ro = :4,
                        markdown_decision_sk = :4,
                        markdown_decision_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND markdown_decision_ID = :2`;
         break;
    default:
			break;
  }

      snowflake.createStatement({
          sqlText : sql_stmt,
          binds : [P_MANDANT_ID,P_MARKDOWN_DECISION_ID,P_MARKDOWN_DECISION,P_MARKDOWN_DECISION_EN,P_MARKDOWN_DECISION_LANDESSPRACHE,P_FLAG_AKTIV].map(function(x){return x === undefined ? null : x})
      }).execute();
		
	var sql_commit = `COMMIT;`;
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
   	
   $$;