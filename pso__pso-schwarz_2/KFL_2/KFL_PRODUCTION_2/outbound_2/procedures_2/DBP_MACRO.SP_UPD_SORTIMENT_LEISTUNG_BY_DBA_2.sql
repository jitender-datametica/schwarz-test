CREATE OR REPLACE PROCEDURE dbp_macro.sp_upd_sortiment_leistung_by_dba(matching_id string, art_id string, gtin string, stk_re_pflege string, vorschlag string, produktwissen_pflege string, lieferantenwissen_pflege string, listung_sst_pflege string, ost_basis_pflege string, ost_gross_pflege string, sued_ost_pflege string, sued_west_pflege string, west_pflege string, nord_pflege string, kjmo string, n_k_artikel string, nl_art_bez string, kjwo_update string, out out_param string)
  BEGIN


DECLARE res ARRAY<JSON>;
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE iterator_res INT64 DEFAULT -1;

DECLARE sql STRING;
DECLARE sql_stmt STRING;
DECLARE var_matching_id     INT64;
DECLARE var_art_id     INT64;
DECLARE var_gtin     STRING  ;
DECLARE var_stk_re_pflege     STRING  ;
DECLARE var_vorschlag     STRING  ;
DECLARE var_vorschlag_hr     STRING  ;
DECLARE var_produktwissen_pflege     STRING  ;
DECLARE var_lieferantenwissen_pflege     STRING  ;
DECLARE var_listung_sst_pflege     STRING  ;
DECLARE var_ost_basis_pflege     STRING  ;
DECLARE var_ost_gross_pflege     STRING  ;
DECLARE var_sued_ost_pflege     STRING  ;
DECLARE var_sued_west_pflege     STRING  ;
DECLARE var_west_pflege     STRING  ;
DECLARE var_nord_pflege     STRING  ;
DECLARE var_kjmo     STRING;
DECLARE var_n_k_artikel     STRING;
DECLARE var_nl_art_bez     STRING  ;
DECLARE var_region_summary     INT64;
DECLARE var_region_summary2     INT64;
DECLARE var_kjwo_update     STRING;
DECLARE mandant_id     INT64;
DECLARE var_sst_tool_fg     INT64 ;
DECLARE var_ob_tool_fg     INT64 ;
DECLARE var_og_tool_fg     INT64 ;
DECLARE var_so_tool_fg     INT64 ;
DECLARE var_sw_tool_fg     INT64 ;
DECLARE var_w_tool_fg      INT64 ;
DECLARE var_n_tool_fg      INT64 ;
DECLARE region_only      INT64 ;
DECLARE sst_only      INT64 ;
DECLARE sst_reg      INT64 ;
DECLARE sst_reg_change     INT64 ;
DECLARE ob_reg_char     STRING  ;
DECLARE og_reg_char     STRING  ;
DECLARE so_reg_char     STRING  ;
DECLARE sw_reg_char     STRING  ;
DECLARE n_reg_char     STRING  ;
DECLARE w_reg_char     STRING  ; 
SET mandant_id = 1;
SET var_matching_id = CAST(MATCHING_ID AS INT64);
SET var_art_id= CAST(ART_ID AS INT64);
SET var_gtin = GTIN;

IF STK_RE_PFLEGE <> '' THEN
    BEGIN
    SET var_stk_re_pflege  =  STK_RE_PFLEGE;
    END;
ELSE
    BEGIN
    SET var_stk_re_pflege  =  null    ;
    END;
END IF;

IF VORSCHLAG <> '' THEN
    BEGIN
    SET var_VORSCHLAG  =  VORSCHLAG;
    END;
ELSE
    BEGIN
    SET var_VORSCHLAG  =  null    ;
    END;
END IF;


IF VORSCHLAG <> '' THEN
    BEGIN
    SET var_vorschlag_hr  =  VORSCHLAG;
    END;
ELSE
    BEGIN
    SET var_vorschlag_hr  =  null    ;
    END;
END IF;


SET var_produktwissen_pflege = PRODUKTWISSEN_PFLEGE;
SET var_lieferantenwissen_pflege = LIEFERANTENWISSEN_PFLEGE;
SET var_listung_sst_pflege =  LISTUNG_SST_PFLEGE  ;

IF CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(WEST_PFLEGE AS FLOAT64) = 0 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 THEN
    BEGIN
    SET var_region_summary  =  0;
    END;
ELSE
    BEGIN
    SET var_region_summary  =  1;
    END;
END IF;

/*----------------------------------------------------
 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A; 5 = SST gesetzt bei ausschließlicher Clusterpflege
--SET var_sst_tool_fg*/


