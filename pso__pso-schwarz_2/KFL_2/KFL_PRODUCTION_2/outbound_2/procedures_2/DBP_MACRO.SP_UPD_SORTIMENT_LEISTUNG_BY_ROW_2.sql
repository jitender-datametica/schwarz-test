CREATE OR REPLACE PROCEDURE `dbp_macro.sp_upd_sortiment_leistung_by_row`(
    matching_id STRING, 
    art_id STRING, 
    gtin STRING, 
    stk_re_pflege STRING, 
    vorschlag STRING, 
    produktwissen_pflege STRING, 
    lieferantenwissen_pflege STRING, 
    listung_sst_pflege STRING, 
    ost_basis_pflege STRING, 
    ost_gross_pflege STRING, 
    sued_ost_pflege STRING, 
    sued_west_pflege STRING, 
    west_pflege STRING, 
    nord_pflege STRING, 
    kjmo STRING, 
    n_k_artikel STRING, 
    nl_art_bez STRING, 
    kjwo_update STRING,
    OUT result_msg STRING
)


BEGIN


    DECLARE var_matching_id STRING;
    DECLARE var_art_id STRING;
    DECLARE var_gtin STRING;
    DECLARE var_stk_re_pflege STRING;
    DECLARE var_vorschlag STRING;
    DECLARE var_vorschlag_hr STRING;
    DECLARE var_produktwissen_pflege STRING;
    DECLARE var_lieferantenwissen_pflege STRING;
    DECLARE var_listung_sst_pflege STRING;
    DECLARE var_ost_basis_pflege STRING;
    DECLARE var_ost_gross_pflege STRING;
    DECLARE var_sued_ost_pflege STRING;
    DECLARE var_sued_west_pflege STRING;
    DECLARE var_west_pflege STRING;
    DECLARE var_nord_pflege STRING;
    DECLARE var_kjmo STRING;
    DECLARE var_n_k_artikel STRING;
    DECLARE var_nl_art_bez STRING;
    DECLARE var_region_summary INT64;
    DECLARE var_region_summary2 INT64;
    DECLARE var_kjwo_update STRING;
    DECLARE mandant_id INT64;
    DECLARE var_sst_tool_fg INT64;
    DECLARE var_ob_tool_fg INT64;
    DECLARE var_og_tool_fg INT64;
    DECLARE var_so_tool_fg INT64;
    DECLARE var_sw_tool_fg INT64;
    DECLARE var_w_tool_fg INT64;
    DECLARE var_n_tool_fg INT64;
    DECLARE region_only INT64;
    DECLARE sst_only INT64;
    DECLARE sst_reg INT64;
    DECLARE sst_reg_change INT64;

    DECLARE ob_reg_char STRING;
    DECLARE og_reg_char STRING;
    DECLARE so_reg_char STRING;
    DECLARE sw_reg_char STRING;
    DECLARE n_reg_char STRING;
    DECLARE w_reg_char STRING;
    
    DECLARE sql STRING;
    DECLARE sql_stmt STRING;
    DECLARE result INT64;
    DECLARE res ARRAY<JSON>;


    SET mandant_id = 1;
    SET var_matching_id = matching_id;
    SET var_art_id = art_id;
    SET var_gtin = gtin;

    IF stk_re_pflege != '' THEN
        SET var_stk_re_pflege = stk_re_pflege;
    ELSE
        SET var_stk_re_pflege = NULL;
    END IF;

    IF vorschlag IS NOT NULL THEN
        SET var_vorschlag = vorschlag;
    ELSE
        SET var_vorschlag = '';
    END IF;

    IF vorschlag IS NOT NULL THEN
        SET var_vorschlag_hr = vorschlag;
    ELSE
        SET var_vorschlag_hr = '';
    END IF;

    SET var_produktwissen_pflege = produktwissen_pflege;
    SET var_lieferantenwissen_pflege = lieferantenwissen_pflege;
    SET var_listung_sst_pflege = listung_sst_pflege;


    IF ost_basis_pflege = '0' AND ost_gross_pflege = '0' AND sued_ost_pflege = '0' AND sued_west_pflege = '0' AND west_pflege = '0' AND nord_pflege = '0' THEN
        SET var_region_summary = 0;
    ELSE
        SET var_region_summary = 1;
    END IF;

    /*----------------------------------------------------
     1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A; 5 = SST gesetzt bei ausschließlicher Clusterpflege
    --SET var_sst_tool_fg*/

    SET sql = """ SELECT CASE
            WHEN listung_sst_mvke <> 'N/A' AND
                (NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'') IS NOT NULL AND TRIM('""" || var_listung_sst_pflege || """') <> '') AND
                CAST(NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'') AS INT64 ) < CAST(listung_sst_mvke AS INT64 )
            THEN 1
            WHEN listung_sst_mvke <> 'N/A' AND
                (NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'') IS NOT NULL AND TRIM('""" || var_listung_sst_pflege || """') <> '') AND
                CAST(NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'') AS INT64 ) > CAST(listung_sst_mvke AS INT64 )
            THEN 2
            WHEN listung_sst_mvke <> 'N/A' AND
                (NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'')  IS NOT NULL AND  TRIM('""" || var_listung_sst_pflege || """')  <> '') AND
                CAST(NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'') AS INT64 ) = CAST(listung_sst_mvke AS INT64 )
            THEN 3
            WHEN listung_sst_mvke = 'N/A' AND
                (NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'')  IS NOT NULL AND  TRIM('""" || var_listung_sst_pflege || """')  <> '')
            THEN 4
            WHEN listung_sst_mvke <> 'N/A' AND
                (NULLIF(TRIM('""" || var_listung_sst_pflege || """'),'')  IS NULL OR  TRIM('""" || var_listung_sst_pflege || """')  = '')
            THEN 5
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
                MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
                KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
   EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_sst_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    SET sql = """ SELECT CASE
            WHEN COALESCE(west,'') = 'X'
            THEN 1
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
            KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
       EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_w_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    SET sql = """ SELECT CASE
            WHEN COALESCE(nord,'') = 'X'
            THEN 1
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
            KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
       EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_n_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    SET sql = """ SELECT CASE
            WHEN COALESCE(ost_basis,'') = 'X'
            THEN 1
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
            KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
       EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_ob_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    SET sql = """ SELECT CASE
            WHEN COALESCE(ost_gross,'') = 'X'
            THEN 1
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
            KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
       EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_og_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    SET sql = """ SELECT CASE
            WHEN COALESCE(sued_ost,'') = 'X'
            THEN 1
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
            KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
       EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_so_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    SET sql = """ SELECT CASE
            WHEN COALESCE(sued_west,'') = 'X'
            THEN 1
            ELSE 0
            END AS T10
        FROM `dbp_data.sortiment_leistung_2` 
        WHERE mandant_id = 1 AND 
            MATCHING_ID =  CAST('""" || matching_id || """' AS INT64)  AND 
            KJWO_UPDATE =  CAST('""" || kjwo_update || """' AS INT64)""";

    SET sql = REPLACE(sql, """undefined""", 'NULL');
    SET sql_stmt = sql;
      EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", 'T10', sql_stmt)
