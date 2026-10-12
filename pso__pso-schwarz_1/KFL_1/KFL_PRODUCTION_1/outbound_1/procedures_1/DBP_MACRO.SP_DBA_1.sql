CREATE OR REPLACE PROCEDURE dbp_macro.sp_dba(IN MATCHING_ID FLOAT64, IN ART_ID FLOAT64, IN GTIN STRING, IN STK_RE_PFLEGE STRING, IN VORSCHLAG STRING, IN PRODUKTWISSEN_PFLEGE STRING, IN LIEFERANTENWISSEN_PFLEGE STRING, IN LISTUNG_SST_PFLEGE STRING, IN OST_BASIS_PFLEGE FLOAT64, IN OST_GROSS_PFLEGE FLOAT64, IN SUED_OST_PFLEGE FLOAT64, IN SUED_WEST_PFLEGE FLOAT64, IN WEST_PFLEGE FLOAT64, IN NORD_PFLEGE FLOAT64, IN KJMO FLOAT64, IN N_K_ARTIKEL FLOAT64, IN NL_ART_BEZ STRING, IN KJWO_UPDATE FLOAT64)
BEGIN

DECLARE var_matching_id FLOAT64;
DECLARE var_art_id FLOAT64;
DECLARE var_gtin STRING;
DECLARE var_stk_re_pflege STRING;
DECLARE var_vorschlag STRING;
DECLARE var_vorschlag_hr STRING;
DECLARE var_produktwissen_pflege STRING;
DECLARE var_lieferantenwissen_pflege STRING;
DECLARE var_listung_sst_pflege STRING;
DECLARE var_ost_basis_pflege FLOAT64;
DECLARE var_ost_gross_pflege FLOAT64;
DECLARE var_sued_ost_pflege FLOAT64;
DECLARE var_sued_west_pflege FLOAT64;
DECLARE var_west_pflege FLOAT64;
DECLARE var_nord_pflege FLOAT64;
DECLARE var_kjmo FLOAT64;
DECLARE var_n_k_artikel FLOAT64;
DECLARE var_nl_art_bez STRING;
DECLARE var_region_summary NUMERIC;
DECLARE var_region_summary2 NUMERIC;
DECLARE var_kjwo_update FLOAT64;
DECLARE mandant_id NUMERIC;
DECLARE var_sst_tool_fg FLOAT64;
DECLARE var_ob_tool_fg FLOAT64;
DECLARE var_og_tool_fg FLOAT64;
DECLARE var_so_tool_fg FLOAT64;
DECLARE var_sw_tool_fg FLOAT64;
DECLARE var_w_tool_fg FLOAT64;
DECLARE var_n_tool_fg FLOAT64;
DECLARE region_only NUMERIC;
DECLARE sst_only NUMERIC;
DECLARE sst_reg NUMERIC;
DECLARE sst_reg_change NUMERIC;
DECLARE ob_reg_char STRING;
DECLARE og_reg_char STRING;
DECLARE so_reg_char STRING;
DECLARE sw_reg_char STRING;
DECLARE n_reg_char STRING;
DECLARE w_reg_char STRING;
DECLARE sql_stmt STRING;
DECLARE stmt FLOAT64;

SET mandant_id  =  1;
SET var_matching_id  =  MATCHING_ID;
SET var_art_id  =  ART_ID;
SET var_gtin  =  GTIN;
SET var_kjwo_update = KJWO_UPDATE;

IF STK_RE_PFLEGE = '' THEN
    BEGIN
    SET var_stk_re_pflege  =  NULL;
    END;
ELSE
    BEGIN
    SET var_stk_re_pflege  =  STK_RE_PFLEGE;
    END;
END IF;


IF VORSCHLAG = '' THEN
    BEGIN
    SET var_vorschlag  =  NULL;
    END;
ELSE
    BEGIN
    SET var_vorschlag  =  VORSCHLAG;
    END;
END IF;


IF VORSCHLAG = '' THEN
    BEGIN
    SET var_vorschlag_hr  =  NULL;
    END;
ELSE
    BEGIN
    SET var_vorschlag_hr  =  VORSCHLAG;
    END;
END IF;

SET var_produktwissen_pflege  =  PRODUKTWISSEN_PFLEGE;
SET var_lieferantenwissen_pflege  =  LIEFERANTENWISSEN_PFLEGE;
SET var_listung_sst_pflege  =  LISTUNG_SST_PFLEGE;

IF OST_BASIS_PFLEGE = 0 AND OST_GROSS_PFLEGE = 0 AND SUED_OST_PFLEGE = 0 AND SUED_WEST_PFLEGE = 0 AND WEST_PFLEGE = 0 AND NORD_PFLEGE = 0 THEN
    BEGIN
    SET var_region_summary  =  0;
    END;
ELSE
    BEGIN
    SET var_region_summary  =  1;
    END;
END IF;

---- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A; 5 = SST gesetzt bei ausschließlicher Clusterpflege*/
SET sql_stmt  =  """SELECT CASE   
  WHEN listung_sst_mvke <> 'N/A' AND ('""" || var_listung_sst_pflege || """' IS NOT NULL AND '""" || var_listung_sst_pflege || """' <> '') AND CAST(ROUND(CAST('""" || var_listung_sst_pflege || """' AS FLOAT64)) AS INTEGER) < CAST(ROUND(CAST(listung_sst_mvke AS FLOAT64)) AS INTEGER) THEN 1   
  WHEN listung_sst_mvke <> 'N/A' AND ('""" || var_listung_sst_pflege || """' IS NOT NULL AND '""" || var_listung_sst_pflege || """' <> '') AND CAST(ROUND(CAST('""" || var_listung_sst_pflege || """' AS FLOAT64)) AS INTEGER) > CAST(ROUND(CAST(listung_sst_mvke AS FLOAT64)) AS INTEGER) THEN 2   
  WHEN listung_sst_mvke <> 'N/A' AND ('""" || var_listung_sst_pflege || """' IS NOT NULL AND '""" || var_listung_sst_pflege || """' <> '') AND CAST(ROUND(CAST('""" || var_listung_sst_pflege || """' AS FLOAT64)) AS INTEGER) = CAST(ROUND(CAST(listung_sst_mvke AS FLOAT64)) AS INTEGER) THEN 3   
  WHEN listung_sst_mvke = 'N/A' AND ('""" || var_listung_sst_pflege || """' IS NOT NULL AND '""" || var_listung_sst_pflege || """' <> '') THEN 4   
  WHEN listung_sst_mvke <> 'N/A' AND ('""" || var_listung_sst_pflege || """' IS NULL OR '""" || var_listung_sst_pflege || """' = '') THEN 5   
  ELSE 0   
  END 
  FROM dbp_data.sortiment_leistung_1 
  WHERE mandant_id = 1  
  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  
  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_sst_tool_fg  =  stmt;
SET sql_stmt  =  """SELECT CASE   WHEN COALESCE(west, '') = 'X'   THEN 1   ELSE 0   END FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_w_tool_fg  =  stmt;
SET sql_stmt  =  """SELECT CASE   WHEN COALESCE(nord, '') = 'X'   THEN 1   ELSE 0   END FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_n_tool_fg  =  stmt;
SET sql_stmt  =  """SELECT CASE   WHEN COALESCE(ost_basis, '') = 'X'   THEN 1   ELSE 0   END FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_ob_tool_fg  =  stmt;
SET sql_stmt  =  """SELECT CASE   WHEN COALESCE(ost_gross, '') = 'X'   THEN 1   ELSE 0   END FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_og_tool_fg  =  stmt;
SET sql_stmt  =  """SELECT CASE   WHEN COALESCE(sued_ost, '') = 'X'   THEN 1   ELSE 0   END FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_so_tool_fg  =  stmt;
SET sql_stmt  =  """SELECT CASE   WHEN COALESCE(sued_west, '') = 'X'   THEN 1   ELSE 0   END FROM dbp_data.sortiment_leistung_1 WHERE mandant_id = 1  AND matching_id = """ || CAST(MATCHING_ID AS STRING) || """  AND kjwo_update = """ || CAST(KJWO_UPDATE AS STRING) || """ """;

EXECUTE IMMEDIATE (sql_stmt)
INTO stmt ;
SET var_sw_tool_fg  =  stmt;

IF (OST_BASIS_PFLEGE = 1 OR OST_GROSS_PFLEGE = 1 OR SUED_OST_PFLEGE = 1 OR SUED_WEST_PFLEGE = 1 OR WEST_PFLEGE = 1 OR NORD_PFLEGE = 1) AND (var_listung_sst_pflege IS NULL OR var_listung_sst_pflege = '') THEN
    BEGIN
    SET var_region_summary2  =  1;
    END;
ELSE
    BEGIN
    SET var_region_summary2  =  0;
    END;
END IF;

----- Die alles entscheidende Weiche, welcher Zweig zu waehlen ist!*/

IF LISTUNG_SST_PFLEGE IS NULL OR LISTUNG_SST_PFLEGE = '' THEN
    BEGIN
    SET region_only  =  1;
    END;
ELSE
    BEGIN
    SET region_only  =  0;
    END;
END IF;


IF LISTUNG_SST_PFLEGE IS NOT NULL AND LISTUNG_SST_PFLEGE <> '' AND var_region_summary = 0 THEN
    BEGIN
    SET sst_only  =  1;
    END;
ELSE
    BEGIN
    SET sst_only  =  0;
    END;
END IF;


IF LISTUNG_SST_PFLEGE IS NOT NULL AND LISTUNG_SST_PFLEGE <> '' AND var_region_summary = 1 THEN
    BEGIN
    SET sst_reg  =  1;
    END;
ELSE
    BEGIN
    SET sst_reg  =  0;
    END;
END IF;

---- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A*/

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

END;
