CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_DBA(MATCHING_ID FLOAT, ART_ID FLOAT, GTIN VARCHAR, STK_RE_PFLEGE VARCHAR, VORSCHLAG VARCHAR, PRODUKTWISSEN_PFLEGE VARCHAR, LIEFERANTENWISSEN_PFLEGE VARCHAR, LISTUNG_SST_PFLEGE VARCHAR, OST_BASIS_PFLEGE FLOAT, OST_GROSS_PFLEGE FLOAT, SUED_OST_PFLEGE FLOAT, SUED_WEST_PFLEGE FLOAT, WEST_PFLEGE FLOAT, NORD_PFLEGE FLOAT, KJMO FLOAT, N_K_ARTIKEL FLOAT, NL_ART_BEZ VARCHAR, KJWO_UPDATE FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '

 	var var_matching_id;

	var var_art_id;

	var var_gtin;

	var var_stk_re_pflege;

	var var_vorschlag;

	var var_vorschlag_hr;

	var var_produktwissen_pflege;

	var var_lieferantenwissen_pflege;

	var var_listung_sst_pflege;

	var var_ost_basis_pflege;

	var var_ost_gross_pflege;

	var var_sued_ost_pflege;

	var var_sued_west_pflege;

	var var_west_pflege;

	var var_nord_pflege;

	var var_kjmo;

	var var_n_k_artikel;

	var var_nl_art_bez;

	var var_region_summary;

	var var_region_summary2;

	var var_kjwo_update;

	var mandant_id;

	var var_sst_tool_fg;

	var var_ob_tool_fg;

	var var_og_tool_fg;

	var var_so_tool_fg;

	var var_sw_tool_fg;

	var var_w_tool_fg;

	var var_n_tool_fg;

	var region_only;

	var sst_only;

	var sst_reg;

	var sst_reg_change;

	var ob_reg_char;

	var og_reg_char;

	var so_reg_char;

	var sw_reg_char;

	var n_reg_char;

	var w_reg_char;

	mandant_id = 1;

	var_matching_id = MATCHING_ID;

	var_art_id = ART_ID;

	var_gtin = GTIN;



    if (STK_RE_PFLEGE == ``) {var_stk_re_pflege = null}

	else  {var_stk_re_pflege = STK_RE_PFLEGE};



    if (VORSCHLAG == ``) {var_vorschlag = null}

	else  {var_vorschlag = VORSCHLAG};



    if (VORSCHLAG == ``) {var_vorschlag_hr = null}

	else  {var_vorschlag_hr = VORSCHLAG};



	var_produktwissen_pflege = PRODUKTWISSEN_PFLEGE;

	var_lieferantenwissen_pflege = LIEFERANTENWISSEN_PFLEGE;

	var_listung_sst_pflege = LISTUNG_SST_PFLEGE;



    if (OST_BASIS_PFLEGE == 0 && OST_GROSS_PFLEGE == 0 && SUED_OST_PFLEGE == 0 && SUED_WEST_PFLEGE == 0 && WEST_PFLEGE == 0 && NORD_PFLEGE == 0) {var_region_summary = 0}

	else  {var_region_summary = 1};



	//-- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A; 5 = SST gesetzt bei ausschließlicher Clusterpflege*/

	var sql_stmt = `SELECT CASE

	                                WHEN listung_sst_mvke <> ''''N/A'''' AND

	                                    (  ''''` + var_listung_sst_pflege + `''''  IS NOT NULL AND   ''''` + var_listung_sst_pflege + `''''   <> '''''''') AND

	                                    Cast(  ''''` + var_listung_sst_pflege + `''''   AS INT) < Cast(listung_sst_mvke AS INT)

	                                THEN 1

	                                WHEN listung_sst_mvke <> ''''N/A'''' AND

	                                    (  ''''` + var_listung_sst_pflege + `''''   IS NOT NULL AND   ''''` + var_listung_sst_pflege + `''''   <> '''''''') AND

	                                    Cast(  ''''` + var_listung_sst_pflege + `''''   AS INT) > Cast(listung_sst_mvke AS INT)

	                                THEN 2

	                                WHEN listung_sst_mvke <> ''''N/A'''' AND

	                                    (  ''''` + var_listung_sst_pflege + `''''   IS NOT NULL AND   ''''` + var_listung_sst_pflege + `''''   <> '''''''') AND

	                                    Cast(  ''''` + var_listung_sst_pflege + `''''   AS INT) = Cast(listung_sst_mvke AS INT)

	                                THEN 3

	                                WHEN listung_sst_mvke = ''''N/A'''' AND

	                                    (  ''''` + var_listung_sst_pflege + `''''   IS NOT NULL AND   ''''` + var_listung_sst_pflege + `''''   <> '''''''')

	                                THEN 4

	                                WHEN listung_sst_mvke <> ''''N/A'''' AND

	                                    (  ''''` + var_listung_sst_pflege + `''''   IS NULL OR   ''''` + var_listung_sst_pflege + `''''   = '''''''')

	                                THEN 5

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_sst_tool_fg = stmt.getColumnValue(1);



	var sql_stmt = `SELECT CASE

	                                WHEN Coalesce(west,'''''''') = ''''X''''

	                                THEN 1

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_w_tool_fg = stmt.getColumnValue(1);



	var sql_stmt = `SELECT CASE

	                                WHEN Coalesce(nord,'''''''') = ''''X''''

	                                THEN 1

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_n_tool_fg = stmt.getColumnValue(1);





	var sql_stmt = `SELECT CASE

	                                WHEN Coalesce(ost_basis,'''''''') = ''''X''''

	                                THEN 1

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_ob_tool_fg = stmt.getColumnValue(1);



	var sql_stmt = `SELECT CASE

	                                WHEN Coalesce(ost_gross,'''''''') = ''''X''''

	                                THEN 1

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_og_tool_fg = stmt.getColumnValue(1);



	var sql_stmt = `SELECT CASE

	                                WHEN Coalesce(sued_ost,'''''''') = ''''X''''

	                                THEN 1

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_so_tool_fg = stmt.getColumnValue(1);



	var sql_stmt = `SELECT CASE

	                                WHEN Coalesce(sued_west,'''''''') = ''''X''''

	                                THEN 1

	                                ELSE 0

	                              END

	                       FROM dbp_data.sortiment_leistung

	                       WHERE mandant_id = 1 AND

	                             matching_id =  ''''` + MATCHING_ID + `''''  AND

	                             kjwo_update =  ''''` + KJWO_UPDATE + `'''' `;

	var stmt = snowflake.createStatement({sqlText : sql_stmt}).execute();

	stmt.next();

	var_sw_tool_fg = stmt.getColumnValue(1);



	if ((OST_BASIS_PFLEGE == 1 || OST_GROSS_PFLEGE == 1 || SUED_OST_PFLEGE == 1 || SUED_WEST_PFLEGE == 1 || WEST_PFLEGE == 1 || NORD_PFLEGE == 1) && (var_listung_sst_pflege == null || var_listung_sst_pflege == ``)) {var_region_summary2 = 1}

	else  {var_region_summary2 = 0};



	//--- Die alles entscheidende Weiche, welcher Zweig zu waehlen ist!*/

    if (LISTUNG_SST_PFLEGE == null || LISTUNG_SST_PFLEGE == ``) {region_only = 1}

	else  {region_only = 0};



    if (LISTUNG_SST_PFLEGE !== null && LISTUNG_SST_PFLEGE !== `` && var_region_summary == 0) {sst_only = 1}

	else  {sst_only = 0};



    if (LISTUNG_SST_PFLEGE !== null && LISTUNG_SST_PFLEGE !== `` && var_region_summary == 1) {sst_reg = 1}

	else  {sst_reg = 0};



	//-- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A*/

    if (sst_reg == 1 && var_sst_tool_fg == 1) {sst_reg_change = 1}

    else if (sst_reg == 1 && var_sst_tool_fg == 2) {sst_reg_change = 2}

    else if (sst_reg == 1 && var_sst_tool_fg == 3) {sst_reg_change = 3}

    else if (sst_reg == 1 && var_sst_tool_fg == 4) {sst_reg_change = 4}    

	else  {sst_reg_change = 0};

';