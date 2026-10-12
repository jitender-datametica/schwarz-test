CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_BY_ROW(MATCHING_ID VARCHAR, ART_ID VARCHAR, GTIN VARCHAR, STK_RE_PFLEGE VARCHAR, VORSCHLAG VARCHAR, PRODUKTWISSEN_PFLEGE VARCHAR, LIEFERANTENWISSEN_PFLEGE VARCHAR, LISTUNG_SST_PFLEGE VARCHAR, OST_BASIS_PFLEGE VARCHAR, OST_GROSS_PFLEGE VARCHAR, SUED_OST_PFLEGE VARCHAR, SUED_WEST_PFLEGE VARCHAR, WEST_PFLEGE VARCHAR, NORD_PFLEGE VARCHAR, KJMO VARCHAR, N_K_ARTIKEL VARCHAR, NL_ART_BEZ VARCHAR, KJWO_UPDATE VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '

var var_matching_id; // INTEGER;
var var_art_id; // INTEGER;
var var_gtin; // VARCHAR(100);
var var_stk_re_pflege; // VARCHAR(255);
var var_vorschlag; // VARCHAR(255);
var var_vorschlag_hr; // VARCHAR(255);
var var_produktwissen_pflege ; //VARCHAR(255);
var var_lieferantenwissen_pflege; // VARCHAR(255);
var var_listung_sst_pflege; // VARCHAR(255);
var var_ost_basis_pflege; // CHAR(1);
var var_ost_gross_pflege; // CHAR(1);
var var_sued_ost_pflege; // CHAR(1);
var var_sued_west_pflege; // CHAR(1);
var var_west_pflege; // CHAR(1);
var var_nord_pflege; // CHAR(1);
var var_kjmo; // INTEGER;
var var_n_k_artikel; // INTEGER;
var var_nl_art_bez; // VARCHAR(300);
var var_region_summary; // INTEGER;
var var_region_summary2; // INTEGER;
var var_kjwo_update; // INTEGER;
var mandant_id; // INTEGER;
var var_sst_tool_fg; // BYTEINT;
var var_ob_tool_fg; // BYTEINT;
var var_og_tool_fg; // BYTEINT;
var var_so_tool_fg; // BYTEINT;
var var_sw_tool_fg; // BYTEINT;
var var_w_tool_fg;  // BYTEINT;
var var_n_tool_fg;  // BYTEINT;
var region_only;  // BYTEINT;
var sst_only;  // BYTEINT;
var sst_reg;  // BYTEINT;
var sst_reg_change; // BYTEINT;

var ob_reg_char; // CHAR(1);
var og_reg_char; // CHAR(1);
var so_reg_char; // CHAR(1);
var sw_reg_char; // CHAR(1);
var n_reg_char; // CHAR(1);
var w_reg_char; // CHAR(1);

mandant_id = 1;
var_matching_id = MATCHING_ID;
var_art_id= ART_ID;
var_gtin = GTIN;

if (STK_RE_PFLEGE != "") {
    var_stk_re_pflege = STK_RE_PFLEGE;
}
else {
    var_stk_re_pflege = undefined
}


if (VORSCHLAG != undefined) {
    var_vorschlag = VORSCHLAG;
}
else {
    var_vorschlag = ''''
}

if (VORSCHLAG != undefined) {
    var_vorschlag_hr = VORSCHLAG;
}
else {
    var_vorschlag_hr = ''''
}

var_produktwissen_pflege = PRODUKTWISSEN_PFLEGE;
var_lieferantenwissen_pflege = LIEFERANTENWISSEN_PFLEGE;
var_listung_sst_pflege =  LISTUNG_SST_PFLEGE  ;


if (OST_BASIS_PFLEGE == 0 && OST_GROSS_PFLEGE == 0 && SUED_OST_PFLEGE == 0 && SUED_WEST_PFLEGE == 0 && WEST_PFLEGE == 0 && NORD_PFLEGE == 0) {
    var_region_summary = 0;
}
else {
    var_region_summary = 1;
}
/*----------------------------------------------------
 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A; 5 = SST gesetzt bei ausschließlicher Clusterpflege
--SET var_sst_tool_fg*/
sql = ` SELECT CASE
            WHEN listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') IS NOT NULL AND TRIM(''` + var_listung_sst_pflege + `'') <> '''') AND
                CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') AS INT) < CAST(listung_sst_mvke AS INT)
            THEN 1
            WHEN listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') IS NOT NULL AND TRIM(''` + var_listung_sst_pflege + `'') <> '''') AND
                CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') AS INT) > CAST(listung_sst_mvke AS INT)
            THEN 2
            WHEN listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  IS NOT NULL AND  TRIM(''` + var_listung_sst_pflege + `'')  <> '''') AND
                CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') AS INT) = CAST(listung_sst_mvke AS INT)
            THEN 3
            WHEN listung_sst_mvke = ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  IS NOT NULL AND  TRIM(''` + var_listung_sst_pflege + `'')  <> '''')
            THEN 4
            WHEN listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  IS NULL OR  TRIM(''` + var_listung_sst_pflege + `'')  = '''')
            THEN 5
            ELSE 0
            END
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
                MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
                KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_sst_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(west,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_w_tool_fg = result.getColumnValue(1);



sql = ` SELECT CASE
            WHEN COALESCE(nord,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_n_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(ost_basis,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_ob_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(ost_gross,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_og_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(sued_ost,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_so_tool_fg = result.getColumnValue(1);



sql = ` SELECT CASE
            WHEN COALESCE(sued_west,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.sortiment_leistung 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            KJWO_UPDATE =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_sw_tool_fg = result.getColumnValue(1);


if ((OST_BASIS_PFLEGE == 1 || OST_GROSS_PFLEGE == 1 || SUED_OST_PFLEGE == 1 || SUED_WEST_PFLEGE == 1 || NORD_PFLEGE == 1) && (var_listung_sst_pflege == undefined || var_listung_sst_pflege == "")  ) {
    var_region_summary2 = 1;
}
else {
    var_region_summary2 = 0;
}




/*--- Die alles entscheidende Weiche, welcher Zweig zu waehlen ist!*/

if (LISTUNG_SST_PFLEGE == undefined || LISTUNG_SST_PFLEGE == "" || LISTUNG_SST_PFLEGE == " "){
    region_only = 1;
}
else {
    region_only = 0;
}

if ((LISTUNG_SST_PFLEGE != undefined && LISTUNG_SST_PFLEGE != "" && LISTUNG_SST_PFLEGE != " ") && var_region_summary == 0){
    sst_only = 1;
}
else {
    sst_only = 0;
}         

if ((LISTUNG_SST_PFLEGE != undefined && LISTUNG_SST_PFLEGE !=  "" && LISTUNG_SST_PFLEGE !=  " ") && var_region_summary == 1){
    sst_reg = 1;
}
else {
    sst_reg = 0;
}         

/*--------------------------------------*/

/*-- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A*/

if (  sst_reg == 1 && var_sst_tool_fg == 1 ){ 
	sst_reg_change =  1;
} 
else if( sst_reg == 1 && var_sst_tool_fg == 2 ){ 
	sst_reg_change =  2;
} 
else if( sst_reg == 1 && var_sst_tool_fg == 3 ){ 
	sst_reg_change =  3;
} 
else if( sst_reg == 1 && var_sst_tool_fg == 4 ){ 
	sst_reg_change =  4;
}
else { 
	sst_reg_change =  0 ;
}

                      
/*--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---*/

if (  NORD_PFLEGE      == 1 ){ 
	n_reg_char  =  ''N'' ;
}
else { 
	n_reg_char  =  '' '' ;
}

if (  WEST_PFLEGE      == 1 ){ 
	w_reg_char  =  ''W'' ;
}
else { 
	w_reg_char  =  '' '' ;
}

if (  OST_BASIS_PFLEGE == 1 ){ 
	ob_reg_char =  ''O'' ;
}
else { 
	ob_reg_char =  '' '' ;
}


if (  OST_GROSS_PFLEGE == 1 ){ 
	og_reg_char =  ''Q'' ;
}
else { 
	og_reg_char =  '' '' ;
}

if (  SUED_OST_PFLEGE  == 1 ){ 
	so_reg_char =  ''G'' ;
}
else { 
	so_reg_char =  '' '' ;
}

if (  SUED_WEST_PFLEGE == 1 ){ 
	sw_reg_char =  ''M'' ;
}
else { 
	sw_reg_char =  '' '' ;
}



if (  region_only == 1 && OST_BASIS_PFLEGE == 1 && var_ob_tool_fg == 0 ){ 
	var_ost_basis_pflege =  ''x'';
} 
else if( region_only == 1 && OST_BASIS_PFLEGE == 1 && var_ob_tool_fg == 1 ){ 
	var_ost_basis_pflege =  '' '';
} 
else if( region_only == 1 && OST_BASIS_PFLEGE == 0 && var_ob_tool_fg == 0 && var_sst_tool_fg  == 5 ){ 
	var_ost_basis_pflege =  ''u'';
} 
else if( region_only == 1 && OST_BASIS_PFLEGE == 0 && var_ob_tool_fg == 0 && var_sst_tool_fg != 5 ){ 
	var_ost_basis_pflege =  '' '';
} 
else if( region_only == 1 && OST_BASIS_PFLEGE == 0 && var_ob_tool_fg == 0 ){ 
	var_ost_basis_pflege =  '' '';
} 
else if( region_only == 1 && OST_BASIS_PFLEGE == 0 && var_ob_tool_fg == 1 ){ 
	var_ost_basis_pflege =  ''u'';
} 
else if( sst_reg     == 1 && OST_BASIS_PFLEGE == 0 && var_ob_tool_fg == 0 ){ 
	var_ost_basis_pflege =  '' '';
} 
else if( sst_reg     == 1 && OST_BASIS_PFLEGE == 0 && var_ob_tool_fg == 1 ){ 
	var_ost_basis_pflege =  ''u'';
} 
else if( sst_reg     == 1 && OST_BASIS_PFLEGE == 1 && var_ob_tool_fg == 0 ){ 
	var_ost_basis_pflege =  ''x'';
} 
else if( sst_reg     == 1 && OST_BASIS_PFLEGE == 1 && var_ob_tool_fg == 1 ){ 
	var_ost_basis_pflege =  '' '';
}
else { 
	var_ost_basis_pflege =  '' '' ;
}




if (  region_only == 1 && OST_GROSS_PFLEGE == 1 && var_og_tool_fg == 0 ){ 
	var_ost_gross_pflege =  ''x'';
} 
else if( region_only == 1 && OST_GROSS_PFLEGE == 1 && var_og_tool_fg == 1 ){ 
	var_ost_gross_pflege =  '' '';
} 
else if( region_only == 1 && OST_GROSS_PFLEGE == 0 && var_og_tool_fg == 0 && var_sst_tool_fg  == 5 ){ 
	var_ost_gross_pflege =  ''u'';
} 
else if( region_only == 1 && OST_GROSS_PFLEGE == 0 && var_og_tool_fg == 0 && var_sst_tool_fg != 5 ){ 
	var_ost_gross_pflege =  '' '';
} 
else if( region_only == 1 && OST_GROSS_PFLEGE == 0 && var_og_tool_fg == 0 ){ 
	var_ost_gross_pflege =  '' '';
} 
else if( region_only == 1 && OST_GROSS_PFLEGE == 0 && var_og_tool_fg == 1 ){ 
	var_ost_gross_pflege =  ''u'';
} 
else if( sst_reg     == 1 && OST_GROSS_PFLEGE == 0 && var_og_tool_fg == 0 ){ 
	var_ost_gross_pflege =  '' '';
} 
else if( sst_reg     == 1 && OST_GROSS_PFLEGE == 0 && var_og_tool_fg == 1 ){ 
	var_ost_gross_pflege =  ''u'';
} 
else if( sst_reg     == 1 && OST_GROSS_PFLEGE == 1 && var_og_tool_fg == 0 ){ 
	var_ost_gross_pflege =  ''x'';
} 
else if( sst_reg     == 1 && OST_GROSS_PFLEGE == 1 && var_og_tool_fg == 1 ){ 
	var_ost_gross_pflege =  '' '';
}
else { 
	var_ost_gross_pflege =  '' '' ;
}



if (  region_only == 1 && SUED_OST_PFLEGE == 1 && var_so_tool_fg == 0 ){ 
	var_sued_ost_pflege  =  ''x'';
} 
else if( region_only == 1 && SUED_OST_PFLEGE == 1 && var_so_tool_fg == 1 ){ 
	var_sued_ost_pflege  =  '' '';
} 
else if( region_only == 1 && SUED_OST_PFLEGE == 0 && var_so_tool_fg == 0 && var_sst_tool_fg  == 5 ){ 
	var_sued_ost_pflege  =  ''u'';
} 
else if( region_only == 1 && SUED_OST_PFLEGE == 0 && var_so_tool_fg == 0 && var_sst_tool_fg != 5 ){ 
	var_sued_ost_pflege  =  '' '';
} 
else if( region_only == 1 && SUED_OST_PFLEGE == 0 && var_so_tool_fg == 0 ){ 
	var_sued_ost_pflege  =  '' '';
} 
else if( region_only == 1 && SUED_OST_PFLEGE == 0 && var_so_tool_fg == 1 ){ 
	var_sued_ost_pflege  =  ''u'';
} 
else if( sst_reg     == 1 && SUED_OST_PFLEGE == 0 && var_so_tool_fg == 0 ){ 
	var_sued_ost_pflege  =  '' '';
} 
else if( sst_reg     == 1 && SUED_OST_PFLEGE == 0 && var_so_tool_fg == 1 ){ 
	var_sued_ost_pflege  =  ''u'';
} 
else if( sst_reg     == 1 && SUED_OST_PFLEGE == 1 && var_so_tool_fg == 0 ){ 
	var_sued_ost_pflege  =  ''x'';
} 
else if( sst_reg     == 1 && SUED_OST_PFLEGE == 1 && var_so_tool_fg == 1 ){ 
	var_sued_ost_pflege  =  '' '';
}
else { 
	var_sued_ost_pflege  =  '' '' ;
}
                                

if (  region_only == 1 && SUED_WEST_PFLEGE == 1 && var_sw_tool_fg == 0 ){ 
	var_sued_west_pflege =  ''x'';
} 
else if( region_only == 1 && SUED_WEST_PFLEGE == 1 && var_sw_tool_fg == 1 ){ 
	var_sued_west_pflege =  '' '';
} 
else if( region_only == 1 && SUED_WEST_PFLEGE == 0 && var_sw_tool_fg == 0 && var_sst_tool_fg  == 5 ){ 
	var_sued_west_pflege =  ''u'';
} 
else if( region_only == 1 && SUED_WEST_PFLEGE == 0 && var_sw_tool_fg == 0 && var_sst_tool_fg != 5 ){ 
	var_sued_west_pflege =  '' '';
} 
else if( region_only == 1 && SUED_WEST_PFLEGE == 0 && var_sw_tool_fg == 0 ){ 
	var_sued_west_pflege =  '' '';
} 
else if( region_only == 1 && SUED_WEST_PFLEGE == 0 && var_sw_tool_fg == 1 ){ 
	var_sued_west_pflege =  ''u'';
} 
else if( sst_reg     == 1 && SUED_WEST_PFLEGE == 0 && var_sw_tool_fg == 0 ){ 
	var_sued_west_pflege =  '' '';
} 
else if( sst_reg     == 1 && SUED_WEST_PFLEGE == 0 && var_sw_tool_fg == 1 ){ 
	var_sued_west_pflege =  ''u'';
} 
else if( sst_reg     == 1 && SUED_WEST_PFLEGE == 1 && var_sw_tool_fg == 0 ){ 
	var_sued_west_pflege =  ''x'';
} 
else if( sst_reg     == 1 && SUED_WEST_PFLEGE == 1 && var_sw_tool_fg == 1 ){ 
	var_sued_west_pflege =  '' '';
}
else { 
	var_sued_west_pflege =  '' '' ;
}
                                

if (  region_only == 1 && WEST_PFLEGE == 1 && var_w_tool_fg == 0 ){ 
	var_west_pflege      =  ''x'';
} 
else if( region_only == 1 && WEST_PFLEGE == 1 && var_w_tool_fg == 1 ){ 
	var_west_pflege      =  '' '';
} 
else if( region_only == 1 && WEST_PFLEGE == 0 && var_w_tool_fg == 0 && var_sst_tool_fg  == 5 ){ 
	var_west_pflege      =  ''u'';
} 
else if( region_only == 1 && WEST_PFLEGE == 0 && var_w_tool_fg == 0 && var_sst_tool_fg != 5 ){ 
	var_west_pflege      =  '' '';
} 
else if( region_only == 1 && WEST_PFLEGE == 0 && var_w_tool_fg == 1 ){ 
	var_west_pflege      =  ''u'';
} 
else if( sst_reg     == 1 && WEST_PFLEGE == 0 && var_w_tool_fg == 0 ){ 
	var_west_pflege      =  '' '';
} 
else if( sst_reg     == 1 && WEST_PFLEGE == 0 && var_w_tool_fg == 1 ){ 
	var_west_pflege      =  ''u'';
} 
else if( sst_reg     == 1 && WEST_PFLEGE == 1 && var_w_tool_fg == 0 ){ 
	var_west_pflege      =  ''x'';
} 
else if( sst_reg     == 1 && WEST_PFLEGE == 1 && var_w_tool_fg == 1 ){ 
	var_west_pflege      =  '' '';
}
else { 
	var_west_pflege      =  '' '' ;
}
                               

if (  region_only == 1 && NORD_PFLEGE == 1 && var_n_tool_fg == 0 ){ 
	var_nord_pflege      =  ''x'';
} 
else if( region_only == 1 && NORD_PFLEGE == 1 && var_n_tool_fg == 1 ){ 
	var_nord_pflege      =  '' '';
} 
else if( region_only == 1 && NORD_PFLEGE == 0 && var_n_tool_fg == 0 && var_sst_tool_fg  == 5 ){ 
	var_nord_pflege      =  ''u'';
} 
else if( region_only == 1 && NORD_PFLEGE == 0 && var_n_tool_fg == 0 && var_sst_tool_fg != 5 ){ 
	var_nord_pflege      =  '' '';
} 
else if( region_only == 1 && NORD_PFLEGE == 0 && var_n_tool_fg == 0 ){ 
	var_nord_pflege      =  '' '';
} 
else if( region_only == 1 && NORD_PFLEGE == 0 && var_n_tool_fg == 1 ){ 
	var_nord_pflege      =  ''u'';
} 
else if( sst_reg     == 1 && NORD_PFLEGE == 0 && var_n_tool_fg == 0 ){ 
	var_nord_pflege      =  '' '';
} 
else if( sst_reg     == 1 && NORD_PFLEGE == 0 && var_n_tool_fg == 1 ){ 
	var_nord_pflege      =  ''u'';
} 
else if( sst_reg     == 1 && NORD_PFLEGE == 1 && var_n_tool_fg == 0 ){ 
	var_nord_pflege      =  ''x'';
} 
else if( sst_reg     == 1 && NORD_PFLEGE == 1 && var_n_tool_fg == 1 ){ 
	var_nord_pflege      =  '' '';
}
else { 
	var_nord_pflege      =  '' '' ;
}


var_kjmo = KJMO;
var_n_k_artikel = N_K_ARTIKEL;
var_nl_art_bez = NL_ART_BEZ;
var_kjwo_update = KJWO_UPDATE;

/*
--IF (var_vorschlag IN (''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen''))
--THEN
--  DELETE FROM dbp_etl_process.ek_sort_batch WHERE MATCHING_ID =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND mandant_id =  ''` + mandant_id + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE; + `'' 
--  IF (var_vorschlag IN (''Keine Veränderung setzen''))
--  THEN 
--    INSERT INTO dbp_etl_process.ek_sort_batch (mandant_id,matching_id,kjmo,kjwo_update) VALUES ( ''` + mandant_id, + `''   ''` + MATCHING_ID, + `''   ''` + kjmo, + `''   ''` + KJWO_UPDATE + `'' );
--  END IF;
--ELSE                                             
*/


if ((var_region_summary == 0 && (var_listung_sst_pflege == undefined || var_listung_sst_pflege == '''') && 
    (var_produktwissen_pflege == undefined || var_produktwissen_pflege == '''') &&
    (var_lieferantenwissen_pflege == undefined || var_lieferantenwissen_pflege == '''') &&
    (var_vorschlag = '''' || var_vorschlag == undefined))) {
        
        var_nl_art_bez = NL_ART_BEZ
}
else{
    if (var_gtin == undefined || (var_gtin != undefined && (''-9999'',''-9998'').includes(var_gtin) == false)) {
        if (var_vorschlag == ''Zurücksetzen'') {
            sql=`UPDATE dbp_data.sortiment_leistung
            SET stk_re_pflege = NULL
            ,listungsaktion = NULL
            ,produktwissen_pflege = NULL
            ,lieferantenwissen_pflege = NULL
            ,listung_sst_pflege = NULL
            ,ost_basis_pflege = '' ''
            ,ost_gross_pflege = '' ''
            ,sued_ost_pflege = '' ''
            ,sued_west_pflege = '' ''
            ,west_pflege = '' ''
            ,nord_pflege = '' ''
            ,umsatz_hr = NULL
            ,absatz_hr = NULL
            ,rohertrag_hr = NULL
            WHERE matching_id = ''` + MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'';`;

            sql = sql.replace(/''undefined''/g, "NULL")
            sql_stmt = snowflake.createStatement({sqlText: sql});
            sql_stmt.execute();    


            sql= `DELETE FROM dbp_msi_data.erwartete_entwicklung
                  WHERE matching_id = ''` +  MATCHING_ID + `''  AND
                          kjmo = ''` +  KJMO + `'' AND
                          kjwo_update = ''` +  KJWO_UPDATE + `'' AND
                          mandant_id = ''` +  mandant_id + `'';`;
        } /* END IF (var_vorschlag == ''Zurücksetzen'') */
        else if (var_vorschlag == ''Keine Veränderung setzen'') {

        	sql=`UPDATE dbp_data.sortiment_leistung
        		SET  listungsaktion = ''Keine Veränderung''
        		,listung_sst_pflege = NULL
        		,ost_basis_pflege = '' ''
        		,ost_gross_pflege = '' ''
        		,sued_ost_pflege = '' ''
        		,sued_west_pflege = '' ''
        		,west_pflege = '' ''
        		,nord_pflege = '' ''
        		,umsatz_hr = NULL
        		,absatz_hr = NULL
        		,rohertrag_hr = NULL
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'' AND (listungsaktion IS NULL OR listungsaktion = '''');`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
            
        }
            
        else if (var_vorschlag == ''Keine Veränderung'') {
        	sql = `UPDATE dbp_data.sortiment_leistung
        		SET  listungsaktion = ''Keine Veränderung''
        		,listung_sst_pflege = NULL
        		,ost_basis_pflege = '' ''
        		,ost_gross_pflege = '' ''
        		,sued_ost_pflege = '' ''
        		,sued_west_pflege = '' ''
        		,produktwissen_pflege = ''` +  PRODUKTWISSEN_PFLEGE + `''
        		,lieferantenwissen_pflege = ''` +  LIEFERANTENWISSEN_PFLEGE + `''
        		,west_pflege = '' ''
        		,nord_pflege = '' ''
        		,umsatz_hr = NULL
        		,absatz_hr = NULL
        		,rohertrag_hr = NULL
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'';`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
            
        }

        else if (var_vorschlag == ''Keine Veränderung zurücksetzen'') {
        	sql= `UPDATE dbp_data.sortiment_leistung
        		SET  listungsaktion = NULL
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND listungsaktion = ''Keine Veränderung'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'';`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
            
        }   

        else if (var_vorschlag == ''Produktwissen'') {
        	sql =`UPDATE dbp_data.sortiment_leistung
        		SET  produktwissen_pflege = produktwissen_vp
        	    WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'' AND (produktwissen_pflege IS NULL OR produktwissen_pflege = '''') AND (produktwissen_vp IS NOT NULL AND produktwissen_vp <> '''');`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
        }

        else if ((var_vorschlag == '''' || var_vorschlag == undefined) && (var_listung_sst_pflege == '''' || var_listung_sst_pflege == undefined) && var_produktwissen_pflege != '''' && var_produktwissen_pflege != undefined && var_region_summary2 == 0) {
        	sql =`UPDATE dbp_data.sortiment_leistung
        		SET  produktwissen_pflege = ''` +  PRODUKTWISSEN_PFLEGE + `''
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'';`;
            
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
        
        }

        else if ((var_vorschlag == '''' || var_vorschlag == undefined) && (var_listung_sst_pflege == '''' || var_listung_sst_pflege == undefined) && var_produktwissen_pflege != '''' && var_produktwissen_pflege != undefined && var_region_summary2 == 0) {
        	sql =`UPDATE dbp_data.sortiment_leistung
        		SET  produktwissen_pflege = ''` +  PRODUKTWISSEN_PFLEGE + `''
                    , lieferantenwissen_pflege =  ''` + lieferantenwissen_pflege + `'' 
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'';`;
            
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
        
        }

        else if (var_vorschlag == ''Lieferantenwissen'') {
        	sql =`UPDATE dbp_data.sortiment_leistung
                SET  lieferantenwissen_pflege = lieferantenwissen_vp
                WHERE MATCHING_ID =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND mandant_id =  ''` + mandant_id + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND (lieferantenwissen_pflege IS NULL OR lieferantenwissen_pflege = '''') AND (lieferantenwissen_vp IS NOT NULL AND lieferantenwissen_vp <> '''');`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
        }

        else if ((var_vorschlag == "" || var_vorschlag == " ") && (var_listung_sst_pflege == "" || var_listung_sst_pflege == " " ||  var_listung_sst_pflege == undefined) && var_lieferantenwissen_pflege != "" && var_lieferantenwissen_pflege != " " && var_lieferantenwissen_pflege != undefined && var_region_summary2 == 0 ) {
        	sql =`UPDATE dbp_data.sortiment_leistung
                SET  produktwissen_pflege =  ''` + PRODUKTWISSEN_PFLEGE + `'' 
                , lieferantenwissen_pflege =  ''` + LIEFERANTENWISSEN_PFLEGE + `'' 
                WHERE MATCHING_ID =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND mandant_id =  ''` + mandant_id + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE + `'' `;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
        }

        else{        
            sql =`UPDATE dbp_data.sortiment_leistung
	            	SET  stk_re_pflege = ''` +  STK_RE_PFLEGE + `''
	            	,listungsaktion = ''` +  VORSCHLAG + `''
	            	,produktwissen_pflege = ''` +  PRODUKTWISSEN_PFLEGE + `''
	            	,lieferantenwissen_pflege = ''` +  LIEFERANTENWISSEN_PFLEGE + `''
	            	,listung_sst_pflege = Coalesce(Trim(''` +  LISTUNG_SST_PFLEGE + `''),''N/A'')
	            	,ost_basis_pflege = Trim(Decode(''` +  OST_BASIS_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,ost_gross_pflege = Trim(Decode(''` +  OST_GROSS_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,sued_ost_pflege = Trim(Decode(''` +  SUED_OST_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,sued_west_pflege = Trim(Decode(''` +  SUED_WEST_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,west_pflege = Trim(Decode(''` +  WEST_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,nord_pflege = Trim(Decode(''` +  NORD_PFLEGE + `'',0, '' '', 1, ''X''))
                    WHERE matching_id = ''` +  MATCHING_ID + `'' AND kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND kjwo_update = ''` +  KJWO_UPDATE + `'';`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();

            
        
            if ((var_listung_sst_pflege != '''' && var_listung_sst_pflege != '' '' && var_listung_sst_pflege != undefined) || (var_vorschlag_hr == ''Auslisten'')) {
                if (var_vorschlag_hr == ''Auslisten'' || ((var_listung_sst_pflege == '''' || var_listung_sst_pflege == '' '' || var_listung_sst_pflege == undefined ) && var_region_summary == 0)) {
                  var_listung_sst_pflege = ''-1'';
                }

      	        sql=`INSERT INTO dbp_msi_data.sortiment_art (mandant_id,
                                                                art_id,
                                                                gtin_id,
                                                                status,
                                                                kjwo_update)
                    SELECT a.mandant_id,
      	                     a.art_id,
                               Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
                               Max(a.status) AS status,
                               ''` +  KJWO_UPDATE + `'' AS kjwo_update
                              FROM dbp_etl.art_matching_nielsen_per a
                    WHERE a.art_matching_id =  ''` + MATCHING_ID + `''  AND
                        CASE
                            WHEN a.status <> ''N'' AND
                                a.list_kz = ''A''
                            THEN 1
                            WHEN a.status = ''N''
                            THEN 1
                            ELSE 0
                        END = 1
                    GROUP BY 1,2;`;
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();


                /*
                --------------------------------------------------------------------------------------------------------
                --   (I) UPDATE FUER SORTIMENT_LEISTUNG (mit K-Stufen)
                --------------------------------------------------------------------------------------------------------
                */
                sql=`UPDATE dbp_data.sortiment_leistung FROM (
                                                    SELECT SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
                                                    SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
                                                    replace(replace(
                         	                                        Max(
                         	                                        	IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         	                                        				, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         	                                        				, replace(x.vorschlag_, ''dynamic'', ''AAA'')
                         	                                        					)
                         	                                        )
                         	                                           , ''Dynamic'', ''dynamic'')
                         	                                           , ''AAA'', ''dynamic'')AS vorschlag__, 
                                                    CASE
                                                        WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
                                                        WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ AND  ''` + var_region_summary + `''  = 0 THEN ''Listung reduzieren und erweitern''
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ AND  ''` + var_region_summary + `''  = 0 THEN ''Listung erweitern und reduzieren''
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ AND  ''` + var_region_summary + `''  = 1 THEN ''Listung reduzieren und erweitern''
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ AND  ''` + var_region_summary + `''  = 1 THEN ''Listung erweitern und reduzieren''
                                                                                        WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
                                                                                        ELSE ''SOLL-Listung = IST-Listung''
                                                    END AS vorschlag,

                                                    CASE
                                                        WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                        THEN 0
                                                        ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                                    END AS umsatz,
                                                    CASE
                                                        WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                        THEN 0
                                                        ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                                    END AS absatz,
                                                    CASE
                                                        WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                        THEN 0
                                                        ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                                    END AS rohertrag
                                                    
                                                FROM (-- Nur SST gepflegt fuer Erweiterung!
                                                    `
                                                    /* hier kann noch optimiert werden */
                                                    sql = sql.concat(`
                                                    SELECT a.art_id,
                                                            MAX(b.status) AS status,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            CAST(0 AS INT) AS anzahl_reduktion,
                                                            SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                            CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END AS vorschlag_
                                                    FROM dbp_msi_data.kl_listung a
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                                            a.listung_art = ''Listung erweitern'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord = ''-'' AND 
                                                            a.ost_basis = ''-'' AND 
                                                            a.ost_gross = ''-'' AND 
                                                            a.sued_ost = ''-'' AND 
                                                            a.sued_west = ''-'' AND 
                                                            a.west = ''-'') AND
                                                        ( ''` + sst_only + `''  = 1 OR
                                                            ''` + sst_reg_change + `''  IN (1,4))
                                                    GROUP BY 1
                                                    -- Nur SST gepflegt fuer Reduktion!
                                                    `)
                                                    if (sst_only == 1 || sst_reg_change in [2,4]){
                                                    sql = sql.concat(`
                                                    UNION ALL
                                                    SELECT a.art_id,
                                                            MAX(b.status) AS status,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            SUM(reduktion_fg) AS anzahl_reduktion,
                                                            CAST(0 AS INT) AS anzahl_erweiterung,
                                                            ''dynamic'' AS vorschlag_
                                                    FROM dbp_msi_data.kl_listung a
                                                    JOIN dbp_data.wup x
                                                        ON a.mandant_id = x.mandant_id AND
                                                        a.wup_id = x.wup_id
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                                            a.listung_art = ''Listung reduzieren'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                            a.sm_id < CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord = ''-'' AND 
                                                            a.ost_basis = ''-'' AND 
                                                            a.ost_gross = ''-'' AND 
                                                            a.sued_ost = ''-'' AND 
                                                            a.sued_west = ''-'' AND 
                                                            a.west = ''-'') AND 
                                                            CASE
                                                            WHEN  ''` + sst_reg_change + `''  = 4 AND
                                                                (x.kreistyp_gruppe_id =  ''` + n_reg_char + `''   OR
                                                                x.kreistyp_gruppe_id =  ''` + w_reg_char + `''   OR
                                                                x.kreistyp_gruppe_id =  ''` + so_reg_char + `''  OR
                                                                x.kreistyp_gruppe_id =  ''` + sw_reg_char + `''  OR
                                                                x.kreistyp_gruppe_id =  ''` + ob_reg_char + `''  OR
                                                                x.kreistyp_gruppe_id =  ''` + og_reg_char + `'' )
                                                            THEN 0
                                                            ELSE 1
                                                            END = 1 AND
                                                        ( ''` + sst_only + `''  = 1 OR
                                                            ''` + sst_reg_change + `''  IN (2,4))
                                                    GROUP BY 1
                                                    `)
                                                    }
                                                    if (sst_reg == 1){
                                                    sql = sql.concat(`
                                                    UNION ALL
                                                    -- SST plus Cluster fuer Erweiterung!
                                                    SELECT a.art_id,
                                                            MAX(b.status) AS status,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            CAST(0 AS INT) AS anzahl_reduktion,
                                                            SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                            CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END AS vorschlag_
                                                    FROM dbp_msi_data.kl_listung a
                                                    JOIN dbp_data.wup x
                                                        ON a.mandant_id = x.mandant_id AND
                                                        a.wup_id = x.wup_id
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                                            a.listung_art = ''Listung erweitern'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = 0 AND
                                                            a.sm_id < CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord =  ''` + var_nord_pflege + `''  OR 
                                                            a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                                            a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                                            a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                                            a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                                            a.west =  ''` + var_west_pflege + `'' ) AND 
                                                            CASE
                                                            WHEN  ''` + sst_reg_change + `''  = 4 AND
                                                                a.sm_id >= CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                                (x.kreistyp_gruppe_id =  ''` + n_reg_char + `''   OR
                                                                x.kreistyp_gruppe_id =  ''` + w_reg_char + `''   OR
                                                                x.kreistyp_gruppe_id =  ''` + so_reg_char + `''  OR
                                                                x.kreistyp_gruppe_id =  ''` + sw_reg_char + `''  OR
                                                                x.kreistyp_gruppe_id =  ''` + ob_reg_char + `''  OR
                                                                x.kreistyp_gruppe_id =  ''` + og_reg_char + `'' )
                                                            THEN 0
                                                            ELSE 1
                                                            END = 1 AND
                                                            ''` + sst_reg + `''  = 1
                                                    GROUP BY 1
                                                    `)
                                                    }
                                                    if (sst_reg == 1 && sst_reg_change != 4){
                                                    sql = sql.concat(`
                                                    UNION ALL
                                                    -- SST plus Cluster fuer Reduktion!
                                                    SELECT a.art_id,
                                                            MAX(b.status) AS status,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            SUM(reduktion_fg) AS anzahl_reduktion,
                                                            CAST(0 AS INT) AS anzahl_erweiterung,
                                                            ''dynamic'' AS vorschlag_
                                                    FROM dbp_msi_data.kl_listung a
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                                            a.listung_art = ''Listung reduzieren'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = 0 AND
                                                            a.sm_id < CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord =  ''` + var_nord_pflege + `''  OR 
                                                            a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                                            a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                                            a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                                            a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                                            a.west =  ''` + var_west_pflege + `'' ) AND
                                                            ''` + sst_reg + `''  = 1 AND
                                                            ''` + sst_reg_change + `''  NOT IN (4)
                                                    GROUP BY 1
                                                    `)
                                                    }
                                                    sql = sql.concat(`
                                                    -- Auslistung!
                                                    UNION ALL
                                                    SELECT a.art_id,
                                                            MAX(b.status) AS status,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            SUM(reduktion_fg) AS anzahl_reduktion,
                                                            CAST(0 AS INT) AS anzahl_erweiterung,
                                                            ''Auslistung'' AS vorschlag_
                                                    FROM dbp_msi_data.kl_listung a
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                                            a.listung_art = ''Auslistung'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord = ''-'' AND 
                                                            a.ost_basis = ''-'' AND 
                                                            a.ost_gross = ''-'' AND 
                                                            a.sued_ost = ''-'' AND 
                                                            a.sued_west = ''-'' AND 
                                                            a.west = ''-'')
                                                    GROUP BY 1
                                                    `)
                                                    if (var_region_summary == 1){
                                                        sql = sql.concat(`
                                                    -- Regionen on top (Nielsen 1)
                                                    UNION ALL
                                                    SELECT 1 AS art_id,
                                                            ''N'' AS status,
                                                            ''A'' AS list_kz,
                                                            SUM(umsatz_hr) AS umsatz_,
                                                            SUM(absatz_hr) AS absatz_,
                                                            SUM(absatz_hr)*CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.''  ) AS FLOAT) AS rohertrag_,
                                                            CAST(0 AS INT) AS anzahl_reduktion,
                                                            COUNT(*) AS anzahl_erweiterung,
                                                            ''Einlistung Potenzialartikel'' AS vorschlag_
                                                    FROM dbp_msi_data.nl_listung
                                                    WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis) AND
                                                            gtin =  ''` + GTIN + `''  AND
                                                            listung_art = ''Einlistung Potenzialartikel'' AND
                                                            KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                                                            art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
                                                            sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (nord =  ''` + var_nord_pflege + `''  OR 
                                                            ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                                            ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                                            sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                                            sued_west =  ''` + var_sued_west_pflege + `''  OR
                                                            west =  ''` + var_west_pflege + `'' )  AND
                                                            ''` + var_region_summary + `''  = 1
                                                    GROUP BY 1,2
                                                    `)
                                                    }
                                                    if(var_region_summary == 0){
                                                    sql = sql.concat(`
                                                    UNION ALL
                                                    --K-Sicht fuer Nielsen (Nielsen 1)
                                                    SELECT 1 AS art_id,
                                                            ''N'' AS status,
                                                            ''A'' AS list_kz,
                                                            SUM(umsatz_hr) AS umsatz_,
                                                            SUM(absatz_hr) AS absatz_,
                                                            SUM(absatz_hr)*CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT) AS rohertrag_,
                                                            CAST(0 AS INT) AS anzahl_reduktion,
                                                            COUNT(*) AS anzahl_erweiterung,
                                                            ''Einlistung Potenzialartikel'' AS vorschlag_
                                                    FROM dbp_msi_data.nl_listung
                                                    WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis) AND
                                                            gtin =  ''` + GTIN + `''  AND
                                                            listung_art = ''Einlistung Potenzialartikel'' AND
                                                            KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                                                            art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
                                                            sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (nord = ''-'' AND
                                                            ost_basis = ''-'' AND
                                                            ost_gross = ''-'' AND
                                                            sued_ost = ''-'' AND
                                                            sued_west = ''-'' AND
                                                            west = ''-'') AND
                                                            ''` + var_region_summary + `''  = 0
                                                    GROUP BY 1,2
                                                    `)
                                                    }
                                                    if(var_region_summary == 1){
                                                    sql = sql.concat(`
                                                    UNION ALL
                                                    SELECT b.art_id,
                                                            MAX(b.status) AS status,
                                                            MAX(''A'') AS list_kz,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.absatz_hr*COALESCE(CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_,
                                                            CAST(0 AS INT) AS anzahl_reduktion,
                                                            COUNT(*) AS anzahl_erweiterung,
                                                            ''Einlistung Kauflandartikel'' AS vorschlag_
                                                    FROM dbp_msi_data.nl_listung a
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON 1 = b.mandant_id AND
                                                            ''` + GTIN + `''  = b.gtin_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    JOIN dbp_etl.bf_sort_sal_export c
                                                        ON b.art_id/100 = CAST(c.art_nr AS INT)
                                                    WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) FROM dbp_etl.not_listed_basis WHERE CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) =  ''` + GTIN + `'' ) AND
                                                            a.listung_art = ''Listung erweitern'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord =  ''` + var_nord_pflege + `''  OR 
                                                            a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                                            a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                                            a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                                            a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                                            a.west =  ''` + var_west_pflege + `'' ) AND
                                                            ''` + var_region_summary + `''  = 1
                                                    GROUP BY 1
                                                    `)
                                                    }
                                                    if(var_region_summary == 0) {
                                                    sql = sql.concat(`
                                                    UNION ALL
                                                    SELECT b.art_id,
                                                            MAX(b.status) AS status,
                                                            MAX(''A'') AS list_kz,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.absatz_hr*COALESCE(CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_,
                                                            CAST(0 AS INT) AS anzahl_reduktion,
                                                            COUNT(*) AS anzahl_erweiterung,
                                                            ''Einlistung Kauflandartikel'' AS vorschlag_
                                                    FROM dbp_msi_data.nl_listung a
                                                    JOIN dbp_msi_data.sortiment_art b
                                                        ON 1 = b.mandant_id AND
                                                            ''` + GTIN + `''  = b.gtin_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    JOIN dbp_etl.bf_sort_sal_export c
                                                        ON b.art_id/100 = CAST(c.art_nr AS INT)
                                                    WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis WHERE CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) =  ''` + GTIN + `'' ) AND
                                                            a.listung_art = ''Listung erweitern'' AND
                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                                            a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                                        (a.nord = ''-'' AND
                                                            a.ost_basis = ''-'' AND
                                                            a.ost_gross = ''-'' AND
                                                            a.sued_ost = ''-'' AND
                                                            a.sued_west = ''-'' AND
                                                            a.west = ''-'') AND
                                                            ''` + var_region_summary + `''  = 0
                                                    GROUP BY 1
                                                    `)
                                                    }
                                                    sql = sql.concat(`
                                                    -- DUMMY-UNION Block ICS
                                                    UNION ALL
                                                    SELECT ''` + var_art_id + `'' AS art_id,
                                                        ''N'' AS status,
                                                        ''A'' as list_kz,
                                                        0 AS umsatz_,
                                                        0 AS absatz_,
                                                        0 AS rohertrag_,
                                                        0 AS anzahl_reduktion,
                                                        0 AS anzahl_erweiterung,
                                                        --COUNT(*) AS anzahl_erweiterung,
                                                        Cast(''dynamic'' AS VARCHAR(100)) AS vorschlag_
                                                        ) x) x

                    SET umsatz_hr = x.umsatz,
                        absatz_hr = x.absatz,
                        rohertrag_hr = x.rohertrag,
                        listungsaktion = CASE WHEN  ''` + var_vorschlag + `''  = ''Auslisten'' THEN ''Auslistung'' ELSE x.vorschlag END

                    WHERE (mandant_id =  ''` + mandant_id + `''  AND art_id =  ''` + ART_ID + `''  AND kjmo =  ''` + KJMO + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE + `'' ) OR (mandant_id =  ''` + mandant_id + `''  AND gtin =  ''` + GTIN + `''  AND kjmo =  ''` + KJMO + `''  AND nielsen_art_bez =  ''` + NL_ART_BEZ + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE + `'' );`);

                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();



                sql=`UPDATE dbp_data.sortiment_leistung FROM (SELECT CASE
                                                        WHEN  ''` + var_region_summary + `''  IN (1,0)
                                                        THEN
                                                        CASE
                                                            WHEN (listung_sst_mvke = ''N/A'' OR listung_sst_mvke IS NULL) AND
                                                                GREATEST(COALESCE(ost_basis,''''),COALESCE(ost_gross,''''),COALESCE(sued_ost,''''),COALESCE(sued_west,''''),COALESCE(west,''''),COALESCE(nord,'''')) = '''' AND
                                                                anz_maerkte_sst = 0 AND anz_maerkte_baustein_sonstige = 0 AND anz_maerkte_listung_einzel = 0 AND anz_maerkte_listung_gesamt = 0
                                                            THEN ''Einlistung Kauflandartikel''
                                                            ELSE listungsaktion
                                                        END
                                                        ELSE listungsaktion
                                                        END AS listungsaktion
                                                FROM dbp_data.sortiment_leistung
                                                WHERE mandant_id =  ''` + mandant_id + `''  AND 
                                                        art_id IS NOT NULL AND 
                                                        kjmo =  ''` + KJMO + `''  AND 
                                                        KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                                                        MATCHING_ID =  ''` + MATCHING_ID + `'' ) z
                                            
                    SET listungsaktion = z.listungsaktion

                    WHERE dbp_data.sortiment_leistung.mandant_id = 1 AND
                            dbp_data.sortiment_leistung.kjmo =  ''` + KJMO + `''  AND
                            dbp_data.sortiment_leistung.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                            dbp_data.sortiment_leistung.matching_id =  ''` + MATCHING_ID + `'';`;
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();

                /*
                --------------------------------------------------------------------------------------------------------
                --   (II) INSERT FUER ERWARTETE ENTWICKLUNG (mit K-Stufen)
                --------------------------------------------------------------------------------------------------------
                */ 

                
                if (!(var_vorschlag_hr in [''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen'',''Zurücksetzen'']  )){

                    sql=`DELETE FROM dbp_msi_data.erwartete_entwicklung
                        WHERE MATCHING_ID =  ''` + MATCHING_ID + `''  AND
                                kjmo =  ''` + KJMO + `''  AND
                                KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                                mandant_id =  ''` + mandant_id + `'';`;
                        sql = sql.replace(/''undefined''/g, "NULL")
                        sql_stmt = snowflake.createStatement({sqlText: sql});
                        sql_stmt.execute();

                    sql=`INSERT INTO dbp_msi_data.erwartete_entwicklung (mandant_id
                                                  ,kjmo
                                                  ,matching_id
                                                  ,sm_id
                                                  ,ksm_id
                                                  ,kjwo_update
                                                  ,wrg_id
                                                  ,kl_wg_id
                                                  ,kl_owg_id
                                                  ,kl_uwg_id
                                                  ,hwg_id
                                                  ,owg_id
                                                  ,wg_id
                                                  ,wug_id
                                                  ,ost_basis_pflege
                                                  ,ost_gross_pflege
                                                  ,sued_ost_pflege
                                                  ,sued_west_pflege
                                                  ,west_pflege
                                                  ,nord_pflege
                                                  ,umsatz_hr
                                                  ,absatz_hr
                                                  ,rohertrag_hr)
                        SELECT 1 AS mandant_id
                            , ''` + KJMO + `''  AS kjmo
                            ,x.matching_id
                            ,x.sm_id
                            ,'''' AS ksm_id
                            , ''` + KJWO_UPDATE + `''  AS KJWO_UPDATE
                            ,''EUR'' AS wrg_id
                            ,y.kl_wg_id
                            ,y.kl_owg_id
                            ,y.kl_uwg_id
                            ,0 AS hwg_id
                            ,y.kl_wg_id AS owg_id
                            ,y.kl_owg_id AS wg_id
                            ,y.kl_uwg_id AS wug_id
                            ,x.ost_basis
                            ,x.ost_gross
                            ,x.sued_ost
                            ,x.sued_west
                            ,x.west
                            ,x.nord
                            ,COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS umsatz
                            ,COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS absatz
                            ,COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS rohertrag
                        FROM (-- Nur SST gepflegt fuer Erweiterung!
                            `
                            if (sst_only == 1 || sst_reg_change in [1,4]){
                            sql = sql.concat(`
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Listung erweitern'' AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord = ''-'' AND 
                                a.ost_basis = ''-'' AND 
                                a.ost_gross = ''-'' AND 
                                a.sued_ost = ''-'' AND 
                                a.sued_west = ''-'' AND 
                                a.west = ''-'') AND
                                ( ''` + sst_only + `''  = 1 OR
                                ''` + sst_reg_change + `''  IN (1,4))
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            `)
                            }
                            if (sst_only == 1 || sst_reg_change in [2,4]){
                            sql = sql.concat(`
                            -- Nur SST gepflegt fuer Reduktion!
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_data.wup x
                            ON a.mandant_id = x.mandant_id AND
                                a.wup_id = x.wup_id
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Listung reduzieren'' AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                a.sm_id < CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord = ''-'' AND 
                                a.ost_basis = ''-'' AND 
                                a.ost_gross = ''-'' AND 
                                a.sued_ost = ''-'' AND 
                                a.sued_west = ''-'' AND 
                                a.west = ''-'') AND 
                                CASE
                                    WHEN  ''` + sst_reg_change + `''  = 4 AND
                                        (x.kreistyp_gruppe_id =  ''` + n_reg_char + `''   OR
                                        x.kreistyp_gruppe_id =  ''` + w_reg_char + `''   OR
                                        x.kreistyp_gruppe_id =  ''` + so_reg_char + `''  OR
                                        x.kreistyp_gruppe_id =  ''` + sw_reg_char + `''  OR
                                        x.kreistyp_gruppe_id =  ''` + ob_reg_char + `''  OR
                                        x.kreistyp_gruppe_id =  ''` + og_reg_char + `'' )
                                    THEN 0
                                    ELSE 1
                                END = 1 AND
                                ( ''` + sst_only + `''  = 1 OR
                                ''` + sst_reg_change + `''  IN (2,4))
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            `)
                            }
                            if(sst_reg == 1){
                            sql = sql.concat(`
                            -- SST plus Cluster fuer Erweiterung!
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_data.wup x
                            ON a.mandant_id = x.mandant_id AND
                                a.wup_id = x.wup_id
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Listung erweitern'' AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                a.sm_id_selected = 0 AND
                                a.sm_id < CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord =  ''` + var_nord_pflege + `''  OR 
                                a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                a.west =  ''` + var_west_pflege + `'' ) AND 
                                CASE
                                    WHEN  ''` + sst_reg_change + `''  = 4 AND
                                        a.sm_id >= CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                        (x.kreistyp_gruppe_id =  ''` + n_reg_char + `''   OR
                                        x.kreistyp_gruppe_id =  ''` + w_reg_char + `''   OR
                                        x.kreistyp_gruppe_id =  ''` + so_reg_char + `''  OR
                                        x.kreistyp_gruppe_id =  ''` + sw_reg_char + `''  OR
                                        x.kreistyp_gruppe_id =  ''` + ob_reg_char + `''  OR
                                        x.kreistyp_gruppe_id =  ''` + og_reg_char + `'' )
                                    THEN 0
                                    ELSE 1
                                END = 1 AND
                                ''` + sst_reg + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            `)
                            }
                            if (sst_reg == 1 && sst_reg_change != 4){
                            sql=sql.concat(`
                            -- SST plus Cluster fuer Reduktion!
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Listung reduzieren'' AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                a.sm_id_selected = 0 AND
                                a.sm_id < CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord =  ''` + var_nord_pflege + `''  OR 
                                a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + sst_reg + `''  = 1 AND
                                ''` + sst_reg_change + `''  NOT IN (4)
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            `)
                            }
                            sql=sql.concat(`
                            -- Auslistung!
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Auslistung'' AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord = ''-'' AND 
                                a.ost_basis = ''-'' AND 
                                a.ost_gross = ''-'' AND 
                                a.sued_ost = ''-'' AND 
                                a.sued_west = ''-'' AND 
                                a.west = ''-'')
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            -- Cluster fuer Nielsen!
                            `)
                            if(var_region_summary == 1){
                            sql = sql.concat(`
                            UNION ALL
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                sm_id,
                                nord,
                                ost_basis,
                                ost_gross,
                                sued_ost,
                                sued_west,
                                west,
                                1 AS art_id,
                                ''N'' AS status,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT) AS rohertrag_
                            FROM dbp_msi_data.nl_listung
                            WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis) AND
                                gtin =  ''` + GTIN + `''  AND
                                listung_art = ''Einlistung Potenzialartikel'' AND
                                KJWO_UPDATE =  ''` + var_kjwo_update + `''  AND
                                art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
                                sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (nord =  ''` + var_nord_pflege + `''  OR 
                                ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                sued_west =  ''` + var_sued_west_pflege + `''  OR
                                west =  ''` + var_west_pflege + `'' ) AND
                                ''` + var_region_summary + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9,10
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            if(var_region_summary == 0){
                            sql = sql.concat(`
                            UNION ALL
                            -- SST fuer Nielsen!
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                sm_id,
                                nord,
                                ost_basis,
                                ost_gross,
                                sued_ost,
                                sued_west,
                                west,
                                1 AS art_id,
                                ''N'' AS status,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT) AS rohertrag_
                            FROM dbp_msi_data.nl_listung
                            WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis) AND
                                gtin =  ''` + GTIN + `''  AND
                                listung_art = ''Einlistung Potenzialartikel'' AND
                                KJWO_UPDATE =  ''` + var_kjwo_update + `''  AND
                                art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
                                sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (nord = ''-'' AND
                                ost_basis = ''-'' AND
                                ost_gross = ''-'' AND
                                sued_ost = ''-'' AND
                                sued_west = ''-'' AND
                                west = ''-'') AND
                                ''` + var_region_summary + `''  = 0
                            GROUP BY 1,2,3,4,5,6,7,8,9,10
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            if(var_region_summary == 1){
                            sql = sql.concat(`
                            UNION ALL
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                b.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_
                            FROM dbp_msi_data.nl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON 1 = b.mandant_id AND
                                ''` + GTIN + `''  = b.gtin_id AND
                                a.kjwo_update = b.kjwo_update
                            JOIN dbp_etl.bf_sort_sal_export c
                            ON b.art_id/100 = CAST(c.art_nr AS INT)
                            WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) FROM dbp_etl.not_listed_basis WHERE CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) =  ''` + GTIN + `'' ) AND
                                a.listung_art = ''Listung erweitern'' AND
                                a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord =  ''` + var_nord_pflege + `''  OR 
                                a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + var_region_summary + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            if (var_region_summary == 0 ){
                            sql = sql.concat(`
                            UNION ALL
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                b.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_
                            FROM dbp_msi_data.nl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON 1 = b.mandant_id AND
                                ''` + GTIN + `''  = b.gtin_id AND
                                a.kjwo_update = b.kjwo_update
                            JOIN dbp_etl.bf_sort_sal_export c
                            ON b.art_id/100 = CAST(c.art_nr AS INT)
                            WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis WHERE CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) =  ''` + GTIN + `'' ) AND
                                a.listung_art = ''Listung erweitern'' AND
                                a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  AS INT) AND
                                (a.nord = ''-'' AND
                                a.ost_basis = ''-'' AND
                                a.ost_gross = ''-'' AND
                                a.sued_ost = ''-'' AND
                                a.sued_west = ''-'' AND
                                a.west = ''-'') AND
                                ''` + var_region_summary + `''  = 0
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            sql = sql.concat(`
                            ) x
                        JOIN (SELECT art_matching_id,
                                MAX(kl_wg_id) AS kl_wg_id,
                                MAX(kl_owg_id) AS kl_owg_id,
                                MAX(kl_uwg_id) AS kl_uwg_id
                            FROM dbp_etl.art_matching_nielsen_per
                            GROUP BY 1) y
                        ON x.matching_id = y.art_matching_id
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20;`);
                        sql = sql.replace(/''undefined''/g, "NULL")
                        sql_stmt = snowflake.createStatement({sqlText: sql});
                        sql_stmt.execute();
                } /* end if */

                sql = `DELETE FROM dbp_msi_data.sortiment_art
                    WHERE (mandant_id,art_id,gtin_id,kjwo_update) IN (SELECT a.mandant_id,
                                                               a.art_id,
                                                               MAX(CAST(CAST(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
                                                                ''` + KJWO_UPDATE + `''  AS KJWO_UPDATE
                                                        FROM dbp_etl.art_matching_nielsen_per a
                                                        WHERE a.art_matching_id =  ''` + MATCHING_ID + `'' 
                                                        GROUP BY 1,2);`;
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();


      
                /*else if ((var_listung_sst_pflege == "" || var_listung_sst_pflege == " " || var_listung_sst_pflege == undefined) && (var_vorschlag_hr != ''Keine Veränderung setzen'' && var_vorschlag_hr != ''Zurücksetzen'' && var_vorschlag_hr != ''Produktwissen'' && var_vorschlag_hr != ''Keine Veränderung'')) {*/
            }
            else if ((var_listung_sst_pflege == "" || var_listung_sst_pflege == " " || var_listung_sst_pflege == undefined) && !(var_vorschlag_hr in [''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen'',''Keine Veränderung''])) {
            
                sql=`INSERT INTO dbp_msi_data.sortiment_art (mandant_id,
                                            art_id,
                                            gtin_id,
                                            status,
                                            KJWO_UPDATE)
                    SELECT a.mandant_id,
                        a.art_id,
                        MAX(CAST(CAST(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
                        MAX(status) AS status,
                        ''` + KJWO_UPDATE + `''  AS KJWO_UPDATE
                    FROM dbp_etl.art_matching_nielsen_per a
                    WHERE a.art_matching_id =  ''` + MATCHING_ID + `''  AND
                            CASE
                            WHEN a.status <> ''N'' AND
                                a.list_kz = ''A''
                            THEN 1
                            WHEN a.status = ''N''
                            THEN 1
                            ELSE 0
                            END = 1
                    GROUP BY 1,2;`;
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();

                /*
                --------------------------------------------------------------------------------------------------------
                --   (III) UPDATE FUER SORTIMENT_LEISTUNG (nur Regionen)
                --------------------------------------------------------------------------------------------------------
                */
                sql = `UPDATE dbp_data.sortiment_leistung 
                        FROM (
                            SELECT 
                                SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
                                SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
                                replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA'', ''dynamic'')AS vorschlag__, 
                        CASE
                            WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
                            WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
                            WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
                            WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN ''Listung reduzieren und erweitern''
                            WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN ''Listung erweitern und reduzieren''
                            WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
                            ELSE ''SOLL-Listung = IST-Listung''
                        END AS vorschlag,
                        CASE
                                    WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                    THEN 0
                                    ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                    END AS umsatz,
                                CASE
                                    WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                    THEN 0
                                    ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                END AS absatz,
                                CASE
                                    WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                    THEN 0
                                    ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                END AS rohertrag
                    FROM (-- KL nur Regionen; Erweiterung!!!
                        `
                        /*if(region_only == 1){ NOTE: diese Bedingung kann auch mit rein, aber wenn die parameter ungünsting sind kann es sein dass wir einen syntax fehler durch die UNION ALL kriegen. Deshalb bleibt dieser teil fürs erste drin - wenn mehr Zeit ist kann eine Bedingung für das UNION ALL implementiert werden*/
                        sql = sql.concat(`
                        SELECT a.art_id,
                                MAX(b.status) AS status,
                                MIN(a.list_kz) AS list_kz_,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_,
                                CAST(0 AS INT) AS anzahl_reduktion,
                                SUM(erweiterung_fg) AS anzahl_erweiterung,
                                CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END AS vorschlag_
                        FROM dbp_msi_data.kl_listung a
                        JOIN dbp_msi_data.sortiment_art b
                        ON a.mandant_id = b.mandant_id AND
                            a.art_id = b.art_id AND
                            a.kjwo_update = b.kjwo_update
                        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                            a.listung_art = ''Listung erweitern'' AND
                            a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                            a.sm_id_selected = 0 AND
                            (a.nord =  ''` + var_nord_pflege + `''  OR 
                            a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                            a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                            a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                            a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                            a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + region_only + `''  = 1
                        GROUP BY 1

                        `)
                        /* } */
                        if(region_only == 1){
                        sql = sql.concat(`
                        UNION ALL
                        -- KL nur Regionen; Reduktion!!!
                        SELECT a.art_id,
                                MAX(b.status) AS status,
                                MIN(a.list_kz) AS list_kz_,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_,
                                SUM(reduktion_fg) AS anzahl_reduktion,
                                CAST(0 AS INT) AS anzahl_erweiterung,
                                ''dynamic'' AS vorschlag_
                        FROM dbp_msi_data.kl_listung a
                        JOIN dbp_msi_data.sortiment_art b
                        ON a.mandant_id = b.mandant_id AND
                            a.art_id = b.art_id AND
                            a.kjwo_update = b.kjwo_update
                        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                            a.listung_art = ''Listung reduzieren'' AND
                            a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                            a.sm_id_selected = 0 AND
                            (a.nord =  ''` + var_nord_pflege + `''  OR 
                            a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                            a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                            a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                            a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                            a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + region_only + `''  = 1
                        GROUP BY 1
                        
                        `)
                        }
                        if (var_region_summary == 1){
                        sql = sql.concat(`
                        --Nur Regionen fuer Nielsen (1)
                        UNION ALL
                        SELECT 1 AS art_id,
                                ''N'' AS status,
                                MAX(''A'') AS list_kz,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT) AS rohertrag_,
                                CAST(0 AS INT) AS anzahl_reduktion,
                                COUNT(*) AS anzahl_erweiterung,
                                ''Einlistung Potenzialartikel'' AS vorschlag_
                        FROM dbp_msi_data.nl_listung
                        WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis) AND
                            gtin =  ''` + GTIN + `''  AND
                            listung_art = ''Einlistung Potenzialartikel'' AND
                            KJWO_UPDATE =  ''` + var_kjwo_update + `''  AND
                            art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
                            sm_id_selected = 0 AND
                            (nord =  ''` + var_nord_pflege + `''  OR 
                            ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                            ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                            sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                            sued_west =  ''` + var_sued_west_pflege + `''  OR
                            west =  ''` + var_west_pflege + `'' ) AND
                                ''` + var_region_summary + `''  = 1
                        GROUP BY 1,2
                        
                        `)
                        }
                        if(var_region_summary == 1){
                        sql = sql.concat(`
                        UNION ALL
                        SELECT b.art_id,
                                MAX(b.status) AS status,
                                MAX(''A'') AS list_kz,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_,
                                CAST(0 AS INT) AS anzahl_reduktion,
                                COUNT(*) AS anzahl_erweiterung,
                                ''Einlistung Kauflandartikel'' AS vorschlag_
                        FROM dbp_msi_data.nl_listung a
                        JOIN dbp_msi_data.sortiment_art b
                        ON 1 = b.mandant_id AND
                            ''` + GTIN + `''  = b.gtin_id AND
                            a.kjwo_update = b.kjwo_update
                        LEFT JOIN dbp_etl.bf_sort_sal_export c
                        ON b.art_id/100 = CAST(c.art_nr AS INT)
                        WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis WHERE CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) =  ''` + GTIN + `'' ) AND
                            a.listung_art = ''Listung erweitern'' AND
                            a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                            a.sm_id_selected = 0 AND
                            (a.nord =  ''` + var_nord_pflege + `''  OR 
                            a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                            a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                            a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                            a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                            a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + var_region_summary + `''  = 1
                        GROUP BY 1
                        `)
                        }
                        sql = sql.concat(`
                        ) x) x

                    SET umsatz_hr = x.umsatz,
                        absatz_hr = x.absatz,
                        rohertrag_hr = x.rohertrag,
                        listungsaktion = CASE WHEN  ''` + var_vorschlag + `''  = ''Auslisten'' THEN ''Auslistung'' ELSE x.vorschlag END

                    WHERE (art_id =  ''` + ART_ID + `''  AND kjmo =  ''` + KJMO + `''  AND mandant_id =  ''` + mandant_id + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE + `'' ) OR (gtin =  ''` + GTIN + `''  AND kjmo =  ''` + KJMO + `''  AND nielsen_art_bez =  ''` + NL_ART_BEZ + `''  AND mandant_id =  ''` + mandant_id + `''  AND KJWO_UPDATE =  ''` + KJWO_UPDATE + `'' );`);
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();
                
                sql = `UPDATE dbp_data.sortiment_leistung FROM (SELECT CASE
                    WHEN  ''` + region_only + `''  = 1
                    THEN
                    CASE
                        WHEN (listung_sst_mvke = ''N/A'' OR listung_sst_mvke IS NULL) AND
                            GREATEST(COALESCE(ost_basis,''''),COALESCE(ost_gross,''''),COALESCE(sued_ost,''''),COALESCE(sued_west,''''),COALESCE(west,''''),COALESCE(nord,'''')) = '''' AND
                            anz_maerkte_sst = 0 AND anz_maerkte_baustein_sonstige = 0 AND anz_maerkte_listung_einzel = 0 AND anz_maerkte_listung_gesamt = 0
                        THEN ''Einlistung Kauflandartikel''
                        ELSE listungsaktion
                    END
                    ELSE listungsaktion
                    END AS listungsaktion
                    FROM dbp_data.sortiment_leistung
                    WHERE mandant_id =  ''` + mandant_id + `''  AND 
                        art_id IS NOT NULL AND 
                        kjmo =  ''` + KJMO + `''  AND 
                        KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                        MATCHING_ID =  ''` + MATCHING_ID + `'' ) z
                                            
                    SET listungsaktion = z.listungsaktion

                    WHERE dbp_data.sortiment_leistung.mandant_id = 1 AND
                        dbp_data.sortiment_leistung.kjmo =  ''` + KJMO + `''  AND
                        dbp_data.sortiment_leistung.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                        dbp_data.sortiment_leistung.matching_id =  ''` + MATCHING_ID + `'';`;
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();     
                    
                /*     
                --------------------------------------------------------------------------------------------------------
                --   (IV) INSERT FUER ERWARTETE ENTWICKLUNG (nur Regionen)
                --------------------------------------------------------------------------------------------------------
                */

                if (!(var_vorschlag_hr in [''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen'',''Zurücksetzen''])){
                
                    sql = `DELETE FROM dbp_msi_data.erwartete_entwicklung
                        WHERE MATCHING_ID =  ''` + MATCHING_ID + `''  AND
                            kjmo =  ''` + KJMO + `''  AND
                            KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                            mandant_id =  ''` + mandant_id + `'';`;
                        sql = sql.replace(/''undefined''/g, "NULL")
                        sql_stmt = snowflake.createStatement({sqlText: sql});
                        sql_stmt.execute();     

                    sql = `INSERT INTO dbp_msi_data.erwartete_entwicklung (mandant_id
                                                ,kjmo
                                                ,matching_id
                                                ,sm_id
                                                ,ksm_id
                                                ,kjwo_update
                                                ,wrg_id
                                                ,kl_wg_id
                                                ,kl_owg_id
                                                ,kl_uwg_id
                                                ,hwg_id
                                                ,owg_id
                                                ,wg_id
                                                ,wug_id
                                                ,ost_basis_pflege
                                                ,ost_gross_pflege
                                                ,sued_ost_pflege
                                                ,sued_west_pflege
                                                ,west_pflege
                                                ,nord_pflege
                                                ,umsatz_hr
                                                ,absatz_hr
                                                ,rohertrag_hr)
                        SELECT 1 AS mandant_id
                            , ''` + KJMO + `''  AS kjmo
                            ,x.matching_id
                            ,x.sm_id
                            ,'''' AS ksm_id
                            , ''` + KJWO_UPDATE + `''  AS KJWO_UPDATE
                            ,''EUR'' AS wrg_id
                            ,y.kl_wg_id
                            ,y.kl_owg_id
                            ,y.kl_uwg_id
                            ,0 AS hwg_id
                            ,y.kl_wg_id AS owg_id
                            ,y.kl_owg_id AS wg_id
                            ,y.kl_uwg_id AS wug_id
                            ,x.ost_basis
                            ,x.ost_gross
                            ,x.sued_ost
                            ,x.sued_west
                            ,x.west
                            ,x.nord
                            ,COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS umsatz
                            ,COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS absatz
                            ,COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status) = ''G'' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS rohertrag
                        FROM (-- KL nur Regionen; Erweiterung!!!
                            `
                            /*auch hier: die erste abfrage kann auch noch in eine if bedingung gepackt werden; kann zu problemen mit dem UNION ALL führen, deshalb optional für später*/
                            sql = sql.concat(`
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Listung erweitern'' AND
                                a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                                a.sm_id_selected = 0 AND
                                (a.nord =  ''` + var_nord_pflege + `''  OR 
                                a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + region_only + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            if (region_only == 1){
                            sql = sql.concat(`
                            UNION ALL
                            -- KL nur Regionen; Reduktion!!!
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                a.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM dbp_msi_data.kl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis) AND
                                a.listung_art = ''Listung reduzieren'' AND
                                a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                                a.sm_id_selected = 0 AND
                                (a.nord =  ''` + var_nord_pflege + `''  OR 
                                a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + region_only + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            if(var_region_summary == 1){
                            sql = sql.concat(`
                            UNION ALL
                            --Nur Regionen fuer Nielsen (1)
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                sm_id,
                                nord,
                                ost_basis,
                                ost_gross,
                                sued_ost,
                                sued_west,
                                west,
                                1 AS art_id,
                                ''N'' AS status,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT) AS rohertrag_
                            FROM dbp_msi_data.nl_listung
                            WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis) AND
                                gtin =  ''` + GTIN + `''  AND
                                listung_art = ''Einlistung Potenzialartikel'' AND
                                KJWO_UPDATE =  ''` + var_kjwo_update + `''  AND
                                art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
                                sm_id_selected = 0 AND
                                (nord =  ''` + var_nord_pflege + `''  OR 
                                ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                sued_west =  ''` + var_sued_west_pflege + `''  OR
                                west =  ''` + var_west_pflege + `'' ) AND
                                ''` + var_region_summary + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            if (var_region_summary == 1){
                            sql = sql.concat(`
                            UNION ALL
                            SELECT  ''` + MATCHING_ID + `''  AS MATCHING_ID,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost, 
                                a.sued_west,
                                a.west,
                                b.art_id,
                                MAX(b.status) AS status,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(Replace( ''` + var_stk_re_pflege + `'','','',''.'' ) AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_
                            FROM dbp_msi_data.nl_listung a
                            JOIN dbp_msi_data.sortiment_art b
                            ON 1 = b.mandant_id AND
                                ''` + GTIN + `''  = b.gtin_id AND
                                a.kjwo_update = b.kjwo_update
                            LEFT JOIN dbp_etl.bf_sort_sal_export c
                            ON b.art_id/100 = CAST(c.art_nr AS INT)
                            WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis WHERE CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(100)) =  ''` + GTIN + `'' ) AND
                                a.listung_art = ''Listung erweitern'' AND
                                a.kjwo_update =  ''` + var_kjwo_update + `''  AND
                                a.sm_id_selected = 0 AND
                                (a.nord =  ''` + var_nord_pflege + `''  OR 
                                a.ost_basis =  ''` + var_ost_basis_pflege + `''  OR
                                a.ost_gross =  ''` + var_ost_gross_pflege + `''  OR
                                a.sued_ost =  ''` + var_sued_ost_pflege + `''  OR
                                a.sued_west =  ''` + var_sued_west_pflege + `''  OR
                                a.west =  ''` + var_west_pflege + `'' ) AND
                                ''` + var_region_summary + `''  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            `)
                            }
                            sql = sql.concat(`
                            ) x
                        JOIN (SELECT art_matching_id,
                                MAX(kl_wg_id) AS kl_wg_id,
                                MAX(kl_owg_id) AS kl_owg_id,
                                MAX(kl_uwg_id) AS kl_uwg_id
                            FROM dbp_etl.art_matching_nielsen_per
                            GROUP BY 1) y
                        ON x.matching_id = y.art_matching_id
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20;`);
                        sql = sql.replace(/''undefined''/g, "NULL")
                        sql_stmt = snowflake.createStatement({sqlText: sql});
                        sql_stmt.execute();    
                } /* end if */


                sql = `DELETE FROM dbp_msi_data.sortiment_art
                    WHERE (mandant_id,art_id,gtin_id,kjwo_update) IN (SELECT a.mandant_id,
                                                                    a.art_id,
                                                                    MAX(CAST(CAST(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
                                                                        ''` + KJWO_UPDATE + `''  AS KJWO_UPDATE
                                                                FROM dbp_etl.art_matching_nielsen_per a
                                                                WHERE a.art_matching_id =  ''` + MATCHING_ID + `'' 
                                                                GROUP BY 1,2);`;
                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();    
                
            }/* end if */
        }/* end if */

        if (var_vorschlag == ''Zurücksetzen''){

            sql = `DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
                WHERE kjmo =  ''` + KJMO + `''  AND 
                        KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                        art_matching_id =  ''` + MATCHING_ID + `''  AND
                        mandant_id = 1;`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute(); 

            sql = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu
                SELECT *
                FROM dbp_data.art_kl_preislage_zu_per
                WHERE kjmo =  ''` + KJMO + `''  AND 
                        KJWO_UPDATE =  ''` + KJWO_UPDATE + `''  AND
                        art_matching_id =  ''` + MATCHING_ID + `''  AND
                        mandant_id = 1;`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute(); 
        }

        else {
                sql = `SELECT COUNT(*)
                        FROM dbp_data.sortiment_leistung a
                        INNER JOIN dbp_data.art_kl_preislage_zu_per_neu c
                          ON a.mandant_id = c.mandant_id AND
                             a.kjmo = c.kjmo AND
                             a.matching_id = c.art_matching_id AND
                             a.listung_sst_mvke = c.sm_id AND
                             a.kjwo_update = c.kjwo_update
                        WHERE a.kjmo = ''` + KJMO + `''  AND
                              a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                              a.umsatz_hr IS NOT NULL AND
                              a.listung_sst_pflege NOT IN (''N/A'') AND
                              a.listungsaktion IN (''Listung erweitern'',''Einlistung Kauflandartikel'',''Listung reduzieren und erweitern'',''Listung erweitern und reduzieren'') AND 
                                (a.mandant_id,a.matching_id,a.kjmo,a.kjwo_update) NOT IN (SELECT mandant_id,art_matching_id,kjmo,kjwo_update  
                                                                                           FROM dbp_data.art_kl_preislage_zu_per_neu 
                                                                                           WHERE sm_id NOT IN (''N/A'',''-1''))`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_u = res.getColumnValue(1)

        if (row_count_u > 0){ 
            sql= `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
                                                    ,art_matching_id
                                                    ,kjmo
                                                    ,kjwo_update
                                                    ,wrg_id
                                                    ,sm_id
                                                    ,ksm_id
                                                    ,owg_id
                                                    ,wg_id
                                                    ,wug_id
                                                    ,vk_brutto_pk_1
                                                    ,durchschnitt_preis_kasse
                                                    ,umsatz_brutto
                                                    ,umsatz_brutto_af
                                                    ,umsatz_brutto_sa
                                                    ,menge
                                                    ,menge_af
                                                    ,menge_sa)
                SELECT 1 AS mandant_id,
                    a.matching_id AS art_matching_id,
                    a.kjmo,
                    a.kjwo_update,
                    ''EUR'' AS wrg_id,
                    TRIM(CAST(b.k AS VARCHAR(10))) AS sm_id,
                    '''' AS ksm_id,
                    a.owg_id,
                    a.wg_id,
                    a.wug_id,
                    a.vk_preis AS vk_brutto_pk_1,
                    a.durchschnittspreis AS durchschnitt_preis_kasse,
                    c.umsatz_brutto,
                    c.umsatz_brutto_af,
                    c.umsatz_brutto_sa,
                    c.menge,
                    c.menge_af,
                    c.menge_sa
                FROM dbp_data.sortiment_leistung a
                JOIN dbp_data.art_kl_preislage_zu_per_neu c
                ON a.mandant_id = c.mandant_id AND 
                    a.kjmo = c.kjmo AND 
                    a.matching_id = c.art_matching_id AND 
                    a.listung_sst_mvke = c.sm_id AND
                    a.kjwo_update = c.kjwo_update
                JOIN (SELECT wtag_id AS k
                    FROM dbp_data.tag
                     WHERE wtag_id BETWEEN 1 AND 5
                     GROUP BY 1) b
                ON CAST(a.listung_sst_pflege AS INT) <= b.k AND 
                    b.k < CASE WHEN a.listung_sst_mvke = ''N/A'' THEN 6 ELSE CAST(a.listung_sst_mvke AS INT) END
                WHERE a.kjmo =  ''` + KJMO + `''  AND
                    a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                    a.umsatz_hr IS NOT NULL AND
                    a.listung_sst_pflege NOT IN (''N/A'') AND
                    a.listungsaktion IN (''Listung erweitern'',''Einlistung Kauflandartikel'',''Listung reduzieren und erweitern'',''Listung erweitern und reduzieren'') AND 
                    (a.mandant_id,a.matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT                mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT),kjwo_update 
                FROM dbp_data.art_kl_preislage_zu_per_neu
                WHERE sm_id NOT IN (''N/A'',''-1''));`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute(); 
        }

                sql=`DELETE FROM   dbp_data.art_kl_preislage_zu_per_neu
                    WHERE (mandant_id,art_matching_id,kjmo,sm_id,kjwo_update) IN (SELECT a.mandant_id,a.matching_id,a.kjmo,CAST(b.k AS VARCHAR(10)),a.kjwo_update
                        FROM dbp_data.sortiment_leistung a
                        JOIN (SELECT wtag_id AS k
                                FROM dbp_data.tag
                                WHERE wtag_id BETWEEN 1 AND 5
                                GROUP BY 1) b
                            ON CAST(NULLIF(TRIM(a.listung_sst_pflege),'''') AS INT) > b.k AND
                            b.k <= CASE WHEN a.listung_sst_mvke = ''N/A'' THEN 6 ELSE CAST(a.listung_sst_mvke AS INT) END
                        WHERE a.kjmo =  ''` + KJMO + `''  AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                                a.umsatz_hr IS NOT NULL AND
                                a.listung_sst_pflege NOT IN (''N/A'') AND
                                a.listungsaktion IN (''Listung reduzieren'',''Listung reduzieren und erweitern'',''Listung erweitern und reduzieren''));`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute(); 

        // Check if SQL needs to be executed
             sql = `SELECT COUNT(*)
                        FROM dbp_data.sortiment_leistung a
                        INNER JOIN dbp_data.art_nielsen_preislage_zu_per c
                          ON a.mandant_id = c.mandant_id AND
                             a.kjmo = c.kjmo AND
                             a.matching_id = c.art_matching_id AND
                             a.kjwo_update =  ''` + KJWO_UPDATE + `'' 
                        WHERE a.kjmo = ''` + KJMO + `''  AND
                              a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                              a.umsatz_hr IS NOT NULL AND
                              a.listung_sst_pflege NOT IN (''N/A'') AND
                              a.listungsaktion IN (''Einlistung Potenzialartikel'',''Einlistung Kauflandartikel'') AND 
                                (a.mandant_id,a.matching_id,a.kjmo,a.kjwo_update) NOT IN (SELECT mandant_id,art_matching_id,kjmo,kjwo_update  
                                                                                           FROM dbp_data.art_kl_preislage_zu_per_neu 
                                                                                           WHERE sm_id NOT IN (''N/A'',''-1''))`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_v = res.getColumnValue(1)

        if (row_count_v > 0){ 
            sql=`INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
                                                ,art_matching_id
                                                ,kjmo
                                                ,kjwo_update
                                                ,wrg_id
                                                ,sm_id
                                                ,ksm_id
                                                ,owg_id
                                                ,wg_id
                                                ,wug_id
                                                ,vk_brutto_pk_1
                                                ,durchschnitt_preis_kasse
                                                ,umsatz_brutto
                                                ,umsatz_brutto_af
                                                ,umsatz_brutto_sa
                                                ,menge
                                                ,menge_af
                                                ,menge_sa)
                SELECT 1 AS mandant_id,
                    a.matching_id AS art_matching_id,
                    a.kjmo,
                    a.kjwo_update,
                    ''EUR'' AS wrg_id,
                    TRIM(CAST(b.k AS VARCHAR(10))) AS sm_id,
                    '''' AS ksm_id,
                    a.owg_id,
                    a.wg_id,
                    a.wug_id,
                                    a.durchschnitt_preis AS vk_brutto_pk_1,
                                    a.durchschnitt_preis AS durchschnitt_preis_kasse,
                    c.umsatz_brutto,
                    c.umsatz_brutto_af,
                    c.umsatz_brutto_sa,
                    c.menge,
                    c.menge_af,
                    c.menge_sa
                FROM dbp_data.sortiment_leistung a
                JOIN dbp_data.art_nielsen_preislage_zu_per c
                ON a.mandant_id = c.mandant_id AND
                    a.kjmo = c.kjmo AND
                                a.matching_id = c.art_matching_id AND
                                a.kjwo_update =  ''` + KJWO_UPDATE + `'' 
                JOIN (SELECT wtag_id AS k
                    FROM dbp_data.tag
                                            WHERE wtag_id BETWEEN 1 AND 5
                                            GROUP BY 1) b
                ON CAST(NULLIF(TRIM(a.listung_sst_pflege),'''') AS INT) <= b.k
                WHERE a.kjmo =  ''` + KJMO + `''  AND
                    a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                    a.umsatz_hr IS NOT NULL AND 
                    a.listung_sst_pflege NOT IN (''N/A'') AND 
                    a.listungsaktion IN (''Einlistung Potenzialartikel'',''Einlistung Kauflandartikel'') AND 
                    (a.mandant_id,a.matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT                mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT),kjwo_update 
                        FROM dbp_data.art_kl_preislage_zu_per_neu
                        WHERE sm_id NOT IN (''N/A'',''-1''));`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute(); 
            }

            sql = `DELETE FROM   dbp_data.art_kl_preislage_zu_per_neu
                WHERE (mandant_id, art_matching_id, kjmo, KJWO_UPDATE) IN (SELECT a.mandant_id, a.matching_id, a.kjmo, a.kjwo_update
                    FROM dbp_data.sortiment_leistung a
                    WHERE a.kjmo =  ''` + KJMO + `''  AND 
                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
                            a.umsatz_hr IS NOT NULL AND 
                            a.listungsaktion = ''Auslistung'');`;
                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute(); 



        }/*END IF; --Zuruecksetzen bei Preislage*/

    }/*END IF; --GTIN (-9999)*/

}/*END IF; --keine Pflege*/

    /*  -- END IF; --"Keine Veränderung setzen" ueber Batch!*/

';