INTO res ;

    -- EXECUTE IMMEDIATE (sql_stmt) INTO result;
    SET var_sw_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]') AS INT64);

    IF (ost_basis_pflege = '1' OR ost_gross_pflege = '1' OR sued_ost_pflege = '1' OR sued_west_pflege = '1' OR nord_pflege = '1') AND (var_listung_sst_pflege IS NULL OR var_listung_sst_pflege = '') THEN
        SET var_region_summary2 = 1;
    ELSE
        SET var_region_summary2 = 0;
    END IF;

    /*--- Die alles entscheidende Weiche, welcher Zweig zu waehlen ist!*/

    IF listung_sst_pflege IS NULL OR listung_sst_pflege = '' OR listung_sst_pflege = ' ' THEN
        SET region_only = 1;
    ELSE
        SET region_only = 0;
    END IF;

    IF (listung_sst_pflege IS NOT NULL AND listung_sst_pflege != '' AND listung_sst_pflege != ' ') AND var_region_summary = 0 THEN
        SET sst_only = 1;
    ELSE
        SET sst_only = 0;
    END IF;         

    IF (listung_sst_pflege IS NOT NULL AND listung_sst_pflege != '' AND listung_sst_pflege != ' ') AND var_region_summary = 1 THEN
        SET sst_reg = 1;
    ELSE
        SET sst_reg = 0;
    END IF;         

    /*--------------------------------------*/

    /*-- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A*/

    IF sst_reg = 1 AND var_sst_tool_fg = 1 THEN 
        SET sst_reg_change = 1;
    ELSEIF sst_reg = 1 AND var_sst_tool_fg = 2 THEN 
        SET sst_reg_change = 2;
    ELSEIF sst_reg = 1 AND var_sst_tool_fg = 3 THEN 
        SET sst_reg_change = 3;
    ELSEIF sst_reg = 1 AND var_sst_tool_fg = 4 THEN 
        SET sst_reg_change = 4;
    ELSE 
        SET sst_reg_change = 0;
    END IF;

    /*--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---*/

    IF nord_pflege = '1' THEN 
        SET n_reg_char = 'N';
    ELSE 
        SET n_reg_char = ' ';
    END IF;

    IF west_pflege = '1' THEN 
        SET w_reg_char = 'W';
    ELSE 
        SET w_reg_char = ' ';
    END IF;

    IF ost_basis_pflege = '1' THEN 
        SET ob_reg_char = 'O';
    ELSE 
        SET ob_reg_char = ' ';
    END IF;

    IF ost_gross_pflege = '1' THEN 
        SET og_reg_char = 'Q';
    ELSE 
        SET og_reg_char = ' ';
    END IF;

    IF sued_ost_pflege = '1' THEN 
        SET so_reg_char = 'G';
    ELSE 
        SET so_reg_char = ' ';
    END IF;

    IF sued_west_pflege = '1' THEN 
        SET sw_reg_char = 'M';
    ELSE 
        SET sw_reg_char = ' ';
    END IF;

    IF region_only = 1 AND ost_basis_pflege = '1' AND var_ob_tool_fg = 0 THEN 
        SET var_ost_basis_pflege = 'x';
    ELSEIF region_only = 1 AND ost_basis_pflege = '1' AND var_ob_tool_fg = 1 THEN 
        SET var_ost_basis_pflege = ' ';
    ELSEIF region_only = 1 AND ost_basis_pflege = '0' AND var_ob_tool_fg = 0 AND var_sst_tool_fg = 5 THEN 
        SET var_ost_basis_pflege = 'u';
    ELSEIF region_only = 1 AND ost_basis_pflege = '0' AND var_ob_tool_fg = 0 AND var_sst_tool_fg != 5 THEN 
        SET var_ost_basis_pflege = ' ';
    ELSEIF region_only = 1 AND ost_basis_pflege = '0' AND var_ob_tool_fg = 0 THEN 
        SET var_ost_basis_pflege = ' ';
    ELSEIF region_only = 1 AND ost_basis_pflege = '0' AND var_ob_tool_fg = 1 THEN 
        SET var_ost_basis_pflege = 'u';
    ELSEIF sst_reg = 1 AND ost_basis_pflege = '0' AND var_ob_tool_fg = 0 THEN 
        SET var_ost_basis_pflege = ' ';
    ELSEIF sst_reg = 1 AND ost_basis_pflege = '0' AND var_ob_tool_fg = 1 THEN 
        SET var_ost_basis_pflege = 'u';
    ELSEIF sst_reg = 1 AND ost_basis_pflege = '1' AND var_ob_tool_fg = 0 THEN 
        SET var_ost_basis_pflege = 'x';
    ELSEIF sst_reg = 1 AND ost_basis_pflege = '1' AND var_ob_tool_fg = 1 THEN 
        SET var_ost_basis_pflege = ' ';
    ELSE 
        SET var_ost_basis_pflege = ' ';
    END IF;

    IF region_only = 1 AND ost_gross_pflege = '1' AND var_og_tool_fg = 0 THEN 
        SET var_ost_gross_pflege = 'x';
    ELSEIF region_only = 1 AND ost_gross_pflege = '1' AND var_og_tool_fg = 1 THEN 
        SET var_ost_gross_pflege = ' ';
    ELSEIF region_only = 1 AND ost_gross_pflege = '0' AND var_og_tool_fg = 0 AND var_sst_tool_fg = 5 THEN 
        SET var_ost_gross_pflege = 'u';
    ELSEIF region_only = 1 AND ost_gross_pflege = '0' AND var_og_tool_fg = 0 AND var_sst_tool_fg != 5 THEN 
        SET var_ost_gross_pflege = ' ';
    ELSEIF region_only = 1 AND ost_gross_pflege = '0' AND var_og_tool_fg = 0 THEN 
        SET var_ost_gross_pflege = ' ';
    ELSEIF region_only = 1 AND ost_gross_pflege = '0' AND var_og_tool_fg = 1 THEN 
        SET var_ost_gross_pflege = 'u';
    ELSEIF sst_reg = 1 AND ost_gross_pflege = '0' AND var_og_tool_fg = 0 THEN 
        SET var_ost_gross_pflege = ' ';
    ELSEIF sst_reg = 1 AND ost_gross_pflege = '0' AND var_og_tool_fg = 1 THEN 
        SET var_ost_gross_pflege = 'u';
    ELSEIF sst_reg = 1 AND ost_gross_pflege = '1' AND var_og_tool_fg = 0 THEN 
        SET var_ost_gross_pflege = 'x';
    ELSEIF sst_reg = 1 AND ost_gross_pflege = '1' AND var_og_tool_fg = 1 THEN 
        SET var_ost_gross_pflege = ' ';
    ELSE 
        SET var_ost_gross_pflege = ' ';
    END IF;

    IF region_only = 1 AND sued_ost_pflege = '1' AND var_so_tool_fg = 0 THEN 
        SET var_sued_ost_pflege = 'x';
    ELSEIF region_only = 1 AND sued_ost_pflege = '1' AND var_so_tool_fg = 1 THEN 
        SET var_sued_ost_pflege = ' ';
    ELSEIF region_only = 1 AND sued_ost_pflege = '0' AND var_so_tool_fg = 0 AND var_sst_tool_fg = 5 THEN 
        SET var_sued_ost_pflege = 'u';
    ELSEIF region_only = 1 AND sued_ost_pflege = '0' AND var_so_tool_fg = 0 AND var_sst_tool_fg != 5 THEN 
        SET var_sued_ost_pflege = ' ';
    ELSEIF region_only = 1 AND sued_ost_pflege = '0' AND var_so_tool_fg = 0 THEN 
        SET var_sued_ost_pflege = ' ';
    ELSEIF region_only = 1 AND sued_ost_pflege = '0' AND var_so_tool_fg = 1 THEN 
        SET var_sued_ost_pflege = 'u';
    ELSEIF sst_reg = 1 AND sued_ost_pflege = '0' AND var_so_tool_fg = 0 THEN 
        SET var_sued_ost_pflege = ' ';
    ELSEIF sst_reg = 1 AND sued_ost_pflege = '0' AND var_so_tool_fg = 1 THEN 
        SET var_sued_ost_pflege = 'u';
    ELSEIF sst_reg = 1 AND sued_ost_pflege = '1' AND var_so_tool_fg = 0 THEN 
        SET var_sued_ost_pflege = 'x';
    ELSEIF sst_reg = 1 AND sued_ost_pflege = '1' AND var_so_tool_fg = 1 THEN 
        SET var_sued_ost_pflege = ' ';
    ELSE 
        SET var_sued_ost_pflege = ' ';
    END IF;

    IF region_only = 1 AND sued_west_pflege = '1' AND var_sw_tool_fg = 0 THEN 
        SET var_sued_west_pflege = 'x';
    ELSEIF region_only = 1 AND sued_west_pflege = '1' AND var_sw_tool_fg = 1 THEN 
        SET var_sued_west_pflege = ' ';
    ELSEIF region_only = 1 AND sued_west_pflege = '0' AND var_sw_tool_fg = 0 AND var_sst_tool_fg = 5 THEN 
        SET var_sued_west_pflege = 'u';
    ELSEIF region_only = 1 AND sued_west_pflege = '0' AND var_sw_tool_fg = 0 AND var_sst_tool_fg != 5 THEN 
        SET var_sued_west_pflege = ' ';
    ELSEIF region_only = 1 AND sued_west_pflege = '0' AND var_sw_tool_fg = 0 THEN 
        SET var_sued_west_pflege = ' ';
    ELSEIF region_only = 1 AND sued_west_pflege = '0' AND var_sw_tool_fg = 1 THEN 
        SET var_sued_west_pflege = 'u';
    ELSEIF sst_reg = 1 AND sued_west_pflege = '0' AND var_sw_tool_fg = 0 THEN 
        SET var_sued_west_pflege = ' ';
    ELSEIF sst_reg = 1 AND sued_west_pflege = '0' AND var_sw_tool_fg = 1 THEN 
        SET var_sued_west_pflege = 'u';
    ELSEIF sst_reg = 1 AND sued_west_pflege = '1' AND var_sw_tool_fg = 0 THEN 
        SET var_sued_west_pflege = 'x';
    ELSEIF sst_reg = 1 AND sued_west_pflege = '1' AND var_sw_tool_fg = 1 THEN 
        SET var_sued_west_pflege = ' ';
    ELSE 
        SET var_sued_west_pflege = ' ';
    END IF;

    IF region_only = 1 AND west_pflege = '1' AND var_w_tool_fg = 0 THEN 
        SET var_west_pflege = 'x';
    ELSEIF region_only = 1 AND west_pflege = '1' AND var_w_tool_fg = 1 THEN 
        SET var_west_pflege = ' ';
    ELSEIF region_only = 1 AND west_pflege = '0' AND var_w_tool_fg = 0 AND var_sst_tool_fg = 5 THEN 
        SET var_west_pflege = 'u';
    ELSEIF region_only = 1 AND west_pflege = '0' AND var_w_tool_fg = 0 AND var_sst_tool_fg != 5 THEN 
        SET var_west_pflege = ' ';
    ELSEIF region_only = 1 AND west_pflege = '0' AND var_w_tool_fg = 1 THEN 
        SET var_west_pflege = 'u';
    ELSEIF sst_reg = 1 AND west_pflege = '0' AND var_w_tool_fg = 0 THEN 
        SET var_west_pflege = ' ';
    ELSEIF sst_reg = 1 AND west_pflege = '0' AND var_w_tool_fg = 1 THEN 
        SET var_west_pflege = 'u';
    ELSEIF sst_reg = 1 AND west_pflege = '1' AND var_w_tool_fg = 0 THEN 
        SET var_west_pflege = 'x';
    ELSEIF sst_reg = 1 AND west_pflege = '1' AND var_w_tool_fg = 1 THEN 
        SET var_west_pflege = ' ';
    ELSE 
        SET var_west_pflege = ' ';
    END IF;

    IF region_only = 1 AND nord_pflege = '1' AND var_n_tool_fg = 0 THEN 
        SET var_nord_pflege = 'x';
    ELSEIF region_only = 1 AND nord_pflege = '1' AND var_n_tool_fg = 1 THEN 
        SET var_nord_pflege = ' ';
    ELSEIF region_only = 1 AND nord_pflege = '0' AND var_n_tool_fg = 0 AND var_sst_tool_fg = 5 THEN 
        SET var_nord_pflege = 'u';
    ELSEIF region_only = 1 AND nord_pflege = '0' AND var_n_tool_fg = 0 AND var_sst_tool_fg != 5 THEN 
        SET var_nord_pflege = ' ';
    ELSEIF region_only = 1 AND nord_pflege = '0' AND var_n_tool_fg = 0 THEN 
        SET var_nord_pflege = ' ';
    ELSEIF region_only = 1 AND nord_pflege = '0' AND var_n_tool_fg = 1 THEN 
        SET var_nord_pflege = 'u';
    ELSEIF sst_reg = 1 AND nord_pflege = '0' AND var_n_tool_fg = 0 THEN 
        SET var_nord_pflege = ' ';
    ELSEIF sst_reg = 1 AND nord_pflege = '0' AND var_n_tool_fg = 1 THEN 
        SET var_nord_pflege = 'u';
    ELSEIF sst_reg = 1 AND nord_pflege = '1' AND var_n_tool_fg = 0 THEN 
        SET var_nord_pflege = 'x';
    ELSEIF sst_reg = 1 AND nord_pflege = '1' AND var_n_tool_fg = 1 THEN 
        SET var_nord_pflege = ' ';
    ELSE 
        SET var_nord_pflege = ' ';
    END IF;

    SET var_kjmo = kjmo;
    SET var_n_k_artikel = n_k_artikel;
    SET var_nl_art_bez = nl_art_bez;
    SET var_kjwo_update = kjwo_update;

    /*
    --IF (var_vorschlag IN ('Keine Veränderung setzen','Keine Veränderung zurücksetzen'))
    --THEN
    --  DELETE FROM dbp_etl_process.ek_sort_batch WHERE MATCHING_ID =  '` + MATCHING_ID + `'  AND kjmo =  '` + KJMO + `'  AND mandant_id =  '` + mandant_id + `'  AND KJWO_UPDATE =  '` + KJWO_UPDATE; + `' 
    --  IF (var_vorschlag IN ('Keine Veränderung setzen'))
    --  THEN 
    --    INSERT INTO dbp_etl_process.ek_sort_batch (mandant_id,matching_id,kjmo,kjwo_update) VALUES ( '` + mandant_id, + `'   '` + MATCHING_ID, + `'   '` + kjmo, + `'   '` + KJWO_UPDATE + `' );
    --  END IF;
    --ELSE                                             
    */


   --- ###########  2nd batch ############# 


   IF (var_region_summary = 0 AND (var_listung_sst_pflege IS NULL OR var_listung_sst_pflege = '') AND 
        (var_produktwissen_pflege IS NULL OR var_produktwissen_pflege = '') AND
        (var_lieferantenwissen_pflege IS NULL OR var_lieferantenwissen_pflege = '') AND
        (var_vorschlag = '' OR var_vorschlag IS NULL)) THEN
            
            SET var_nl_art_bez = nl_art_bez;

    ELSE

        IF var_gtin IS NULL OR (var_gtin IS NOT NULL AND var_gtin NOT IN ('-9999', '-9998')) THEN
            IF var_vorschlag = 'Zurücksetzen' THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                SET stk_re_pflege = NULL
                ,listungsaktion = NULL
                ,produktwissen_pflege = NULL
                ,lieferantenwissen_pflege = NULL
                ,listung_sst_pflege = NULL
                ,ost_basis_pflege = ' '
                ,ost_gross_pflege = ' '
                ,sued_ost_pflege = ' '
                ,sued_west_pflege = ' '
                ,west_pflege = ' '
                ,nord_pflege = ' '
                ,umsatz_hr = NULL
                ,absatz_hr = NULL
                ,rohertrag_hr = NULL
                WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = CAST('""" || kjwo_update || """' AS INT64);""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

                SET sql = """DELETE FROM `dbp_msi_data.erwartete_entwicklung_2`
                      WHERE matching_id = CAST('""" || matching_id || """' AS INT64)  AND
                              kjmo = CAST('""" || kjmo || """' AS INT64) AND
                              kjwo_update = cast('""" || kjwo_update || """' as int64) AND
                              mandant_id = """ || CAST(mandant_id AS STRING) || """;""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;  /* END IF (var_vorschlag == 'Zurücksetzen') */

            ELSEIF var_vorschlag = 'Keine Veränderung setzen' THEN

                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  listungsaktion = 'Keine Veränderung'
                    ,listung_sst_pflege = NULL
                    ,ost_basis_pflege = ' '
                    ,ost_gross_pflege = ' '
                    ,sued_ost_pflege = ' '
                    ,sued_west_pflege = ' '
                    ,west_pflege = ' '
                    ,nord_pflege = ' '
                    ,umsatz_hr = NULL
                    ,absatz_hr = NULL
                    ,rohertrag_hr = NULL
                    WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = cast('""" || kjwo_update || """' as int64) AND (listungsaktion IS NULL OR listungsaktion = '');""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSEIF var_vorschlag = 'Keine Veränderung' THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  listungsaktion = 'Keine Veränderung'
                    ,listung_sst_pflege = NULL
                    ,ost_basis_pflege = ' '
                    ,ost_gross_pflege = ' '
                    ,sued_ost_pflege = ' '
                    ,sued_west_pflege = ' '
                    ,produktwissen_pflege = '""" || COALESCE(produktwissen_pflege, 'NULL') || """'
                    ,lieferantenwissen_pflege = '""" || COALESCE(lieferantenwissen_pflege, 'NULL') || """'
                    ,west_pflege = ' '
                    ,nord_pflege = ' '
                    ,umsatz_hr = NULL
                    ,absatz_hr = NULL
                    ,rohertrag_hr = NULL
                    WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = cast('""" || kjwo_update || """' as int64);""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSEIF var_vorschlag = 'Keine Veränderung zurücksetzen' THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  listungsaktion = NULL
                    WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND listungsaktion = 'Keine Veränderung' AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = cast('""" || kjwo_update || """' as int64);""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSEIF var_vorschlag = 'Produktwissen_2' THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  produktwissen_pflege = produktwissen_vp
                    WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = cast('""" || kjwo_update || """' as int64) AND (produktwissen_pflege IS NULL OR produktwissen_pflege = '') AND (produktwissen_vp IS NOT NULL AND produktwissen_vp <> '');""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSEIF (var_vorschlag = '' OR var_vorschlag IS NULL) AND (var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL) AND var_produktwissen_pflege != '' AND var_produktwissen_pflege IS NOT NULL AND var_region_summary2 = 0 THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  produktwissen_pflege = '""" || COALESCE(produktwissen_pflege, 'NULL') || """'
                    WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = cast('""" || kjwo_update || """' as int64);""";
                
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            /* NOTE FROM ASSISTANT: The original code has two identical IF condition blocks here. I have maintained the structure as requested, appending the logic. */
            ELSEIF (var_vorschlag = '' OR var_vorschlag IS NULL) AND (var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL) AND var_produktwissen_pflege != '' AND var_produktwissen_pflege IS NOT NULL AND var_region_summary2 = 0 THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  produktwissen_pflege = '""" || COALESCE(produktwissen_pflege, 'NULL') || """'
                        , lieferantenwissen_pflege =  '""" || COALESCE(lieferantenwissen_pflege, 'NULL') || """' 
                    WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = CAST('""" || kjwo_update || """' AS INT64);""";
                
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSEIF var_vorschlag = 'Lieferantenwissen_2' THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  lieferantenwissen_pflege = lieferantenwissen_vp
                    WHERE matching_id =  CAST('""" || matching_id || """' AS INT64)  AND kjmo =  CAST('""" || kjmo || """' AS INT64)  AND mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND kjwo_update =  CAST('""" || kjwo_update || """' AS INT64)  AND (lieferantenwissen_pflege IS NULL OR lieferantenwissen_pflege = '') AND (lieferantenwissen_vp IS NOT NULL AND lieferantenwissen_vp <> '');""";
                
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSEIF (var_vorschlag = "" OR var_vorschlag = " ") AND (var_listung_sst_pflege = "" OR var_listung_sst_pflege = " " OR var_listung_sst_pflege IS NULL) AND var_lieferantenwissen_pflege != "" AND var_lieferantenwissen_pflege != " " AND var_lieferantenwissen_pflege IS NOT NULL AND var_region_summary2 = 0 THEN
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                    SET  produktwissen_pflege =  '""" || COALESCE(produktwissen_pflege, 'NULL') || """' 
                    , lieferantenwissen_pflege =  '""" || COALESCE(lieferantenwissen_pflege, 'NULL') || """' 
                    WHERE matching_id =  CAST('""" || matching_id || """' AS INT64)  AND kjmo =  CAST('""" || kjmo || """' AS INT64)  AND mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND kjwo_update =  CAST('""" || kjwo_update || """' AS INT64) """;
                
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            ELSE        
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2`
                        SET  stk_re_pflege = '""" || COALESCE(stk_re_pflege, 'NULL') || """'
                        ,listungsaktion = '""" || COALESCE(vorschlag, 'NULL') || """'
                        ,produktwissen_pflege = '""" || COALESCE(produktwissen_pflege, 'NULL') || """'
                        ,lieferantenwissen_pflege = '""" || COALESCE(lieferantenwissen_pflege, 'NULL') || """'
                        ,listung_sst_pflege = COALESCE(TRIM('""" || COALESCE(listung_sst_pflege, 'NULL') || """'),'N/A')
                        ,ost_basis_pflege = TRIM(CASE WHEN '""" || COALESCE(ost_basis_pflege, 'NULL') || """' = '0' THEN ' ' WHEN '""" || COALESCE(ost_basis_pflege, 'NULL') || """' = '1' THEN 'X' END)
                        ,ost_gross_pflege = TRIM(CASE WHEN '""" || COALESCE(ost_gross_pflege, 'NULL') || """' = '0' THEN ' ' WHEN '""" || COALESCE(ost_gross_pflege, 'NULL') || """' = '1' THEN 'X' END)
                        ,sued_ost_pflege = TRIM(CASE WHEN '""" || COALESCE(sued_ost_pflege, 'NULL') || """' = '0' THEN ' ' WHEN '""" || COALESCE(sued_ost_pflege, 'NULL') || """' = '1' THEN 'X' END)
                        ,sued_west_pflege = TRIM(CASE WHEN '""" || COALESCE(sued_west_pflege, 'NULL') || """' = '0' THEN ' ' WHEN '""" || COALESCE(sued_west_pflege, 'NULL') || """' = '1' THEN 'X' END)
                        ,west_pflege = TRIM(CASE WHEN '""" || COALESCE(west_pflege, 'NULL') || """' = '0' THEN ' ' WHEN '""" || COALESCE(west_pflege, 'NULL') || """' = '1' THEN 'X' END)
                        ,nord_pflege = TRIM(CASE WHEN '""" || COALESCE(nord_pflege, 'NULL') || """' = '0' THEN ' ' WHEN '""" || COALESCE(nord_pflege, 'NULL') || """' = '1' THEN 'X' END)
                        WHERE matching_id = CAST('""" || matching_id || """' AS INT64) AND kjmo = CAST('""" || kjmo || """' AS INT64) AND mandant_id = """ || CAST(mandant_id AS STRING) || """ AND kjwo_update = CAST('""" || kjwo_update || """' AS INT64);""";
                
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

                IF (var_listung_sst_pflege != '' AND var_listung_sst_pflege != ' ' AND var_listung_sst_pflege IS NOT NULL) OR (var_vorschlag_hr = 'Auslisten') THEN
                    IF var_vorschlag_hr = 'Auslisten' OR ((var_listung_sst_pflege = '' OR var_listung_sst_pflege = ' ' OR var_listung_sst_pflege IS NULL ) AND var_region_summary = 0) THEN
                      SET var_listung_sst_pflege = '-1';
                    END IF;

                    SET sql = """INSERT INTO `dbp_msi_data.sortiment_art_2` (mandant_id,
                                                                    art_id,
                                                                    gtin_id,
                                                                    status_2,
                                                                    kjwo_update)
                        SELECT a.mandant_id,
                                 a.art_id,
                                   MAX(CAST(CAST(a.gtin_id AS INT64 ) AS STRING )) AS gtin_id,
                                   MAX(a.status_2) AS status_2,
                                   CAST('""" || kjwo_update || """' AS INT64) AS kjwo_update
                                  FROM `dbp_etl.art_matching_nielsen_per_2` a
                        WHERE a.art_matching_id =  CAST('""" || matching_id || """' AS INT64)  AND
                            CASE
                                WHEN a.status_2 <> 'N' AND
                                    a.list_kz = 'A'
                                THEN 1
                                WHEN a.status_2 = 'N'
                                THEN 1
                                ELSE 0
                            END = 1
                        GROUP BY 1,2;""";
                        
                    SET sql = REPLACE(sql, """undefined""", 'NULL');
                    SET sql_stmt = sql;
                    EXECUTE IMMEDIATE sql_stmt;

                    /*
                    --------------------------------------------------------------------------------------------------------
                    --   (I) UPDATE FUER SORTIMENT_LEISTUNG_2 (mit K-Stufen)
                    --------------------------------------------------------------------------------------------------------
                    */
                    SET sql = """UPDATE `dbp_data.sortiment_leistung_2` sl
                                 SET sl.umsatz_hr = x.umsatz,
                                     sl.absatz_hr = x.absatz,
                                     sl.rohertrag_hr = CAST(x.rohertrag AS NUMERIC),
                                     sl.listungsaktion = CASE WHEN  '""" || COALESCE(var_vorschlag, 'NULL') || """'  = 'Auslisten' THEN 'Auslistung' ELSE x.vorschlag END
                                 FROM (
                                                        SELECT SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
                                                        SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
                                                        REPLACE(REPLACE(
                                                                        MAX(
                                                                            IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                                                                                        , REPLACE(x.vorschlag_, 'dynamic', 'Dynamic')
                                                                                        , REPLACE(x.vorschlag_, 'dynamic', 'AAA_2')
                                                                                            )
                                                                        )
                                                                           , 'Dynamic', 'dynamic')
                                                                           , 'AAA_2', 'dynamic')AS vorschlag__, 
                                                        CASE
                                                            WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic')
                                                            WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                                            WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                                            WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND  """ || CAST(var_region_summary AS STRING) || """  = 0 THEN 'Listung reduzieren und erweitern'
                                                            WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND  """ || CAST(var_region_summary AS STRING) || """  = 0 THEN 'Listung erweitern und reduzieren'
                                                            WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND  """ || CAST(var_region_summary AS STRING) || """  = 1 THEN 'Listung reduzieren und erweitern'
                                                            WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND  """ || CAST(var_region_summary AS STRING) || """  = 1 THEN 'Listung erweitern und reduzieren'
                                                                                            WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                                                                            ELSE 'SOLL-Listung = IST-Listung'
                                                        END AS vorschlag,

                                                        CASE
                                                            WHEN CASE WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 0 THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 0 THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 1 THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 1 THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung'
                                                            THEN 0
                                                            ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                                        END AS umsatz,
                                                        CASE
                                                            WHEN CASE WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 0 THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 0 THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 1 THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 1 THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung'
                                                            THEN 0
                                                            ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                                        END AS absatz,
                                                        CASE
                                                            WHEN CASE WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 0 THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 0 THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 1 THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) AND """ || CAST(var_region_summary AS STRING) || """ = 1 THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung'
                                                            THEN 0
                                                            ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                                        END AS rohertrag
                                                        
                                                    FROM (-- Nur SST gepflegt fuer Erweiterung!

                                                        """;
  /* hier kann noch optimiert werden */                                                        

                    SET sql = CONCAT(sql, """
                                                        SELECT CAST(a.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MIN(a.list_kz) AS list_kz_,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.rohertrag_hr) AS rohertrag_,
                                                                CAST(0 AS INT64 ) AS anzahl_reduktion,
                                                                SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                                CASE WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN CAST('Einlistung Kauflandartikel' AS STRING ) ELSE CAST('dynamic' AS STRING ) END AS vorschlag_
                                                        FROM `dbp_msi_data.kl_listung_2` a
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON a.mandant_id = b.mandant_id AND
                                                            a.art_id = b.art_id AND
                                                            a.kjwo_update = b.kjwo_update
                                                        WHERE a.art_id NOT IN (SELECT art_id FROM `dbp_etl.not_listed_basis_2`) AND
                                                                a.listung_art = 'Listung erweitern' AND
                                                                a.kjwo_update =  CAST('""" || kjwo_update || """' AS INT64)  AND
                                                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord = '-' AND 
                                                                a.ost_basis = '-' AND 
                                                                a.ost_gross = '-' AND 
                                                                a.sued_ost = '-' AND 
                                                                a.sued_west = '-' AND 
                                                                a.west = '-') AND
                                                            ( """ || CAST(sst_only AS STRING) || """  = 1 OR
                                                                """ || CAST(sst_reg_change AS STRING) || """  IN (1,4))
                                                        GROUP BY 1
                                                        -- Nur SST gepflegt fuer Reduktion!

                                                        """);
                                                        
                    IF sst_only = 1 OR sst_reg_change IN (2,4) THEN
                        SET sql = CONCAT(sql, """
                                                        UNION ALL
                                                        SELECT CAST(a.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MIN(a.list_kz) AS list_kz_,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.rohertrag_hr) AS rohertrag_,
                                                                SUM(reduktion_fg) AS anzahl_reduktion,
                                                                CAST(0 AS INT64 ) AS anzahl_erweiterung,
                                                                'dynamic' AS vorschlag_
                                                        FROM `dbp_msi_data.kl_listung_2` a
                                                        JOIN `dbp_data.wup_2` x
                                                            ON a.mandant_id = x.mandant_id AND
                                                            a.wup_id = x.wup_id
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON a.mandant_id = b.mandant_id AND
                                                            a.art_id = b.art_id AND
                                                            a.kjwo_update = b.kjwo_update
                                                        WHERE a.art_id NOT IN (SELECT art_id FROM `dbp_etl.not_listed_basis_2`) AND
                                                                a.listung_art = 'Listung reduzieren' AND
                                                                a.kjwo_update =  CAST('""" || kjwo_update || """' as int64)  AND
                                                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                                a.sm_id < CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord = '-' AND 
                                                                a.ost_basis = '-' AND 
                                                                a.ost_gross = '-' AND 
                                                                a.sued_ost = '-' AND 
                                                                a.sued_west = '-' AND 
                                                                a.west = '-') AND 
                                                                CASE
                                                                WHEN  """ || CAST(sst_reg_change AS STRING) || """  = 4 AND
                                                                    (x.kreistyp_gruppe_id =  '""" || n_reg_char || """'   OR
                                                                    x.kreistyp_gruppe_id =  '""" || w_reg_char || """'   OR
                                                                    x.kreistyp_gruppe_id =  '""" || so_reg_char || """'  OR
                                                                    x.kreistyp_gruppe_id =  '""" || sw_reg_char || """'  OR
                                                                    x.kreistyp_gruppe_id =  '""" || ob_reg_char || """'  OR
                                                                    x.kreistyp_gruppe_id =  '""" || og_reg_char || """' )
                                                                THEN 0
                                                                ELSE 1
                                                                END = 1 AND
                                                            ( """ || CAST(sst_only AS STRING) || """  = 1 OR
                                                                """ || CAST(sst_reg_change AS STRING) || """  IN (2,4))
                                                        GROUP BY 1
                                                        """);
                    END IF;
                    
                    IF sst_reg = 1 THEN
                        SET sql = CONCAT(sql, """
                                                        UNION ALL
                                                        -- SST plus Cluster fuer Erweiterung!
                                                        SELECT CAST(a.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MIN(a.list_kz) AS list_kz_,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.rohertrag_hr) AS rohertrag_,
                                                                CAST(0 AS INT64 ) AS anzahl_reduktion,
                                                                SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                                CASE WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN CAST('Einlistung Kauflandartikel' AS STRING ) ELSE CAST('dynamic' AS STRING ) END AS vorschlag_
                                                        FROM `dbp_msi_data.kl_listung_2` a
                                                        JOIN `dbp_data.wup_2` x
                                                            ON a.mandant_id = x.mandant_id AND
                                                            a.wup_id = x.wup_id
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON a.mandant_id = b.mandant_id AND
                                                            a.art_id = b.art_id AND
                                                            a.kjwo_update = b.kjwo_update
                                                        WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                                                a.listung_art = 'Listung erweitern' AND
                                                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                a.sm_id_selected = 0 AND
                                                                a.sm_id < CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND 
                                                                CASE
                                                                WHEN  """ || CAST(sst_reg_change AS STRING) || """  = 4 AND
                                                                    a.sm_id >= CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                                    (x.kreistyp_gruppe_id =  '""" || n_reg_char || """'   OR
                                                                    x.kreistyp_gruppe_id =  '""" || w_reg_char || """'   OR
                                                                    x.kreistyp_gruppe_id =  '""" || so_reg_char || """'  OR
                                                                    x.kreistyp_gruppe_id =  '""" || sw_reg_char || """'  OR
                                                                    x.kreistyp_gruppe_id =  '""" || ob_reg_char || """'  OR
                                                                    x.kreistyp_gruppe_id =  '""" || og_reg_char || """' )
                                                                THEN 0
                                                                ELSE 1
                                                                END = 1 AND
                                                                """ || CAST(sst_reg AS STRING) || """  = 1
                                                        GROUP BY 1
                                                        """);
                    END IF;
                    
                    IF sst_reg = 1 AND sst_reg_change != 4 THEN
                        SET sql = CONCAT(sql, """
                                                        UNION ALL
                                                        -- SST plus Cluster fuer Reduktion!
                                                        SELECT CAST(a.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MIN(a.list_kz) AS list_kz_,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.rohertrag_hr) AS rohertrag_,
                                                                SUM(reduktion_fg) AS anzahl_reduktion,
                                                                CAST(0 AS INT64 ) AS anzahl_erweiterung,
                                                                'dynamic' AS vorschlag_
                                                        FROM `dbp_msi_data.kl_listung_2` a
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON a.mandant_id = b.mandant_id AND
                                                            a.art_id = b.art_id AND
                                                            a.kjwo_update = b.kjwo_update
                                                        WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                                                a.listung_art = 'Listung reduzieren' AND
                                                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                a.sm_id_selected = 0 AND
                                                                a.sm_id < CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                                                """ || CAST(sst_reg AS STRING) || """  = 1 AND
                                                                """ || CAST(sst_reg_change AS STRING) || """  NOT IN (4)
                                                        GROUP BY 1
                                                        """);
                    END IF;
                    
                    SET sql = CONCAT(sql, """
                                                        -- Auslistung!

                                                        UNION ALL
                                                        SELECT CAST(a.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MIN(a.list_kz) AS list_kz_,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.rohertrag_hr) AS rohertrag_,
                                                                SUM(reduktion_fg) AS anzahl_reduktion,
                                                                CAST(0 AS INT64 ) AS anzahl_erweiterung,
                                                                'Auslistung' AS vorschlag_
                                                        FROM `dbp_msi_data.kl_listung_2` a
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON a.mandant_id = b.mandant_id AND
                                                            a.art_id = b.art_id AND
                                                            a.kjwo_update = b.kjwo_update
                                                        WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                                                a.listung_art = 'Auslistung' AND
                                                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord = '-' AND 
                                                                a.ost_basis = '-' AND 
                                                                a.ost_gross = '-' AND 
                                                                a.sued_ost = '-' AND 
                                                                a.sued_west = '-' AND 
                                                                a.west = '-')
                                                        GROUP BY 1
                                                        """);
                                                        
                    IF var_region_summary = 1 THEN
                        SET sql = CONCAT(sql, """
                                                        -- Regionen on top (Nielsen 1)
                                                        UNION ALL
                                                        SELECT '1' AS art_id,
                                                                'N' AS status_2,
                                                                'A' AS list_kz,
                                                                SUM(umsatz_hr) AS umsatz_,
                                                                SUM(absatz_hr) AS absatz_,
                                                                SUM(absatz_hr)*CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.'  ) AS FLOAT64) AS rohertrag_,
                                                                CAST(0 AS INT64 ) AS anzahl_reduktion,
                                                                COUNT(*) AS anzahl_erweiterung,
                                                                'Einlistung Potenzialartikel' AS vorschlag_
                                                        FROM `dbp_msi_data.nl_listung_2`
                                                        WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2`) AND
                                                                gtin =  '""" || gtin || """'  AND
                                                                listung_art = 'Einlistung Potenzialartikel' AND
                                                                kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                art_nielsen_bez =  '""" || nl_art_bez || """'  AND
                                                                sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                                                ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                                                ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                                                sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                                                sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                                                west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' )  AND
                                                                """ || CAST(var_region_summary AS STRING) || """  = 1
                                                        GROUP BY 1,2
                                                        """);
                    END IF;
                    
                    IF var_region_summary = 0 THEN
                        SET sql = CONCAT(sql, """
                                                        UNION ALL
                                                        --K-Sicht fuer Nielsen (Nielsen 1)

                                                        SELECT '1' AS art_id,
                                                                'N' AS status_2,
                                                                'A' AS list_kz,
                                                                SUM(umsatz_hr) AS umsatz_,
                                                                SUM(absatz_hr) AS absatz_,
                                                                SUM(absatz_hr)*CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64) AS rohertrag_,
                                                                CAST(0 AS INT64 ) AS anzahl_reduktion,
                                                                COUNT(*) AS anzahl_erweiterung,
                                                                'Einlistung Potenzialartikel' AS vorschlag_
                                                        FROM `dbp_msi_data.nl_listung_2`
                                                        WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2`) AND
                                                                gtin =  '""" || gtin || """'  AND
                                                                listung_art = 'Einlistung Potenzialartikel' AND
                                                                kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                art_nielsen_bez =  '""" || nl_art_bez || """'  AND
                                                                sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (nord = '-' AND
                                                                ost_basis = '-' AND
                                                                ost_gross = '-' AND
                                                                sued_ost = '-' AND
                                                                sued_west = '-' AND
                                                                west = '-') AND
                                                                """ || CAST(var_region_summary AS STRING) || """  = 0
                                                        GROUP BY 1,2
                                                        """);
                    END IF;
                    
                    IF var_region_summary = 1 THEN
                        SET sql = CONCAT(sql, """
                                                        UNION ALL
                                                        SELECT CAST(b.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MAX('A') AS list_kz,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.absatz_hr*COALESCE(CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64),c.stueck_re_mep,0)) AS rohertrag_,
                                                                CAST(0 AS INT64 ) AS anzahl_reduktion,
                                                                COUNT(*) AS anzahl_erweiterung,
                                                                'Einlistung Kauflandartikel' AS vorschlag_
                                                        FROM `dbp_msi_data.nl_listung_2` a
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON 1 = b.mandant_id AND
                                                                '""" || gtin || """'  = CAST(b.gtin_id AS STRING) AND
                                                            a.kjwo_update = b.kjwo_update
                                                        JOIN `dbp_etl.bf_sort_sal_export_2` c
                                                            ON b.art_id/100 = CAST(c.art_nr AS INT64 )
                                                        WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2` WHERE CAST(CAST(gtin_id AS INT64 ) AS STRING ) =  '""" || gtin || """' ) AND
                                                                a.listung_art = 'Listung erweitern' AND
                                                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                                                """ || CAST(var_region_summary AS STRING) || """  = 1
                                                        GROUP BY 1
                                                        """);
                    END IF;
                    
                    IF var_region_summary = 0 THEN
                        SET sql = CONCAT(sql, """
                                                        UNION ALL
                                                        SELECT CAST(b.art_id AS STRING) as art_id,
                                                                MAX(b.status_2) AS status_2,
                                                                MAX('A') AS list_kz,
                                                                SUM(a.umsatz_hr) AS umsatz_,
                                                                SUM(a.absatz_hr) AS absatz_,
                                                                SUM(a.absatz_hr*COALESCE(CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64),c.stueck_re_mep,0)) AS rohertrag_,
                                                                CAST(0 AS INT64 ) AS anzahl_reduktion,
                                                                COUNT(*) AS anzahl_erweiterung,
                                                                'Einlistung Kauflandartikel' AS vorschlag_
                                                        FROM `dbp_msi_data.nl_listung_2` a
                                                        JOIN `dbp_msi_data.sortiment_art_2` b
                                                            ON 1 = b.mandant_id AND
                                                                '""" || gtin || """'  = CAST(b.gtin_id AS STRING) AND
                                                            a.kjwo_update = b.kjwo_update
                                                        JOIN `dbp_etl.bf_sort_sal_export_2` c
                                                            ON b.art_id/100 = CAST(c.art_nr AS INT64 )
                                                        WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2` WHERE CAST(CAST(gtin_id AS INT64 ) AS STRING ) =  '""" || gtin || """' ) AND
                                                                a.listung_art = 'Listung erweitern' AND
                                                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                                            (a.nord = '-' AND
                                                                a.ost_basis = '-' AND
                                                                a.ost_gross = '-' AND
                                                                a.sued_ost = '-' AND
                                                                a.sued_west = '-' AND
                                                                a.west = '-') AND
                                                                """ || CAST(var_region_summary AS STRING) || """  = 0
                                                        GROUP BY 1
                                                        """);
                    END IF;
                    
                    SET sql = CONCAT(sql, """
                                                        -- DUMMY_2-UNION Block ICS

                                                        UNION ALL
                                                        SELECT '""" || COALESCE(var_art_id, 'NULL') || """' AS art_id,
                                                            'N' AS status_2,
                                                            'A' as list_kz,
                                                            0 AS umsatz_,
                                                            0 AS absatz_,
                                                            0 AS rohertrag_,
                                                            0 AS anzahl_reduktion,
                                                            0 AS anzahl_erweiterung,
                                                            --COUNT(*) AS anzahl_erweiterung,

                                                            CAST('dynamic' AS STRING ) AS vorschlag_
                                                            ) x
                                                        GROUP BY x.art_id 
                                                        ) x

                                 WHERE (sl.mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND CAST(sl.art_id AS STRING) =  '""" || art_id || """'  AND sl.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND sl.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64) ) OR (sl.mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND sl.gtin =  '""" || gtin || """'  AND sl.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND sl.nielsen_art_bez =  '""" || nl_art_bez || """'  AND sl.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64) );""");

                    SET sql = REPLACE(sql, """undefined""", 'NULL');
                    SET sql_stmt = sql;
                    EXECUTE IMMEDIATE sql_stmt;



