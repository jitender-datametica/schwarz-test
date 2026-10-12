CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_UPD_L_ARTICLE_CLUSTER(
	P_MANDANT_ID FLOAT,
	P_ARTICLE_CLUSTER_ID FLOAT,
	P_ARTICLE_CLUSTER VARCHAR,
	P_ARTICLE_CLUSTER_EN VARCHAR ,
	P_ARTICLE_CLUSTER_LANDESSPRACHE VARCHAR,
	P_FLAG_AKTIV FLOAT
	)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
   // Vorhandener Datensatz updaten
   if ( P_ARTICLE_CLUSTER_ID == 99 | P_ARTICLE_CLUSTER_ID == 0){
        P_FLAG_AKTIV = 2;
    }
    
    // Pruefen welcher mandant wegen der Landessprache
    var sql_stmt = "";

  switch (P_MANDANT_ID) {
    case 1: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :4,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;
    case 2: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :5,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :4,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;

    case 3: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :5,
                        ARTICLE_CLUSTER_ro = :4,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;

    case 4: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :5,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;

    case 5: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :4,
                        ARTICLE_CLUSTER_sk = :5,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;

    case 6: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :5,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :4,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;

    case 7: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :4,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :5,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;

    case 8: 
        var sql_stmt = 	
            `UPDATE CORE.TS_L_ARTICLE_CLUSTER
                SET ARTICLE_CLUSTER = :3 ,
                        ARTICLE_CLUSTER_bg = :5,
                        ARTICLE_CLUSTER_cz = :4,
                        ARTICLE_CLUSTER_en = :4,
                        ARTICLE_CLUSTER_hr = :4,
                        ARTICLE_CLUSTER_pl = :4,
                        ARTICLE_CLUSTER_ro = :4,
                        ARTICLE_CLUSTER_sk = :4,
                        ARTICLE_CLUSTER_landessprache = :5,
                        flag_aktiv = :6,
                        flag_deaktiv = :6
                Where mandant_id = :1
                    AND ARTICLE_CLUSTER_ID = :2`;
         break;
    default:
			break;
  }

      snowflake.createStatement({
          sqlText : sql_stmt,
          binds : [P_MANDANT_ID,P_ARTICLE_CLUSTER_ID,P_ARTICLE_CLUSTER,P_ARTICLE_CLUSTER_EN,P_ARTICLE_CLUSTER_LANDESSPRACHE,P_FLAG_AKTIV].map(function(x){return x === undefined ? null : x})
      }).execute();
		
	var sql_commit = `COMMIT;`;
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
   	
   $$;