SET sql = '''SELECT * FROM dbp_msi_data.dba_cross_2 WHERE mandant_id = 1  AND matching_id = ''' ||MATCHING_ID || ''' AND kjwo_update = ''' ||KJWO_UPDATE ;
SET sql_stmt  =  sql;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""", '',sql_stmt) INTO res;

WHILE (iterator_res < ARRAY_LENGTH(res)) DO
BEGIN

SET var_sst_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[3]') AS INT64) ;
SET var_w_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[4]') AS INT64);
SET var_n_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[5]') AS INT64);
SET var_ob_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[6]') AS INT64);
SET var_og_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[7]') AS INT64);
SET var_so_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[8]') AS INT64);
SET var_sw_tool_fg = CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[9]') AS INT64);

SET iterator_res = iterator_res + 1 ;
END;
END WHILE;


IF CAST(OST_BASIS_PFLEGE AS FLOAT64) = 1 OR CAST(OST_GROSS_PFLEGE AS FLOAT64) = 1 OR CAST(SUED_OST_PFLEGE AS FLOAT64) = 1 OR CAST(SUED_WEST_PFLEGE AS FLOAT64) = 1 OR CAST(NORD_PFLEGE AS FLOAT64) = 1 AND var_listung_sst_pflege IS NULL OR var_listung_sst_pflege = '' THEN
    BEGIN
    SET var_region_summary2  =  1;
    END;
ELSE
    BEGIN
    SET var_region_summary2  =  0;
    END;
END IF;

/*--- Die alles entscheidende Weiche, welcher Zweig zu waehlen ist!*/


IF LISTUNG_SST_PFLEGE IS NULL OR LISTUNG_SST_PFLEGE = '' OR LISTUNG_SST_PFLEGE = ' ' THEN
    BEGIN
    SET region_only  =  1;
    END;
ELSE
    BEGIN
    SET region_only  =  0;
    END;
END IF;


IF LISTUNG_SST_PFLEGE IS NOT NULL AND LISTUNG_SST_PFLEGE <> '' AND LISTUNG_SST_PFLEGE <> ' ' AND CAST(var_region_summary AS FLOAT64) = 0 THEN
    BEGIN
    SET sst_only  =  1;
    END;
ELSE
    BEGIN
    SET sst_only  =  0;
    END;
END IF;


IF LISTUNG_SST_PFLEGE IS NOT NULL AND LISTUNG_SST_PFLEGE <> '' AND LISTUNG_SST_PFLEGE <> ' ' AND CAST(var_region_summary AS FLOAT64) = 1 THEN
    BEGIN
    SET sst_reg  =  1;
    END;
ELSE
    BEGIN
    SET sst_reg  =  0;
    END;
END IF;

/*--------------------------------------*/

/*-- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A*/

IF sst_reg = 1 AND CAST(var_sst_tool_fg AS FLOAT64) = 1 THEN
    BEGIN
    SET sst_reg_change  =  1;
    END;
ELSE
    BEGIN

    IF sst_reg = 1 AND CAST(var_sst_tool_fg AS FLOAT64) = 2 THEN
        BEGIN
        SET sst_reg_change  =  2;
        END;
    ELSE
        BEGIN

        IF sst_reg = 1 AND CAST(var_sst_tool_fg AS FLOAT64) = 3 THEN
            BEGIN
            SET sst_reg_change  =  3;
            END;
        ELSE
            BEGIN

            IF sst_reg = 1 AND CAST(var_sst_tool_fg AS FLOAT64) = 4 THEN
                BEGIN
                SET sst_reg_change  =  4;
                END;
            ELSE
                BEGIN
                SET sst_reg_change  =  0;
                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;

/*--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---*/

IF CAST(NORD_PFLEGE AS FLOAT64) = 1 THEN
    BEGIN
    SET n_reg_char  =  'N';
    END;
ELSE
    BEGIN
    SET n_reg_char  =  ' ';
    END;
END IF;


IF CAST(WEST_PFLEGE AS FLOAT64) = 1 THEN
    BEGIN
    SET w_reg_char  =  'W';
    END;
ELSE
    BEGIN
    SET w_reg_char  =  ' ';
    END;
END IF;


IF CAST(OST_BASIS_PFLEGE AS FLOAT64) = 1 THEN
    BEGIN
    SET ob_reg_char  =  'O';
    END;
ELSE
    BEGIN
    SET ob_reg_char  =  ' ';
    END;
END IF;


IF CAST(OST_GROSS_PFLEGE AS FLOAT64) = 1 THEN
    BEGIN
    SET og_reg_char  =  'Q';
    END;
ELSE
    BEGIN
    SET og_reg_char  =  ' ';
    END;
END IF;


IF CAST(SUED_OST_PFLEGE AS FLOAT64) = 1 THEN
    BEGIN
    SET so_reg_char  =  'G';
    END;
ELSE
    BEGIN
    SET so_reg_char  =  ' ';
    END;
END IF;


IF CAST(SUED_WEST_PFLEGE AS FLOAT64) = 1 THEN
    BEGIN
    SET sw_reg_char  =  'M';
    END;
ELSE
    BEGIN
    SET sw_reg_char  =  ' ';
    END;
END IF;


IF region_only = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 1 AND CAST(var_ob_tool_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET var_ost_basis_pflege  =  'x';
    END;
ELSE
    BEGIN

    IF region_only = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 1 AND CAST(var_ob_tool_fg AS FLOAT64) = 1 THEN
        BEGIN
        SET var_ost_basis_pflege  =  ' ';
        END;
    ELSE
        BEGIN

        IF region_only = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(var_ob_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) = 5 THEN
            BEGIN
            SET var_ost_basis_pflege  =  'u';
            END;
        ELSE
            BEGIN

            IF region_only = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(var_ob_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) <> 5 THEN
                BEGIN
                SET var_ost_basis_pflege  =  ' ';
                END;
            ELSE
                BEGIN

                IF region_only = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(var_ob_tool_fg AS FLOAT64) = 0 THEN
                    BEGIN
                    SET var_ost_basis_pflege  =  ' ';
                    END;
                ELSE
                    BEGIN

                    IF region_only = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(var_ob_tool_fg AS FLOAT64) = 1 THEN
                        BEGIN
                        SET var_ost_basis_pflege  =  'u';
                        END;
                    ELSE
                        BEGIN

                        IF sst_reg = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(var_ob_tool_fg AS FLOAT64) = 0 THEN
                            BEGIN
                            SET var_ost_basis_pflege  =  ' ';
                            END;
                        ELSE
                            BEGIN

                            IF sst_reg = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 0 AND CAST(var_ob_tool_fg AS FLOAT64) = 1 THEN
                                BEGIN
                                SET var_ost_basis_pflege  =  'u';
                                END;
                            ELSE
                                BEGIN

                                IF sst_reg = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 1 AND CAST(var_ob_tool_fg AS FLOAT64) = 0 THEN
                                    BEGIN
                                    SET var_ost_basis_pflege  =  'x';
                                    END;
                                ELSE
                                    BEGIN

                                    IF sst_reg = 1 AND CAST(OST_BASIS_PFLEGE AS FLOAT64) = 1 AND CAST(var_ob_tool_fg AS FLOAT64) = 1 THEN
                                        BEGIN
                                        SET var_ost_basis_pflege  =  ' ';
                                        END;
                                    ELSE
                                        BEGIN
                                        SET var_ost_basis_pflege  =  ' ';
                                        END;
                                    END IF;

                                    END;
                                END IF;

                                END;
                            END IF;

                            END;
                        END IF;

                        END;
                    END IF;

                    END;
                END IF;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;


IF region_only = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 1 AND CAST(var_og_tool_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET var_ost_gross_pflege  =  'x';
    END;
ELSE
    BEGIN

    IF region_only = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 1 AND CAST(var_og_tool_fg AS FLOAT64) = 1 THEN
        BEGIN
        SET var_ost_gross_pflege  =  ' ';
        END;
    ELSE
        BEGIN

        IF region_only = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(var_og_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) = 5 THEN
            BEGIN
            SET var_ost_gross_pflege  =  'u';
            END;
        ELSE
            BEGIN

            IF region_only = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(var_og_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) <> 5 THEN
                BEGIN
                SET var_ost_gross_pflege  =  ' ';
                END;
            ELSE
                BEGIN

                IF region_only = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(var_og_tool_fg AS FLOAT64) = 0 THEN
                    BEGIN
                    SET var_ost_gross_pflege  =  ' ';
                    END;
                ELSE
                    BEGIN

                    IF region_only = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(var_og_tool_fg AS FLOAT64) = 1 THEN
                        BEGIN
                        SET var_ost_gross_pflege  =  'u';
                        END;
                    ELSE
                        BEGIN

                        IF sst_reg = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(var_og_tool_fg AS FLOAT64) = 0 THEN
                            BEGIN
                            SET var_ost_gross_pflege  =  ' ';
                            END;
                        ELSE
                            BEGIN

                            IF sst_reg = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 0 AND CAST(var_og_tool_fg AS FLOAT64) = 1 THEN
                                BEGIN
                                SET var_ost_gross_pflege  =  'u';
                                END;
                            ELSE
                                BEGIN

                                IF sst_reg = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 1 AND CAST(var_og_tool_fg AS FLOAT64) = 0 THEN
                                    BEGIN
                                    SET var_ost_gross_pflege  =  'x';
                                    END;
                                ELSE
                                    BEGIN

                                    IF sst_reg = 1 AND CAST(OST_GROSS_PFLEGE AS FLOAT64) = 1 AND CAST(var_og_tool_fg AS FLOAT64) = 1 THEN
                                        BEGIN
                                        SET var_ost_gross_pflege  =  ' ';
                                        END;
                                    ELSE
                                        BEGIN
                                        SET var_ost_gross_pflege  =  ' ';
                                        END;
                                    END IF;

                                    END;
                                END IF;

                                END;
                            END IF;

                            END;
                        END IF;

                        END;
                    END IF;

                    END;
                END IF;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;


IF region_only = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 1 AND CAST(var_so_tool_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET var_sued_ost_pflege  =  'x';
    END;
ELSE
    BEGIN

    IF region_only = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 1 AND CAST(var_so_tool_fg AS FLOAT64) = 1 THEN
        BEGIN
        SET var_sued_ost_pflege  =  ' ';
        END;
    ELSE
        BEGIN

        IF region_only = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(var_so_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) = 5 THEN
            BEGIN
            SET var_sued_ost_pflege  =  'u';
            END;
        ELSE
            BEGIN

            IF region_only = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(var_so_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) <> 5 THEN
                BEGIN
                SET var_sued_ost_pflege  =  ' ';
                END;
            ELSE
                BEGIN

                IF region_only = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(var_so_tool_fg AS FLOAT64) = 0 THEN
                    BEGIN
                    SET var_sued_ost_pflege  =  ' ';
                    END;
                ELSE
                    BEGIN

                    IF region_only = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(var_so_tool_fg AS FLOAT64) = 1 THEN
                        BEGIN
                        SET var_sued_ost_pflege  =  'u';
                        END;
                    ELSE
                        BEGIN

                        IF sst_reg = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(var_so_tool_fg AS FLOAT64) = 0 THEN
                            BEGIN
                            SET var_sued_ost_pflege  =  ' ';
                            END;
                        ELSE
                            BEGIN

                            IF sst_reg = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 0 AND CAST(var_so_tool_fg AS FLOAT64) = 1 THEN
                                BEGIN
                                SET var_sued_ost_pflege  =  'u';
                                END;
                            ELSE
                                BEGIN

                                IF sst_reg = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 1 AND CAST(var_so_tool_fg AS FLOAT64) = 0 THEN
                                    BEGIN
                                    SET var_sued_ost_pflege  =  'x';
                                    END;
                                ELSE
                                    BEGIN

                                    IF sst_reg = 1 AND CAST(SUED_OST_PFLEGE AS FLOAT64) = 1 AND CAST(var_so_tool_fg AS FLOAT64) = 1 THEN
                                        BEGIN
                                        SET var_sued_ost_pflege  =  ' ';
                                        END;
                                    ELSE
                                        BEGIN
                                        SET var_sued_ost_pflege  =  ' ';
                                        END;
                                    END IF;

                                    END;
                                END IF;

                                END;
                            END IF;

                            END;
                        END IF;

                        END;
                    END IF;

                    END;
                END IF;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;


IF region_only = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_sw_tool_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET var_sued_west_pflege  =  'x';
    END;
ELSE
    BEGIN

    IF region_only = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_sw_tool_fg AS FLOAT64) = 1 THEN
        BEGIN
        SET var_sued_west_pflege  =  ' ';
        END;
    ELSE
        BEGIN

        IF region_only = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_sw_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) = 5 THEN
            BEGIN
            SET var_sued_west_pflege  =  'u';
            END;
        ELSE
            BEGIN

            IF region_only = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_sw_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) <> 5 THEN
                BEGIN
                SET var_sued_west_pflege  =  ' ';
                END;
            ELSE
                BEGIN

                IF region_only = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_sw_tool_fg AS FLOAT64) = 0 THEN
                    BEGIN
                    SET var_sued_west_pflege  =  ' ';
                    END;
                ELSE
                    BEGIN

                    IF region_only = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_sw_tool_fg AS FLOAT64) = 1 THEN
                        BEGIN
                        SET var_sued_west_pflege  =  'u';
                        END;
                    ELSE
                        BEGIN

                        IF sst_reg = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_sw_tool_fg AS FLOAT64) = 0 THEN
                            BEGIN
                            SET var_sued_west_pflege  =  ' ';
                            END;
                        ELSE
                            BEGIN

                            IF sst_reg = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_sw_tool_fg AS FLOAT64) = 1 THEN
                                BEGIN
                                SET var_sued_west_pflege  =  'u';
                                END;
                            ELSE
                                BEGIN

                                IF sst_reg = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_sw_tool_fg AS FLOAT64) = 0 THEN
                                    BEGIN
                                    SET var_sued_west_pflege  =  'x';
                                    END;
                                ELSE
                                    BEGIN

                                    IF sst_reg = 1 AND CAST(SUED_WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_sw_tool_fg AS FLOAT64) = 1 THEN
                                        BEGIN
                                        SET var_sued_west_pflege  =  ' ';
                                        END;
                                    ELSE
                                        BEGIN
                                        SET var_sued_west_pflege  =  ' ';
                                        END;
                                    END IF;

                                    END;
                                END IF;

                                END;
                            END IF;

                            END;
                        END IF;

                        END;
                    END IF;

                    END;
                END IF;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;


IF region_only = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_w_tool_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET var_west_pflege  =  'x';
    END;
ELSE
    BEGIN

    IF region_only = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_w_tool_fg AS FLOAT64) = 1 THEN
        BEGIN
        SET var_west_pflege  =  ' ';
        END;
    ELSE
        BEGIN

        IF region_only = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_w_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) = 5 THEN
            BEGIN
            SET var_west_pflege  =  'u';
            END;
        ELSE
            BEGIN

            IF region_only = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_w_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) <> 5 THEN
                BEGIN
                SET var_west_pflege  =  ' ';
                END;
            ELSE
                BEGIN

                IF region_only = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_w_tool_fg AS FLOAT64) = 1 THEN
                    BEGIN
                    SET var_west_pflege  =  'u';
                    END;
                ELSE
                    BEGIN

                    IF sst_reg = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_w_tool_fg AS FLOAT64) = 0 THEN
                        BEGIN
                        SET var_west_pflege  =  ' ';
                        END;
                    ELSE
                        BEGIN

                        IF sst_reg = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 0 AND CAST(var_w_tool_fg AS FLOAT64) = 1 THEN
                            BEGIN
                            SET var_west_pflege  =  'u';
                            END;
                        ELSE
                            BEGIN

                            IF sst_reg = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_w_tool_fg AS FLOAT64) = 0 THEN
                                BEGIN
                                SET var_west_pflege  =  'x';
                                END;
                            ELSE
                                BEGIN

                                IF sst_reg = 1 AND CAST(WEST_PFLEGE AS FLOAT64) = 1 AND CAST(var_w_tool_fg AS FLOAT64) = 1 THEN
                                    BEGIN
                                    SET var_west_pflege  =  ' ';
                                    END;
                                ELSE
                                    BEGIN
                                    SET var_west_pflege  =  ' ';
                                    END;
                                END IF;

                                END;
                            END IF;

                            END;
                        END IF;

                        END;
                    END IF;

                    END;
                END IF;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;


IF region_only = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 1 AND CAST(var_n_tool_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET var_nord_pflege  =  'x';
    END;
ELSE
    BEGIN

    IF region_only = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 1 AND CAST(var_n_tool_fg AS FLOAT64) = 1 THEN
        BEGIN
        SET var_nord_pflege  =  ' ';
        END;
    ELSE
        BEGIN

        IF region_only = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 AND CAST(var_n_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) = 5 THEN
            BEGIN
            SET var_nord_pflege  =  'u';
            END;
        ELSE
            BEGIN

            IF region_only = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 AND CAST(var_n_tool_fg AS FLOAT64) = 0 AND CAST(var_sst_tool_fg AS FLOAT64) <> 5 THEN
                BEGIN
                SET var_nord_pflege  =  ' ';
                END;
            ELSE
                BEGIN

                IF region_only = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 AND CAST(var_n_tool_fg AS FLOAT64) = 0 THEN
                    BEGIN
                    SET var_nord_pflege  =  ' ';
                    END;
                ELSE
                    BEGIN

                    IF region_only = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 AND CAST(var_n_tool_fg AS FLOAT64) = 1 THEN
                        BEGIN
                        SET var_nord_pflege  =  'u';
                        END;
                    ELSE
                        BEGIN

                        IF sst_reg = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 AND CAST(var_n_tool_fg AS FLOAT64) = 0 THEN
                            BEGIN
                            SET var_nord_pflege  =  ' ';
                            END;
                        ELSE
                            BEGIN

                            IF sst_reg = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 0 AND CAST(var_n_tool_fg AS FLOAT64) = 1 THEN
                                BEGIN
                                SET var_nord_pflege  =  'u';
                                END;
                            ELSE
                                BEGIN

                                IF sst_reg = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 1 AND CAST(var_n_tool_fg AS FLOAT64) = 0 THEN
                                    BEGIN
                                    SET var_nord_pflege  =  'x';
                                    END;
                                ELSE
                                    BEGIN

                                    IF sst_reg = 1 AND CAST(NORD_PFLEGE AS FLOAT64) = 1 AND CAST(var_n_tool_fg AS FLOAT64) = 1 THEN
                                        BEGIN
                                        SET var_nord_pflege  =  ' ';
                                        END;
                                    ELSE
                                        BEGIN
                                        SET var_nord_pflege  =  ' ';
                                        END;
                                    END IF;

                                    END;
                                END IF;

                                END;
                            END IF;

                            END;
                        END IF;

                        END;
                    END IF;

                    END;
                END IF;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;


SET var_kjmo = KJMO ;
SET var_n_k_artikel = N_K_ARTIKEL;
SET var_nl_art_bez = NL_ART_BEZ;
SET var_kjwo_update = KJWO_UPDATE;

IF CAST(var_region_summary AS FLOAT64) = 0 AND var_listung_sst_pflege IS NULL OR var_listung_sst_pflege = '' AND var_produktwissen_pflege IS NULL OR var_produktwissen_pflege = '' AND var_lieferantenwissen_pflege IS NULL OR var_lieferantenwissen_pflege = '' AND var_vorschlag = '' OR var_vorschlag IS NULL
 THEN
    BEGIN
    SET var_nl_art_bez  =  NL_ART_BEZ;
    END;
ELSE


BEGIN


IF var_gtin IS NULL OR var_gtin NOT IN ('-9999', '-9998') 
THEN

BEGIN
  IF var_vorschlag = 'Zurücksetzen'
  THEN

    BEGIN
      SET sql = '''UPDATE dbp_data.sortiment_leistung_2
                              SET
                                stk_re_pflege = NULL,
                                listungsaktion = NULL,
                                produktwissen_pflege = NULL,
                                lieferantenwissen_pflege = NULL,
                                listung_sst_pflege = NULL,
                                ost_basis_pflege = ' ',
                                ost_gross_pflege = ' ',
                                sued_ost_pflege = ' ',
                                sued_west_pflege = ' ',
                                west_pflege = ' ',
                                nord_pflege = ' ',
                                umsatz_hr = NULL,
                                absatz_hr = NULL,
                                rohertrag_hr = NULL
                              WHERE
                                matching_id =  ''' || matching_id || '''
                                and kjmo =  ''' || kjmo || '''
                                and mandant_id =  ''' || mandant_id || '''
                                and kjwo_update =  ''' || kjwo_update || ''';''' ;

                        SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');  
                        SET sql_stmt = sql;
                             

                        EXECUTE IMMEDIATE (sql_stmt);

                        SET sql = '''DELETE FROM dbp_msi_data.erwartete_entwicklung_2
                                          WHERE matching_id = ''' ||MATCHING_ID || ''' AND kjmo =  ''' || KJMO || ''' AND
                                                  kjwo_update =  ''' || KJWO_UPDATE || ''' AND
                                                  mandant_id =  ''' || mandant_id || ''';''';
    END;

/* END IF (var_vorschlag == 'Zurücksetzen') */

    ELSEIF var_vorschlag = 'Keine Veränderung setzen'
    THEN 
    BEGIN
        SET sql ='''UPDATE dbp_data.sortiment_leistung_2
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
                WHERE matching_id =  ''' || matching_id || '''
                                and kjmo =  ''' || kjmo || '''
                                and mandant_id =  ''' || mandant_id || '''
                                and kjwo_update =  ''' || kjwo_update || ''' AND (listungsaktion IS NULL OR listungsaktion = '');''';
                        SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');  
                        SET sql_stmt = sql;

                        EXECUTE IMMEDIATE (sql_stmt);

      END;

      ELSEIF var_vorschlag = 'Keine Veränderung'
      THEN

      BEGIN
      SET sql = '''UPDATE dbp_data.sortiment_leistung_2
        		SET  listungsaktion = 'Keine Veränderung'
        		,listung_sst_pflege = NULL
        		,ost_basis_pflege = ' '
        		,ost_gross_pflege = ' '
        		,sued_ost_pflege = ' '
        		,sued_west_pflege = ' '
        		,produktwissen_pflege =  "''' || PRODUKTWISSEN_PFLEGE || '''"
            ,lieferantenwissen_pflege =  "''' || LIEFERANTENWISSEN_PFLEGE || '''"
        		,west_pflege = ' '
            ,nord_pflege = ' '
        		,umsatz_hr = NULL
        		,absatz_hr = NULL
        		,rohertrag_hr = NULL
                WHERE matching_id ='''|| matching_id || '''
                                and kjmo =  ''' || kjmo || '''
                                and mandant_id =  ''' || mandant_id || '''
                                and kjwo_update =  ''' || kjwo_update || ''';''' ;
                        SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');
                        SET sql_stmt = sql;        

                        EXECUTE IMMEDIATE (sql_stmt);
            END;

        ELSEIF var_vorschlag = 'Keine Veränderung zurücksetzen'
      THEN
      BEGIN
      SET sql = '''UPDATE dbp_data.sortiment_leistung_2
        		SET  listungsaktion = NULL
                WHERE matching_id = '''|| matching_id || '''
                                and kjmo =  ''' || kjmo || '''
                                and listungsaktion = 'Keine Veränderung'
                                and mandant_id =  ''' || mandant_id || '''
                                and kjwo_update =  ''' || kjwo_update || ''';''';
                        SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');        
                        SET sql_stmt = sql;
                        EXECUTE IMMEDIATE (sql_stmt);
          END;

        ELSEIF var_vorschlag = 'Produktwissen_2'
          THEN
          BEGIN
      SET sql = '''UPDATE dbp_data.sortiment_leistung_2
        		SET  produktwissen_pflege = produktwissen_vp
        	    WHERE matching_id = CAST('''|| matching_id || ''' AS INT64)
                                and kjmo =  CAST(''' || kjmo || ''' AS INT64)
                                and mandant_id =  CAST(''' || mandant_id || ''' AS INT64)
                                and kjwo_update =  CAST(''' || kjwo_update || ''' AS INT64) AND (produktwissen_pflege IS NULL OR produktwissen_pflege = '') AND (produktwissen_vp IS NOT NULL AND produktwissen_vp <> '');''';
                        SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');  
                         SET sql_stmt = sql; 
                        
                        EXECUTE IMMEDIATE (sql_stmt);
            END;

    ELSEIF var_vorschlag = '' OR var_vorschlag IS NULL AND var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL AND var_produktwissen_pflege <> '' AND var_produktwissen_pflege IS NOT NULL AND CAST(var_region_summary2 AS FLOAT64) = 0 
            THEN 
            BEGIN
                    SET sql = '''UPDATE dbp_data.sortiment_leistung_2        		SET  produktwissen_pflege = ''' || PRODUKTWISSEN_PFLEGE || '''                WHERE matching_id = CAST(''' || MATCHING_ID || ''' AS INT64)  AND kjmo = CAST(''' || KJMO || ''' AS INT64)  AND mandant_id = CAST(''' || mandant_id || ''' AS INT64)  AND kjwo_update = CAST(''' || KJWO_UPDATE || ''' AS INT64) ; ''' ;

              SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');        
              SET sql_stmt = sql;
                        EXECUTE IMMEDIATE (sql_stmt);

            END;
        ELSEIF var_vorschlag = '' OR var_vorschlag IS NULL AND var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL AND var_produktwissen_pflege <> '' AND var_produktwissen_pflege IS NOT NULL AND CAST(var_region_summary2 AS FLOAT64) = 0 
        THEN 
            BEGIN
                    SET sql ='''UPDATE dbp_data.sortiment_leistung_2
        		SET  produktwissen_pflege = ''' ||  PRODUKTWISSEN_PFLEGE || '''
                    , lieferantenwissen_pflege =  ''' || lieferantenwissen_pflege || ''' 
                WHERE matching_id = CAST(''' ||  MATCHING_ID || ''' AS INT64) AND kjmo = CAST(''' ||  KJMO || ''' AS INT64) AND mandant_id = CAST(''' ||  mandant_id || ''' AS INT64) AND kjwo_update = CAST(''' ||  KJWO_UPDATE || ''' AS INT64);''';

              SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');        
              SET sql_stmt = sql;
                        EXECUTE IMMEDIATE (sql_stmt);

            END;
            
        ELSEIF var_vorschlag = 'Lieferantenwissen_2'
             THEN 
             BEGIN
                    SET sql = '''UPDATE dbp_data.sortiment_leistung_2        		SET  lieferantenwissen_pflege =  lieferantenwissen_vp     WHERE matching_id = CAST(''' || MATCHING_ID || ''' AS INT64) AND kjmo = CAST(''' || KJMO || ''' AS INT64) AND mandant_id = CAST(''' || mandant_id || ''' AS INT64) AND kjwo_update = CAST(''' || KJWO_UPDATE || ''' AS INT64) AND (lieferantenwissen_pflege IS NULL OR lieferantenwissen_pflege = '') AND (lieferantenwissen_vp IS NOT NULL AND lieferantenwissen_vp <> ''); ''' ;

              SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');        
              SET sql_stmt = sql;
                        EXECUTE IMMEDIATE (sql_stmt);
            END;


            ELSEIF var_vorschlag = '' OR var_vorschlag IS NULL AND var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL AND var_produktwissen_pflege <> '' AND var_produktwissen_pflege IS NOT NULL AND CAST(var_region_summary2 AS FLOAT64) = 0 
            THEN
            BEGIN
            SET sql = '''UPDATE dbp_data.sortiment_leistung_2
                SET  produktwissen_pflege =  ''' || PRODUKTWISSEN_PFLEGE || ''' 
                , lieferantenwissen_pflege =  ''' || LIEFERANTENWISSEN_PFLEGE || ''' 
                WHERE MATCHING_ID =  CAST(''' || MATCHING_ID || ''' AS INT64)  AND kjmo =  CAST(''' || KJMO || ''' AS INT64)  AND mandant_id =  CAST(''' || mandant_id || ''' AS INT64)  AND KJWO_UPDATE =  CAST(''' || KJWO_UPDATE  || ''' AS INT64)''';

              SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');        
              SET sql_stmt = sql;
                        EXECUTE IMMEDIATE (sql_stmt);
            END;




            ELSE
                BEGIN
                SET sql = '''UPDATE dbp_data.sortiment_leistung_2
	            	SET  stk_re_pflege = "''' ||  STK_RE_PFLEGE || '''"
	            	,listungsaktion = "''' ||  VORSCHLAG || '''"
	            	,produktwissen_pflege = "''' ||  PRODUKTWISSEN_PFLEGE || '''"
	            	,lieferantenwissen_pflege = "''' ||  LIEFERANTENWISSEN_PFLEGE || '''"
	            	,listung_sst_pflege = Coalesce(Trim("''' ||  LISTUNG_SST_PFLEGE || '''"),'N/A')
	            	,ost_basis_pflege = TRIM(CASE CAST(''' ||  OST_BASIS_PFLEGE || ''' AS INT64) WHEN 0 THEN  ' ' WHEN 1 THEN 'X' ELSE ' ' END )
	            	,ost_gross_pflege = TRIM(CASE CAST(''' ||  OST_GROSS_PFLEGE || ''' AS INT64) WHEN 0 THEN  ' ' WHEN 1 THEN 'X' ELSE ' ' END )
	            	,sued_ost_pflege = TRIM(CASE CAST(''' ||  SUED_OST_PFLEGE || ''' AS INT64) WHEN 0 THEN  ' ' WHEN 1 THEN 'X' ELSE ' ' END )
	            	,sued_west_pflege = TRIM(CASE CAST(''' ||  SUED_WEST_PFLEGE || ''' AS INT64) WHEN 0 THEN  ' ' WHEN 1 THEN 'X' ELSE ' ' END )
	            	,west_pflege = TRIM(CASE CAST(''' ||  WEST_PFLEGE || ''' AS INT64) WHEN 0 THEN  ' ' WHEN 1 THEN 'X' ELSE ' ' END )
	            	,nord_pflege = TRIM(CASE CAST(''' ||  NORD_PFLEGE || ''' AS INT64) WHEN 0 THEN  ' ' WHEN 1 THEN 'X' ELSE ' ' END )                    WHERE matching_id = CAST(''' ||  MATCHING_ID || ''' AS INT64) AND kjmo = CAST(''' ||  KJMO || ''' AS INT64) AND mandant_id = CAST(''' ||  mandant_id ||''' AS INT64) AND kjwo_update = CAST(''' ||  KJWO_UPDATE ||''' AS INT64);''' ;
                    SET sql_stmt = sql;

              SET sql_stmt = REGEXP_REPLACE(sql_stmt, 'undefined', 'NULL');        

                        EXECUTE IMMEDIATE (sql_stmt) ;


                IF var_listung_sst_pflege <> '' AND var_listung_sst_pflege <> ' ' AND var_listung_sst_pflege IS NOT NULL OR var_vorschlag_hr = 'Auslisten' THEN
                    BEGIN

                    IF var_vorschlag_hr = 'Auslisten' OR var_listung_sst_pflege = '' OR var_listung_sst_pflege = ' ' OR var_listung_sst_pflege IS NULL AND CAST(var_region_summary AS FLOAT64) = 0 THEN
                        BEGIN
                        SET var_listung_sst_pflege  =  '-1';
                        END;
                    END IF;
                    SET sql  = '''INSERT INTO dbp_msi_data.sortiment_art_2 (mandant_id,
                                                                art_id,
                                                                gtin_id,
                                                                status_2,
                                                                kjwo_update)
                    SELECT a.mandant_id,
      	                     a.art_id,
                               Max(Cast(Cast(a.gtin_id AS INTEGER ) AS STRING )) AS gtin_id,
                               Max(a.status_2) AS status_2,
                               ''' ||  KJWO_UPDATE || ''' AS kjwo_update
                              FROM dbp_etl.art_matching_nielsen_per_2 a
                    WHERE a.art_matching_id =  ''' ||  MATCHING_ID || '''  AND
                        CASE
                            WHEN a.status_2 <> 'N' AND
                                a.list_kz = 'A'
                            THEN 1
                            WHEN a.status_2 = 'N'
                            THEN 1
                            ELSE 0
                        END = 1
                    GROUP BY 1,2;''';

              SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');        
                    SET sql_stmt = sql;
                        EXECUTE IMMEDIATE (sql_stmt) ;
/*
                --------------------------------------------------------------------------------------------------------
                --   (I) UPDATE FUER SORTIMENT_LEISTUNG_2 (mit K-Stufen)
                --------------------------------------------------------------------------------------------------------
                */
                --COUNT(*) AS anzahl_erweiterung,
                -- DUMMY_2-UNION Block ICS
                 -- Auslistung!
                --  Nur SST gepflegt fuer Reduktion!
                SET sql = '''UPDATE dbp_data.sortiment_leistung_2
SET 
  umsatz_hr = x.umsatz,
  absatz_hr = x.absatz,
  rohertrag_hr = x.rohertrag,
  listungsaktion = CASE 
    WHEN (sortiment_leistung.listung_sst_mvke = 'N/A' OR sortiment_leistung.listung_sst_mvke IS NULL) AND 
         GREATEST(COALESCE(sortiment_leistung.ost_basis,''), 
                  COALESCE(sortiment_leistung.ost_gross,''), 
                  COALESCE(sortiment_leistung.sued_ost ,''), 
                  COALESCE(sortiment_leistung.sued_west,''), 
                  COALESCE(sortiment_leistung.west      ,''), 
                  COALESCE(sortiment_leistung.nord      ,'')) = '' AND 
         sortiment_leistung.anz_maerkte_sst = 0 AND 
         sortiment_leistung.anz_maerkte_baustein_sonstige = 0 AND 
         sortiment_leistung.anz_maerkte_listung_einzel = 0 AND 
         sortiment_leistung.anz_maerkte_listung_gesamt = 0 
    THEN 'Einlistung Kauflandartikel'
    WHEN "''' || var_vorschlag || '''" = 'Auslisten' 
    THEN 'Auslistung'
    ELSE x.vorschlag 
  END
FROM (
    SELECT 
        SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
        SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
        REPLACE(REPLACE(
            MAX(
                CASE 
                    WHEN x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0 
                    THEN REPLACE(x.vorschlag, 'dynamic', 'Dynamic') 
                    ELSE REPLACE(x.vorschlag, 'dynamic', 'AAA_2') 
                END
            ), 'Dynamic', 'dynamic'), 'AAA_2', 'dynamic') AS vorschlag__,
        CASE 
            WHEN vorschlag <> 'dynamic' THEN vorschlag
            WHEN anzahl_reduktion = 0 AND anzahl_erweiterung > 0 THEN 'Listung erweitern'
            WHEN anzahl_reduktion > 0 AND anzahl_erweiterung = 0 THEN 'Listung reduzieren'
            WHEN anzahl_reduktion > 0 AND anzahl_erweiterung > 0 AND anzahl_reduktion > anzahl_erweiterung AND ''' || var_region_summary || ''' = 0 THEN 'Listung reduzieren und erweitern'
            WHEN anzahl_reduktion > 0 AND anzahl_erweiterung > 0 AND anzahl_reduktion < anzahl_erweiterung AND ''' || var_region_summary || ''' = 0 THEN 'Listung erweitern und reduzieren'
            WHEN anzahl_reduktion > 0 AND anzahl_erweiterung > 0 AND anzahl_reduktion > anzahl_erweiterung AND ''' || var_region_summary || ''' = 1 THEN 'Listung reduzieren und erweitern'
            WHEN anzahl_reduktion > 0 AND anzahl_erweiterung > 0 AND anzahl_reduktion < anzahl_erweiterung AND ''' || var_region_summary || ''' = 1 THEN 'Listung erweitern und reduzieren'
            WHEN anzahl_reduktion = anzahl_erweiterung THEN 'SOLL-Listung = IST-Listung'
            ELSE 'SOLL-Listung = IST-Listung'
        END AS vorschlag,
        CASE 
            WHEN vorschlag = 'SOLL-Listung = IST-Listung' THEN 0
            ELSE COALESCE(SUM(x.umsatz_) / CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END, 0)
        END AS umsatz,
        CASE 
            WHEN vorschlag = 'SOLL-Listung = IST-Listung' THEN 0
            ELSE COALESCE(SUM(x.absatz_) / CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END, 0)
        END AS absatz,
        CASE 
            WHEN vorschlag = 'SOLL-Listung = IST-Listung' THEN 0
            ELSE COALESCE(SUM(x.rohertrag_) / CASE WHEN MAX(x.status_2) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END, 0)
        END AS rohertrag
    FROM (
        
        SELECT a.art_id, MAX(b.status_2) AS status_2, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, CAST(0 AS INT64) AS anzahl_reduktion, SUM(erweiterung_fg) AS anzahl_erweiterung,
        CASE WHEN list_kz IN ('B','C1','C2','D1','D2') THEN CAST('Einlistung Kauflandartikel' AS STRING) ELSE CAST('dynamic' AS STRING) END AS vorschlag
        FROM dbp_msi_data.kl_listung_2 a
        JOIN dbp_msi_data.sortiment_art_2 b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_2) AND a.listung_art = 'Listung erweitern' AND a.kjwo_update = ''' || KJWO_UPDATE || ''' AND a.sm_id_selected = CAST(NULLIF(TRIM("''' || var_listung_sst_pflege || '''"),'') AS INT64)
        AND (a.nord = '-' AND a.ost_basis = '-' AND a.ost_gross = '-' AND a.sued_ost = '-' AND a.sued_west = '-' AND a.west = '-')
        AND (''' || sst_only || ''' = 1 OR ''' || sst_reg_change || ''' IN (1,4))
        GROUP BY 1,list_kz
        
        UNION ALL
        
        
        SELECT a.art_id, MAX(b.status_2) AS status_2, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, SUM(reduktion_fg) AS anzahl_reduktion, CAST(0 AS INT64) AS anzahl_erweiterung, 'Auslistung' AS vorschlag
        FROM dbp_msi_data.kl_listung_2 a
        JOIN dbp_msi_data.sortiment_art_2 b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_2) AND a.listung_art = 'Auslistung' AND a.kjwo_update = ''' || KJWO_UPDATE || ''' AND a.sm_id_selected = CAST(NULLIF(TRIM("''' || var_listung_sst_pflege || '''"),'') AS INT64)
        AND (a.nord = '-' AND a.ost_basis = '-' AND a.ost_gross = '-' AND a.sued_ost = '-' AND a.sued_west = '-' AND a.west = '-')
        GROUP BY 1
        
        '''
;
                                 
                                  /* hier kann noch optimiert werden */


                IF (sst_only = 1 OR sst_reg_change in (2,4))
                THEN
                    BEGIN
                        SET sql = CONCAT(sql,'''UNION ALL
                                                    SELECT a.art_id,
                                                            MAX(b.status_2) AS status_2,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            SUM(reduktion_fg) AS anzahl_reduktion,
                                                            CAST(0 AS INTEGER ) AS anzahl_erweiterung,
                                                            'dynamic' AS vorschlag
                                                    FROM dbp_msi_data.kl_listung_2 a
                                                    JOIN dbp_data.wup_2 x
                                                        ON a.mandant_id = x.mandant_id AND
                                                        a.wup_id = x.wup_id
                                                    JOIN dbp_msi_data.sortiment_art_2 b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_2) AND
                                                            a.listung_art = 'Listung reduzieren' AND
                                                            a.kjwo_update =   ''' ||  KJWO_UPDATE || '''  AND
                                                            a.sm_id_selected = CAST(NULLIF(TRIM( "''' ||  var_listung_sst_pflege || '''"),'')  AS INTEGER ) AND
                                                            a.sm_id < CAST(NULLIF(TRIM( "''' ||  var_listung_sst_pflege || '''"),'')  AS INTEGER ) AND
                                                        (a.nord = '-' AND 
                                                            a.ost_basis = '-' AND 
                                                            a.ost_gross = '-' AND 
                                                            a.sued_ost = '-' AND 
                                                            a.sued_west = '-' AND 
                                                            a.west = '-') AND 
                                                            CASE
                                                            WHEN   ''' ||  sst_reg_change || '''  = 4 AND
                                                                (x.kreistyp_gruppe_id =  " ''' ||  n_reg_char || '''"   OR
                                                                x.kreistyp_gruppe_id =   "''' ||  w_reg_char || '''"   OR
                                                                x.kreistyp_gruppe_id =   "''' ||  so_reg_char || '''"  OR
                                                                x.kreistyp_gruppe_id =   "''' ||  sw_reg_char || '''"  OR
                                                                x.kreistyp_gruppe_id =   "''' ||  ob_reg_char || '''"  OR
                                                                x.kreistyp_gruppe_id =   "''' ||  og_reg_char || '''" )
                                                            THEN 0
                                                            ELSE 1
                                                            END = 1 AND
                                                        (  ''' ||  sst_only || '''  = 1 OR
                                                             ''' ||  sst_reg_change || '''  IN (2,4))
                                                    GROUP BY 1 ''');
                                    IF (sst_reg = 1)
                                    THEN
                                        BEGIN
                                            SET sql = CONCAT(sql,''' UNION ALL
                                                    /* SST plus Cluster fuer Erweiterung! */
                                                    SELECT a.art_id,
                                                            MAX(b.status_2) AS status_2,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            CAST(0 AS INTEGER ) AS anzahl_reduktion,
                                                            SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                            CASE WHEN list_kz IN ('B','C1','C2','D1','D2') THEN CAST('Einlistung Kauflandartikel' AS STRING ) ELSE CAST('dynamic' AS STRING ) END AS vorschlag
                                                    FROM dbp_msi_data.kl_listung_2 a
                                                    JOIN dbp_data.wup_2 x
                                                        ON a.mandant_id = x.mandant_id AND
                                                        a.wup_id = x.wup_id
                                                    JOIN dbp_msi_data.sortiment_art_2 b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_2) AND
                                                            a.listung_art = 'Listung erweitern' AND
                                                            a.kjwo_update =  ''' || KJWO_UPDATE  || '''   AND
                                                            a.sm_id_selected = 0 AND
                                                            a.sm_id < CAST(NULLIF(TRIM( "''' || var_listung_sst_pflege  || ''' "),'')  AS INTEGER ) AND
                                                        (a.nord =  "''' || var_nord_pflege  || '''"   OR 
                                                            a.ost_basis =  "''' || var_ost_basis_pflege  || '''"   OR
                                                            a.ost_gross = " ''' || var_ost_gross_pflege  || '''"   OR
                                                            a.sued_ost =  "''' || var_sued_ost_pflege  || '''"   OR
                                                            a.sued_west =  "''' || var_sued_west_pflege  || '''"   OR
                                                            a.west =  "''' || var_west_pflege  || '''"  ) AND 
                                                            CASE
                                                            WHEN  ''' || sst_reg_change  || '''   = 4 AND
                                                                a.sm_id >= CAST(NULLIF(TRIM("''' || var_listung_sst_pflege  || ''' "),'')  AS INTEGER ) AND
                                                                (x.kreistyp_gruppe_id =  "''' || n_reg_char  || '''"    OR
                                                                x.kreistyp_gruppe_id =  "''' || w_reg_char  || '''"    OR
                                                                x.kreistyp_gruppe_id =  "''' || so_reg_char  || '''"   OR
                                                                x.kreistyp_gruppe_id =  "''' || sw_reg_char  || '''"   OR
                                                                x.kreistyp_gruppe_id =  "''' || ob_reg_char  || '''"   OR
                                                                x.kreistyp_gruppe_id =  "''' || og_reg_char  || '''"  )
                                                            THEN 0
                                                            ELSE 1
                                                            END = 1 AND
                                                            ''' || sst_reg  || ''' = 1
                                                    GROUP BY 1,list_kz ''');
                                    END;
                                    END IF;
                                    IF (sst_reg = 1 AND sst_reg_change <> 4)
                                    THEN 
                                    BEGIN
                                        SET sql = CONCAT(sql,''' UNION ALL
                                                    /* SST plus Cluster fuer Reduktion! */
                                                    SELECT a.art_id,
                                                            MAX(b.status_2) AS status_2,
                                                            MIN(a.list_kz) AS list_kz_,
                                                            SUM(a.umsatz_hr) AS umsatz_,
                                                            SUM(a.absatz_hr) AS absatz_,
                                                            SUM(a.rohertrag_hr) AS rohertrag_,
                                                            SUM(reduktion_fg) AS anzahl_reduktion,
                                                            CAST(0 AS INTEGER ) AS anzahl_erweiterung,
                                                            'dynamic' AS vorschlag
                                                    FROM dbp_msi_data.kl_listung_2 a
                                                    JOIN dbp_msi_data.sortiment_art_2 b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_2) AND
                                                            a.listung_art = 'Listung reduzieren' AND
                                                            a.kjwo_update =  ''' || KJWO_UPDATE || '''  AND
                                                            a.sm_id_selected = 0 AND
                                                            a.sm_id < CAST(NULLIF(TRIM("''' || var_listung_sst_pflege || '''"),'')  AS INTEGER ) AND
                                                        (a.nord =  "''' || var_nord_pflege || '''"  OR 
                                                            a.ost_basis =  "''' || var_ost_basis_pflege || '''"  OR
                                                            a.ost_gross =  "''' || var_ost_gross_pflege || '''"  OR
                                                            a.sued_ost =  "''' || var_sued_ost_pflege || '''"  OR
                                                            a.sued_west =  "''' || var_sued_west_pflege || '''"  OR
                                                            a.west =  "''' || var_west_pflege || '''" ) AND
                                                            ''' || sst_reg || '''  = 1 AND
                                                            ''' || sst_reg_change || '''  NOT IN (4)
                                                    GROUP BY 1''');
                                    END;
                                    END IF;

                                
                        SET sql = CONCAT(sql,''') x
                        GROUP BY 
        x.vorschlag, 
        x.anzahl_reduktion, 
        x.anzahl_erweiterung
) x
WHERE (sortiment_leistung.mandant_id = ''' || mandant_id || ''' AND sortiment_leistung.art_id = ''' || ART_ID || ''' AND sortiment_leistung.KJWO_UPDATE = ''' || KJWO_UPDATE || ''');''');

                    SET sql_stmt = sql;
                SET sql_stmt = REGEXP_REPLACE(sql_stmt, 'undefined', 'NULL');        
    
                            EXECUTE IMMEDIATE (sql_stmt);



                SET sql = '''DELETE FROM dbp_msi_data.sortiment_art_2 where (sortiment_art.mandant_id, sortiment_art.art_id, sortiment_art.gtin_id, sortiment_art.kjwo_update) IN(
  SELECT AS STRUCT
      a.mandant_id,
      a.art_id,
      MAX(SUBSTR(CAST(CAST( a.gtin_id as bignumeric) AS STRING), 1, 16777216)) as gtin_id,
      CAST(''' || KJWO_UPDATE || ''' AS INT64) as kjwo_update
    FROM
      dbp_etl.art_matching_nielsen_per_2 AS A
    WHERE a.art_matching_id = cast(''' || MATCHING_ID || ''' AS INT64) 
    GROUP BY 1, 2
);''';





                SET sql = REGEXP_REPLACE(sql, 'undefined', 'NULL');
                SET sql_stmt = sql;
                EXECUTE IMMEDIATE (sql_stmt);
                END;






                END IF;



                    END;
                END IF;

  END;



  END IF; 
END;  
END IF;

END; 
END IF;
END;
