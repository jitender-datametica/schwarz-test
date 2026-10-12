CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_L_MARKDOWN_DECISION(
	P_MANDANT_ID FLOAT,
	P_MARKDOWN_DECISION VARCHAR,
	P_MARKDOWN_DECISION_EN VARCHAR ,
	P_MARKDOWN_DECISION_LANDESSPRACHE VARCHAR
	)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
   //check last ID + 1
  var SQL_nextID = `select case when max(markdown_decision_ID) = 97 then 100 else max(markdown_decision_ID)+1 end as next_id
                      from CORE.TS_L_MARKDOWN_DECISION_2
                          where  MANDANT_ID = :1 
                          and markdown_decision_ID not in  (98,99)`;
  var nextID = snowflake.createStatement({
      sqlText : SQL_nextID,
      binds: [P_MANDANT_ID]
  }).execute();
  nextID.next();
  // Value next ID 
  var value_nextID = nextID.getColumnValue(1);
   // Vorhandener Datensatz updaten
     
  var sql_stmt = "";


  switch (P_MANDANT_ID) {
    case 1: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :5, 
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break;
    case 2: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :4,
                            :5,
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break;    
    case 3: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :4,
                            :4,
                            :4,
                            :4,
                            :5,
                            :4,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break; 
    case 4: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :5,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break;
    case 5: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :5,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break;
    case 6: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :4,
                            :4,
                            :4,
                            :5,
                            :4,
                            :4,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break; 
    case 7: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :5,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break;
    case 8: 
        var sql_stmt = `INSERT INTO CORE.TS_L_MARKDOWN_DECISION_2 (
                            mandant_id,
                            markdown_decision_ID,
                            markdown_decision,
                            markdown_decision_bg,
                            markdown_decision_cz,
                            markdown_decision_en,
                            markdown_decision_hr,
                            markdown_decision_pl,
                            markdown_decision_ro,
                            markdown_decision_sk,
                            markdown_decision_landessprache,
                            flag_aktiv,
                            flag_deaktiv
                        )values (
                            :1,
                            :2, 
                            :3, 
                            :5,
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :4,
                            :5, -- Landessprache
                            1,
                            1
                        )`;
            break;
            default:
			break;
  }

       
    snowflake.createStatement({
        sqlText : sql_stmt,
        binds : [P_MANDANT_ID,value_nextID,P_MARKDOWN_DECISION,P_MARKDOWN_DECISION_EN,P_MARKDOWN_DECISION_LANDESSPRACHE].map(function(x){return x === undefined ? null : x})
    }).execute();	
		
	var sql_commit = `COMMIT`;
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
   	
   $$;