 CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_IN_USER_TS_LIN_GF_ORG_EBENE(
    P_USER_ID VARCHAR(30),
    P_HR_OBJEKT_EBENE2_ID FLOAT,
    P_HR_OBJEKT_EBENE3_ID FLOAT,
    P_HR_OBJEKT_EBENE4_ID FLOAT
) RETURNS BOOLEAN 
LANGUAGE JAVASCRIPT 
EXECUTE AS OWNER AS $$ 

if (P_HR_OBJEKT_EBENE2_ID != null){
    var SQL_INSERT = 'INSERT INTO dbp_msi_data.ts_lin_gf_org_ebene_zu(USER_ID, HR_OBJEKT_EBENE2_ID) values (:1,:2)';
    
    snowflake.createStatement({
        sqlText : SQL_INSERT,
        binds: [P_USER_ID, P_HR_OBJEKT_EBENE2_ID]
    }).execute();

} else if (P_HR_OBJEKT_EBENE3_ID != null){
    var SQL_INSERT = 'INSERT INTO dbp_msi_data.ts_lin_gf_org_ebene_zu(USER_ID,HR_OBJEKT_EBENE3_ID) values (:1,:2)';
     snowflake.createStatement({
        sqlText : SQL_INSERT,
        binds: [P_USER_ID, P_HR_OBJEKT_EBENE3_ID]
    }).execute();
} else if (P_HR_OBJEKT_EBENE4_ID != null){
   var SQL_INSERT = 'INSERT INTO dbp_msi_data.ts_lin_gf_org_ebene_zu(USER_ID,HR_OBJEKT_EBENE4_ID) values (:1,:2)';
    snowflake.createStatement({
        sqlText : SQL_INSERT,
        binds: [P_USER_ID, P_HR_OBJEKT_EBENE4_ID]
    }).execute();
}

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;
