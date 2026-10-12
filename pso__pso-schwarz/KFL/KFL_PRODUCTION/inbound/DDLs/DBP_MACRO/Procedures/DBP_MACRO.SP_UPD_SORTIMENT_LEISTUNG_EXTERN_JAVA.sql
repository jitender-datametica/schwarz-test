CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_EXTERN_JAVA(MATCHING_ID VARCHAR, ART_ID VARCHAR, GTIN VARCHAR, STK_RE_PFLEGE VARCHAR, VORSCHLAG VARCHAR, PRODUKTWISSEN_PFLEGE VARCHAR, LIEFERANTENWISSEN_PFLEGE VARCHAR, LISTUNG_SST_PFLEGE VARCHAR, OST_BASIS_PFLEGE VARCHAR, OST_GROSS_PFLEGE VARCHAR, SUED_OST_PFLEGE VARCHAR, SUED_WEST_PFLEGE VARCHAR, WEST_PFLEGE VARCHAR, NORD_PFLEGE VARCHAR, KJMO VARCHAR, N_K_ARTIKEL VARCHAR, NL_ART_BEZ VARCHAR, KJWO_UPDATE VARCHAR)
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
            WHEN A39_listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') IS NOT NULL AND TRIM(''` + var_listung_sst_pflege + `'') <> '''') AND
                CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') AS INT) < CAST(A39_listung_sst_mvke AS INT)
            THEN 1
            WHEN A39_listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') IS NOT NULL AND TRIM(''` + var_listung_sst_pflege + `'') <> '''') AND
                CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') AS INT) > CAST(A39_listung_sst_mvke AS INT)
            THEN 2
            WHEN A39_listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  IS NOT NULL AND  TRIM(''` + var_listung_sst_pflege + `'')  <> '''') AND
                CAST(NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''') AS INT) = CAST(A39_listung_sst_mvke AS INT)
            THEN 3
            WHEN A39_listung_sst_mvke = ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  IS NOT NULL AND  TRIM(''` + var_listung_sst_pflege + `'')  <> '''')
            THEN 4
            WHEN A39_listung_sst_mvke <> ''N/A'' AND
                (NULLIF(TRIM(''` + var_listung_sst_pflege + `''),'''')  IS NULL OR  TRIM(''` + var_listung_sst_pflege + `'')  = '''')
            THEN 5
            ELSE 0
            END
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
                MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
                A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_sst_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(A44_west,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_w_tool_fg = result.getColumnValue(1);



sql = ` SELECT CASE
            WHEN COALESCE(A45_nord,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_n_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(A40_ost_basis,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_ob_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(A41_ost_gross,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_og_tool_fg = result.getColumnValue(1);


sql = ` SELECT CASE
            WHEN COALESCE(A42_sued_ost,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

    sql = sql.replace(/''undefined''/g, "NULL")
    sql_stmt = snowflake.createStatement({sqlText: sql});
    result = sql_stmt.execute(); 
    result.next();
    var_so_tool_fg = result.getColumnValue(1);



sql = ` SELECT CASE
            WHEN COALESCE(A43_sued_west,'''') = ''X''
            THEN 1
            ELSE 0
            END 
        FROM dbp_data.tupel_mat 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  ''` + MATCHING_ID + `''  AND 
            A500_kjwo_update =  ''` + KJWO_UPDATE + `'';`;

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


if ((var_region_summary == 0 && (var_listung_sst_pflege == undefined || var_listung_sst_pflege == '''') && 
    (var_produktwissen_pflege == undefined || var_produktwissen_pflege == '''') &&
    (var_lieferantenwissen_pflege == undefined || var_lieferantenwissen_pflege == '''') &&
    (var_vorschlag = '''' || var_vorschlag == undefined))) {
        
        var_nl_art_bez = NL_ART_BEZ
}
else{
    if (var_gtin == undefined || (var_gtin != undefined && (''-9999'',''-9998'').includes(var_gtin) == false)) {
        
        if (var_vorschlag == ''Zurücksetzen'') {
            sql=`UPDATE dbp_data.tupel_mat
            SET A411_stk_rohertrag_pflege = NULL
            ,A50_listungsaktion = NULL
            ,A51_listung_sst_pflege = NULL
            ,A426_ost_basis_pflege = '' ''
            ,A427_ost_gross_pflege = '' ''
            ,A428_sued_ost_pflege = '' ''
            ,A429_sued_west_pflege = '' ''
            ,A430_west_pflege = '' ''
            ,A431_nord_pflege = '' ''
            ,A412_umsatz_brutto_hochrechnung = NULL
            ,A413_absatz_hochrechnung = NULL
            ,A414_rohertrag_hochrechnung = NULL
            WHERE matching_id = ''` + MATCHING_ID + `'' AND A425_kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND A500_kjwo_update = ''` +  KJWO_UPDATE + `'';`;

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

        	sql=`UPDATE dbp_data.tupel_mat
        		SET  A50_listungsaktion = ''Keine Veränderung''
        		,A51_listung_sst_pflege = NULL
        		,A426_ost_basis_pflege = '' ''
        		,A427_ost_gross_pflege = '' ''
        		,A428_sued_ost_pflege = '' ''
        		,A429_sued_west_pflege = '' ''
        		,A430_west_pflege = '' ''
        		,A431_nord_pflege = '' ''
        		,A412_umsatz_brutto_hochrechnung = NULL
        		,A413_absatz_hochrechnung = NULL
        		,A414_rohertrag_hochrechnung = NULL
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND A425_kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND A500_kjwo_update = ''` +  KJWO_UPDATE + `'' AND (A50_listungsaktion IS NULL OR A50_listungsaktion = '''');`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
            
        }
            
        else if (var_vorschlag == ''Keine Veränderung'') {
        	sql = `UPDATE dbp_data.tupel_mat
        		SET  A50_listungsaktion = ''Keine Veränderung''
        		,A51_listung_sst_pflege = NULL
        		,A426_ost_basis_pflege = '' ''
        		,A427_ost_gross_pflege = '' ''
        		,A428_sued_ost_pflege = '' ''
        		,A429_sued_west_pflege = '' ''
        		,A430_west_pflege = '' ''
        		,A431_nord_pflege = '' ''
        		,A412_umsatz_brutto_hochrechnung = NULL
        		,A413_absatz_hochrechnung = NULL
        		,A414_rohertrag_hochrechnung = NULL
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND A425_kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND A500_kjwo_update = ''` +  KJWO_UPDATE + `'';`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
            
        }

        else if (var_vorschlag == ''Keine Veränderung zurücksetzen'') {
        	sql= `UPDATE dbp_data.tupel_mat
        		SET  A50_listungsaktion = NULL
                WHERE matching_id = ''` +  MATCHING_ID + `'' AND A425_kjmo = ''` +  KJMO + `'' AND A50_listungsaktion = ''Keine Veränderung'' AND mandant_id = ''` +  mandant_id + `'' AND A500_kjwo_update = ''` +  KJWO_UPDATE + `'';`;

                sql = sql.replace(/''undefined''/g, "NULL")
                sql_stmt = snowflake.createStatement({sqlText: sql});
                sql_stmt.execute();
            
        }   

        else{      
          
            sql =`UPDATE dbp_data.tupel_mat
	            	SET  A411_stk_rohertrag_pflege = ''` +  STK_RE_PFLEGE + `''
	            	,A50_listungsaktion = ''` +  VORSCHLAG + `''
	            	,A51_listung_sst_pflege = Coalesce(Trim(''` +  LISTUNG_SST_PFLEGE + `''),''N/A'')
	            	,A426_ost_basis_pflege = Trim(Decode(''` +  OST_BASIS_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,A427_ost_gross_pflege = Trim(Decode(''` +  OST_GROSS_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,A428_sued_ost_pflege = Trim(Decode(''` +  SUED_OST_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,A429_sued_west_pflege = Trim(Decode(''` +  SUED_WEST_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,A430_west_pflege = Trim(Decode(''` +  WEST_PFLEGE + `'',0, '' '', 1, ''X''))
	            	,A431_nord_pflege = Trim(Decode(''` +  NORD_PFLEGE + `'',0, '' '', 1, ''X''))
                    WHERE matching_id = ''` +  MATCHING_ID + `'' AND A425_kjmo = ''` +  KJMO + `'' AND mandant_id = ''` +  mandant_id + `'' AND A500_kjwo_update = ''` +  KJWO_UPDATE + `'';`;
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
                sql=`UPDATE dbp_data.tupel_mat FROM (
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
                        listungsaktion = CASE
                                           WHEN (dbp_data.tupel_mat.A39_listung_sst_mvke = ''N/A'' OR dbp_data.tupel_mat.A39_listung_sst_mvke IS NULL) AND
                                                GREATEST(COALESCE(dbp_data.tupel_mat.A40_ost_basis,''''),
                                                         COALESCE(dbp_data.tupel_mat.A41_ost_gross,''''),
                                                         COALESCE(dbp_data.tupel_mat.A42_sued_ost ,''''),
                                                         COALESCE(dbp_data.tupel_mat.A43_sued_west,''''),
                                                         COALESCE(dbp_data.tupel_mat.A44_west     ,''''),
                                                         COALESCE(dbp_data.tupel_mat.A45_nord     ,'''')) = '''' AND
                                                dbp_data.tupel_mat.A59_anz_maerkte_sst = 0 AND 
                                                dbp_data.tupel_mat.anz_maerkte_baustein_sonstige = 0 AND 
                                                dbp_data.tupel_mat.A57_anz_maerkte_listung_einzel = 0 AND 
                                                dbp_data.tupel_mat.A53_anz_maerkte_listung_gesamt = 0
                                           THEN ''Einlistung Kauflandartikel''
                                           WHEN  ''` + var_vorschlag + `''  = ''Auslisten'' 
                                           THEN ''Auslistung''
                                           ELSE x.vorschlag
                                         END

                    WHERE (mandant_id =  ''` + mandant_id + `''  AND art_id =  ''` + ART_ID + `'' AND A500_kjwo_update =  ''` + KJWO_UPDATE + `'' );`);

                    sql = sql.replace(/''undefined''/g, "NULL")
                    sql_stmt = snowflake.createStatement({sqlText: sql});
                    sql_stmt.execute();
                    


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

                    
                    
    } } } }


';