--- ########## 3rd batch ################

SET sql = """UPDATE `dbp_data.sortiment_leistung_2` sl
                             SET sl.listungsaktion = z.listungsaktion
                             FROM (SELECT CASE
                                                        WHEN  """ || CAST(var_region_summary AS STRING) || """  IN (1,0)
                                                        THEN
                                                        CASE
                                                            WHEN (listung_sst_mvke = 'N/A' OR listung_sst_mvke IS NULL) AND
                                                                GREATEST(COALESCE(ost_basis,''),COALESCE(ost_gross,''),COALESCE(sued_ost,''),COALESCE(sued_west,''),COALESCE(west,''),COALESCE(nord,'')) = '' AND
                                                                anz_maerkte_sst = 0 AND anz_maerkte_baustein_sonstige = 0 AND anz_maerkte_listung_einzel = 0 AND anz_maerkte_listung_gesamt = 0
                                                            THEN 'Einlistung Kauflandartikel'
                                                            ELSE listungsaktion
                                                        END
                                                        ELSE listungsaktion
                                                        END AS listungsaktion
                                                FROM `dbp_data.sortiment_leistung_2`
                                                WHERE mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND 
                                                        art_id IS NOT NULL AND 
                                                        kjmo = CAST( '""" || kjmo || """' AS INT64)  AND 
                                                        kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                                        matching_id = CAST( '""" || matching_id || """' AS INT64) ) z
                             WHERE sl.mandant_id = 1 AND
                                   sl.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                                   sl.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                   sl.matching_id = CAST( '""" || matching_id || """' AS INT64);""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

                /*
                --------------------------------------------------------------------------------------------------------
                --   (II) INSERT FUER ERWARTETE ENTWICKLUNG (mit K-Stufen)
                --------------------------------------------------------------------------------------------------------
                */ 
                
                IF COALESCE(var_vorschlag_hr, '') NOT IN ('Keine Veränderung','Keine Veränderung setzen','Keine Veränderung zurücksetzen','Produktwissen_2','Zurücksetzen') THEN

                    SET sql = """DELETE FROM `dbp_msi_data.erwartete_entwicklung_2`
                        WHERE matching_id = CAST( '""" || matching_id || """' AS INT64)  AND
                                kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                                kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                mandant_id =  """ || CAST(mandant_id AS STRING) || """;""";

                    SET sql = REPLACE(sql, """undefined""", 'NULL');
                    SET sql_stmt = sql;
                    EXECUTE IMMEDIATE sql_stmt;

                    SET sql = """INSERT INTO `dbp_msi_data.erwartete_entwicklung_2` (mandant_id
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
                            , CAST('""" || kjmo || """' AS INT64)  AS kjmo
                            ,CAST(x.matching_id AS INT64)
                            ,x.sm_id
                            ,'' AS ksm_id
                            ,CAST( '""" || kjwo_update || """' AS INT64)  AS kjwo_update
                            ,'EUR' AS wrg_id
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
                            ,COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS umsatz
                            ,COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS absatz
                            ,CAST(COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS INT64)AS rohertrag
                        FROM (-- Nur SST gepflegt fuer Erweiterung!

                            """;

                    IF sst_only = 1 OR sst_reg_change IN (1,4) THEN
                        SET sql = CONCAT(sql, """
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Listung erweitern' AND
                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord = '-' AND 
                                a.ost_basis = '-' AND 
                                a.ost_gross = '-' AND 
                                a.sued_ost = '-' AND 
                                a.sued_west = '-' AND 
                                a.west = '-') AND
                                ( """ || CAST(sst_only AS STRING) || """  = 1 OR
                                """ || CAST(sst_reg_change AS STRING) || """  IN (1,4))
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            """);
                    END IF;

                    IF sst_only = 1 OR sst_reg_change IN (2,4) THEN
                        SET sql = CONCAT(sql, """
                            -- Nur SST gepflegt fuer Reduktion!

                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_data.wup_2` x
                            ON a.mandant_id = x.mandant_id AND
                                a.wup_id = x.wup_id
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Listung reduzieren' AND
                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                a.sm_id < CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord = '-' AND 
                                a.ost_basis = '-' AND 
                                a.ost_gross = '-' AND 
                                a.sued_ost = '-' AND 
                                a.sued_west = '-' AND 
                                a.west = '-') AND 
                                CASE
                                    WHEN  """ || CAST(sst_reg_change AS STRING) || """  = 4 AND
                                        (x.kreistyp_gruppe_id =  '""" || n_reg_char || """'   OR
                                        x.kreistyp_gruppe_id =  '""" || w_reg_char || """'   OR
                                        x.kreistyp_gruppe_id =  '""" || so_reg_char || """'  OR
                                        x.kreistyp_gruppe_id =  '""" || sw_reg_char || """'  OR
                                        x.kreistyp_gruppe_id =  '""" || ob_reg_char || """'  OR
                                        x.kreistyp_gruppe_id =  '""" || og_reg_char || """' )
                                    THEN 0
                                    ELSE 1
                                END = 1 AND
                                ( """ || CAST(sst_only AS STRING) || """  = 1 OR
                                """ || CAST(sst_reg_change AS STRING) || """  IN (2,4))
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            """);
                    END IF;

                    IF sst_reg = 1 THEN
                        SET sql = CONCAT(sql, """
                            -- SST plus Cluster fuer Erweiterung!
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_data.wup_2` x
                            ON a.mandant_id = x.mandant_id AND
                                a.wup_id = x.wup_id
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Listung erweitern' AND
                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                a.sm_id_selected = 0 AND
                                a.sm_id < CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND 
                                CASE
                                    WHEN  """ || CAST(sst_reg_change AS STRING) || """  = 4 AND
                                        a.sm_id >= CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                        (x.kreistyp_gruppe_id =  '""" || n_reg_char || """'   OR
                                        x.kreistyp_gruppe_id =  '""" || w_reg_char || """'   OR
                                        x.kreistyp_gruppe_id =  '""" || so_reg_char || """'  OR
                                        x.kreistyp_gruppe_id =  '""" || sw_reg_char || """'  OR
                                        x.kreistyp_gruppe_id =  '""" || ob_reg_char || """'  OR
                                        x.kreistyp_gruppe_id =  '""" || og_reg_char || """' )
                                    THEN 0
                                    ELSE 1
                                END = 1 AND
                                """ || CAST(sst_reg AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            """);
                    END IF;

                    IF sst_reg = 1 AND sst_reg_change != 4 THEN
                        SET sql = CONCAT(sql, """
                            -- SST plus Cluster fuer Reduktion!
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Listung reduzieren' AND
                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                a.sm_id_selected = 0 AND
                                a.sm_id < CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(sst_reg AS STRING) || """  = 1 AND
                                """ || CAST(sst_reg_change AS STRING) || """  NOT IN (4)
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            UNION ALL
                            """);
                    END IF;

                    SET sql = CONCAT(sql, """
                            -- Auslistung!

                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Auslistung' AND
                                a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord = '-' AND 
                                a.ost_basis = '-' AND 
                                a.ost_gross = '-' AND 
                                a.sued_ost = '-' AND 
                                a.sued_west = '-' AND 
                                a.west = '-')
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            -- Cluster fuer Nielsen!
                            """);

                    IF var_region_summary = 1 THEN
                        SET sql = CONCAT(sql, """
                            UNION ALL
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                sm_id,
                                nord,
                                ost_basis,
                                ost_gross,
                                sued_ost,
                                sued_west,
                                west,
                                '1' AS art_id,
                                'N' AS status_2,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64) AS rohertrag_
                            FROM `dbp_msi_data.nl_listung_2`
                            WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2`) AND
                                gtin =  '""" || gtin || """'  AND
                                listung_art = 'Einlistung Potenzialartikel' AND
                                kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                art_nielsen_bez =  '""" || nl_art_bez || """'  AND
                                sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(var_region_summary AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9,10
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                    END IF;

                    IF var_region_summary = 0 THEN
                        SET sql = CONCAT(sql, """
                            UNION ALL
                            -- SST fuer Nielsen!
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                sm_id,
                                nord,
                                ost_basis,
                                ost_gross,
                                sued_ost,
                                sued_west,
                                west,
                                '1' AS art_id,
                                'N' AS status_2,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64) AS rohertrag_
                            FROM `dbp_msi_data.nl_listung_2`
                            WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2`) AND
                                gtin =  '""" || gtin || """'  AND
                                listung_art = 'Einlistung Potenzialartikel' AND
                                kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                art_nielsen_bez =  '""" || nl_art_bez || """'  AND
                                sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (nord = '-' AND
                                ost_basis = '-' AND
                                ost_gross = '-' AND
                                sued_ost = '-' AND
                                sued_west = '-' AND
                                west = '-') AND
                                """ || CAST(var_region_summary AS STRING) || """  = 0
                            GROUP BY 1,2,3,4,5,6,7,8,9,10
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                    END IF;

                    IF var_region_summary = 1 THEN
                        SET sql = CONCAT(sql, """
                            UNION ALL
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(b.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64),c.stueck_re_mep,0)) AS rohertrag_
                            FROM `dbp_msi_data.nl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON 1 = b.mandant_id AND
                                '""" || gtin || """'  = CAST(b.gtin_id AS STRING) AND
                                a.kjwo_update = b.kjwo_update
                            JOIN `dbp_etl.bf_sort_sal_export_2` c
                            ON b.art_id/100 = CAST(c.art_nr AS INT64 )
                            WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2` WHERE CAST(CAST(gtin_id AS INT64 ) AS STRING ) =  '""" || gtin || """' ) AND
                                a.listung_art = 'Listung erweitern' AND
                                a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(var_region_summary AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                    END IF;

                    IF var_region_summary = 0 THEN
                        SET sql = CONCAT(sql, """
                            UNION ALL
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(b.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64),c.stueck_re_mep,0)) AS rohertrag_
                            FROM `dbp_msi_data.nl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON 1 = b.mandant_id AND
                                '""" || gtin || """'  = CAST(b.gtin_id AS STRING) AND
                                a.kjwo_update = b.kjwo_update
                            JOIN `dbp_etl.bf_sort_sal_export_2` c
                            ON b.art_id/100 = CAST(c.art_nr AS INT64 )
                            WHERE a.gtin IN (SELECT CAST(gtin_id AS STRING )  FROM `dbp_etl.not_listed_basis_2` WHERE CAST(CAST(gtin_id AS INT64 ) AS STRING ) =  '""" || gtin || """' ) AND
                                a.listung_art = 'Listung erweitern' AND
                                a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                a.sm_id_selected = CAST(NULLIF(TRIM('""" || COALESCE(var_listung_sst_pflege, 'NULL') || """'),'')  AS INT64 ) AND
                                (a.nord = '-' AND
                                a.ost_basis = '-' AND
                                a.ost_gross = '-' AND
                                a.sued_ost = '-' AND
                                a.sued_west = '-' AND
                                a.west = '-') AND
                                """ || CAST(var_region_summary AS STRING) || """  = 0
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                    END IF;

                    SET sql = CONCAT(sql, """
                            ) x
                        JOIN (SELECT art_matching_id,
                                MAX(kl_wg_id) AS kl_wg_id,
                                MAX(kl_owg_id) AS kl_owg_id,
                                MAX(kl_uwg_id) AS kl_uwg_id
                            FROM `dbp_etl.art_matching_nielsen_per_2`
                            GROUP BY 1) y
                        ON x.matching_id = CAST(y.art_matching_id AS STRING) 
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20;""");

                    SET sql = REPLACE(sql, """undefined""", 'NULL');
                    SET sql_stmt = sql;
                    EXECUTE IMMEDIATE sql_stmt;

                END IF; /* end if */

                SET sql = """DELETE FROM `dbp_msi_data.sortiment_art_2`
                    WHERE (mandant_id, CAST(art_id AS STRING), CAST(gtin_id AS STRING), kjwo_update) IN (SELECT (mandant_id, art_id, gtin_id, kjwo_update) from 
(
Select a.mandant_id, CAST(a.art_id AS STRING) art_id,
                                                               MAX(CAST(CAST(a.gtin_id AS INT64 ) AS STRING )) AS gtin_id,
                                                               CAST( '""" || kjwo_update || """' AS INT64)  AS kjwo_update
                                                        FROM `dbp_etl.art_matching_nielsen_per_2` a
                                                        WHERE a.art_matching_id = CAST( '""" || matching_id || """' AS INT64) 
                                                        GROUP BY 1,2));""";
                                                        
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            /*else if ((var_listung_sst_pflege == """""" || var_listung_sst_pflege == """ """ || var_listung_sst_pflege == undefined) && (var_vorschlag_hr != 'Keine Veränderung setzen' && var_vorschlag_hr != 'Zurücksetzen' && var_vorschlag_hr != 'Produktwissen_2' && var_vorschlag_hr != 'Keine Veränderung')) {*/
            ELSEIF (var_listung_sst_pflege = "" OR var_listung_sst_pflege = " " OR var_listung_sst_pflege IS NULL) AND COALESCE(var_vorschlag_hr, '') NOT IN ('Keine Veränderung setzen','Zurücksetzen','Produktwissen_2','Keine Veränderung') THEN

                SET sql = """INSERT INTO `dbp_msi_data.sortiment_art_2` (mandant_id,
                                            art_id,
                                            gtin_id,
                                            status_2,
                                            kjwo_update)
                    SELECT a.mandant_id,
                        a.art_id,
                        MAX(CAST(CAST(a.gtin_id AS INT64 ) AS STRING )) AS gtin_id,
                        MAX(status_2) AS status_2,
                       CAST( '""" || kjwo_update || """' AS INT64)  AS kjwo_update
                    FROM `dbp_etl.art_matching_nielsen_per_2` a
                    WHERE a.art_matching_id = CAST( '""" || matching_id || """' AS INT64)  AND
                            CASE
                            WHEN a.status_2 <> 'N' AND
                                a.list_kz = 'A'
                            THEN 1
                            WHEN a.status_2 = 'N'
                            THEN 1
                            ELSE 0
                            END = 1
                    GROUP BY 1,2;""";
                    
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;


--- ########## 4th Batch #############

/*
                --------------------------------------------------------------------------------------------------------
                --   (III) UPDATE FUER SORTIMENT_LEISTUNG_2 (nur Regionen)
                --------------------------------------------------------------------------------------------------------
                */
                SET sql = """UPDATE `dbp_data.sortiment_leistung_2` sl
                             SET sl.umsatz_hr = x.umsatz,
                                 sl.absatz_hr = x.absatz,
                                 sl.rohertrag_hr = CAST(x.rohertrag AS NUMERIC),
                                 sl.listungsaktion = CASE WHEN '""" || COALESCE(var_vorschlag, 'NULL') || """' = 'Auslisten' THEN 'Auslistung' ELSE x.vorschlag END
                             FROM (
                                 SELECT 
                                     SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
                                     SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
                                     REPLACE(REPLACE(
                                         MAX(
                                             IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                                                         , REPLACE(x.vorschlag_, 'dynamic', 'Dynamic')
                                                         , REPLACE(x.vorschlag_, 'dynamic', 'AAA_2')
                                                             )
                                         )
                                            , 'Dynamic', 'dynamic')
                                            , 'AAA_2', 'dynamic') AS vorschlag__, 
                                     CASE
                                         WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic')
                                         WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                         ELSE 'SOLL-Listung = IST-Listung'
                                     END AS vorschlag,
                                     CASE
                                         WHEN CASE WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung'
                                         THEN 0
                                         ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                     END AS umsatz,
                                     CASE
                                         WHEN CASE WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung'
                                         THEN 0
                                         ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                     END AS absatz,
                                     CASE
                                         WHEN CASE WHEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') <> 'dynamic' THEN REPLACE(REPLACE(MAX(IF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0, REPLACE(x.vorschlag_, 'dynamic', 'Dynamic'), REPLACE(x.vorschlag_, 'dynamic', 'AAA_2'))), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern' WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren' WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung'
                                         THEN 0
                                         ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                                     END AS rohertrag
                                 FROM (-- KL nur Regionen; Erweiterung!!!
                                 """;

                /*if(region_only == 1){ NOTE: diese Bedingung kann auch mit rein, aber wenn die parameter ungünsting sind kann es sein dass wir einen syntax fehler durch die UNION ALL kriegen. Deshalb bleibt dieser teil fürs_2 erste drin - wenn mehr Zeit_2 ist kann eine_2 Bedingung für das UNION ALL implementiert werden*/
                SET sql = CONCAT(sql, """
                                     SELECT CAST(a.art_id AS STRING) as art_id,
                                             MAX(b.status_2) AS status_2,
                                             MIN(a.list_kz) AS list_kz_,
                                             SUM(a.umsatz_hr) AS umsatz_,
                                             SUM(a.absatz_hr) AS absatz_,
                                             SUM(a.rohertrag_hr) AS rohertrag_,
                                             CAST(0 AS INT64 ) AS anzahl_reduktion,
                                             SUM(erweiterung_fg) AS anzahl_erweiterung,
                                             CASE WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN CAST('Einlistung Kauflandartikel' AS STRING ) ELSE CAST('dynamic' AS STRING ) END AS vorschlag_
                                     FROM `dbp_msi_data.kl_listung_2` a
                                     JOIN `dbp_msi_data.sortiment_art_2` b
                                     ON a.mandant_id = b.mandant_id AND
                                         a.art_id = b.art_id AND
                                         a.kjwo_update = b.kjwo_update
                                     WHERE a.art_id NOT IN (SELECT art_id FROM `dbp_etl.not_listed_basis_2`) AND
                                         a.listung_art = 'Listung erweitern' AND
                                         a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                         a.sm_id_selected = 0 AND
                                         (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                         a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                         a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                         a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                         a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                         a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                             """ || CAST(region_only AS STRING) || """  = 1
                                     GROUP BY 1
                                     """);
                /* } */

                IF region_only = 1 THEN
                    SET sql = CONCAT(sql, """
                                     UNION ALL
                                     -- KL nur Regionen; Reduktion!!!
                                     SELECT CAST(a.art_id AS STRING) as art_id,
                                             MAX(b.status_2) AS status_2,
                                             MIN(a.list_kz) AS list_kz_,
                                             SUM(a.umsatz_hr) AS umsatz_,
                                             SUM(a.absatz_hr) AS absatz_,
                                             SUM(a.rohertrag_hr) AS rohertrag_,
                                             SUM(reduktion_fg) AS anzahl_reduktion,
                                             CAST(0 AS INT64 ) AS anzahl_erweiterung,
                                             'dynamic' AS vorschlag_
                                     FROM `dbp_msi_data.kl_listung_2` a
                                     JOIN `dbp_msi_data.sortiment_art_2` b
                                     ON a.mandant_id = b.mandant_id AND
                                         a.art_id = b.art_id AND
                                         a.kjwo_update = b.kjwo_update
                                     WHERE a.art_id NOT IN (SELECT art_id FROM `dbp_etl.not_listed_basis_2`) AND
                                         a.listung_art = 'Listung reduzieren' AND
                                         a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                         a.sm_id_selected = 0 AND
                                         (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                         a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                         a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                         a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                         a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                         a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                             """ || CAST(region_only AS STRING) || """  = 1
                                     GROUP BY 1
                                     """);
                END IF;

                IF var_region_summary = 1 THEN
                    SET sql = CONCAT(sql, """
                                     --Nur Regionen fuer Nielsen (1)
                                     UNION ALL
                                     SELECT '1' AS art_id,
                                             'N' AS status_2,
                                             MAX('A') AS list_kz,
                                             SUM(umsatz_hr) AS umsatz_,
                                             SUM(absatz_hr) AS absatz_,
                                             SUM(absatz_hr)*CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64) AS rohertrag_,
                                             CAST(0 AS INT64 ) AS anzahl_reduktion,
                                             COUNT(*) AS anzahl_erweiterung,
                                             'Einlistung Potenzialartikel' AS vorschlag_
                                     FROM `dbp_msi_data.nl_listung_2`
                                     WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2`) AND
                                         gtin =  '""" || gtin || """'  AND
                                         listung_art = 'Einlistung Potenzialartikel' AND
                                         kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                         art_nielsen_bez =  '""" || nl_art_bez || """'  AND
                                         sm_id_selected = 0 AND
                                         (nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                         ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                         ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                         sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                         sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                         west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                             """ || CAST(var_region_summary AS STRING) || """  = 1
                                     GROUP BY 1,2
                                     """);
                END IF;

                IF var_region_summary = 1 THEN
                    SET sql = CONCAT(sql, """
                                     UNION ALL
                                     SELECT CAST(b.art_id AS STRING) as art_id,
                                             MAX(b.status_2) AS status_2,
                                             MAX('A') AS list_kz,
                                             SUM(a.umsatz_hr) AS umsatz_,
                                             SUM(a.absatz_hr) AS absatz_,
                                             SUM(a.absatz_hr*COALESCE(CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64),c.stueck_re_mep,0)) AS rohertrag_,
                                             CAST(0 AS INT64 ) AS anzahl_reduktion,
                                             COUNT(*) AS anzahl_erweiterung,
                                             'Einlistung Kauflandartikel' AS vorschlag_
                                     FROM `dbp_msi_data.nl_listung_2` a
                                     JOIN `dbp_msi_data.sortiment_art_2` b
                                     ON 1 = b.mandant_id AND
                                         '""" || gtin || """'  = CAST(b.gtin_id AS STRING) AND
                                         a.kjwo_update = b.kjwo_update
                                     LEFT JOIN `dbp_etl.bf_sort_sal_export_2` c
                                     ON b.art_id/100 = CAST(c.art_nr AS INT64 )
                                     WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2` WHERE CAST(CAST(gtin_id AS INT64 ) AS STRING ) =  '""" || gtin || """' ) AND
                                         a.listung_art = 'Listung erweitern' AND
                                         a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                         a.sm_id_selected = 0 AND
                                         (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                         a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                         a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                         a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                         a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                         a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                             """ || CAST(var_region_summary AS STRING) || """  = 1
                                     GROUP BY 1
                                     """);
                END IF;

                SET sql = CONCAT(sql, """
                                     ) x
                                 GROUP BY x.art_id) x
                             WHERE (CAST(sl.art_id AS STRING) =  '""" || art_id || """'  AND sl.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND sl.mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND sl.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64) ) OR 
                                   (sl.gtin =  '""" || gtin || """'  AND sl.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND sl.nielsen_art_bez =  '""" || nl_art_bez || """'  AND sl.mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND sl.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64) );""");

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

                SET sql = """UPDATE `dbp_data.sortiment_leistung_2` sl
                             SET sl.listungsaktion = z.listungsaktion
                             FROM (SELECT CASE
                                 WHEN  """ || CAST(region_only AS STRING) || """  = 1
                                 THEN
                                 CASE
                                     WHEN (listung_sst_mvke = 'N/A' OR listung_sst_mvke IS NULL) AND
                                         GREATEST(COALESCE(ost_basis,''),COALESCE(ost_gross,''),COALESCE(sued_ost,''),COALESCE(sued_west,''),COALESCE(west,''),COALESCE(nord,'')) = '' AND
                                         anz_maerkte_sst = 0 AND anz_maerkte_baustein_sonstige = 0 AND anz_maerkte_listung_einzel = 0 AND anz_maerkte_listung_gesamt = 0
                                     THEN 'Einlistung Kauflandartikel'
                                     ELSE listungsaktion
                                 END
                                 ELSE listungsaktion
                                 END AS listungsaktion
                                 FROM `dbp_data.sortiment_leistung_2`
                                 WHERE mandant_id =  """ || CAST(mandant_id AS STRING) || """  AND 
                                     art_id IS NOT NULL AND 
                                     kjmo = CAST( '""" || kjmo || """' AS INT64)  AND 
                                     kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                     matching_id = CAST( '""" || matching_id || """' AS INT64) ) z
                             WHERE sl.mandant_id = 1 AND
                                 sl.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                                 sl.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                 sl.matching_id = CAST( '""" || matching_id || """' AS INT64);""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

                /* --------------------------------------------------------------------------------------------------------
                --   (IV) INSERT FUER ERWARTETE ENTWICKLUNG (nur Regionen)
                --------------------------------------------------------------------------------------------------------
                */

                IF COALESCE(var_vorschlag_hr, '') NOT IN ('Keine Veränderung','Keine Veränderung setzen','Keine Veränderung zurücksetzen','Produktwissen_2','Zurücksetzen') THEN
                
                    SET sql = """DELETE FROM `dbp_msi_data.erwartete_entwicklung_2`
                        WHERE matching_id = CAST( '""" || matching_id || """' AS INT64)  AND
                            kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                            kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                            mandant_id =  """ || CAST(mandant_id AS STRING) || """;""";

                    SET sql = REPLACE(sql, """undefined""", 'NULL');
                    SET sql_stmt = sql;
                    EXECUTE IMMEDIATE sql_stmt;

                    SET sql = """INSERT INTO `dbp_msi_data.erwartete_entwicklung_2` (mandant_id
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
                            , CAST('""" || kjmo || """' AS INT64)  AS kjmo
                            ,CAST(x.matching_id AS INT64)
                            ,x.sm_id
                            ,'' AS ksm_id
                            ,CAST( '""" || kjwo_update || """' AS INT64)  AS kjwo_update
                            ,'EUR' AS wrg_id
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
                            ,COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS umsatz
                            ,COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS absatz
                            ,CAST(COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE CASE WHEN COUNT(DISTINCT x.art_id) = 0 THEN 1 END END,0) AS NUMERIC) AS rohertrag
                        FROM (-- KL nur Regionen; Erweiterung!!!
                            """;

                            /*auch hier: die erste abfrage kann auch noch in eine_2 if bedingung gepackt werden; kann zu problemen mit dem UNION ALL führen, deshalb optional für später*/
                            SET sql = CONCAT(sql, """
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Listung erweitern' AND
                                a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                a.sm_id_selected = 0 AND
                                (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(region_only AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            """);

                            IF region_only = 1 THEN
                            SET sql = CONCAT(sql, """
                            UNION ALL
                            -- KL nur Regionen; Reduktion!!!
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost,
                                a.sued_west,
                                a.west,
                                CAST(a.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON a.mandant_id = b.mandant_id AND
                                a.art_id = b.art_id AND
                                a.kjwo_update = b.kjwo_update
                            WHERE a.art_id NOT IN (SELECT art_id  FROM `dbp_etl.not_listed_basis_2`) AND
                                a.listung_art = 'Listung reduzieren' AND
                                a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                a.sm_id_selected = 0 AND
                                (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(region_only AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                            END IF;

                            IF var_region_summary = 1 THEN
                            SET sql = CONCAT(sql, """
                            UNION ALL
                            --Nur Regionen fuer Nielsen (1)
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                sm_id,
                                nord,
                                ost_basis,
                                ost_gross,
                                sued_ost,
                                sued_west,
                                west,
                                '1' AS art_id,
                                'N' AS status_2,
                                SUM(umsatz_hr) AS umsatz_,
                                SUM(absatz_hr) AS absatz_,
                                SUM(absatz_hr)*CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64) AS rohertrag_
                            FROM `dbp_msi_data.nl_listung_2`
                            WHERE gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2`) AND
                                gtin =  '""" || gtin || """'  AND
                                listung_art = 'Einlistung Potenzialartikel' AND
                                kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                art_nielsen_bez =  '""" || nl_art_bez || """'  AND
                                sm_id_selected = 0 AND
                                (nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(var_region_summary AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                            END IF;

                            IF var_region_summary = 1 THEN
                            SET sql = CONCAT(sql, """
                            UNION ALL
                            SELECT  '""" || matching_id || """'  AS matching_id,
                                a.sm_id,
                                a.nord,
                                a.ost_basis,
                                a.ost_gross,
                                a.sued_ost, 
                                a.sued_west,
                                a.west,
                                CAST(b.art_id AS STRING) as art_id,
                                MAX(b.status_2) AS status_2,
                                SUM(a.umsatz_hr) AS umsatz_,
                                SUM(a.absatz_hr) AS absatz_,
                                SUM(a.absatz_hr*COALESCE(CAST(REPLACE( '""" || COALESCE(var_stk_re_pflege, 'NULL') || """',',','.' ) AS FLOAT64),c.stueck_re_mep,0)) AS rohertrag_
                            FROM `dbp_msi_data.nl_listung_2` a
                            JOIN `dbp_msi_data.sortiment_art_2` b
                            ON 1 = b.mandant_id AND
                                '""" || gtin || """'  = CAST(b.gtin_id AS STRING) AND
                                a.kjwo_update = b.kjwo_update
                            LEFT JOIN `dbp_etl.bf_sort_sal_export_2` c
                            ON b.art_id/100 = CAST(c.art_nr AS INT64 )
                            WHERE a.gtin IN (SELECT CAST(CAST(gtin_id AS INT64 ) AS STRING ) FROM `dbp_etl.not_listed_basis_2` WHERE CAST(CAST(gtin_id AS INT64 ) AS STRING ) =  '""" || gtin || """' ) AND
                                a.listung_art = 'Listung erweitern' AND
                                a.kjwo_update =  CAST( '""" || COALESCE(var_kjwo_update, 'NULL') || """' AS INT64)  AND
                                a.sm_id_selected = 0 AND
                                (a.nord =  '""" || COALESCE(var_nord_pflege, 'NULL') || """'  OR 
                                a.ost_basis =  '""" || COALESCE(var_ost_basis_pflege, 'NULL') || """'  OR
                                a.ost_gross =  '""" || COALESCE(var_ost_gross_pflege, 'NULL') || """'  OR
                                a.sued_ost =  '""" || COALESCE(var_sued_ost_pflege, 'NULL') || """'  OR
                                a.sued_west =  '""" || COALESCE(var_sued_west_pflege, 'NULL') || """'  OR
                                a.west =  '""" || COALESCE(var_west_pflege, 'NULL') || """' ) AND
                                """ || CAST(var_region_summary AS STRING) || """  = 1
                            GROUP BY 1,2,3,4,5,6,7,8,9
                            HAVING ROUND(umsatz_,1) <> 0
                            """);
                            END IF;

                            SET sql = CONCAT(sql, """
                            ) x
                        JOIN (SELECT art_matching_id,
                                MAX(kl_wg_id) AS kl_wg_id,
                                MAX(kl_owg_id) AS kl_owg_id,
                                MAX(kl_uwg_id) AS kl_uwg_id
                            FROM `dbp_etl.art_matching_nielsen_per_2`
                            GROUP BY 1) y
                        ON x.matching_id = CAST(y.art_matching_id AS STRING)
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20;""");

                    SET sql = REPLACE(sql, """undefined""", 'NULL');
                    SET sql_stmt = sql;
                    EXECUTE IMMEDIATE sql_stmt;

                END IF; /* end if */

                SET sql = """DELETE FROM `dbp_msi_data.sortiment_art_2`
                    WHERE (mandant_id,CAST(art_id AS STRING),CAST(gtin_id AS STRING),kjwo_update) IN (
                        Select (mandant_id,art_id, gtin_id, kjwo_update) from(
                        SELECT a.mandant_id,
                                                                    CAST(a.art_id AS STRING)as art_id,
                                                                    MAX(CAST(CAST(a.gtin_id AS INT64 ) AS STRING )) AS gtin_id,
                                                                       CAST( '""" || kjwo_update || """' AS INT64)  AS kjwo_update
                                                                FROM `dbp_etl.art_matching_nielsen_per_2` a
                                                                WHERE a.art_matching_id = CAST( '""" || matching_id || """' AS INT64) 
                                                                GROUP BY 1,2));""";
                                                                
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt;

            END IF; /* end if */
        END IF; /* end if */

        IF var_vorschlag = 'Zurücksetzen' THEN

            SET sql = """DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_2`
                WHERE kjmo = CAST( '""" || kjmo || """' AS INT64)  AND 
                        kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                        art_matching_id = CAST( '""" || matching_id || """' AS INT64)  AND
                        mandant_id = 1;""";
                        
            SET sql = REPLACE(sql, """undefined""", 'NULL');
            SET sql_stmt = sql;
            EXECUTE IMMEDIATE sql_stmt;

            SET sql = """INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_2`
                SELECT *
                FROM `dbp_data.art_kl_preislage_zu_per_2`
                WHERE kjmo = CAST( '""" || kjmo || """' AS INT64)  AND 
                        kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                        art_matching_id = CAST( '""" || matching_id || """' AS INT64)  AND
                        mandant_id = 1;""";
                        
            SET sql = REPLACE(sql, """undefined""", 'NULL');
            SET sql_stmt = sql;
            EXECUTE IMMEDIATE sql_stmt;
            


----  ######## 5th Batch ##########

ELSE

            SET sql = """SELECT COUNT(*)
                        FROM `dbp_data.sortiment_leistung_2` a
                        INNER JOIN `dbp_data.art_kl_preislage_zu_per_neu_2` c
                          ON a.mandant_id = c.mandant_id AND
                             a.kjmo = c.kjmo AND
                             a.matching_id = c.art_matching_id AND
                             a.listung_sst_mvke = c.sm_id AND
                             a.kjwo_update = c.kjwo_update
                        WHERE a.kjmo = CAST('""" || kjmo || """' AS INT64)  AND
                              a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                              a.umsatz_hr IS NOT NULL AND
                              a.listung_sst_pflege NOT IN ('N/A') AND
                              a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND 
                                (a.mandant_id,a.matching_id,a.kjmo,a.kjwo_update) NOT IN (SELECT (mandant_id,art_matching_id,kjmo,kjwo_update)  
                                                                                           FROM `dbp_data.art_kl_preislage_zu_per_neu_2` 
                                                                                           WHERE sm_id NOT IN ('N/A','-1'))""";

            SET sql = REPLACE(sql, """undefined""", 'NULL');
            SET sql_stmt = sql;
            EXECUTE IMMEDIATE sql_stmt INTO result;

            IF result > 0 THEN 
                SET sql = """INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_2` (mandant_id
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
                        'EUR' AS wrg_id,
                        TRIM(CAST(b.k AS STRING )) AS sm_id,
                        '' AS ksm_id,
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
                    FROM `dbp_data.sortiment_leistung_2` a
                    JOIN `dbp_data.art_kl_preislage_zu_per_neu_2` c
                    ON a.mandant_id = c.mandant_id AND 
                        a.kjmo = c.kjmo AND 
                        a.matching_id = c.art_matching_id AND 
                        a.listung_sst_mvke = c.sm_id AND
                        a.kjwo_update = c.kjwo_update
                    JOIN (SELECT wtag_id AS k
                        FROM `dbp_data.tag_2`
                         WHERE wtag_id BETWEEN 1 AND 5
                         GROUP BY 1) b
                    ON CAST(a.listung_sst_pflege AS INT64 ) <= b.k AND 
                        b.k < CASE WHEN a.listung_sst_mvke = 'N/A' THEN 6 ELSE CAST(a.listung_sst_mvke AS INT64 ) END
                    WHERE a.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                        a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                        a.umsatz_hr IS NOT NULL AND
                        a.listung_sst_pflege NOT IN ('N/A') AND
                        a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND 
                        (a.mandant_id,a.matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT               ( mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT64 ),kjwo_update )
                    FROM `dbp_data.art_kl_preislage_zu_per_neu_2`
                    WHERE sm_id NOT IN ('N/A','-1'));""";

                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt; 
            END IF;

            SET sql = """DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_2`
                        WHERE (mandant_id,art_matching_id,kjmo,sm_id,kjwo_update) IN (SELECT (a.mandant_id,a.matching_id,a.kjmo,CAST(b.k AS STRING ),a.kjwo_update)
                            FROM `dbp_data.sortiment_leistung_2` a
                            JOIN (SELECT wtag_id AS k
                                    FROM `dbp_data.tag_2`
                                    WHERE wtag_id BETWEEN 1 AND 5
                                    GROUP BY 1) b
                                ON CAST(NULLIF(TRIM(a.listung_sst_pflege),'') AS INT64 ) > b.k AND
                                b.k <= CASE WHEN a.listung_sst_mvke = 'N/A' THEN 6 ELSE CAST(a.listung_sst_mvke AS INT64 ) END
                            WHERE a.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                                    a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                                    a.umsatz_hr IS NOT NULL AND
                                    a.listung_sst_pflege NOT IN ('N/A') AND
                                    a.listungsaktion IN ('Listung reduzieren','Listung reduzieren und erweitern','Listung erweitern und reduzieren'));""";

            SET sql = REPLACE(sql, """undefined""", 'NULL');
            SET sql_stmt = sql;
            EXECUTE IMMEDIATE sql_stmt; 

            -- Check if SQL needs to be executed
            SET sql = """SELECT COUNT(*)
                        FROM `dbp_data.sortiment_leistung_2` a
                        INNER JOIN `dbp_data.art_nielsen_preislage_zu_per_2` c
                          ON a.mandant_id = c.mandant_id AND
                             a.kjmo = c.kjmo AND
                             a.matching_id = c.art_matching_id AND
                             a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64) 
                        WHERE a.kjmo = CAST('""" || kjmo || """' AS INT64)  AND
                              a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                              a.umsatz_hr IS NOT NULL AND
                              a.listung_sst_pflege NOT IN ('N/A') AND
                              a.listungsaktion IN ('Einlistung Potenzialartikel','Einlistung Kauflandartikel') AND 
                                (a.mandant_id,a.matching_id,a.kjmo,a.kjwo_update) NOT IN (SELECT (mandant_id,art_matching_id,kjmo,kjwo_update)  
                                                                                           FROM `dbp_data.art_kl_preislage_zu_per_neu_2` 
                                                                                           WHERE sm_id NOT IN ('N/A','-1'))""";

            SET sql = REPLACE(sql, """undefined""", 'NULL'); 
            SET sql_stmt = sql; 
            EXECUTE IMMEDIATE sql_stmt INTO result;

            IF result > 0 THEN 
                SET sql = """INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_2` (mandant_id
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
                        'EUR' AS wrg_id,
                        TRIM(CAST(b.k AS STRING )) AS sm_id,
                        '' AS ksm_id,
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
                    FROM `dbp_data.sortiment_leistung_2` a
                    JOIN `dbp_data.art_nielsen_preislage_zu_per_2` c
                    ON a.mandant_id = c.mandant_id AND
                        a.kjmo = c.kjmo AND
                                    a.matching_id = c.art_matching_id AND
                                    a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64) 
                    JOIN (SELECT wtag_id AS k
                        FROM `dbp_data.tag_2`
                                                WHERE wtag_id BETWEEN 1 AND 5
                                                GROUP BY 1) b
                    ON CAST(NULLIF(TRIM(a.listung_sst_pflege),'') AS INT64 ) <= b.k
                    WHERE a.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND
                        a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                        a.umsatz_hr IS NOT NULL AND 
                        a.listung_sst_pflege NOT IN ('N/A') AND 
                        a.listungsaktion IN ('Einlistung Potenzialartikel','Einlistung Kauflandartikel') AND 
                        (a.mandant_id,a.matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT               ( mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT64 ),kjwo_update )
                            FROM `dbp_data.art_kl_preislage_zu_per_neu_2`
                            WHERE sm_id NOT IN ('N/A','-1'));""";
                            
                SET sql = REPLACE(sql, """undefined""", 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE sql_stmt; 
            END IF;

            SET sql = """DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_2`
                WHERE (mandant_id, art_matching_id, kjmo, kjwo_update) IN (SELECT (a.mandant_id, a.matching_id, a.kjmo, a.kjwo_update)
                    FROM `dbp_data.sortiment_leistung_2` a
                    WHERE a.kjmo = CAST( '""" || kjmo || """' AS INT64)  AND 
                            a.kjwo_update = CAST( '""" || kjwo_update || """' AS INT64)  AND
                            a.umsatz_hr IS NOT NULL AND 
                            a.listungsaktion = 'Auslistung');""";
                            
            SET sql = REPLACE(sql, """undefined""", 'NULL');
            SET sql_stmt = sql;
            EXECUTE IMMEDIATE sql_stmt; 

        END IF; /*END IF; --Zuruecksetzen bei Preislage*/

    END IF; /*END IF; --GTIN (-9999)*/

END IF; /*END IF; --keine Pflege*/

-- SET OUT_PARAM = 'Success';

END;


