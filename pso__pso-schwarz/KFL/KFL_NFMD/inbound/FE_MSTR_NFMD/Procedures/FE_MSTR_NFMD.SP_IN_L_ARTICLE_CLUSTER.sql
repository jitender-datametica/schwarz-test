CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_IN_L_ARTICLE_CLUSTER(
	P_MANDANT_ID FLOAT,
	P_ARTICLE_CLUSTER VARCHAR,
	P_ARTICLE_CLUSTER_EN VARCHAR ,
	P_ARTICLE_CLUSTER_LANDESSPRACHE VARCHAR
	)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
   //check last ID + 1
  var SQL_nextID = `select case when max(ARTICLE_CLUSTER_ID) = 97 then 100 else max(ARTICLE_CLUSTER_ID)+1 end as next_id
                      from CORE.TS_L_ARTICLE_CLUSTER
                          where  MANDANT_ID = :1 
                          and ARTICLE_CLUSTER_ID not in  (98,99)`;
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        var sql_stmt = `INSERT INTO CORE.TS_L_ARTICLE_CLUSTER (
                            mandant_id,
                            ARTICLE_CLUSTER_ID,
                            ARTICLE_CLUSTER,
                            ARTICLE_CLUSTER_bg,
                            ARTICLE_CLUSTER_cz,
                            ARTICLE_CLUSTER_en,
                            ARTICLE_CLUSTER_hr,
                            ARTICLE_CLUSTER_pl,
                            ARTICLE_CLUSTER_ro,
                            ARTICLE_CLUSTER_sk,
                            ARTICLE_CLUSTER_landessprache,
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
        binds : [P_MANDANT_ID,value_nextID,P_ARTICLE_CLUSTER,P_ARTICLE_CLUSTER_EN,P_ARTICLE_CLUSTER_LANDESSPRACHE].map(function(x){return x === undefined ? null : x})
    }).execute();	
		
	var sql_commit = `COMMIT`;
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
   	
   $$;