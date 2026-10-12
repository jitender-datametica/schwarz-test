CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_BY_BATCH(USER VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS ' 

sql = `CREATE OR REPLACE TEMPORARY DBP_MACRO.table public.input_table_ek_sort_runtime
as
select a.MATCHING_ID, a.ART_ID, a.GTIN, a.STK_RE_PFLEGE, a.VORSCHLAG, a.PRODUKTWISSEN_PFLEGE, a.LIEFERANTENWISSEN_PFLEGE, a.LISTUNG_SST_PFLEGE
        , a.OST_BASIS_PFLEGE as ost_basis_pflege_int
        , a.OST_GROSS_PFLEGE as OST_GROSS_PFLEGE_int
        , a.SUED_OST_PFLEGE as SUED_OST_PFLEGE_int
        , a.SUED_WEST_PFLEGE as SUED_WEST_PFLEGE_int
        , a.WEST_PFLEGE as WEST_PFLEGE_int
        , a.NORD_PFLEGE as NORD_PFLEGE_int
        , a.KJMO, a.N_K_ARTIKEL, a.NL_ART_BEZ, a.KJWO_UPDATE
        ,      case when A.OST_BASIS_PFLEGE = 0 AND A.OST_GROSS_PFLEGE = 0 AND A.SUED_OST_PFLEGE = 0 AND A.SUED_WEST_PFLEGE = 0 AND A.WEST_PFLEGE = 0 AND A.NORD_PFLEGE = 0
                        then 0 
                  else 1 
                  end as region_summary
                  , cast(CASE
                  WHEN b.listung_sst_mvke <> ''N/A'' AND
                      (a.listung_sst_pflege IS NOT NULL AND a.listung_sst_pflege <> '' '') AND
                      Cast(NULLIF(TRIM(a.listung_sst_pflege), '''') AS INT) < CAST(b.listung_sst_mvke AS INT)
                      
                  THEN 1::int
                  WHEN b.listung_sst_mvke <> ''N/A'' AND
                      (a.listung_sst_pflege IS NOT NULL AND a.listung_sst_pflege <> '' '') AND
                      Cast(NULLIF(TRIM(a.listung_sst_pflege), '''') AS INT) > CAST(b.listung_sst_mvke AS INT)
                  THEN 2::int
                  WHEN b.listung_sst_mvke <> ''N/A'' AND
                      (a.listung_sst_pflege IS NOT NULL AND a.listung_sst_pflege <> '' '') AND
                      Cast(NULLIF(TRIM(a.listung_sst_pflege), '''') AS INT) = CAST(b.listung_sst_mvke AS INT)
                  THEN 3::int
                  WHEN b.listung_sst_mvke = ''N/A'' AND
                      (a.listung_sst_pflege IS NOT NULL AND a.listung_sst_pflege <> '' '')
                  THEN 4::INT
                  WHEN b.listung_sst_mvke <> ''N/A'' AND
                      (a.listung_sst_pflege IS NULL OR a.listung_sst_pflege = '' '')
                  THEN 5::int
                  ELSE 0::int
              END as int) AS sst_tool_fg
              , CASE 
                      WHEN COALESCE(b.west,'' '') = ''X''
                      THEN 1
                      ELSE 0
                  END as w_tool_fg
              , CASE 
                      WHEN COALESCE(b.nord,'' '') = ''X''
                      THEN 1
                      ELSE 0
                  END AS n_tool_fg
          , CASE 
                  WHEN COALESCE(b.ost_basis,'' '') = ''X''
                  THEN 1
                  ELSE 0
              END as ob_tool_fg
          , CASE 
              WHEN COALESCE(b.ost_gross,'' '') = ''X''
              THEN 1
              ELSE 0
          END as og_tool_fg
          , CASE 
                  WHEN COALESCE(b.sued_ost,'' '') = ''X''
                  THEN 1
                  ELSE 0
              END as so_tool_fg
          , CASE 
                  WHEN COALESCE(b.sued_west,'' '') = ''X''
                  THEN 1
                  ELSE 0
              END as sw_tool_fg
          , CASE WHEN (a.ost_basis_pflege = 1 OR
                        a.ost_gross_pflege = 1 OR
                        a.sued_ost_pflege = 1 OR
                        a.sued_west_pflege = 1 OR
                        a.west_pflege = 1 OR
                        a.nord_pflege = 1) AND
                  Cast(NULLIF(TRIM(a.listung_sst_pflege), '''') AS INT) IS NULL
            THEN 1
            ELSE 0
            END as region_summary2
          ,  CASE WHEN (a.listung_sst_pflege IS NULL OR a.listung_sst_pflege = '' '') THEN 1 ELSE 0 END as region_only
          , CASE WHEN (a.listung_sst_pflege IS NOT NULL AND a.listung_sst_pflege <> '' '') AND region_summary = 0 THEN 1 ELSE 0 END as sst_only
          , CASE WHEN (a.listung_sst_pflege IS NOT NULL AND a.listung_sst_pflege <> '' '') AND region_summary = 1 THEN 1 ELSE 0 END as sst_reg
          -- 1 = Erweiterung; 2 = Reduktion; 3 = SOLL = IST; 4 = Erweiterung von N/A
          , cast(CASE WHEN sst_reg = 1 AND sst_tool_fg = 1 THEN 1
                  WHEN sst_reg = 1 AND sst_tool_fg = 2 THEN 2
                  WHEN sst_reg = 1 AND sst_tool_fg = 3 THEN 3
                  WHEN sst_reg = 1 AND sst_tool_fg = 4 THEN 4
                  ELSE 0 END as int) as sst_reg_change
        , CASE WHEN nord_pflege_int      = 1 THEN ''N'' ELSE '' '' END as n_reg_char
        , CASE WHEN west_pflege_int      = 1 THEN ''W'' ELSE '' '' END as w_reg_char
        , CASE WHEN ost_basis_pflege_int = 1 THEN ''O'' ELSE '' '' END as ob_reg_char
        , CASE WHEN ost_gross_pflege_int = 1 THEN ''Q'' ELSE '' '' END as og_reg_char
        , CASE WHEN sued_ost_pflege_int  = 1 THEN ''G'' ELSE '' '' END as so_reg_char
        , CASE WHEN sued_west_pflege_int = 1 THEN ''M'' ELSE '' '' END as sw_reg_char
        , CASE WHEN region_only = 1 AND a.ost_basis_pflege = 1 AND  ob_tool_fg = 0 THEN ''x''
                WHEN region_only = 1 AND a.ost_basis_pflege = 1 AND ob_tool_fg = 1 THEN '' ''
                WHEN region_only = 1 AND a.ost_basis_pflege = 0 AND ob_tool_fg = 0 AND sst_tool_fg  = 5 THEN ''u''
                WHEN region_only = 1 AND a.ost_basis_pflege = 0 AND ob_tool_fg = 0 AND sst_tool_fg <> 5 THEN '' ''
                WHEN region_only = 1 AND a.ost_basis_pflege = 0 AND ob_tool_fg = 0 THEN '' ''
                WHEN region_only = 1 AND a.ost_basis_pflege = 0 AND ob_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.ost_basis_pflege = 0 AND ob_tool_fg = 0 THEN '' ''
                WHEN sst_reg     = 1 AND a.ost_basis_pflege = 0 AND ob_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.ost_basis_pflege = 1 AND ob_tool_fg = 0 THEN ''x''
                WHEN sst_reg     = 1 AND a.ost_basis_pflege = 1 AND ob_tool_fg = 1 THEN '' ''
                ELSE '' '' END as ost_basis_pflege
        , CASE WHEN region_only = 1 AND  a.ost_gross_pflege = 1 AND og_tool_fg = 0 THEN ''x''
                WHEN region_only = 1 AND a.ost_gross_pflege = 1 AND og_tool_fg = 1 THEN '' ''
                WHEN region_only = 1 AND a.ost_gross_pflege = 0 AND og_tool_fg = 0 AND sst_tool_fg  = 5 THEN ''u''
                WHEN region_only = 1 AND a.ost_gross_pflege = 0 AND og_tool_fg = 0 AND sst_tool_fg <> 5 THEN '' ''
                WHEN region_only = 1 AND a.ost_gross_pflege = 0 AND og_tool_fg = 0 THEN '' ''
                WHEN region_only = 1 AND a.ost_gross_pflege = 0 AND og_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.ost_gross_pflege = 0 AND og_tool_fg = 0 THEN '' ''
                WHEN sst_reg     = 1 AND a.ost_gross_pflege = 0 AND og_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.ost_gross_pflege = 1 AND og_tool_fg = 0 THEN ''x''
                WHEN sst_reg     = 1 AND a.ost_gross_pflege = 1 AND og_tool_fg = 1 THEN '' ''
                ELSE '' '' END as ost_gross_pflege
        , CASE WHEN region_only = 1 AND  a.sued_ost_pflege = 1 AND so_tool_fg = 0 THEN ''x''
                WHEN region_only = 1 AND a.sued_ost_pflege = 1 AND so_tool_fg = 1 THEN '' ''
                WHEN region_only = 1 AND a.sued_ost_pflege = 0 AND so_tool_fg = 0 AND sst_tool_fg  = 5 THEN ''u''
                WHEN region_only = 1 AND a.sued_ost_pflege = 0 AND so_tool_fg = 0 AND sst_tool_fg <> 5 THEN '' ''
                WHEN region_only = 1 AND a.sued_ost_pflege = 0 AND so_tool_fg = 0 THEN '' ''
                WHEN region_only = 1 AND a.sued_ost_pflege = 0 AND so_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.sued_ost_pflege = 0 AND so_tool_fg = 0 THEN '' ''
                WHEN sst_reg     = 1 AND a.sued_ost_pflege = 0 AND so_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.sued_ost_pflege = 1 AND so_tool_fg = 0 THEN ''x''
                WHEN sst_reg     = 1 AND a.sued_ost_pflege = 1 AND so_tool_fg = 1 THEN '' ''
                ELSE '' '' END as sued_ost_pflege
        , CASE WHEN region_only = 1 AND  a.sued_west_pflege = 1 AND sw_tool_fg = 0 THEN ''x''
                WHEN region_only = 1 AND a.sued_west_pflege = 1 AND sw_tool_fg = 1 THEN '' ''
                WHEN region_only = 1 AND a.sued_west_pflege = 0 AND sw_tool_fg = 0 AND sst_tool_fg  = 5 THEN ''u''
                WHEN region_only = 1 AND a.sued_west_pflege = 0 AND sw_tool_fg = 0 AND sst_tool_fg <> 5 THEN '' ''
                WHEN region_only = 1 AND a.sued_west_pflege = 0 AND sw_tool_fg = 0 THEN '' ''
                WHEN region_only = 1 AND a.sued_west_pflege = 0 AND sw_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.sued_west_pflege = 0 AND sw_tool_fg = 0 THEN '' ''
                WHEN sst_reg     = 1 AND a.sued_west_pflege = 0 AND sw_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.sued_west_pflege = 1 AND sw_tool_fg = 0 THEN ''x''
                WHEN sst_reg     = 1 AND a.sued_west_pflege = 1 AND sw_tool_fg = 1 THEN '' ''
                ELSE '' '' END as sued_west_pflege
        , CASE WHEN region_only = 1 AND  a.west_pflege = 1 AND w_tool_fg = 0 THEN ''x''
                WHEN region_only = 1 AND a.west_pflege = 1 AND w_tool_fg = 1 THEN '' ''
                WHEN region_only = 1 AND a.west_pflege = 0 AND w_tool_fg = 0 AND sst_tool_fg  = 5 THEN ''u''
                WHEN region_only = 1 AND a.west_pflege = 0 AND w_tool_fg = 0 AND sst_tool_fg <> 5 THEN '' ''
                WHEN region_only = 1 AND a.west_pflege = 0 AND w_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.west_pflege = 0 AND w_tool_fg = 0 THEN '' ''
                WHEN sst_reg     = 1 AND a.west_pflege = 0 AND w_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.west_pflege = 1 AND w_tool_fg = 0 THEN ''x''
                WHEN sst_reg     = 1 AND a.west_pflege = 1 AND w_tool_fg = 1 THEN '' ''
                ELSE '' '' END as west_pflege
       , CASE WHEN region_only = 1 AND   a.nord_pflege = 1 AND n_tool_fg = 0 THEN ''x''
                WHEN region_only = 1 AND a.nord_pflege = 1 AND n_tool_fg = 1 THEN '' ''
                WHEN region_only = 1 AND a.nord_pflege = 0 AND n_tool_fg = 0 AND sst_tool_fg  = 5 THEN ''u''
                WHEN region_only = 1 AND a.nord_pflege = 0 AND n_tool_fg = 0 AND sst_tool_fg <> 5 THEN '' ''
                WHEN region_only = 1 AND a.nord_pflege = 0 AND n_tool_fg = 0 THEN '' ''
                WHEN region_only = 1 AND a.nord_pflege = 0 AND n_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.nord_pflege = 0 AND n_tool_fg = 0 THEN '' ''
                WHEN sst_reg     = 1 AND a.nord_pflege = 0 AND n_tool_fg = 1 THEN ''u''
                WHEN sst_reg     = 1 AND a.nord_pflege = 1 AND n_tool_fg = 0 THEN ''x''
                WHEN sst_reg     = 1 AND a.nord_pflege = 1 AND n_tool_fg = 1 THEN '' ''
                ELSE '' '' END as nord_pflege
FROM PUBLIC.INPUT_TABLE_EK_SORT_U_1 a
INNER JOIN dbp_data.sortiment_leistung_1 b
ON b.mandant_id = 1 AND 
a.matching_id = b.matching_id AND 
a.kjwo_update = b.kjwo_update
WHERE a.user = ''` + USER + `''
                 ;`
                     sql = sql.replace(/''undefined''/g, "NULL") 
                     sql_stmt = snowflake.createStatement({sqlText: sql}); 
                     sql_stmt.execute(); 

// Devide between region_summary 0 and 1
sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime
       WHERE region_summary = 0`
       sql = sql.replace(/''undefined''/g, "NULL") 
       sql_stmt = snowflake.createStatement({sqlText: sql}); 
       res = sql_stmt.execute(); 
       res.next();
       row_count_0 = res.getColumnValue(1)


sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime
       WHERE region_summary = 1`
       sql = sql.replace(/''undefined''/g, "NULL") 
       sql_stmt = snowflake.createStatement({sqlText: sql}); 
       sql_stmt.execute(); 
       res = sql_stmt.execute(); 
       res.next();
       row_count_1 = res.getColumnValue(1)



// if (var_gtin == undefined || (var_gtin != undefined && (''-9999'',''-9998'').includes(var_gtin) == false)) { 
//      if (var_vorschlag == ''Zurücksetzen'')
// Z 169


// Check if SQL-Statement to be executed            
sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime src
            WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL) 
            AND src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'', ''Keine Veränderung setzen'', ''Keine Veränderung zurücksetzen'', ''Lieferantenwissen_1'', ''Produktwissen_1'')`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            sql_stmt.execute(); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_v = res.getColumnValue(1)            

if (row_count_v > 0){            
sql=`UPDATE dbp_data.sortiment_leistung_1 trg
SET stk_re_pflege = case WHEN src.vorschlag = ''Zurücksetzen'' THEN NULL 
                         WHEN src.vorschlag = ''Keine Veränderung'' 
                            OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL) 
                            OR (src.vorschlag = ''Keine Veränderung zurücksetzen'' AND listungsaktion = ''Keine Veränderung'')
                            OR (src.vorschlag = ''Produktwissen_1'' AND NULLIF(trg.produktwissen_pflege,'' '') IS NULL AND NULLIF(produktwissen_vp,'' '') IS NOT NULL)
                            OR (src.vorschlag = ''Lieferantenwissen_1'' AND NULLIF(trg.lieferantenwissen_pflege,'' '') IS NULL AND NULLIF(lieferantenwissen_vp,'' '') IS NOT NULL)
                                 THEN trg.stk_re_pflege
         END
,listungsaktion = case WHEN src.vorschlag = ''Zurücksetzen'' 
                        OR (src.vorschlag = ''Keine Veränderung zurücksetzen'' AND listungsaktion = ''Keine Veränderung'') 
                            THEN NULL 
                       WHEN src.vorschlag = ''Keine Veränderung'' 
                         OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)  
                            THEN ''Keine Veränderung'' 
                       WHEN (src.vorschlag = ''Produktwissen_1'' AND NULLIF(trg.produktwissen_pflege,'' '') IS NULL AND NULLIF(produktwissen_vp,'' '') IS NOT NULL)
                         OR (src.vorschlag = ''Lieferantenwissen_1'' AND NULLIF(trg.lieferantenwissen_pflege,'' '') IS NULL AND NULLIF(lieferantenwissen_vp,'' '') IS NOT NULL)
                            THEN trg.listungsaktion
        end
,trg.produktwissen_pflege = case WHEN src.vorschlag = ''Zurücksetzen'' THEN  NULL 
                                 WHEN src.vorschlag = ''Keine Veränderung''  
                                    OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL) 
                                    OR (src.vorschlag = ''Keine Veränderung zurücksetzen'' AND listungsaktion = ''Keine Veränderung'')
                                    OR (src.vorschlag = ''Lieferantenwissen_1'' AND NULLIF(trg.lieferantenwissen_pflege,'' '') IS NULL AND NULLIF(lieferantenwissen_vp,'' '') IS NOT NULL)
                                        THEN src.produktwissen_pflege 
                                 WHEN (src.vorschlag = ''Produktwissen_1'' AND NULLIF(trg.produktwissen_pflege,'' '') IS NULL AND NULLIF(produktwissen_vp,'' '') IS NOT NULL)
                                        THEN trg.produktwissen_vp
end
,trg.lieferantenwissen_pflege = case WHEN src.vorschlag = ''Zurücksetzen'' THEN NULL
                                    WHEN src.vorschlag = ''Keine Veränderung''  
                                      OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)  
                                      OR (src.vorschlag = ''Keine Veränderung zurücksetzen'' AND listungsaktion = ''Keine Veränderung'')
                                      OR (src.vorschlag = ''Produktwissen_1'' AND NULLIF(trg.produktwissen_pflege,'' '') IS NULL AND NULLIF(produktwissen_vp,'' '') IS NOT NULL)
                                            THEN trg.lieferantenwissen_pflege 
                                    WHEN (src.vorschlag = ''Lieferantenwissen_1'' AND NULLIF(trg.lieferantenwissen_pflege,'' '') IS NULL AND NULLIF(lieferantenwissen_vp,'' '') IS NOT NULL)
                                        THEN trg.lieferantenwissen_vp
                      end
,listung_sst_pflege = case WHEN src.vorschlag = ''Zurücksetzen''  
                             OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL) 
                                    THEN NULL 
                           WHEN src.vorschlag = ''Keine Veränderung'' 
                             OR (src.vorschlag = ''Keine Veränderung zurücksetzen'' AND listungsaktion = ''Keine Veränderung'')
                             OR (src.vorschlag = ''Produktwissen_1'' AND NULLIF(trg.produktwissen_pflege,'' '') IS NULL AND NULLIF(produktwissen_vp,'' '') IS NOT NULL)
                             OR (src.vorschlag = ''Lieferantenwissen_1'' AND NULLIF(trg.lieferantenwissen_pflege,'' '') IS NULL AND NULLIF(lieferantenwissen_vp,'' '') IS NOT NULL)
                                    THEN trg.listung_sst_pflege
end
,ost_basis_pflege = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                           OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                                 THEN '' '' 
                        ELSE trg.ost_basis_pflege
                    END
,ost_gross_pflege = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                            OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                                THEN '' '' 
                            ELSE trg.ost_gross_pflege
                            END
,sued_ost_pflege = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                            OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                                THEN '' '' 
                            ELSE trg.sued_ost_pflege
                            END
,sued_west_pflege = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                            OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                                THEN '' '' 
                            ELSE trg.sued_west_pflege
                            END
,west_pflege = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                        OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                            THEN '' '' 
                        ELSE trg.west_pflege
                        END
,nord_pflege = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                        OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                            THEN '' '' 
                        ELSE trg.nord_pflege
                        END
,umsatz_hr = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                    OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                        THEN NULL
                    ELSE umsatz_hr
                    END
,absatz_hr = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                    OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                        THEN NULL
                    ELSE trg.absatz_hr
                    END
,rohertrag_hr = CASE WHEN src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'')
                        OR (src.vorschlag = ''Keine Veränderung setzen'' AND NULLIF(listungsaktion, '' '') IS NULL)                            
                            THEN NULL
                        ELSE trg.rohertrag_hr
                        END
      FROM PUBLIC.input_table_ek_sort_runtime src
      WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL) 
      AND src.vorschlag IN (''Zurücksetzen'', ''Keine Veränderung'', ''Keine Veränderung setzen'', ''Keine Veränderung zurücksetzen'', ''Lieferantenwissen_1'', ''Produktwissen_1'')
              AND src.matching_id = trg.MATCHING_ID   
              AND src.kjmo = trg.kjmo 
              AND 1 = trg.mandant_id  
              AND src.kjwo_update = trg.kjwo_update;`; 
 
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            sql_stmt.execute();  
          }
 
 
/*sql= `DELETE FROM dbp_msi_data.erwartete_entwicklung_1 trg
      USING PUBLIC.input_table_ek_sort_runtime src
      WHERE src.gtin IS NULL AND src.vorschlag IN (''Zurücksetzen'')
      AND src.matching_id = trg.MATCHING_ID   
      AND src.kjmo = trg.kjmo 
      AND 1 = trg.mandant_id  
      AND src.kjwo_update = trg.kjwo_update;`; 
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  */


sql= `DELETE FROM dbp_msi_data.erwartete_entwicklung_1 trg
      USING PUBLIC.input_table_ek_sort_runtime src
      WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL) AND src.vorschlag IN (''Zurücksetzen'')
      AND src.matching_id = trg.MATCHING_ID   
      AND src.kjmo = trg.kjmo 
      AND 1 = trg.mandant_id  
      AND src.kjwo_update = trg.kjwo_update;`; 
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  



// Check if SQL-Statement to be executed            
sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime src
            WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL)
            AND NULLIF(src.vorschlag,'' '') IS NULL AND NULLIF(src.listung_sst_pflege,'' '') IS NULL AND NULLIF(src.produktwissen_pflege,'' '') IS NOT NULL
                    AND (src.OST_BASIS_PFLEGE_int = 0 AND src.OST_GROSS_PFLEGE_int = 0 AND src.SUED_OST_PFLEGE_int = 0 AND src.SUED_WEST_PFLEGE_int = 0 AND src.NORD_PFLEGE_int = 0)`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            sql_stmt.execute(); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_w = res.getColumnValue(1)            

if (row_count_w > 0){  

    sql= `UPDATE dbp_data.sortiment_leistung_1 trg
    SET  trg.produktwissen_pflege = src.produktwissen_pflege 
        , trg.lieferantenwissen_pflege = src.lieferantenwissen_pflege
    FROM PUBLIC.input_table_ek_sort_runtime src
        WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL)
        AND NULLIF(src.vorschlag,'' '') IS NULL AND NULLIF(src.listung_sst_pflege,'' '') IS NULL AND NULLIF(src.produktwissen_pflege,'' '') IS NOT NULL
                AND (src.OST_BASIS_PFLEGE_int = 0 AND src.OST_GROSS_PFLEGE_int = 0 AND src.SUED_OST_PFLEGE_int = 0 AND src.SUED_WEST_PFLEGE_int = 0 AND src.NORD_PFLEGE_int = 0)
                AND src.matching_id = trg.MATCHING_ID   
                AND src.kjmo = trg.kjmo 
                AND 1 = trg.mandant_id  
                AND src.kjwo_update = trg.kjwo_update;
            `; 
    sql = sql.replace(/''undefined''/g, "NULL") 
    sql_stmt = snowflake.createStatement({sqlText: sql}); 
    sql_stmt.execute(); 

}


// Check if SQL-Statement to be executed            
sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime src
            WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL)
            AND NULLIF(src.vorschlag,'' '') IS NULL AND NULLIF(src.listung_sst_pflege,'' '') IS NULL AND NULLIF(src.lieferantenwissen_pflege,'' '') IS NOT NULL 
                    AND src.region_summary2 = 0`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            sql_stmt.execute(); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_x = res.getColumnValue(1)            

if (row_count_x > 0){  
    // new Code
    sql= `UPDATE dbp_data.sortiment_leistung_1 trg
    SET  trg.produktwissen_pflege = src.produktwissen_pflege 
        , trg.lieferantenwissen_pflege = src.lieferantenwissen_pflege
    FROM PUBLIC.input_table_ek_sort_runtime src
        WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.GTIN IS NULL)
        AND NULLIF(src.vorschlag,'' '') IS NULL AND NULLIF(src.listung_sst_pflege,'' '') IS NULL AND NULLIF(src.lieferantenwissen_pflege,'' '') IS NOT NULL 
                AND src.region_summary2 = 0
                AND src.matching_id = trg.MATCHING_ID   
                AND src.kjmo = trg.kjmo 
                AND 1 = trg.mandant_id  
                AND src.kjwo_update = trg.kjwo_update;
            `; 
    sql = sql.replace(/''undefined''/g, "NULL") 
    sql_stmt = snowflake.createStatement({sqlText: sql}); 
    sql_stmt.execute(); 
}



// Check if SQL-Statement to be executed            
sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime b
            WHERE ((b.gtin IS NOT NULL AND b.GTIN NOT IN (-9999,-9998)) OR b.gtin IS NULL)
            AND (b.vorschlag NOT IN (''Zurücksetzen'', ''Keine Veränderung setzen'', ''Keine Veränderung'', ''Keine Veränderung zurücksetzen'', ''Produktwissen_1'', ''Lieferantenwissen_1'') OR b.vorschlag IS NULL)
            AND NOT (NULLIF(b.vorschlag,'' '') IS NULL AND NULLIF(b.listung_sst_pflege,'' '') IS NULL AND NULLIF(b.produktwissen_pflege,'' '') IS NOT NULL
            AND (b.OST_BASIS_PFLEGE_int = 0 AND b.OST_GROSS_PFLEGE_int = 0 AND b.SUED_OST_PFLEGE_int = 0 AND b.SUED_WEST_PFLEGE_int = 0 AND b.NORD_PFLEGE_int = 0)
            )`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            sql_stmt.execute(); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_y = res.getColumnValue(1)            

if (row_count_y > 0){  
    // else Z 277
    sql=`---------------------STEP1 ll 275
    ----BATCH_OPTIMIZED 
    UPDATE dbp_data.sortiment_leistung_1 A 
    SET  stk_re_pflege = B.STK_RE_PFLEGE  
    ,listungsaktion = NULL 
    ,produktwissen_pflege = B.PRODUKTWISSEN_PFLEGE  
    ,lieferantenwissen_pflege = B.LIEFERANTENWISSEN_PFLEGE  
    ,listung_sst_pflege = COALESCE(TRIM(B.LISTUNG_SST_PFLEGE ),''N/A'') 
    ,ost_basis_pflege = CASE B.OST_BASIS_PFLEGE_int WHEN ''0'' THEN '' '' WHEN ''1'' THEN ''X'' END 
    ,ost_gross_pflege = CASE B.OST_GROSS_PFLEGE_int WHEN ''0'' THEN '' '' WHEN ''1'' THEN ''X'' END 
    ,sued_ost_pflege = CASE B.SUED_OST_PFLEGE_int WHEN ''0'' THEN '' '' WHEN ''1'' THEN ''X'' END 
    ,sued_west_pflege = CASE B.SUED_WEST_PFLEGE_int WHEN ''0'' THEN '' '' WHEN ''1'' THEN ''X'' END 
    ,west_pflege = CASE B.WEST_PFLEGE_int WHEN ''0'' THEN '' '' WHEN ''1'' THEN ''X'' END 
    ,nord_pflege = CASE B.NORD_PFLEGE_int WHEN ''0'' THEN '' '' WHEN ''1'' THEN ''X'' END 
    FROM PUBLIC.input_table_ek_sort_runtime B 
    WHERE A.matching_id = B.MATCHING_ID  
    AND A.kjmo = B.KJMO  
    AND A.mandant_id = 1  
    AND A.kjwo_update = B.KJWO_UPDATE
    AND ((b.gtin IS NOT NULL AND b.GTIN NOT IN (-9999,-9998)) OR b.gtin IS NULL)
            AND (b.vorschlag NOT IN (''Zurücksetzen'', ''Keine Veränderung setzen'', ''Keine Veränderung'', ''Keine Veränderung zurücksetzen'', ''Produktwissen_1'', ''Lieferantenwissen_1'') OR b.vorschlag IS NULL)
            AND NOT (NULLIF(b.vorschlag,'' '') IS NULL AND NULLIF(b.listung_sst_pflege,'' '') IS NULL AND NULLIF(b.produktwissen_pflege,'' '') IS NOT NULL
            AND (b.OST_BASIS_PFLEGE_int = 0 AND b.OST_GROSS_PFLEGE_int = 0 AND b.SUED_OST_PFLEGE_int = 0 AND b.SUED_WEST_PFLEGE_int = 0 AND b.NORD_PFLEGE_int = 0)
            );`; 
                    sql = sql.replace(/''undefined''/g, "NULL") 
                    sql_stmt = snowflake.createStatement({sqlText: sql}); 
                    sql_stmt.execute(); 
}


// ändern von var_listung_sst_pflege; 
// if Z 298
sql=`UPDATE PUBLIC.input_table_ek_sort_runtime 
      SET LISTUNG_SST_PFLEGE = ''-1''
     WHERE Vorschlag = ''Auslisten'' --OR (NULLIF(listung_sst_pflege, '' '') IS NULL AND region_summary = 0)
      `
                  sql = sql.replace(/''undefined''/g, "NULL") 
                  sql_stmt = snowflake.createStatement({sqlText: sql}); 
                  sql_stmt.execute(); 



if(row_count_0 > 0){
// Case var_region_summary = 0
      sql =`CREATE OR REPLACE TEMPORARY DBP_MACRO.TABLE PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0
       AS
       SELECT *
         FROM PUBLIC.input_table_ek_sort_runtime src
      WHERE region_summary = 0
        AND ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
        AND (vorschlag NOT IN (''Zurücksetzen'', ''Keine Veränderung setzen'', ''Keine Veränderung'', ''Keine Veränderung zurücksetzen'', ''Produktwissen_1'', ''Lieferantenwissen_1'') or vorschlag is null)
        AND NOT (NULLIF(src.vorschlag,'' '') IS NULL AND NULLIF(src.listung_sst_pflege,'' '') IS NULL AND NULLIF(src.produktwissen_pflege,'' '') IS NOT NULL)
        -- new Code
        AND NOT (NULLIF(src.vorschlag,'' '') IS NULL AND NULLIF(src.listung_sst_pflege,'' '') IS NULL AND NULLIF(src.lieferantenwissen_pflege,'' '') IS NOT NULL)
        `
      sql = sql.replace(/''undefined''/g, "NULL") 
      sql_stmt = snowflake.createStatement({sqlText: sql}); 
      sql_stmt.execute();  

// Check if SQL-Statments have to be executed
      sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b
      WHERE (NULLIF(b.listung_sst_pflege, '' '') IS NOT NULL OR b.vorschlag = ''Auslisten'')`
      sql = sql.replace(/''undefined''/g, "NULL") 
      sql_stmt = snowflake.createStatement({sqlText: sql}); 
      res = sql_stmt.execute(); 
      res.next();
      row_count_a = res.getColumnValue(1)


      if(row_count_a > 0){


      sql=`---------------------STEP2a - Update for matching art_id 
      ----BATCH_OPTIMIZED 
      UPDATE dbp_data.sortiment_leistung_1 tgt 
      SET tgt.umsatz_hr = src.umsatz
         ,tgt.absatz_hr = src.absatz 
         ,tgt.rohertrag_hr = src.rohertrag 
         ,tgt.listungsaktion = src.vorschlag 
      FROM (WITH CTE_PRE AS 
                  (
                        SELECT DISTINCT * 
                          FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0
                        WHERE (NULLIF(listung_sst_pflege, '''') IS NOT NULL OR vorschlag = ''Auslisten'')
                  )
      , CTE AS 
      ( SELECT a.mandant_id, 
               a.art_id, 
               Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
               Max(a.status_1) AS status_1, 
               B.KJWO_UPDATE AS kjwo_update, 
               B.KJMO AS kjmo, 
               b.ART_ID AS input_art_id, 
               b.LISTUNG_SST_PFLEGE 
               --B.GTIN AS input_gtin, 
               --B.NL_ART_BEZ 
               --b.sst_only,
               --b.sst_reg_change,
               --b.n_reg_char, 
               --,b.w_reg_char  
               --,b.so_reg_char 
               --,b.sw_reg_char 
               --,b.ob_reg_char 
               --,b.og_reg_char
        FROM dbp_etl.art_matching_nielsen_per_1 a 
        INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b 
           ON a.art_matching_id = b.MATCHING_ID  
        WHERE (NULLIF(b.listung_sst_pflege, '''') IS NOT NULL OR b.vorschlag = ''Auslisten'')
          AND CASE
                  WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
                        THEN 1
                  WHEN trim(a.status_1) = ''N''
                        THEN 1
                  ELSE 0
               END = 1
        GROUP BY 1,2,5,6,7,8--, 9, 10,11,12,13,14,15,16
      ) 
      SELECT Sum(ifnull(x.anzahl_reduktion, 0)) AS anzahl_reduktion_, 
                         Sum(ifnull(x.anzahl_erweiterung, 0)) AS anzahl_erweiterung_, 
                         replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                         CASE
                                                         WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
                                                         WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_  THEN ''Listung reduzieren und erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_  THEN ''Listung erweitern und reduzieren''
									   WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
									   ELSE ''SOLL-Listung = IST-Listung''
                                                       END AS vorschlag, 
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0)
                        END AS umsatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS absatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS rohertrag,
                         MANDANT_ID, 
                       input_art_id AS ART_ID, 
                       KJWO_UPDATE, 
                       KJMO 
                   FROM (-- Nur SST gepflegt fuer Erweiterung!
                        SELECT a.art_id,
                               MAX(b.status_1) AS status_1,
                               MIN(a.list_kz) AS list_kz_,
                               SUM(a.umsatz_hr) AS umsatz_,
                               SUM(a.absatz_hr) AS absatz_,
                               SUM(a.rohertrag_hr) AS rohertrag_,
                               CAST(0 AS INT) AS anzahl_reduktion,
                               SUM(erweiterung_fg) AS anzahl_erweiterung,
                               CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END AS vorschlag_, 
                               b.MANDANT_ID, 
                               b.input_art_id, 
                      b.KJWO_UPDATE, 
                      b.KJMO 
                        FROM dbp_msi_data.kl_listung_1 a
                        JOIN CTE b
                          ON a.mandant_id = b.mandant_id AND
                             a.art_id = b.art_id AND
                             a.kjwo_update = b.kjwo_update AND 
                             a.sm_id_selected = b.listung_sst_pflege -- AND (b.sst_only = 1 OR b.sst_reg_change IN (1,4))
                        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                              a.listung_art = ''Listung erweitern'' AND                              
                             (a.nord = ''-'' AND 
                              a.ost_basis = ''-'' AND 
                              a.ost_gross = ''-'' AND 
                              a.sued_ost = ''-'' AND 
                              a.sued_west = ''-'' AND 
                              a.west = ''-'') 
                        GROUP BY 1,10,11,12,13
                        -- Nur SST gepflegt fuer Reduktion!
                        UNION ALL
                        SELECT a.art_id,
                               MAX(b.status_1) AS status_1,
                               MIN(a.list_kz) AS list_kz_,
                               SUM(a.umsatz_hr) AS umsatz_,
                               SUM(a.absatz_hr) AS absatz_,
                               SUM(a.rohertrag_hr) AS rohertrag_,
                               SUM(reduktion_fg) AS anzahl_reduktion,
                               CAST(0 AS INT) AS anzahl_erweiterung,
                               ''dynamic'' AS vorschlag_, 
                               b.MANDANT_ID, 
                               b.input_art_id, 
                      b.KJWO_UPDATE, 
                      b.KJMO 
                        FROM dbp_msi_data.kl_listung_1 a
                        JOIN dbp_data.wup_1 x
                          ON a.mandant_id = x.mandant_id AND
                             a.wup_id = x.wup_id 
                        JOIN CTE b
                          ON a.mandant_id = b.mandant_id AND
                             a.art_id = b.art_id AND
                             a.kjwo_update = b.kjwo_update AND
                             a.sm_id_selected = CAST(b.listung_sst_pflege AS INT) AND
                             a.sm_id < CAST(b.listung_sst_pflege AS INT)
                             /*CASE
                               WHEN b.sst_reg_change = 4 AND
                                   (trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.n_reg_char))  OR
                                    trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.w_reg_char))  OR
                                    trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.so_reg_char)) OR
                                    trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.sw_reg_char)) OR
                                    trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.ob_reg_char)) OR
                                    trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.og_reg_char)))
                               THEN 0
                               ELSE 1
                             END = 1 AND
                            (b.sst_only = 1 OR
                             b.sst_reg_change IN (2,4))*/
                        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                              a.listung_art = ''Listung reduzieren'' AND
                             (a.nord = ''-'' AND 
                              a.ost_basis = ''-'' AND 
                              a.ost_gross = ''-'' AND 
                              a.sued_ost = ''-'' AND 
                              a.sued_west = ''-'' AND 
                              a.west = ''-'')
                        GROUP BY 1, 10,11,12,13
                        -- Auslistung!
                        UNION ALL
                        SELECT a.art_id,
                               MAX(b.status_1) AS status_1,
                               MIN(a.list_kz) AS list_kz_,
                               SUM(a.umsatz_hr) AS umsatz_,
                               SUM(a.absatz_hr) AS absatz_,
                               SUM(a.rohertrag_hr) AS rohertrag_,
                               SUM(reduktion_fg) AS anzahl_reduktion,
                               CAST(0 AS INT) AS anzahl_erweiterung,
                               ''Auslistung'' AS vorschlag_, 
                               b.MANDANT_ID, 
                               b.input_art_id, 
                      b.KJWO_UPDATE, 
                      b.KJMO 
                        FROM dbp_msi_data.kl_listung_1 a
                        JOIN CTE b
                          ON a.mandant_id = b.mandant_id AND
                             a.art_id = b.art_id AND
                             a.kjwo_update = b.kjwo_update AND
                             a.sm_id_selected = CAST(b.listung_sst_pflege AS INT)
                        WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                              a.listung_art = ''Auslistung'' AND
                             (a.nord = ''-'' AND 
                              a.ost_basis = ''-'' AND 
                              a.ost_gross = ''-'' AND 
                              a.sued_ost = ''-'' AND 
                              a.sued_west = ''-'' AND 
                              a.west = ''-'')
                        GROUP BY 1,10,11,12,13
                         /*
                         UNION ALL
                        -- Regionen on top Erweiterung!!! 
                                SELECT a.art_id, 
                                        Max(b.status_1) AS status_1, 
                                        Sum(a.umsatz_hr) AS umsatz_, 
                                        Sum(a.absatz_hr) AS absatz_, 
                                        Sum(a.rohertrag_hr) AS rohertrag_, 
                                        Sum(CASE WHEN a.listung_art = ''Listung erweitern'' THEN 0 ELSE a.reduktion_fg END) AS anzahl_reduktion, 
                                        Sum(CASE WHEN a.listung_art = ''Listung erweitern'' THEN a.erweiterung_fg ELSE 0 END) AS anzahl_erweiterung, 
                                        --COUNT(*) AS anzahl_erweiterung, 
                                        Max(CASE WHEN a.listung_art = ''Auslistung'' THEN ''Auslistung'' 
                                           WHEN a.listung_art = ''Listung erweitern'' AND x.sm_id_selected IS NULL THEN ''Einlistung Kauflandartikel''  
                                           ELSE ''dynamic'' END) AS vorschlag_, 
                                        b.MANDANT_ID, 
                                        b.input_art_id, 
                               b.KJWO_UPDATE, 
                               b.KJMO 
                                    FROM dbp_msi_data.kl_listung_1 a 
                                    --JOIN dbp_msi_data.sortiment_art_1 b 
                                    INNER JOIN CTE b 
                                      ON a.mandant_id = b.mandant_id AND 
                                         a.art_id = b.art_id AND 
                                         a.kjwo_update = b.kjwo_update AND 
                                         a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
                                    LEFT JOIN (SELECT a.mandant_id, 
                                                      a.art_id, 
                                                      a.kjwo_update, 
                                                      a.sm_id_selected 
                                               FROM dbp_msi_data.kl_listung_1 a 
                                               INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b ON a.art_id = b.ART_ID 
                                               AND a.kjwo_update = b.KJWO_UPDATE  
                                               WHERE a.listung_art = ''Auslistung'' 
                                               GROUP BY 1,2,3,4 
                                               ) x ON a.mandant_id = x.mandant_id AND 
      a.art_id = x.art_id AND 
      a.kjwo_update = x.kjwo_update 
                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
                                          a.listung_art IN (''Listung erweitern'',''Listung reduzieren'',''Auslistung'') AND 
                                         (a.nord = ''-'' AND  
                                          a.ost_basis = ''-'' AND  
                                          a.ost_gross = ''-'' AND  
                                          a.sued_ost = ''-'' AND  
                                          a.sued_west = ''-'' AND  
                                          a.west = ''-'') AND 
                                          ''0'' = 0 
                                    GROUP BY 1,9,10,11,12 
                                    */
                                    /* UNION ALL 
                                    --K-Sicht fuer Nielsen (Nielsen 1)
                                    SELECT 1 AS art_id, 
                                           ''N'' AS status_1, 
                                           ''A'' AS list_kz,
                                           Sum(a.umsatz_hr) AS umsatz_, 
                                           Sum(a.absatz_hr) AS absatz_, 
                                           Sum(a.absatz_hr)*Sum(Cast(REPLACE(b.STK_RE_PFLEGE,'','',''.'') AS FLOAT)) AS rohertrag_, 
                                           Cast(0 AS INT) AS anzahl_reduktion, 
                                           Count(*) AS anzahl_erweiterung, 
                                           ''Einlistung Potenzialartikel'' AS vorschlag_, 
                                           a.MANDANT_ID,  
                                           b.ART_ID AS input_art_id, 
                             b.KJWO_UPDATE, 
                             b.KJMO 
                                    FROM dbp_msi_data.nl_listung_1 a 
                                    INNER JOIN CTE_PRE b 
                                      ON a.GTIN = b.GTIN AND 
                                    a.kjwo_update = b.kjwo_update AND 
                                    a.art_nielsen_bez = B.NL_ART_BEZ AND 
                                    a.sm_id_selected = B.LISTUNG_SST_PFLEGE 
                                    WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
                                          a.listung_art = ''Einlistung Potenzialartikel'' AND 
                                         (a.nord = ''-'' AND 
                                          a.ost_basis = ''-'' AND 
                                          a.ost_gross = ''-'' AND 
                                          a.sued_ost = ''-'' AND 
                                          a.sued_west = ''-'' AND 
                                          a.west = ''-'') AND 
                                          ''0'' = 0 
                                    GROUP BY 1,2,9,10,11,12 
                                    --HAVING umsatz_ <> 0 */
                                    UNION ALL 
                                    SELECT ART_ID AS art_id, 
                                           ''N'' AS status_1, 
                                           ''A'' AS list_kz,
                                           0 AS umsatz_, 
                                           0 AS absatz_, 
                                           0 AS rohertrag_, 
                                           0 AS anzahl_reduktion, 
                                           0 AS anzahl_erweiterung, 
                                           --COUNT(*) AS anzahl_erweiterung, 
                                           Cast(''dynamic'' AS VARCHAR(100)) AS vorschlag_ 
                                           ,1 AS MANDANT_ID  
                                           ,ART_ID AS input_art_id 
                             ,KJWO_UPDATE 
                             ,KJMO 
                                      FROM CTE_PRE
                                    --FROM dbp_data.tag_1 
                                    --WHERE dat = CURRENT_DATE() 
                                    ) x 
                             GROUP BY MANDANT_ID  
                             ,input_art_id  
                             ,KJWO_UPDATE 
                             ,KJMO 
                                    ) src                           
      WHERE tgt.mandant_id = src.mandant_id 
      AND tgt.art_id = src.art_id 
      AND tgt.kjmo = src.kjmo 
      AND tgt.kjwo_update = src.kjwo_update;`; 
                        sql = sql.replace(/''undefined''/g, "NULL") 
                        sql_stmt = snowflake.createStatement({sqlText: sql}); 
                        sql_stmt.execute();                   
       
      // Check if SQL-Statments Step 2b have to be executed
      sql = `WITH CTE_PRE AS 
                  (
                        SELECT DISTINCT KJWO_UPDATE 
                             ,KJMO 
                             ,GTIN 
                             ,NL_ART_BEZ 
                             ,ART_ID
                             ,LISTUNG_SST_PFLEGE  
                          FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 
                        WHERE (NULLIF(listung_sst_pflege, '''') IS NOT NULL OR vorschlag = ''Auslisten'')
                  )
      , CTE AS 
      ( SELECT a.mandant_id, 
               a.art_id, 
               Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
               Max(a.status_1) AS status_1, 
               B.KJWO_UPDATE AS kjwo_update, 
               B.KJMO AS kjmo, 
               --b.ART_ID AS input_art_id, 
               b.LISTUNG_SST_PFLEGE, 
               B.GTIN AS input_gtin, 
               B.NL_ART_BEZ 
        FROM dbp_etl.art_matching_nielsen_per_1 a 
        INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b 
           ON a.art_matching_id = b.MATCHING_ID  
        WHERE (NULLIF(b.listung_sst_pflege, '''') IS NOT NULL OR b.vorschlag = ''Auslisten'')
        AND CASE
                  WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
                        THEN 1
                  WHEN trim(a.status_1) = ''N''
                        THEN 1
                  ELSE 0
            END = 1
        GROUP BY 1,2,5,6,7,8,9 
      ) 
      SELECT COUNT(1)
      FROM dbp_msi_data.nl_listung_1 a 
      INNER JOIN CTE_PRE b ON a.GTIN = b.GTIN AND 
      a.kjwo_update = b.kjwo_update AND 
      a.art_nielsen_bez = B.NL_ART_BEZ AND 
      a.sm_id_selected = B.LISTUNG_SST_PFLEGE 
      WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
            a.listung_art = ''Einlistung Potenzialartikel'' AND 
           (a.nord = ''-'' AND 
            a.ost_basis = ''-'' AND 
            a.ost_gross = ''-'' AND 
            a.sued_ost = ''-'' AND 
            a.sued_west = ''-'' AND 
            a.west = ''-'') AND 
            ''0'' = 0
      UNION
      SELECT COUNT(1) 
      FROM CTE_PRE
      INNER JOIN dbp_data.sortiment_leistung_1 sl
         ON sl.mandant_id = 1
         AND CTE_PRE.kjmo = sl.kjmo 
         AND CTE_PRE.kjwo_update = sl.kjwo_update
         AND CTE_PRE.gtin = sl.gtin 
         AND CTE_PRE.nl_art_bez = sl.nielsen_art_bez 
      UNION
      SELECT COUNT(1)   
      FROM dbp_msi_data.nl_listung_1 a 
      JOIN CTE b 
        ON 1 = b.mandant_id AND 
           a.kjwo_update = b.kjwo_update AND 
           a.sm_id_selected = b.Listung_SST_Pflege
      INNER JOIN CTE_PRE d
        ON d.gtin = b.gtin_id 
      JOIN dbp_etl.bf_sort_sal_export_1 c 
        ON b.art_id/100 = Cast(c.art_nr AS INT) 
      --INNER JOIN dbp_etl.not_listed_basis_1 e
      --  ON a.gtin = e.gtin_id
      --AND d.gtin = e.gtin_id
      WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = d.gtin) AND 
           a.listung_art = ''Listung erweitern'' AND 
           (a.nord = ''-'' AND 
            a.ost_basis = ''-'' AND 
            a.ost_gross = ''-'' AND 
            a.sued_ost = ''-'' AND 
            a.sued_west = ''-'' AND 
            a.west = ''-'') AND 
            ''0'' = 0 
      `
      
      sql = sql.replace(/''undefined''/g, "NULL") 
      sql_stmt = snowflake.createStatement({sqlText: sql}); 
      res = sql_stmt.execute(); 
      res.next();
      row_count_2b = res.getColumnValue(1)

      if(row_count_2b > 0){

      

       
      sql=`---------------------STEP2b - Update for matching gtin and nielsen_art_bez ll 322
      ----BATCH_OPTIMIZED 
      UPDATE dbp_data.sortiment_leistung_1 tgt 
      SET tgt.umsatz_hr = src.umsatz 
         ,tgt.absatz_hr = src.absatz 
         ,tgt.rohertrag_hr = src.rohertrag 
         ,tgt.listungsaktion = src.vorschlag 
      FROM (WITH CTE_PRE AS 
                  (
                        SELECT DISTINCT * 
                          FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 
                        WHERE (NULLIF(listung_sst_pflege, '''') IS NOT NULL OR vorschlag = ''Auslisten'')
                  )
      , CTE AS 
      ( SELECT a.mandant_id, 
               a.art_id, 
               Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
               Max(a.status_1) AS status_1, 
               B.KJWO_UPDATE AS kjwo_update, 
               B.KJMO AS kjmo, 
               --b.ART_ID AS input_art_id, 
               b.LISTUNG_SST_PFLEGE, 
               B.GTIN AS input_gtin, 
               B.NL_ART_BEZ 
        FROM dbp_etl.art_matching_nielsen_per_1 a 
        INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b 
           ON a.art_matching_id = b.MATCHING_ID  
        WHERE (NULLIF(b.listung_sst_pflege, '''') IS NOT NULL OR b.vorschlag = ''Auslisten'')
        AND CASE
                  WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
                        THEN 1
                  WHEN trim(a.status_1) = ''N''
                        THEN 1
                  ELSE 0
            END = 1
        GROUP BY 1,2,5,6,7,8,9 
      ) 
      SELECT Sum(ifnull(x.anzahl_reduktion, 0)) AS anzahl_reduktion_, 
                         Sum(ifnull(x.anzahl_erweiterung, 0)) AS anzahl_erweiterung_, 
                         replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                         CASE
                                                         WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
                                                         WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_  THEN ''Listung reduzieren und erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_  THEN ''Listung erweitern und reduzieren''
									   WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
									   ELSE ''SOLL-Listung = IST-Listung''
                                                       END AS vorschlag, 
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS umsatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS absatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS rohertrag,
                         MANDANT_ID, 
                       KJWO_UPDATE, 
                       KJMO,
                       gtin, 
                       nl_art_bez AS nielsen_art_bez                 
                   FROM (/*-- Regionen on top Erweiterung!!! 
                                SELECT a.art_id, 
                                        Max(b.status_1) AS status_1, 
                                        Sum(a.umsatz_hr) AS umsatz_, 
                                        Sum(a.absatz_hr) AS absatz_, 
                                        Sum(a.rohertrag_hr) AS rohertrag_, 
                                        Sum(CASE WHEN a.listung_art = ''Listung erweitern'' THEN 0 ELSE a.reduktion_fg END) AS anzahl_reduktion, 
                                        Sum(CASE WHEN a.listung_art = ''Listung erweitern'' THEN a.erweiterung_fg ELSE 0 END) AS anzahl_erweiterung, 
                                        --COUNT(*) AS anzahl_erweiterung, 
                                        Max(CASE WHEN a.listung_art = ''Auslistung'' THEN ''Auslistung'' 
                                           WHEN a.listung_art = ''Listung erweitern'' AND x.sm_id_selected IS NULL THEN ''Einlistung Kauflandartikel''  
                                           ELSE ''dynamic'' END) AS vorschlag_, 
                                        b.MANDANT_ID, 
                               b.KJWO_UPDATE, 
                               b.KJMO, 
                               b.input_gtin, 
                               b.nl_art_bez 
                                    FROM dbp_msi_data.kl_listung_1 a 
                                    --JOIN dbp_msi_data.sortiment_art_1 b 
                                    INNER JOIN CTE b 
                                      ON a.mandant_id = b.mandant_id AND 
                                         a.art_id = b.art_id AND 
                                         a.kjwo_update = b.kjwo_update AND 
                                         a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
                                    LEFT JOIN (SELECT a.mandant_id, 
                                                      a.art_id, 
                                                      a.kjwo_update, 
                                                      a.sm_id_selected 
                                               FROM dbp_msi_data.kl_listung_1 a 
                                               INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b 
                                                ON a.art_id = b.ART_ID 
                                               AND a.kjwo_update = b.KJWO_UPDATE  
                                               WHERE a.listung_art = ''Auslistung'' 
                                               GROUP BY 1,2,3,4 
                                               ) x ON a.mandant_id = x.mandant_id AND 
      a.art_id = x.art_id AND 
      a.kjwo_update = x.kjwo_update 
                                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
                                          a.listung_art IN (''Listung erweitern'',''Listung reduzieren'',''Auslistung'') AND 
                                         (a.nord = ''-'' AND  
                                          a.ost_basis = ''-'' AND  
                                          a.ost_gross = ''-'' AND  
                                          a.sued_ost = ''-'' AND  
                                          a.sued_west = ''-'' AND  
                                          a.west = ''-'') AND 
                                          ''0'' = 0 
                                    GROUP BY 1,9,10,11,12,13 
                                    UNION ALL */
                                    SELECT 1 AS art_id, 
                                           ''N'' AS status_1, 
                                           ''A'' AS list_kz, 
                                           Sum(a.umsatz_hr) AS umsatz_, 
                                           Sum(a.absatz_hr) AS absatz_, 
                                           Sum(a.absatz_hr)*Sum(Cast(REPLACE(b.STK_RE_PFLEGE,'','',''.'') AS FLOAT)) AS rohertrag_, 
                                           Cast(0 AS INT) AS anzahl_reduktion, 
                                           Count(*) AS anzahl_erweiterung, 
                                           ''Einlistung Potenzialartikel'' AS vorschlag_, 
                                           a.MANDANT_ID,  
                             b.KJWO_UPDATE, 
                             b.KJMO, 
                               b.GTIN, 
                               b.NL_ART_BEZ  
                                    FROM dbp_msi_data.nl_listung_1 a 
                                    INNER JOIN CTE_PRE b ON a.GTIN = b.GTIN AND 
                                    a.kjwo_update = b.kjwo_update AND 
                                    a.art_nielsen_bez = B.NL_ART_BEZ AND 
                                    a.sm_id_selected = B.LISTUNG_SST_PFLEGE 
                                    WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
                                          a.listung_art = ''Einlistung Potenzialartikel'' AND 
                                         (a.nord = ''-'' AND 
                                          a.ost_basis = ''-'' AND 
                                          a.ost_gross = ''-'' AND 
                                          a.sued_ost = ''-'' AND 
                                          a.sued_west = ''-'' AND 
                                          a.west = ''-'') AND 
                                          ''0'' = 0 
                                    GROUP BY 1,2,3,10,11,12,13,14
                                    --HAVING umsatz_ <> 0 
                                    UNION ALL 
                                    SELECT ART_ID AS art_id, 
                                           ''N'' AS status_1, 
                                           ''A'' AS list_kz,
                                           0 AS umsatz_, 
                                           0 AS absatz_, 
                                           0 AS rohertrag_, 
                                           0 AS anzahl_reduktion, 
                                           0 AS anzahl_erweiterung, 
                                           --COUNT(*) AS anzahl_erweiterung, 
                                           Cast(''dynamic'' AS VARCHAR(100)) AS vorschlag_ 
                                           ,1 AS MANDANT_ID  
                             ,KJWO_UPDATE 
                             ,KJMO 
                             ,GTIN 
                             ,NL_ART_BEZ 
                                      FROM CTE_PRE
                                    --FROM dbp_data.tag_1 
                                    --WHERE dat = CURRENT_DATE()  
      ----- Urspr auskommentiert
                                    UNION ALL 
                                      -- K-Sicht fuer Nielsen (Nielsen 2) 
                                      -- NUR FUER KL-ARTIKEL_1, DIE AUS NIELSEN KALKULIERT WERDEN! 
                                      SELECT b.art_id, 
                                             Max(b.status_1) AS status_1, 
                                             Max(''A'') as list_kz, 
                                             Sum(a.umsatz_hr) AS umsatz_, 
                                             Sum(a.absatz_hr) AS absatz_, 
                                             Sum(a.absatz_hr*Coalesce(Cast(REPLACE(d.stk_re_pflege,'','',''.'') AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_, 
                                             Cast(0 AS INT) AS anzahl_reduktion, 
                                             Count(*) AS anzahl_erweiterung, 
                                             ''Einlistung Kauflandartikel'' AS vorschlag_ 
                                            ,1 AS MANDANT_ID  
                               ,d.KJWO_UPDATE 
                               ,d.KJMO 
                               ,d.GTIN 
                               ,d.NL_ART_BEZ 
                                      FROM dbp_msi_data.nl_listung_1 a 
                                      JOIN CTE b 
                                        ON 1 = b.mandant_id AND 
                                           a.kjwo_update = b.kjwo_update AND 
                                           a.sm_id_selected = b.Listung_SST_Pflege
                                      INNER JOIN CTE_PRE d
                                        ON d.gtin = b.gtin_id 
                                      JOIN dbp_etl.bf_sort_sal_export_1 c 
                                        ON b.art_id/100 = Cast(c.art_nr AS INT) 
                                      --INNER JOIN dbp_etl.not_listed_basis_1 e
                                      --  ON a.gtin = e.gtin_id
                                      --AND d.gtin = e.gtin_id
                                      WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = d.gtin) AND 
                                           a.listung_art = ''Listung erweitern'' AND 
                                           (a.nord = ''-'' AND 
                                            a.ost_basis = ''-'' AND 
                                            a.ost_gross = ''-'' AND 
                                            a.sued_ost = ''-'' AND 
                                            a.sued_west = ''-'' AND 
                                            a.west = ''-'') AND 
                                            ''0'' = 0 
                                      GROUP BY 1 ,  11, 12, 13, 14
                                      --HAVING umsatz_ <> 0 
                                    ) x 
                             GROUP BY MANDANT_ID  
                             ,KJWO_UPDATE 
                             ,KJMO 
                             ,gtin 
                             ,NL_ART_BEZ 
                                    ) src                           
      WHERE tgt.mandant_id = src.mandant_id 
      AND tgt.gtin = src.gtin 
      AND tgt.kjmo = src.kjmo 
      AND tgt.nielsen_art_bez = src.nielsen_art_bez 
      AND tgt.kjwo_update = src.kjwo_update;` 
                        sql = sql.replace(/''undefined''/g, "NULL") 
                        sql_stmt = snowflake.createStatement({sqlText: sql}); 
                        sql_stmt.execute(); 
      }



                        
sql = `UPDATE dbp_data.sortiment_leistung_1 trg
                        SET trg.listungsaktion = src.listungsaktion
                        FROM 
                        (SELECT CASE
                                    WHEN b.region_summary IN (1,0)
                                          THEN
                                          CASE
                                                WHEN NULLIF(a.listung_sst_mvke,''N/A'') IS NULL AND
                                                      GREATEST(COALESCE(a.ost_basis,'' ''),COALESCE(a.ost_gross,'' ''),COALESCE(a.sued_ost,'' ''),COALESCE(a.sued_west,'' ''),COALESCE(a.west,'' ''),COALESCE(a.nord,'' '')) = '' '' AND
                                                      a.anz_maerkte_sst = 0 AND a.anz_maerkte_baustein_sonstige = 0 AND a.anz_maerkte_listung_einzel = 0 AND a.anz_maerkte_listung_gesamt = 0
                                                THEN ''Einlistung Kauflandartikel''
                                          ELSE listungsaktion
                                          END
                               ELSE listungsaktion
                              END AS listungsaktion
                              , b.matching_id
                              , b.kjmo
                              , b.kjwo_update
                        FROM dbp_data.sortiment_leistung_1 a
                        INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b
                        ON a.kjmo = b.kjmo AND 
                        a.kjwo_update = b.kjwo_update AND
                        a.matching_id = b.matching_id
                        WHERE a.mandant_id = 1 AND 
                        a.art_id IS NOT NULL AND 
                        (NULLIF(b.listung_sst_pflege, '' '') IS NOT NULL OR b.vorschlag = ''Auslisten'')
                        ) src
                        WHERE trg.mandant_id = 1 AND
                        trg.kjmo = src.kjmo AND
                        trg.kjwo_update = src.kjwo_update AND
                        trg.matching_id = src.matching_id;
                        ;`
                        sql = sql.replace(/''undefined''/g, "NULL") 
                        sql_stmt = snowflake.createStatement({sqlText: sql}); 
                        sql_stmt.execute();


//-------------------------------------------------------------------------------------------------------- 
//--   (II) INSERT FUER ERWARTETE ENTWICKLUNG (mit K-Stufen) 
//-------------------------------------------------------------------------------------------------------- 
// ll 645

// if ((''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'').includes(var_vorschlag_hr) == false) 
// 3 Commands - bis Z. 1229

// Check if SQL-Statments have to be executed
    sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b
    WHERE (vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or vorschlag IS NULL)
    AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')`
    sql = sql.replace(/''undefined''/g, "NULL") 
    sql_stmt = snowflake.createStatement({sqlText: sql}); 
    res = sql_stmt.execute(); 
    res.next();
    row_count_b = res.getColumnValue(1)

    if(row_count_b > 0){

sql=`---------------------STEP_Delete
                  ----BATCH_OPTIMIZED 
DELETE FROM dbp_msi_data.erwartete_entwicklung_1 a
                  using ( SELECT DISTINCT kjmo, 
                                 matching_id, 
                                 Kjwo_update
                            FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 
                          WHERE (vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or vorschlag IS NULL)
                          AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')
                  ) d
                  WHERE a.matching_id = d.matching_id  AND 
                       a.kjmo = d.kjmo AND 
                       a.kjwo_update = d.kjwo_update AND 
                       a.mandant_id = 1`; 
                                    sql = sql.replace(/''undefined''/g, "NULL") 
                                    sql_stmt = snowflake.createStatement({sqlText: sql}); 
                                    sql_stmt.execute(); 




sql=`---------------------STEP_INSERT
                                    ----BATCH_OPTIMIZED 
                                    INSERT INTO dbp_msi_data.erwartete_entwicklung_1 (mandant_id 
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
WITH CTE_PRE AS 
(
      SELECT DISTINCT * 
      FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 
      WHERE (vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or vorschlag IS NULL)
      AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')
)
SELECT DISTINCT 1 AS mandant_id 
    ,x.kjmo AS kjmo 
    ,x.matching_id 
    ,x.sm_id 
    ,'' '' AS ksm_id 
    ,x.KJWO_UPDATE AS kjwo_update 
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
    ,ifnull(Coalesce(Sum(x.umsatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS umsatz 
    ,ifnull(Coalesce(Sum(x.absatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS absatz 
    ,ifnull(Coalesce(Sum(x.rohertrag_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS rohertrag 
FROM (
                  WITH CTE AS 
                  ( SELECT a.mandant_id, 
                        a.art_id, 
                        Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
                        Max(a.status_1) AS status_1, 
                        B.KJWO_UPDATE AS kjwo_update, 
                        B.KJMO AS kjmo, 
                        --b.ART_ID AS input_art_id, 
                        b.LISTUNG_SST_PFLEGE, 
                        B.GTIN AS input_gtin, 
                        B.NL_ART_BEZ , 
                        b.matching_id
                  FROM dbp_etl.art_matching_nielsen_per_1 a 
                  INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b 
                   ON a.art_matching_id = b.MATCHING_ID  
                   WHERE (b.vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or b.vorschlag is null)
                   AND (NULLIF(b.listung_sst_pflege, '' '') IS NOT NULL OR b.vorschlag = ''Auslisten'')
                   AND CASE
                        WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
                              THEN 1
                        WHEN trim(a.status_1) = ''N''
                              THEN 1
                        ELSE 0
                  END = 1                  
                  GROUP BY 1,2,5,6,7,8,9, 10
                  ) 
    SELECT b.matching_id AS matching_id, 
           a.sm_id, 
           a.nord, 
           a.ost_basis, 
           a.ost_gross, 
           a.sued_ost, 
           a.sued_west, 
           a.west, 
           a.art_id, 
  b.kjmo, 
  b.kjwo_update,
           Max(b.status_1) AS status_1, 
           Sum(a.umsatz_hr) AS umsatz_, 
           Sum(a.absatz_hr) AS absatz_, 
           Sum(a.rohertrag_hr) AS rohertrag_ 
    FROM dbp_msi_data.kl_listung_1 a 
    --JOIN dbp_msi_data.sortiment_art_1 b 
    INNER JOIN CTE b
    ON a.mandant_id = b.mandant_id AND 
    a.art_id = b.art_id AND 
    a.kjwo_update = b.kjwo_update AND 
    a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
          a.listung_art IN (''Listung erweitern'', ''Listung reduzieren'', ''Auslistung'') AND
         (a.nord = ''-'' AND  
          a.ost_basis = ''-'' AND  
          a.ost_gross = ''-'' AND  
          a.sued_ost = ''-'' AND  
          a.sued_west = ''-'' AND  
          a.west = ''-'') AND 
          ''0'' = 0 
    GROUP BY 1,2,3,4,5,6,7,8,9 , 10, 11
    HAVING Round(umsatz_,1) <> 0 
    UNION ALL 
    --K-Sicht fuer Nielsen (Nielsen 1) 
    SELECT d.matching_id AS matching_id, 
           sm_id, 
           nord, 
           ost_basis, 
           ost_gross, 
           sued_ost, 
           sued_west, 
           west, 
           1 AS art_id, 
           ''N'' AS status_1, 
    d.kjmo, 
  d.kjwo_update,
           Sum(umsatz_hr) AS umsatz_, 
           Sum(absatz_hr) AS absatz_, 
           Sum(absatz_hr)*Cast(REPLACE(d.stk_re_pflege ,'','',''.'') AS FLOAT) AS rohertrag_ 
    FROM dbp_msi_data.nl_listung_1 a
    INNER JOIN cte_pre d
       ON a.gtin = d.gtin AND 
          a.kjwo_update = d.kjwo_update  AND 
          a.art_nielsen_bez = d.NL_ART_BEZ  AND 
          a.sm_id_selected = d.listung_sst_pflege 
    WHERE --d.vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') AND
            a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
          a.listung_art = ''Einlistung Potenzialartikel'' AND 
         (a.nord = ''-'' AND 
          a.ost_basis = ''-'' AND 
          a.ost_gross = ''-'' AND 
          a.sued_ost = ''-'' AND 
          a.sued_west = ''-'' AND 
          a.west = ''-'') AND 
          ''0'' = 0 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12, d.stk_re_pflege
    HAVING Round(umsatz_,1) <> 0 
    UNION ALL 
    -- K-Sicht fuer Nielsen (Nielsen 2) 
    -- NUR FUER KL-ARTIKEL_1, DIE AUS NIELSEN KALKULIERT WERDEN! 
    SELECT b.matching_id AS matching_id, 
           a.sm_id, 
           a.nord, 
           a.ost_basis, 
           a.ost_gross, 
           a.sued_ost, 
           a.sued_west, 
           a.west, 
           b.art_id, 
    b.kjmo, 
  b.kjwo_update,
           Max(b.status_1) AS status_1, 
           Sum(a.umsatz_hr) AS umsatz_, 
           Sum(a.absatz_hr) AS absatz_, 
           Sum(a.absatz_hr*Coalesce(Cast(REPLACE(d.stk_re_pflege ,'','',''.'') AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_ 
    FROM dbp_msi_data.nl_listung_1 a 
    --JOIN dbp_msi_data.sortiment_art_1 b 
    INNER JOIN CTE b
    ON 1 = b.mandant_id AND 
    a.kjwo_update = b.kjwo_update AND 
    a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
     INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 d
      ON d.gtin = b.gtin_id
    JOIN dbp_etl.bf_sort_sal_export_1 c 
      ON b.art_id/100 = Cast(c.art_nr AS INT) 
    WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = d.gtin) AND 
          a.listung_art = ''Listung erweitern'' AND 
         (a.nord = ''-'' AND 
          a.ost_basis = ''-'' AND 
          a.ost_gross = ''-'' AND 
          a.sued_ost = ''-'' AND 
          a.sued_west = ''-'' AND 
          a.west = ''-'') AND 
          ''0'' = 0 
    GROUP BY 1,2,3,4,5,6,7,8,9 , 10, 11
    HAVING Round(umsatz_,1) <> 0 
    ) x 
JOIN (SELECT art_matching_id, 
           Max(kl_wg_id) AS kl_wg_id, 
           Max(kl_owg_id) AS kl_owg_id, 
           Max(kl_uwg_id) AS kl_uwg_id 
    FROM dbp_etl.art_matching_nielsen_per_1 
    GROUP BY 1) y 
ON x.matching_id = y.art_matching_id 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20; `
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();             

    }
      }




// Nur Case: var_region_summary = 1 :
//-------------------------------------------------------------------------------------------------------- 
//--   (III) UPDATE FUER SORTIMENT_LEISTUNG_1 (nur Regionen) 
//-------------------------------------------------------------------------------------------------------- 

// else if ((var_listung_sst_pflege == '' '' || var_listung_sst_pflege == undefined) AND (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'').includes(var_vorschlag_hr) == false)
// Z 1247


// Check if SQL-Statments have to be executed
sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b
WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
res = sql_stmt.execute(); 
res.next();
row_count_c = res.getColumnValue(1)

if(row_count_c > 0){


// ein Update-Stmt jetzt auch im 0-Fall
// Update for matching art_id ART_ID
sql = `UPDATE dbp_data.sortiment_leistung_1 tgt 
SET tgt.umsatz_hr = ifnull(src.umsatz ,0)
   ,tgt.absatz_hr = ifnull(src.absatz,0) 
   ,tgt.rohertrag_hr = ifnull(src.rohertrag ,0)
   ,tgt.listungsaktion = src.vorschlag 
FROM (WITH CTE_PRE AS 
      (
            SELECT DISTINCT * 
              FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b
            WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
      )
, CTE AS 
( SELECT a.mandant_id, 
         a.art_id, 
         Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
         Max(a.status_1) AS status_1, 
         B.KJWO_UPDATE AS kjwo_update, 
         B.KJMO AS kjmo, 
         b.ART_ID AS input_art_id, 
         b.LISTUNG_SST_PFLEGE, 
         --B.GTIN AS input_gtin, 
         --B.NL_ART_BEZ, 
         b.nord_pflege, 
         b.ost_basis_pflege, 
         b.ost_gross_pflege, 
         b.sued_ost_pflege, 
         b.sued_west_pflege, 
         b.west_pflege, 
         b.region_only
  FROM dbp_etl.art_matching_nielsen_per_1 a 
  INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b ON a.art_matching_id = b.MATCHING_ID  
  WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
  AND
            CASE
              WHEN trim(a.status_1) <> ''N'' AND
                   trim(a.list_kz) = ''A''
              THEN 1
              WHEN trim(a.status_1) = ''N''
              THEN 1
              ELSE 0
            END = 1
  GROUP BY 1,2,5,6,7,8 ,9,10,11,12,13,14, 15
) 
SELECT Sum(x.anzahl_reduktion) AS anzahl_reduktion_, 
                   Sum(x.anzahl_erweiterung) AS anzahl_erweiterung_, 
                   replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                   CASE WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__ 
WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN ''Listung reduzieren und erweitern'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN ''Listung erweitern und reduzieren'' 
WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung'' 
ELSE ''nicht möglich'' END AS vorschlag, 
CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS umsatz,
                                                       CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS absatz,
                                                       CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS rohertrag,
                   MANDANT_ID, 
                 input_art_id AS ART_ID, 
                 KJWO_UPDATE, 
                 KJMO 
             FROM (-- KL nur Regionen; Erweiterung!!! 
                     SELECT a.art_id,
                     MAX(b.status_1) AS status_1,
                     MIN(a.list_kz) AS list_kz_,
                     SUM(a.umsatz_hr) AS umsatz_,
                     SUM(a.absatz_hr) AS absatz_,
                     SUM(a.rohertrag_hr) AS rohertrag_,
                     SUM(CASE WHEN a.listung_art = ''Listung erweitern'' THEN cast(0 as int)
                              WHEN a.Listung_art = ''Listung reduzieren'' THEN reduktion_fg
                         END) AS anzahl_reduktion,
                     SUM(CASE WHEN a.listung_art = ''Listung erweitern'' THEN erweiterung_fg
                              WHEN a.Listung_art = ''Listung reduzieren'' THEN cast(0 as int)
                        END) AS anzahl_erweiterung,
                        CASE WHEN a.listung_art = ''Listung erweitern'' THEN
                                                      CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END 
                              WHEN a.listung_art = ''Listung reduzieren'' THEN ''dynamic''
                        END
                     AS vorschlag_,
              b.MANDANT_ID, 
                                  b.input_art_id, 
                         b.KJWO_UPDATE, 
                         b.KJMO 
                              FROM dbp_msi_data.kl_listung_1 a 
                              JOIN CTE b
                              ON a.mandant_id = b.mandant_id AND
                                 a.art_id = b.art_id AND
                                 a.kjwo_update = b.kjwo_update AND
                                 (trim(a.nord) = trim(b.nord_pflege) OR 
                                  trim(a.ost_basis) = trim(b.ost_basis_pflege) OR
                                    trim(a.ost_gross) = trim(b.ost_gross_pflege) OR
                                    trim(a.sued_ost) = trim(b.sued_ost_pflege) OR
                                    trim(a.sued_west) = trim(b.sued_west_pflege) OR
                                    trim(a.west) = trim(b.west_pflege)) AND
                                  b.region_only = 1
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                                  a.listung_art in (''Listung reduzieren'', ''Listung erweitern'') AND
                                  a.sm_id_selected = 0 
                        GROUP BY 1,10,11,12,13  , a.listung_art
                        ) x
                        GROUP BY MANDANT_ID  
                        ,input_art_id  
                        ,KJWO_UPDATE 
                        ,KJMO 
                               ) src                           
 WHERE tgt.mandant_id = src.mandant_id 
 AND tgt.art_id = src.art_id 
 AND tgt.kjmo = src.kjmo 
 AND tgt.kjwo_update = src.kjwo_update;                     
                              ` 
                              sql = sql.replace(/''undefined''/g, "NULL") 
                              sql_stmt = snowflake.createStatement({sqlText: sql}); 
                              sql_stmt.execute();  





sql = `UPDATE dbp_data.sortiment_leistung_1 trg
                              SET trg.listungsaktion = src.listungsaktion
                              FROM 
                              (SELECT CASE
                                          WHEN b.region_only = 1
                                                THEN
                                                CASE
                                                      WHEN NULLIF(a.listung_sst_mvke,''N/A'') IS NULL AND
                                                            GREATEST(COALESCE(a.ost_basis,'' ''),COALESCE(a.ost_gross,'' ''),COALESCE(a.sued_ost,'' ''),COALESCE(a.sued_west,'' ''),COALESCE(a.west,'' ''),COALESCE(a.nord,'' '')) = '' '' AND
                                                            a.anz_maerkte_sst = 0 AND a.anz_maerkte_baustein_sonstige = 0 AND a.anz_maerkte_listung_einzel = 0 AND a.anz_maerkte_listung_gesamt = 0
                                                      THEN ''Einlistung Kauflandartikel''
                                                ELSE listungsaktion
                                                END
                                     ELSE listungsaktion
                                    END AS listungsaktion
                                    , b.matching_id
                                    , b.kjmo
                                    , b.kjwo_update
                              FROM dbp_data.sortiment_leistung_1 a
                              INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b
                              ON a.kjmo = b.kjmo AND 
                              a.kjwo_update = b.kjwo_update AND
                              a.matching_id = b.matching_id
                              WHERE a.mandant_id = 1 AND 
                              a.art_id IS NOT NULL AND 
                              NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
                              ) src
                              WHERE trg.mandant_id = 1 AND
                              trg.kjmo = src.kjmo AND
                              trg.kjwo_update = src.kjwo_update AND
                              trg.matching_id = src.matching_id;
                              ;`
                              sql = sql.replace(/''undefined''/g, "NULL") 
                              sql_stmt = snowflake.createStatement({sqlText: sql}); 
                              sql_stmt.execute();   
                              
                              

//-------------------------------------------------------------------------------------------------------- 
//--   (IV) INSERT FUER ERWARTETE ENTWICKLUNG (nur Regionen) 
//-------------------------------------------------------------------------------------------------------- 
// if ((''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'').includes(var_vorschlag_hr) == false)
// Z. 1428 ff
// FILTER VORSCHLAG NOT IN (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'')
// vergleich: vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'')

// Filter von (III): NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'')
// neuer Filter:  NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'')

// Check if SQL-Statments have to be executed
sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 d
WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag IS NULL)`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
res = sql_stmt.execute(); 
res.next();
row_count_d = res.getColumnValue(1)

if(row_count_d > 0){


sql=`DELETE FROM dbp_msi_data.erwartete_entwicklung_1 a 
            USING PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 d
      WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag IS NULL) AND
            a.matching_id = d.matching_id AND 
            a.kjmo = d.kjmo AND 
            a.kjwo_update = d.kjwo_update AND 
            a.mandant_id = 1`

sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); 




// Insert for matching art_id
sql = `INSERT INTO dbp_msi_data.erwartete_entwicklung_1 (mandant_id 
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
WITH CTE_PRE AS 
      (
            SELECT DISTINCT * 
              FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 d
            WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag IS NULL)
      )
SELECT DISTINCT 1 AS mandant_id 
,x.kjmo AS kjmo 
,x.matching_id 
,x.sm_id 
,'' '' AS ksm_id 
,x.KJWO_UPDATE AS kjwo_update 
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
,ifnull(Coalesce(Sum(x.umsatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS umsatz 
,ifnull(Coalesce(Sum(x.absatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS absatz 
,ifnull(Coalesce(Sum(x.rohertrag_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS rohertrag 
FROM (
   WITH CTE AS 
      ( SELECT a.mandant_id, 
      a.art_id, 
      Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
      Max(a.status_1) AS status_1, 
      B.KJWO_UPDATE AS kjwo_update, 
      B.KJMO AS kjmo, 
      b.ART_ID AS input_art_id, 
      b.LISTUNG_SST_PFLEGE, 
      --B.GTIN AS input_gtin, 
      --B.NL_ART_BEZ , 
      b.matching_id, 
      b.nord_pflege, 
      b.ost_basis_pflege, 
      b.ost_gross_pflege, 
      b.sued_ost_pflege,
      b.sued_west_pflege, 
      b.west_pflege
      , b.region_only
      FROM dbp_etl.art_matching_nielsen_per_1 a 
      INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0 b 
      ON a.art_matching_id = b.MATCHING_ID  
      WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
      AND
      CASE
            WHEN trim(a.status_1) <> ''N'' AND
                trim(a.list_kz) = ''A''
            THEN 1
            WHEN trim(a.status_1) = ''N''
            THEN 1
            ELSE 0
      END = 1
      GROUP BY 1,2,5,6,7,8,9, 10,11,12,13,14,15,16
      ) 
            -- Regionen on top; Erweiterung!!! - Reduktion!!! 
            SELECT b.matching_id AS matching_id, 
            a.sm_id, 
            a.nord, 
            a.ost_basis, 
            a.ost_gross, 
            a.sued_ost, 
            a.sued_west, 
            a.west, 
            a.art_id, 
            b.kjmo, 
            b.kjwo_update,
            Max(b.status_1) AS status_1, 
            Sum(a.umsatz_hr) AS umsatz_, 
            Sum(a.absatz_hr) AS absatz_, 
            Sum(a.rohertrag_hr) AS rohertrag_ 
            FROM dbp_msi_data.kl_listung_1 a 
            --JOIN dbp_msi_data.sortiment_art_1 b 
            INNER JOIN CTE b
            ON a.mandant_id = b.mandant_id AND 
            a.art_id = b.art_id AND 
            a.kjwo_update = b.kjwo_update AND 
            a.sm_id_selected = 0 AND
            (trim(a.nord) = trim(b.nord_pflege)  OR  
            trim(a.ost_basis) = trim(b.ost_basis_pflege)  OR 
            trim(a.ost_gross) = trim(b.ost_gross_pflege)  OR 
            trim(a.sued_ost) = trim(b.sued_ost_pflege)  OR 
            trim(a.sued_west) = trim(b.sued_west_pflege)  OR 
            trim(a.west) = trim(b.west_pflege) ) 
            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
            a.listung_art IN (''Listung erweitern'',''Listung reduzieren'')  AND 
            b.region_only = 1 AND
            ''1'' = 1 
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11
            HAVING Round(umsatz_,1) <> 0 
) x 
JOIN (SELECT art_matching_id, 
Max(kl_wg_id) AS kl_wg_id, 
Max(kl_owg_id) AS kl_owg_id, 
Max(kl_uwg_id) AS kl_uwg_id 
FROM dbp_etl.art_matching_nielsen_per_1 
GROUP BY 1) y 
ON x.matching_id = y.art_matching_id 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); 


    }
        }



}



//
// var_region_summary = 1
if(row_count_1 > 0){
// Case var_region_summary = 1
      sql=`CREATE OR REPLACE temporary DBP_MACRO.TABLE PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1
       AS
       SELECT *
         FROM PUBLIC.input_table_ek_sort_runtime src
      WHERE region_summary = 1
      AND (src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998) OR src.gtin IS NULL)
      AND (vorschlag NOT IN (''Zurücksetzen'', ''Keine Veränderung setzen'', ''Keine Veränderung'', ''Keine Veränderung zurücksetzen'', ''Produktwissen_1'', ''Lieferantenwissen_1'') OR vorschlag IS NULL)
      `
      sql = sql.replace(/''undefined''/g, "NULL") 
      sql_stmt = snowflake.createStatement({sqlText: sql}); 
      sql_stmt.execute();  


// Debug Mode
/*sql = `SELECT ''MATCHING ART_ID BEGIN''`
      sql = sql.replace(/''undefined''/g, "NULL") 
      sql_stmt = snowflake.createStatement({sqlText: sql}); 
      sql_stmt.execute();*/
// Step 2a & 2b für den 1 Case

// Check if SQL-Statments have to be executed
sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
WHERE (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
res = sql_stmt.execute(); 
res.next();
row_count_e = res.getColumnValue(1)

if(row_count_e > 0){

sql =`---------------------STEP2a - Update for matching art_id 
----BATCH_OPTIMIZED 
UPDATE dbp_data.sortiment_leistung_1 tgt 
SET tgt.umsatz_hr = src.umsatz 
   ,tgt.absatz_hr = src.absatz
   ,tgt.rohertrag_hr = src.rohertrag 
   ,tgt.listungsaktion = src.vorschlag 
FROM (WITH CTE_PRE AS 
            (
                  SELECT DISTINCT * 
                    FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1
                  WHERE (NULLIF(listung_sst_pflege, '''') IS NOT NULL OR vorschlag = ''Auslisten'')
            )
, CTE AS 
( SELECT a.mandant_id, 
         a.art_id, 
         Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
         Max(a.status_1) AS status_1, 
         B.KJWO_UPDATE AS kjwo_update, 
         B.KJMO AS kjmo, 
         b.ART_ID AS input_art_id, 
         b.LISTUNG_SST_PFLEGE  
         --B.GTIN AS input_gtin, 
         --B.NL_ART_BEZ 
 , b.nord_pflege
         , b.ost_basis_pflege
         , b.ost_gross_pflege
         , b.sued_ost_pflege
         , b.sued_west_pflege
         , b.west_pflege
         , b.sst_reg
         , b.sst_reg_change
         , b.n_reg_char  
         ,b.w_reg_char  
         ,b.so_reg_char 
         , b.sw_reg_char 
         , b.ob_reg_char 
         , b.og_reg_char
  FROM dbp_etl.art_matching_nielsen_per_1 a 
  INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b 
    ON a.art_matching_id = b.MATCHING_ID  
  WHERE (NULLIF(b.listung_sst_pflege, '''') IS NOT NULL OR b.vorschlag = ''Auslisten'')
  AND CASE
            WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
                  THEN 1
            WHEN trim(a.status_1) = ''N''
                  THEN 1
            ELSE 0
      END = 1
  GROUP BY 1,2,5,6,7,8, 9, 10,11,12,13, 14, 15,16,17,18,19,20,21,22
) 
SELECT Sum(ifnull(x.anzahl_reduktion, 0)) AS anzahl_reduktion_, 
                         Sum(ifnull(x.anzahl_erweiterung, 0)) AS anzahl_erweiterung_, 
                         replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                         CASE
                                                         WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
                                                         WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_  THEN ''Listung reduzieren und erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_  THEN ''Listung erweitern und reduzieren''
									   WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
									   ELSE ''SOLL-Listung = IST-Listung''
                                                       END AS vorschlag, 
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS umsatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS absatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS rohertrag,
                   MANDANT_ID, 
                 input_art_id AS ART_ID, 
                 KJWO_UPDATE, 
                 KJMO 
             FROM (/*-- Regionen on top Erweiterung!!! 
                SELECT a.art_id, 
                        Max(b.status_1) AS status_1, 
                        Sum(a.umsatz_hr) AS umsatz_, 
                        Sum(a.absatz_hr) AS absatz_, 
                        Sum(a.rohertrag_hr) AS rohertrag_, 
                        0 AS anzahl_reduktion, 
                        Sum(a.erweiterung_fg) AS anzahl_erweiterung, 
                        --COUNT(*) AS anzahl_erweiterung, 
                        Max(CASE WHEN x.sm_id_selected IS NULL THEN Cast(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE Cast(''dynamic'' AS VARCHAR(100)) END) AS vorschlag_, 
                        b.MANDANT_ID, 
                        b.input_art_id, 
               b.KJWO_UPDATE, 
               b.KJMO 
                    FROM dbp_msi_data.kl_listung_1 a 
                    --JOIN dbp_msi_data.sortiment_art_1 b 
                    INNER JOIN CTE b 
                      ON a.mandant_id = b.mandant_id AND 
                         a.art_id = b.art_id AND 
                         a.kjwo_update = b.kjwo_update AND 
                         a.sm_id_selected = b.LISTUNG_SST_PFLEGE AND 
                         (((trim(a.nord) = trim(b.nord_pflege) OR  
                            trim(a.ost_basis) = trim(b.ost_basis_pflege) OR 
                              trim(a.ost_gross) = trim(b.ost_gross_pflege) OR 
                              trim(a.sued_ost) = trim(b.sued_ost_pflege) OR 
                              trim(a.sued_west) = trim(b.sued_west_pflege) OR 
                              trim(a.west) = trim(b.west_pflege)) AND 
                          a.sm_id < b.listung_sst_pflege) OR 
                         (a.sm_id >= b.listung_sst_pflege))
                    LEFT JOIN (SELECT a.mandant_id, 
                                      a.art_id, 
                                      a.kjwo_update, 
                                      a.sm_id_selected 
                               FROM dbp_msi_data.kl_listung_1 a 
                               INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b ON a.art_id = b.ART_ID 
                               AND a.kjwo_update = b.KJWO_UPDATE  
                               WHERE a.listung_art = ''Auslistung'' 
                               GROUP BY 1,2,3,4 
                               ) x ON a.mandant_id = x.mandant_id AND 
a.art_id = x.art_id AND 
a.kjwo_update = x.kjwo_update 
                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
                          a.listung_art = ''Listung erweitern''
                          AND ''1'' = 1 
                    GROUP BY 1,9,10,11,12 
                    -- Regionen on Top !!! Reduktion
                    UNION all
                    SELECT a.art_id, 
                        Max(b.status_1) AS status_1, 
                        Sum(a.umsatz_hr) AS umsatz_, 
                        Sum(a.absatz_hr) AS absatz_, 
                        Sum(a.rohertrag_hr) AS rohertrag_, 
                        Sum(a.reduktion_fg) AS anzahl_reduktion, 
                        0 AS anzahl_erweiterung, 
                        --COUNT(*) AS anzahl_erweiterung, 
                        ''dynamic'' AS vorschlag_ , 
                        b.MANDANT_ID, 
                        b.input_art_id, 
               b.KJWO_UPDATE, 
               b.KJMO 
                    FROM dbp_msi_data.kl_listung_1 a 
                    --JOIN dbp_msi_data.sortiment_art_1 b 
                    INNER JOIN CTE b 
                      ON a.mandant_id = b.mandant_id AND 
                         a.art_id = b.art_id AND 
                         a.kjwo_update = b.kjwo_update AND 
                         a.sm_id_selected = b.LISTUNG_SST_PFLEGE AND 
                         (((trim(a.nord) = trim(b.nord_pflege) OR  
                              trim(a.ost_basis) = trim(b.ost_basis_pflege) OR 
                              trim(a.ost_gross) = trim(b.ost_gross_pflege) OR 
                              trim(a.sued_ost) = trim(b.sued_ost_pflege) OR 
                              trim(a.sued_west) = trim(b.sued_west_pflege) OR 
                              trim(a.west) = trim(b.west_pflege)) AND 
                          a.sm_id > b.listung_sst_pflege) OR 
                         (a.sm_id < b.listung_sst_pflege))
                    WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
                          a.listung_art =''Listung reduzieren''
                          AND ''1'' = 1 
                    GROUP BY 1,9,10,11,12 */
                    --
                    --
                    -- Nur SST gepflegt fuer Erweiterung!
                    SELECT a.art_id,
                                                             MAX(b.status_1) AS status_1,
                                                             MIN(a.list_kz) AS list_kz_,
                                                             SUM(a.umsatz_hr) AS umsatz_,
                                                             SUM(a.absatz_hr) AS absatz_,
                                                             SUM(a.rohertrag_hr) AS rohertrag_,
                                                             CAST(0 AS INT) AS anzahl_reduktion,
                                                             SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                             CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END AS vorschlag_, 
                                                             b.MANDANT_ID, 
                                                             b.input_art_id, 
                                                    b.KJWO_UPDATE, 
                                                    b.KJMO 
                                                      FROM dbp_msi_data.kl_listung_1 a
                                                      JOIN CTE b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           a.kjwo_update = b.kjwo_update AND
                                                           a.sm_id_selected = CAST(b.listung_sst_pflege AS INT)
                                                      WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                                                            a.listung_art = ''Listung erweitern'' AND
                                                           (a.nord = ''-'' AND 
                                                            a.ost_basis = ''-'' AND 
                                                            a.ost_gross = ''-'' AND 
                                                            a.sued_ost = ''-'' AND 
                                                            a.sued_west = ''-'' AND 
                                                            a.west = ''-'') AND
                                                            b.sst_reg_change IN (1,4)
                                                      GROUP BY 1, 10,11,12,13
                                                      -- Nur SST gepflegt fuer Reduktion!
                                                      -- 0A
                                                      -- 1A
         UNION ALL
         SELECT a.art_id,
                                                             MAX(b.status_1) AS status_1,
                                                             MIN(a.list_kz) AS list_kz_,
                                                             SUM(a.umsatz_hr) AS umsatz_,
                                                             SUM(a.absatz_hr) AS absatz_,
                                                             SUM(a.rohertrag_hr) AS rohertrag_,
                                                             SUM(reduktion_fg) AS anzahl_reduktion,
                                                             CAST(0 AS INT) AS anzahl_erweiterung,
                                                             ''dynamic'' AS vorschlag_, 
                                                             b.MANDANT_ID, 
                                                             b.input_art_id, 
                                                    b.KJWO_UPDATE, 
                                                    b.KJMO 
                                                      FROM dbp_msi_data.kl_listung_1 a
                                                      JOIN dbp_data.wup_1 x
                                                        ON a.mandant_id = x.mandant_id AND
                                                           a.wup_id = x.wup_id
                                                      JOIN CTE b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           a.kjwo_update = b.kjwo_update AND
                                                           a.sm_id_selected = CAST(b.listung_sst_pflege AS INT) AND
                                                           a.sm_id < CAST(b.listung_sst_pflege AS INT)
                                                      WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                                                            a.listung_art = ''Listung reduzieren''  AND
                                                           (a.nord = ''-'' AND 
                                                            a.ost_basis = ''-'' AND 
                                                            a.ost_gross = ''-'' AND 
                                                            a.sued_ost = ''-'' AND 
                                                            a.sued_west = ''-'' AND 
                                                            a.west = ''-'') AND 
                                                            CASE
                                                              WHEN b.sst_reg_change = 4 AND
                                                                  (trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.n_reg_char))  OR
                                                                  trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.w_reg_char))  OR
                                                                  trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.so_reg_char)) OR
                                                                  trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.sw_reg_char)) OR
                                                                  trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.ob_reg_char)) OR
                                                                  trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.og_reg_char)))
                                                              THEN 0
                                                              ELSE 1
                                                            END = 1 AND
                                                            b.sst_reg_change IN (2,4)
                                                      GROUP BY 1, 10,11,12,13
                                                      UNION ALL
                                                      -- SST plus Cluster fuer Erweiterung!
                                                      SELECT a.art_id,
                                                             MAX(b.status_1) AS status_1,
                                                             MIN(a.list_kz) AS list_kz_,
                                                             SUM(a.umsatz_hr) AS umsatz_,
                                                             SUM(a.absatz_hr) AS absatz_,
                                                             SUM(a.rohertrag_hr) AS rohertrag_,
                                                             CAST(0 AS INT) AS anzahl_reduktion,
                                                             SUM(erweiterung_fg) AS anzahl_erweiterung,
                                                             CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END AS vorschlag_, 
                                                             b.MANDANT_ID, 
                                                             b.input_art_id, 
                                                    b.KJWO_UPDATE, 
                                                    b.KJMO 
                                                      FROM dbp_msi_data.kl_listung_1 a
                                                      JOIN dbp_data.wup_1 x
                                                        ON a.mandant_id = x.mandant_id AND
                                                           a.wup_id = x.wup_id
                                                      JOIN CTE b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           a.kjwo_update = b.kjwo_update AND
                                                           a.sm_id_selected = 0 AND
                                                           a.sm_id < CAST(b.listung_sst_pflege AS INT) AND
                                                          (trim(a.nord) = trim(b.nord_pflege) OR 
                                                          trim(a.ost_basis) = trim(b.ost_basis_pflege) OR
                                                           trim(a.ost_gross) = trim(b.ost_gross_pflege) OR
                                                           trim(a.sued_ost) = trim(b.sued_ost_pflege) OR
                                                           trim(a.sued_west) = trim(b.sued_west_pflege) OR
                                                           trim(a.west) = trim(b.west_pflege)) AND 
                                                           CASE
                                                             WHEN b.sst_reg_change = 4 AND
                                                                  a.sm_id >= CAST(b.listung_sst_pflege AS INT) AND
                                                                 (trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.n_reg_char))  OR
                                                                 trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.w_reg_char))  OR
                                                                 trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.so_reg_char)) OR
                                                                 trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.sw_reg_char)) OR
                                                                 trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.ob_reg_char)) OR
                                                                 trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.og_reg_char)))
                                                             THEN 0
                                                             ELSE 1
                                                           END = 1 
                                                      WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                                                            a.listung_art = ''Listung erweitern'' AND
                                                            b.sst_reg = 1
                                                      GROUP BY 1,10,11,12,13
                                                      UNION ALL
                                                      -- SST plus Cluster fuer Reduktion!
                                                      SELECT a.art_id,
                                                             MAX(b.status_1) AS status_1,
                                                             MIN(a.list_kz) AS list_kz_,
                                                             SUM(a.umsatz_hr) AS umsatz_,
                                                             SUM(a.absatz_hr) AS absatz_,
                                                             SUM(a.rohertrag_hr) AS rohertrag_,
                                                             SUM(reduktion_fg) AS anzahl_reduktion,
                                                             CAST(0 AS INT) AS anzahl_erweiterung,
                                                             ''dynamic'' AS vorschlag_, 
                                                             b.MANDANT_ID, 
                                                             b.input_art_id, 
                                                    b.KJWO_UPDATE, 
                                                    b.KJMO 
                                                      FROM dbp_msi_data.kl_listung_1 a
                                                      JOIN CTE b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           a.kjwo_update = b.kjwo_update AND
                                                           a.sm_id_selected = 0 AND
                                                           a.sm_id < CAST(b.listung_sst_pflege AS INT) AND
                                                          (trim(a.nord) = trim(b.nord_pflege) OR 
                                                            trim(a.ost_basis) = trim(b.ost_basis_pflege) OR
                                                            trim(a.ost_gross) = trim(b.ost_gross_pflege) OR
                                                            trim(a.sued_ost) = trim(b.sued_ost_pflege) OR
                                                            trim(a.sued_west) = trim(b.sued_west_pflege) OR
                                                            trim(a.west) = trim(b.west_pflege))
                                                      WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                                                            a.listung_art = ''Listung reduzieren'' AND
                                                            b.sst_reg = 1 AND
                                                            b.sst_reg_change NOT IN (4)
                                                      GROUP BY 1,10,11,12,13
                              -- Auslistung ist sowohl für var_region_summary = 0 & 1
                              UNION ALL 
                              SELECT a.art_id, 
                                     Max(b.status_1) AS status_1, 
                                     Max(a.list_kz) as list_kz, 
                                     Sum(a.umsatz_hr) AS umsatz_, 
                                     Sum(a.absatz_hr) AS absatz_, 
                                     Sum(a.rohertrag_hr) AS rohertrag_, 
                                     Sum(reduktion_fg) AS anzahl_reduktion, 
                                     Cast(0 AS INT) AS anzahl_erweiterung, 
                                     ''Auslistung'' AS vorschlag_ , 
                                     b.MANDANT_ID, 
                                     b.input_art_id, 
                            b.KJWO_UPDATE, 
                            b.KJMO 
                              FROM dbp_msi_data.kl_listung_1 a 
                              JOIN CTE b 
                                ON a.mandant_id = b.mandant_id AND 
                                   a.art_id = b.art_id AND 
                                   a.kjwo_update = b.kjwo_update AND 
                                   a.sm_id_selected = B.listung_sst_PFLEGE
                              WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
                                    a.listung_art = ''Auslistung'' AND 
                                   (a.nord = ''-'' AND  
                                    a.ost_basis = ''-'' AND  
                                    a.ost_gross = ''-'' AND  
                                    a.sued_ost = ''-'' AND  
                                    a.sued_west = ''-'' AND  
                                    a.west = ''-'') 
                              GROUP BY 1, 10,11,12,13
                              UNION ALL 
                              SELECT ART_ID AS art_id, 
                                           ''N'' AS status_1, 
                                           ''A'' AS list_kz, 
                                           0 AS umsatz_, 
                                           0 AS absatz_, 
                                           0 AS rohertrag_, 
                                           0 AS anzahl_reduktion, 
                                           0 AS anzahl_erweiterung, 
                                           --COUNT(*) AS anzahl_erweiterung, 
                                           Cast(''dynamic'' AS VARCHAR(100)) AS vorschlag_ 
                                           ,1 AS MANDANT_ID  
                                           ,ART_ID AS input_art_id 
                             ,KJWO_UPDATE 
                             ,KJMO 
                                      FROM CTE_PRE
                              ) x 
                       GROUP BY MANDANT_ID  
                       ,input_art_id  
                       ,KJWO_UPDATE 
                       ,KJMO 
                              ) src                           
WHERE tgt.mandant_id = src.mandant_id 
AND tgt.art_id = src.art_id 
AND tgt.kjmo = src.kjmo 
AND tgt.kjwo_update = src.kjwo_update;`; 
                  sql = sql.replace(/''undefined''/g, "NULL") 
                  sql_stmt = snowflake.createStatement({sqlText: sql}); 
                  sql_stmt.execute();   
/* // Debug Mode
sql = `SELECT ''MATCHING ART_ID END''`
                  sql = sql.replace(/''undefined''/g, "NULL") 
                  sql_stmt = snowflake.createStatement({sqlText: sql}); 
                  sql_stmt.execute();  */
 
 
 
sql=`---------------------STEP2b - Update for matching gtin and nielsen_art_bez ll 322
----BATCH_OPTIMIZED 
UPDATE dbp_data.sortiment_leistung_1 tgt 
SET tgt.umsatz_hr = src.umsatz 
   ,tgt.absatz_hr = src.absatz 
   ,tgt.rohertrag_hr = src.rohertrag 
   ,tgt.listungsaktion = src.vorschlag 
FROM (WITH CTE_PRE AS 
            (
                  SELECT DISTINCT * 
                    FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1
                  WHERE (NULLIF(listung_sst_pflege, '''') IS NOT NULL OR vorschlag = ''Auslisten'')
            )
, CTE AS 
( SELECT a.mandant_id, 
         a.art_id, 
         Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
         Max(a.status_1) AS status_1, 
         B.KJWO_UPDATE AS kjwo_update, 
         B.KJMO AS kjmo, 
         --b.ART_ID AS input_art_id, 
         b.LISTUNG_SST_PFLEGE, 
         B.GTIN AS input_gtin, 
         B.NL_ART_BEZ 
         ,  b.nord_pflege
         , b.ost_basis_pflege
         , b.ost_gross_pflege
         , b.sued_ost_pflege
         , b.sued_west_pflege
         , b.west_pflege
  FROM dbp_etl.art_matching_nielsen_per_1 a 
  INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b 
     ON a.art_matching_id = b.MATCHING_ID  
  WHERE (NULLIF(b.listung_sst_pflege, '''') IS NOT NULL OR b.vorschlag = ''Auslisten'')
  AND  CASE
            WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
                  THEN 1
            WHEN trim(a.status_1) = ''N''
                  THEN 1
            ELSE 0
       END = 1
  GROUP BY 1,2,5,6,7,8,9 ,10,11,12,13,14,15
) 
SELECT Sum(ifnull(x.anzahl_reduktion, 0)) AS anzahl_reduktion_, 
                         Sum(ifnull(x.anzahl_erweiterung, 0)) AS anzahl_erweiterung_, 
                         replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                         CASE
                                                         WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
                                                         WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_  THEN ''Listung reduzieren und erweitern''
                                                         WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_  THEN ''Listung erweitern und reduzieren''
									   WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
									   ELSE ''SOLL-Listung = IST-Listung''
                                                       END AS vorschlag, 
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS umsatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS absatz,
                        CASE
                                                       WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                       THEN 0
                                                       ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) 
                        END AS rohertrag,
                   MANDANT_ID, 
                 KJWO_UPDATE, 
                 KJMO, 
                 input_gtin AS gtin, 
                 nl_art_bez AS nielsen_art_bez                 
             FROM (-- Regionen on top (Nielsen 1)
                              SELECT 1 AS art_id, 
                                     ''N'' AS status_1, 
                                     ''A'' AS list_kz,
                                     Sum(a.umsatz_hr) AS umsatz_, 
                                     Sum(a.absatz_hr) AS absatz_, 
                                     Sum(a.absatz_hr)*Sum(Cast(REPLACE(b.STK_RE_PFLEGE,'','',''.'') AS FLOAT)) AS rohertrag_, 
                                     Cast(0 AS INT) AS anzahl_reduktion, 
                                     Count(*) AS anzahl_erweiterung, 
                                     ''Einlistung Potenzialartikel'' AS vorschlag_, 
                                     a.MANDANT_ID,  
                       b.KJWO_UPDATE, 
                       b.KJMO, 
                         b.GTIN as input_gtin, 
                         b.NL_ART_BEZ  
                              FROM dbp_msi_data.nl_listung_1 a 
                              INNER JOIN CTE_PRE b ON a.GTIN = b.GTIN AND 
                              a.kjwo_update = b.kjwo_update AND 
                              a.art_nielsen_bez = B.NL_ART_BEZ AND 
                              a.sm_id_selected = B.LISTUNG_SST_PFLEGE AND 
                              (trim(a.nord) = trim(b.nord_pflege) AND 
                                    trim(a.ost_basis) = trim(b.ost_basis_pflege) AND 
                                    trim(a.ost_gross) = trim(b.ost_gross_pflege) AND 
                                    trim(a.sued_ost) = trim(b.sued_ost_pflege) AND 
                                    trim(a.sued_west) = trim(b.sued_west_pflege) AND 
                                    trim(a.west) = trim(b.west_pflege))
                              WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
                                    a.listung_art = ''Einlistung Potenzialartikel'' AND 
                                    ''1'' = 1 
                              GROUP BY 1,2,10,11,12,13, 14
                              --HAVING umsatz_ <> 0 
                              UNION ALL 
                              SELECT ART_ID AS art_id, 
                                     ''N'' AS status_1, 
                                     ''A'' AS list_kz,
                                     0 AS umsatz_, 
                                     0 AS absatz_, 
                                     0 AS rohertrag_, 
                                     0 AS anzahl_reduktion, 
                                     0 AS anzahl_erweiterung, 
                                     --COUNT(*) AS anzahl_erweiterung, 
                                     Cast(''dynamic'' AS VARCHAR(100)) AS vorschlag_ 
                                     ,1 AS MANDANT_ID  
                       ,KJWO_UPDATE 
                       ,KJMO 
                       ,GTIN as input_gtin
                       ,NL_ART_BEZ 
                                FROM CTE_PRE
                              --FROM dbp_data.tag_1 
                              --WHERE dat = CURRENT_DATE() 
----- Urspr auskommentiert
-- "Chi for initions"
                              UNION ALL 
                                -- K-Sicht fuer Nielsen (Nielsen 2) 
                                -- NUR FUER KL-ARTIKEL_1, DIE AUS NIELSEN KALKULIERT WERDEN! 
                                SELECT b.art_id, 
                                       Max(b.status_1) AS status_1, 
                                       Max(''A'') as list_kz, 
                                       Sum(a.umsatz_hr) AS umsatz_, 
                                       Sum(a.absatz_hr) AS absatz_, 
                                       Sum(a.absatz_hr*Coalesce(Cast(REPLACE(d.stk_re_pflege,'','',''.'') AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_, 
                                       Cast(0 AS INT) AS anzahl_reduktion, 
                                       Count(*) AS anzahl_erweiterung, 
                                       ''Einlistung Kauflandartikel'' AS vorschlag_ 
                                      ,1 AS MANDANT_ID  
                         ,d.KJWO_UPDATE 
                         ,d.KJMO 
                         ,d.GTIN 
                         ,d.NL_ART_BEZ 
                                FROM dbp_msi_data.nl_listung_1 a 
                                JOIN CTE b 
                                  ON 1 = b.mandant_id AND 
                                     a.kjwo_update = b.kjwo_update AND 
                                     a.sm_id_selected = b.Listung_SST_Pflege AND 
                                     (trim(a.nord) = trim(b.nord_pflege) AND 
                                     trim(a.ost_basis) = trim(b.ost_basis_pflege) AND 
                                      trim(a.ost_gross) = trim(b.ost_gross_pflege) AND 
                                      trim(a.sued_ost) = trim(b.sued_ost_pflege) AND 
                                      trim(a.sued_west) = trim(b.sued_west_pflege) AND 
                                      trim(a.west) = trim(b.west_pflege)) 
                                INNER JOIN CTE_PRE d
                                  ON d.gtin = b.gtin_id 
                                JOIN dbp_etl.bf_sort_sal_export_1 c 
                                  ON b.art_id/100 = Cast(c.art_nr AS INT) 
                                --INNER JOIN dbp_etl.not_listed_basis_1 e
                                --  ON a.gtin = e.gtin_id
                                --AND d.gtin = e.gtin_id
                                WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = d.gtin) AND 
                                     a.listung_art = ''Listung erweitern'' AND 
                                      ''1'' = 1
                                GROUP BY 1 ,  11, 12, 13, 14
                                --HAVING umsatz_ <> 0 
                              ) x 
                       GROUP BY MANDANT_ID  
                       ,KJWO_UPDATE 
                       ,KJMO 
                       ,input_gtin 
                       ,NL_ART_BEZ 
                              ) src                           
WHERE tgt.mandant_id = src.mandant_id 
AND tgt.gtin = src.gtin 
AND tgt.kjmo = src.kjmo 
AND tgt.nielsen_art_bez = src.nielsen_art_bez 
AND tgt.kjwo_update = src.kjwo_update;` 
                  sql = sql.replace(/''undefined''/g, "NULL") 
                  sql_stmt = snowflake.createStatement({sqlText: sql}); 
                  sql_stmt.execute(); 



sql = `UPDATE dbp_data.sortiment_leistung_1 trg
SET trg.listungsaktion = src.listungsaktion
FROM 
(SELECT CASE
            WHEN b.region_summary IN (1,0)
                  THEN
                  CASE
                        WHEN NULLIF(a.listung_sst_mvke,''N/A'') IS NULL AND
                              GREATEST(COALESCE(a.ost_basis,'' ''),COALESCE(a.ost_gross,'' ''),COALESCE(a.sued_ost,'' ''),COALESCE(a.sued_west,'' ''),COALESCE(a.west,'' ''),COALESCE(a.nord,'' '')) = '' '' AND
                              a.anz_maerkte_sst = 0 AND a.anz_maerkte_baustein_sonstige = 0 AND a.anz_maerkte_listung_einzel = 0 AND a.anz_maerkte_listung_gesamt = 0
                        THEN ''Einlistung Kauflandartikel''
                  ELSE listungsaktion
                  END
       ELSE listungsaktion
      END AS listungsaktion
      , b.matching_id
      , b.kjmo
      , b.kjwo_update
FROM dbp_data.sortiment_leistung_1 a
INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
ON a.kjmo = b.kjmo AND 
a.kjwo_update = b.kjwo_update AND
a.matching_id = b.matching_id
WHERE a.mandant_id = 1 AND 
a.art_id IS NOT NULL AND 
(NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NOT NULL OR b.vorschlag = ''Auslisten'')
) src
WHERE trg.mandant_id = 1 AND
trg.kjmo = src.kjmo AND
trg.kjwo_update = src.kjwo_update AND
trg.matching_id = src.matching_id
;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); 



//-------------------------------------------------------------------------------------------------------- 
//--   (II) INSERT FUER ERWARTETE ENTWICKLUNG (mit K-Stufen) 
//-------------------------------------------------------------------------------------------------------- 
// ll 645

// if ((''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'').includes(var_vorschlag_hr) == false) 
// 3 Commands - bis Z. 1229

// Check if SQL-Statments have to be executed
sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
WHERE (vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or vorschlag is null)
AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
res = sql_stmt.execute(); 
res.next();
row_count_f = res.getColumnValue(1)

if(row_count_f > 0){

sql=`---------------------STEP_Delete
                  ----BATCH_OPTIMIZED 
                  DELETE FROM dbp_msi_data.erwartete_entwicklung_1 a
                  using ( SELECT DISTINCT kjmo, 
                                 matching_id, 
                                 Kjwo_update
                            FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 
                          WHERE (vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or vorschlag is null)
                          AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')
                  ) d
                  WHERE a.matching_id = d.matching_id  AND 
                       a.kjmo = d.kjmo AND 
                       a.kjwo_update = d.kjwo_update AND 
                       a.mandant_id = 1`; 
                                    sql = sql.replace(/''undefined''/g, "NULL") 
                                    sql_stmt = snowflake.createStatement({sqlText: sql}); 
                                    sql_stmt.execute(); 


sql=` INSERT INTO dbp_msi_data.erwartete_entwicklung_1 (mandant_id 
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
WITH CTE_PRE AS 
(
SELECT DISTINCT * 
FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 
WHERE (vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or vorschlag is NULL)
AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')
)
SELECT DISTINCT 1 AS mandant_id 
,x.kjmo AS kjmo 
,x.matching_id 
,x.sm_id 
,'' '' AS ksm_id 
,x.KJWO_UPDATE AS kjwo_update 
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
,ifnull(Coalesce(Sum(x.umsatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS umsatz 
,ifnull(Coalesce(Sum(x.absatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS absatz 
,ifnull(Coalesce(Sum(x.rohertrag_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0),0) AS rohertrag 
FROM (
WITH CTE AS 
( SELECT a.mandant_id, 
a.art_id, 
Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
Max(a.status_1) AS status_1, 
B.KJWO_UPDATE AS kjwo_update, 
B.KJMO AS kjmo, 
b.ART_ID AS input_art_id, 
b.LISTUNG_SST_PFLEGE, 
--B.GTIN AS input_gtin, 
--B.NL_ART_BEZ , 
b.matching_id
, b.nord_pflege
, b.ost_basis_pflege
, b.ost_gross_pflege
, b.sued_ost_pflege
, b.sued_west_pflege
, b.west_pflege
, b.sst_reg
, b.sst_reg_change
, b.n_reg_char  
,b.w_reg_char  
,b.so_reg_char 
, b.sw_reg_char 
, b.ob_reg_char 
, b.og_reg_char
FROM dbp_etl.art_matching_nielsen_per_1 a 
INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b 
ON a.art_matching_id = b.MATCHING_ID  
WHERE (b.vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') or b.vorschlag IS NULL)
AND (NULLIF(listung_sst_pflege, '' '') IS NOT NULL OR vorschlag = ''Auslisten'')
AND CASE
      WHEN trim(a.status_1) <> ''N'' AND trim(a.list_kz) = ''A''
            THEN 1
      WHEN trim(a.status_1) = ''N''
            THEN 1
      ELSE 0
      END = 1
GROUP BY 1,2,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
) 
--
--
-- Nur SST gepflegt fuer Erweiterung!
SELECT b.matching_id AS matching_id,
a.sm_id,
a.nord,
a.ost_basis,
a.ost_gross,
a.sued_ost,
a.sued_west,
a.west,
a.art_id,                                      
b.kjmo, 
b.kjwo_update,
MAX(b.status_1) AS status_1,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_
                FROM dbp_msi_data.kl_listung_1 a
                JOIN CTE b
                  ON a.mandant_id = b.mandant_id AND
                     a.art_id = b.art_id AND
                     a.kjwo_update = b.kjwo_update AND
                     a.sm_id_selected = CAST(b.listung_sst_pflege AS INT)
                WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                      a.listung_art = ''Listung erweitern'' AND
                     (a.nord = ''-'' AND 
                      a.ost_basis = ''-'' AND 
                      a.ost_gross = ''-'' AND 
                      a.sued_ost = ''-'' AND 
                      a.sued_west = ''-'' AND 
                      a.west = ''-'') AND
                      b.sst_reg_change IN (1,4)
                GROUP BY 1, 2,3,4,5,6,7,8,9,10,11
                HAVING Round(umsatz_,1) <> 0 
                -- Nur SST gepflegt fuer Reduktion!
UNION ALL
SELECT b.matching_id AS matching_id,
a.sm_id,
a.nord,
a.ost_basis,
a.ost_gross,
a.sued_ost,
a.sued_west,
a.west,
a.art_id,                                      
b.kjmo, 
b.kjwo_update,
MAX(b.status_1) AS status_1,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_
                FROM dbp_msi_data.kl_listung_1 a
                JOIN dbp_data.wup_1 x
                  ON a.mandant_id = x.mandant_id AND
                     a.wup_id = x.wup_id
                JOIN CTE b
                  ON a.mandant_id = b.mandant_id AND
                     a.art_id = b.art_id AND
                     a.kjwo_update = b.kjwo_update AND
                     a.sm_id_selected = CAST(b.listung_sst_pflege AS INT) AND
                     a.sm_id < CAST(b.listung_sst_pflege AS INT)
                WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                      a.listung_art = ''Listung reduzieren''  AND
                     (a.nord = ''-'' AND 
                      a.ost_basis = ''-'' AND 
                      a.ost_gross = ''-'' AND 
                      a.sued_ost = ''-'' AND 
                      a.sued_west = ''-'' AND 
                      a.west = ''-'') AND 
                      CASE
                        WHEN b.sst_reg_change = 4 AND
                            (trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.n_reg_char))  OR
                            trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.w_reg_char))  OR
                            trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.so_reg_char)) OR
                            trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.sw_reg_char)) OR
                            trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.ob_reg_char)) OR
                            trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.og_reg_char)))
                        THEN 0
                        ELSE 1
                      END = 1 AND
                      b.sst_reg_change IN (2,4)
                GROUP BY 1, 2,3,4,5,6,7,8,9,10,11
                HAVING Round(umsatz_,1) <> 0 
                UNION ALL
                -- SST plus Cluster fuer Erweiterung!
                SELECT b.matching_id AS matching_id,
                a.sm_id,
                a.nord,
                a.ost_basis,
                a.ost_gross,
                a.sued_ost,
                a.sued_west,
                a.west,
                a.art_id,

b.kjmo, 
b.kjwo_update,
                MAX(b.status_1) AS status_1,
                SUM(a.umsatz_hr) AS umsatz_,
                SUM(a.absatz_hr) AS absatz_,
                SUM(a.rohertrag_hr) AS rohertrag_
                FROM dbp_msi_data.kl_listung_1 a
                JOIN dbp_data.wup_1 x
                  ON a.mandant_id = x.mandant_id AND
                     a.wup_id = x.wup_id
                JOIN CTE b
                  ON a.mandant_id = b.mandant_id AND
                     a.art_id = b.art_id AND
                     a.kjwo_update = b.kjwo_update AND
                     a.sm_id_selected = 0 AND
                     a.sm_id < CAST(b.listung_sst_pflege AS INT) AND
                    (trim(a.nord) = trim(b.nord_pflege) OR 
                    trim(a.ost_basis) = trim(b.ost_basis_pflege) OR
                    trim(a.ost_gross) = trim(b.ost_gross_pflege) OR
                    trim(a.sued_ost) = trim(b.sued_ost_pflege) OR
                    trim(a.sued_west) = trim(b.sued_west_pflege) OR
                    trim(a.west) = trim(b.west_pflege)) AND 
                     CASE
                       WHEN b.sst_reg_change = 4 AND
                            a.sm_id >= CAST(b.listung_sst_pflege AS INT) AND
                           (trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.n_reg_char))  OR
                              trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.w_reg_char))  OR
                              trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.so_reg_char)) OR
                              trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.sw_reg_char)) OR
                              trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.ob_reg_char)) OR
                              trim(upper(x.kreistyp_gruppe_id)) = trim(upper(b.og_reg_char)))
                       THEN 0
                       ELSE 1
                     END = 1 
                WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                      a.listung_art = ''Listung erweitern'' AND
                      b.sst_reg = 1
                GROUP BY 1,2,3,4,5,6,7,8,9,10,11
                HAVING Round(umsatz_,1) <> 0 
                UNION ALL
                -- SST plus Cluster fuer Reduktion!
                SELECT b.matching_id AS matching_id,
                a.sm_id,
                a.nord,
                a.ost_basis,
                a.ost_gross,
                a.sued_ost,
                a.sued_west,
                a.west,
                a.art_id,

b.kjmo, 
b.kjwo_update,
                MAX(b.status_1) AS status_1,
                SUM(a.umsatz_hr) AS umsatz_,
                SUM(a.absatz_hr) AS absatz_,
                SUM(a.rohertrag_hr) AS rohertrag_
                FROM dbp_msi_data.kl_listung_1 a
                JOIN CTE b
                  ON a.mandant_id = b.mandant_id AND
                     a.art_id = b.art_id AND
                     a.kjwo_update = b.kjwo_update AND
                     a.sm_id_selected = 0 AND
                     a.sm_id < CAST(b.listung_sst_pflege AS INT) AND
                    (trim(a.nord) = trim(b.nord_pflege) OR 
                        trim(a.ost_basis) = trim(b.ost_basis_pflege) OR
                        trim(a.ost_gross) = trim(b.ost_gross_pflege) OR
                        trim(a.sued_ost) = trim(b.sued_ost_pflege) OR
                        trim(a.sued_west) = trim(b.sued_west_pflege) OR
                        trim(a.west) = trim(b.west_pflege))
                WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                      a.listung_art = ''Listung reduzieren'' AND
                      b.sst_reg = 1 AND
                      b.sst_reg_change NOT IN (4)
                GROUP BY 1,2,3,4,5,6,7,8,9,10,11
                HAVING Round(umsatz_,1) <> 0 
/*                                                   
-- Regionen on top; Erweiterung!!! - Reduktion!!! 
SELECT b.matching_id AS matching_id, 
a.sm_id, 
a.nord, 
a.ost_basis, 
a.ost_gross, 
a.sued_ost, 
a.sued_west, 
a.west, 
a.art_id, 
b.kjmo, 
b.kjwo_update,
Max(b.status_1) AS status_1, 
Sum(a.umsatz_hr) AS umsatz_, 
Sum(a.absatz_hr) AS absatz_, 
Sum(a.rohertrag_hr) AS rohertrag_ 
FROM dbp_msi_data.kl_listung_1 a 
--JOIN dbp_msi_data.sortiment_art_1 b 
INNER JOIN CTE b
ON a.mandant_id = b.mandant_id AND 
a.art_id = b.art_id AND 
a.kjwo_update = b.kjwo_update AND 
a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 d
ON d.matching_id= b.MATCHING_ID  
AND (((trim(a.nord) = trim(d.nord_pflege)  OR  
trim(a.ost_basis) = trim(d.ost_basis_pflege)  OR 
trim(a.ost_gross) = trim(d.ost_gross_pflege) OR 
trim(a.sued_ost) = trim(d.sued_ost_pflege)  OR 
trim(a.sued_west) = trim(d.sued_west_pflege)  OR 
trim(a.west) = trim(d.west_pflege) ) AND 
a.sm_id < d.listung_sst_pflege) OR 
(a.sm_id >= d.listung_sst_pflege ))
WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
a.listung_art IN (''Listung erweitern'',''Listung reduzieren'')  AND 
''1'' = 1 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
HAVING Round(umsatz_,1) <> 0 */
--K-Sicht fuer KL; Auslistung!!! 
-- AUSLISTUNG muss in den 1-Fall !!!
UNION ALL 
SELECT b.matching_id, 
a.sm_id, 
a.nord, 
a.ost_basis, 
a.ost_gross, 
a.sued_ost, 
a.sued_west, 
a.west, 
a.art_id, 
b.kjmo, 
b.kjwo_update,
Max(b.status_1) AS status_1, 
Sum(a.umsatz_hr) AS umsatz_, 
Sum(a.absatz_hr) AS absatz_, 
Sum(a.rohertrag_hr) AS rohertrag_ 
FROM dbp_msi_data.kl_listung_1 a 
--JOIN dbp_msi_data.sortiment_art_1 b 
INNER JOIN CTE b
ON a.mandant_id = b.mandant_id AND 
a.art_id = b.art_id AND 
a.kjwo_update = b.kjwo_update AND 
a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
a.listung_art = ''Auslistung'' AND 
(a.nord = ''-'' AND  
a.ost_basis = ''-'' AND  
a.ost_gross = ''-'' AND  
a.sued_ost = ''-'' AND  
a.sued_west = ''-'' AND  
a.west = ''-'') 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
HAVING Round(umsatz_,1) <> 0 
-- Cluster für Nielsen
UNION ALL 
SELECT d.matching_id, 
sm_id, 
nord, 
ost_basis, 
ost_gross, 
sued_ost, 
sued_west, 
west, 
1 AS art_id, 
''N'' AS status_1, 
d.kjmo, 
d.kjwo_update,
Sum(umsatz_hr) AS umsatz_, 
Sum(absatz_hr) AS absatz_, 
Sum(absatz_hr)*Cast(REPLACE(d.stk_re_pflege,'','',''.'') AS FLOAT) AS rohertrag_ 
FROM dbp_msi_data.nl_listung_1 a
INNER JOIN CTE_pre d
ON a.gtin = d.gtin AND 
a.kjwo_update = d.kjwo_update  AND 
a.art_nielsen_bez = d.NL_ART_BEZ  AND 
a.sm_id_selected = d.listung_sst_pflege AND
(a.nord = d.nord_pflege OR  
a.ost_basis = d.ost_basis_pflege  OR 
a.ost_gross = d.ost_gross_pflege  OR 
a.sued_ost = d.sued_ost_pflege  OR 
a.sued_west = d.sued_west_pflege  OR 
a.west = d.west_pflege ) 
WHERE --d.vorschlag not in (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'') AND
a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
listung_art = ''Einlistung Potenzialartikel'' AND 
''1'' = 1 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12, d.stk_re_pflege
HAVING Round(umsatz_,1) <> 0 
UNION ALL 
-- Regionen on top (Nielsen 2) 
-- NUR FUER KL-ARTIKEL_1, DIE AUS NIELSEN KALKULIERT WERDEN! 
SELECT b.matching_id, 
a.sm_id, 
a.nord, 
a.ost_basis, 
a.ost_gross, 
a.sued_ost, 
a.sued_west, 
a.west, 
b.art_id, 
b.kjmo, 
b.kjwo_update,
Max(b.status_1) AS status_1, 
Sum(a.umsatz_hr) AS umsatz_, 
Sum(a.absatz_hr) AS absatz_, 
Sum(a.absatz_hr*Coalesce(Cast(REPLACE(d.stk_re_pflege ,'','',''.'') AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_ 
FROM dbp_msi_data.nl_listung_1 a 
--JOIN dbp_msi_data.sortiment_art_1 b 
INNER JOIN CTE b
ON 1 = b.mandant_id AND 
a.kjwo_update = b.kjwo_update AND 
a.sm_id_selected = b.LISTUNG_SST_PFLEGE 
INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 d
ON d.gtin = b.gtin_id  AND 
(trim(a.nord) = trim(d.nord_pflege)  OR  
      trim(a.ost_basis) = trim(d.ost_basis_pflege)  OR 
trim(a.ost_gross) = trim(d.ost_gross_pflege)  OR 
trim(a.sued_ost) = trim(d.sued_ost_pflege)  OR 
trim(a.sued_west) = trim(d.sued_west_pflege)  OR 
trim(a.west) = trim(d.west_pflege) )
JOIN dbp_etl.bf_sort_sal_export_1 c 
ON b.art_id/100 = Cast(c.art_nr AS INT) 
WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = d.GTIN ) AND 
a.listung_art = ''Listung erweitern'' AND 
''1'' = 1 
GROUP BY 1,2,3,4,5,6,7,8,9 , 10,11
HAVING Round(umsatz_,1) <> 0 
) x 
JOIN (SELECT art_matching_id, 
Max(kl_wg_id) AS kl_wg_id, 
Max(kl_owg_id) AS kl_owg_id, 
Max(kl_uwg_id) AS kl_uwg_id 
FROM dbp_etl.art_matching_nielsen_per_1 
GROUP BY 1) y 
ON x.matching_id = y.art_matching_id 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20;`
                                       sql = sql.replace(/''undefined''/g, "NULL") 
                                       sql_stmt = snowflake.createStatement({sqlText: sql}); 
                                       sql_stmt.execute(); 



        }
    }


// Nur Case: var_region_summary = 1 :
//-------------------------------------------------------------------------------------------------------- 
//--   (III) UPDATE FUER SORTIMENT_LEISTUNG_1 (nur Regionen) 
//-------------------------------------------------------------------------------------------------------- 

// else if ((var_listung_sst_pflege == '' '' || var_listung_sst_pflege == undefined) AND (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'').includes(var_vorschlag_hr) == false)
// Z 1247


/* // Debug Mode
sql = `SELECT ''WIRD DAS STMT AUSGEFÜHRT??''`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); */ 

// Check if SQL-Statments have to be executed
sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
res = sql_stmt.execute(); 
res.next();
row_count_g = res.getColumnValue(1)

if(row_count_g > 0){

// Update for matching art_id ART_ID
sql = `UPDATE dbp_data.sortiment_leistung_1 tgt 
SET tgt.umsatz_hr = ifnull(src.umsatz ,0)
   ,tgt.absatz_hr = ifnull(src.absatz ,0)
   ,tgt.rohertrag_hr = ifnull(src.rohertrag,0) 
   ,tgt.listungsaktion = src.vorschlag 
FROM (WITH CTE_PRE AS 
      (
            SELECT DISTINCT * 
              FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
            WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
      )
, CTE AS 
( SELECT a.mandant_id, 
         a.art_id, 
         Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
         Max(a.status_1) AS status_1, 
         B.KJWO_UPDATE AS kjwo_update, 
         B.KJMO AS kjmo, 
         b.ART_ID AS input_art_id, 
         b.LISTUNG_SST_PFLEGE, 
         --B.GTIN AS input_gtin, 
         --B.NL_ART_BEZ, 
         b.nord_pflege, 
         b.ost_basis_pflege, 
         b.ost_gross_pflege, 
         b.sued_ost_pflege, 
         b.sued_west_pflege, 
         b.west_pflege, 
         b.region_only
  FROM dbp_etl.art_matching_nielsen_per_1 a 
  INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b ON a.art_matching_id = b.MATCHING_ID  
  WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
  AND
            CASE
              WHEN trim(a.status_1) <> ''N'' AND
                   trim(a.list_kz) = ''A''
              THEN 1
              WHEN trim(a.status_1) = ''N''
              THEN 1
              ELSE 0
            END = 1
  GROUP BY 1,2,5,6,7,8 ,9,10,11,12,13,14, 15
) 
SELECT Sum(x.anzahl_reduktion) AS anzahl_reduktion_, 
                   Sum(x.anzahl_erweiterung) AS anzahl_erweiterung_, 
                   replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                   CASE WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__ 
WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN ''Listung reduzieren und erweitern'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN ''Listung erweitern und reduzieren'' 
WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung'' 
ELSE ''nicht möglich'' END AS vorschlag, 
CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS umsatz,
                                                       CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS absatz,
                                                       CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS rohertrag,
                   MANDANT_ID, 
                 input_art_id AS ART_ID, 
                 KJWO_UPDATE, 
                 KJMO 
             FROM (-- KL nur Regionen; Erweiterung!!! 
                     SELECT a.art_id,
                     MAX(b.status_1) AS status_1,
                     MIN(a.list_kz) AS list_kz_,
                     SUM(a.umsatz_hr) AS umsatz_,
                     SUM(a.absatz_hr) AS absatz_,
                     SUM(a.rohertrag_hr) AS rohertrag_,
                     SUM(CASE WHEN a.listung_art = ''Listung erweitern'' THEN cast(0 as int)
                              WHEN a.Listung_art = ''Listung reduzieren'' THEN reduktion_fg
                         END) AS anzahl_reduktion,
                     SUM(CASE WHEN a.listung_art = ''Listung erweitern'' THEN erweiterung_fg
                              WHEN a.Listung_art = ''Listung reduzieren'' THEN cast(0 as int)
                        END) AS anzahl_erweiterung,
                        CASE WHEN a.listung_art = ''Listung erweitern'' THEN
                                                      CASE WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN CAST(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE CAST(''dynamic'' AS VARCHAR(100)) END 
                              WHEN a.listung_art = ''Listung reduzieren'' THEN ''dynamic''
                        END
                     AS vorschlag_,
              b.MANDANT_ID, 
                                  b.input_art_id, 
                         b.KJWO_UPDATE, 
                         b.KJMO 
                              FROM dbp_msi_data.kl_listung_1 a 
                              JOIN CTE b
                              ON a.mandant_id = b.mandant_id AND
                                 a.art_id = b.art_id AND
                                 a.kjwo_update = b.kjwo_update AND
                                 (trim(a.nord) = trim(b.nord_pflege) OR 
                                    trim(a.ost_basis) = trim(b.ost_basis_pflege) OR
                                    trim(a.ost_gross) = trim(b.ost_gross_pflege) OR
                                    trim(a.sued_ost) = trim(b.sued_ost_pflege) OR
                                    trim(a.sued_west) = trim(b.sued_west_pflege) OR
                                    trim(a.west) = trim(b.west_pflege)) AND
                                  b.region_only = 1
                            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND
                                  a.listung_art in (''Listung reduzieren'', ''Listung erweitern'') AND
                                  a.sm_id_selected = 0 
                        GROUP BY 1,10,11,12,13  , a.listung_art
                        ) x
                        GROUP BY MANDANT_ID  
                        ,input_art_id  
                        ,KJWO_UPDATE 
                        ,KJMO 
                               ) src                           
 WHERE tgt.mandant_id = src.mandant_id 
 AND tgt.art_id = src.art_id 
 AND tgt.kjmo = src.kjmo 
 AND tgt.kjwo_update = src.kjwo_update;` 
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  


/* //Debug Mode
sql = `SELECT ''ICH HOFFE SCHON !!''`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  */

// GTIN & NL_ART_BEZ
sql = `UPDATE dbp_data.sortiment_leistung_1 tgt 
SET tgt.umsatz_hr = ifnull(src.umsatz ,0)
   ,tgt.absatz_hr = ifnull(src.absatz ,0)
   ,tgt.rohertrag_hr = ifnull(src.rohertrag, 0) 
   ,tgt.listungsaktion = src.vorschlag 
FROM (WITH CTE_PRE AS
      (
            SELECT DISTINCT * 
              FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
            WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
      )
, CTE AS 
( SELECT a.mandant_id, 
         a.art_id, 
         Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
         Max(a.status_1) AS status_1, 
         B.KJWO_UPDATE AS kjwo_update, 
         B.KJMO AS kjmo, 
         --b.ART_ID AS input_art_id, 
         b.STK_RE_PFLEGE, 
         B.GTIN AS input_gtin, 
         B.NL_ART_BEZ, 
         b.nord_pflege, 
         b.ost_basis_pflege, 
         b.ost_gross_pflege, 
         b.sued_ost_pflege, 
         b.sued_west_pflege, 
         b.west_pflege
  FROM dbp_etl.art_matching_nielsen_per_1 a 
  INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b ON a.art_matching_id = b.MATCHING_ID  
  WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
  AND
  CASE
        WHEN trim(a.status_1) <> ''N'' AND
            trim(a.list_kz) = ''A''
        THEN 1
        WHEN trim(a.status_1) = ''N''
        THEN 1
        ELSE 0
  END = 1
  GROUP BY 1,2,5,6,7,8 ,9,10,11,12,13,14, 15
) 
SELECT Sum(x.anzahl_reduktion) AS anzahl_reduktion_, 
                   Sum(x.anzahl_erweiterung) AS anzahl_erweiterung_, 
                   replace(replace(
                         	Max(
                         		IFF(x.anzahl_reduktion != 0 OR x.anzahl_erweiterung != 0
                         					, replace(x.vorschlag_, ''dynamic'', ''Dynamic'')
                         					, replace(x.vorschlag_, ''dynamic'', ''AAA_1'')
                         						)
                         	)
                         	   , ''Dynamic'', ''dynamic'')
                         	   , ''AAA_1'', ''dynamic'')AS vorschlag__, 
                   CASE WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__ 
WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN ''Listung reduzieren und erweitern'' 
WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN ''Listung erweitern und reduzieren'' 
WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung'' 
ELSE ''nicht möglich'' END AS vorschlag, 
CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS umsatz,
                                                       CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS absatz,
                                                       CASE
                                                         WHEN vorschlag = ''SOLL-Listung = IST-Listung''
                                                         THEN 0
                                                         ELSE ifnull(COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = ''G'' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) ,0)
                                                       END AS rohertrag,
                   MANDANT_ID, 
                 input_gtin AS GTIN, 
                  NL_ART_BEZ,
                 KJWO_UPDATE, 
                 KJMO 
             FROM (--Nur Regionen fuer Nielsen (1) 
                              SELECT 1 AS art_id, 
                                     ''N'' AS status_1, 
                                     MAX(''A'') AS list_kz,
                                     Sum(a.umsatz_hr) AS umsatz_, 
                                     Sum(a.absatz_hr) AS absatz_, 
                                     Sum(a.absatz_hr)*Sum(Cast(REPLACE(b.STK_RE_PFLEGE,'','',''.'') AS FLOAT)) AS rohertrag_, 
                                     Cast(0 AS INT) AS anzahl_reduktion, 
                                     Count(*) AS anzahl_erweiterung, 
                                     ''Einlistung Potenzialartikel'' AS vorschlag_, 
                                     a.MANDANT_ID,  
                       b.KJWO_UPDATE, 
                       b.KJMO, 
                         b.GTIN as input_gtin, 
                         b.NL_ART_BEZ  
                              FROM dbp_msi_data.nl_listung_1 a 
                        INNER JOIN CTE_PRE b ON a.GTIN = b.GTIN AND 
                              a.kjwo_update = b.kjwo_update AND 
                              a.art_nielsen_bez = B.NL_ART_BEZ AND 
                              a.sm_id_selected = 0 AND 
                              (trim(a.nord) = trim(b.nord_pflege) AND  
                              trim(a.ost_basis) = trim(b.ost_basis_pflege) AND  
                              trim(a.ost_gross) = trim(b.ost_gross_pflege) AND  
                              trim(a.sued_ost) = trim(b.sued_ost_pflege) AND  
                              trim(a.sued_west) = trim(b.sued_west_pflege) AND  
                              trim(a.west) = trim(b.west_pflege)) 
                              WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
                                    a.listung_art = ''Einlistung Potenzialartikel'' AND 
                                    ''1'' = 1 
                              GROUP BY 1,2,10,11,12,13,14
                              --HAVING umsatz_ <> 0 
                              UNION ALL
                              -- NUR FUER KL-ARTIKEL_1, DIE AUS NIELSEN KALKULIERT WERDEN! 
                              SELECT b.art_id, 
                                     Max(b.status_1) AS status_1, 
                                     Max(''A'') as list_kz,
                                     Sum(a.umsatz_hr) AS umsatz_, 
                                     Sum(a.absatz_hr) AS absatz_, 
                                     Sum(a.absatz_hr*Coalesce(Cast(REPLACE(b.stk_re_pflege,'','',''.'') AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_, 
                                     Cast(0 AS INT) AS anzahl_reduktion, 
                                     Count(*) AS anzahl_erweiterung, 
                                     ''Einlistung Kauflandartikel'' AS vorschlag_ 
                                    ,1 AS MANDANT_ID  
                       ,b.KJWO_UPDATE 
                       ,b.KJMO 
                       ,b.input_gtin 
                       ,b.NL_ART_BEZ 
                              FROM dbp_msi_data.nl_listung_1 a 
                              JOIN CTE b 
                                ON 1 = b.mandant_id AND 
                                   a.kjwo_update = b.kjwo_update AND 
                                   a.sm_id_selected = 0 AND 
                                   a.gtin = b.input_gtin AND
                                   (trim(a.nord) = trim(b.nord_pflege) AND  
                                    trim(a.ost_basis) = trim(b.ost_basis_pflege) AND  
                                    trim(a.ost_gross) = trim(b.ost_gross_pflege) AND  
                                    trim(a.sued_ost) = trim(b.sued_ost_pflege) AND  
                                    trim(a.sued_west) = trim(b.sued_west_pflege) AND  
                                    trim(a.west) = trim(b.west_pflege))
                              JOIN dbp_etl.bf_sort_sal_export_1 c 
                                ON b.art_id/100 = Cast(c.art_nr AS INT) 
                              --INNER JOIN dbp_etl.not_listed_basis_1 e
                              --  ON a.gtin = e.gtin_id
                              --AND d.gtin = e.gtin_id
                              WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = b.input_gtin) AND 
                                   a.listung_art = ''Listung erweitern'' AND
                                    ''1'' = 1
                              GROUP BY 1 , 11, 12, 13, 14
                              --HAVING umsatz_ <> 0    
                              ) x
                              GROUP BY MANDANT_ID  
                              ,KJWO_UPDATE 
                              ,KJMO 
                              ,input_gtin 
                              ,NL_ART_BEZ 
                                     ) src                           
       WHERE tgt.mandant_id = src.mandant_id 
       AND tgt.gtin = src.gtin 
       AND tgt.kjmo = src.kjmo 
       AND tgt.nielsen_art_bez = src.nl_art_bez 
       AND tgt.kjwo_update = src.kjwo_update;                    
                                                            ` 
      sql = sql.replace(/''undefined''/g, "NULL") 
   sql_stmt = snowflake.createStatement({sqlText: sql}); 
   sql_stmt.execute(); 




sql = `UPDATE dbp_data.sortiment_leistung_1 trg
   SET trg.listungsaktion = src.listungsaktion
   FROM 
   (SELECT CASE
                  WHEN b.region_only = 1
                  THEN
                        CASE
                        WHEN (a.listung_sst_mvke = ''N/A'' OR a.listung_sst_mvke IS NULL) AND
                              GREATEST(COALESCE(a.ost_basis,'' ''),COALESCE(a.ost_gross,'' ''),COALESCE(a.sued_ost,'' ''),COALESCE(a.sued_west,'' ''),COALESCE(a.west,'' ''),COALESCE(a.nord,'' '')) = '' '' AND
                              a.anz_maerkte_sst = 0 AND a.anz_maerkte_baustein_sonstige = 0 AND a.anz_maerkte_listung_einzel = 0 AND a.anz_maerkte_listung_gesamt = 0
                        THEN ''Einlistung Kauflandartikel''
                  ELSE a.listungsaktion
                  END
          ELSE a.listungsaktion
         END AS listungsaktion
         , b.matching_id
         , b.kjmo
         , b.kjwo_update
   FROM dbp_data.sortiment_leistung_1 a
   INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b
   ON a.kjmo = b.kjmo AND 
   a.kjwo_update = b.kjwo_update AND
   a.matching_id = b.matching_id
   WHERE a.mandant_id = 1 AND 
   a.art_id IS NOT NULL AND 
   NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag IS NULL)
   ) src
   WHERE trg.mandant_id = 1 AND
   trg.kjmo = src.kjmo AND
   trg.kjwo_update = src.kjwo_update AND
   trg.matching_id = src.matching_id
   ;`
   sql = sql.replace(/''undefined''/g, "NULL") 
   sql_stmt = snowflake.createStatement({sqlText: sql}); 
   sql_stmt.execute(); 


//-------------------------------------------------------------------------------------------------------- 
//--   (IV) INSERT FUER ERWARTETE ENTWICKLUNG (nur Regionen) 
//-------------------------------------------------------------------------------------------------------- 
// if ((''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'').includes(var_vorschlag_hr) == false)
// Z. 1428 ff
// FILTER VORSCHLAG NOT IN (''Keine Veränderung'',''Keine Veränderung setzen'',''Keine Veränderung zurücksetzen'',''Produktwissen_1'',''Zurücksetzen'')
// vergleich: vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'')

// Filter von (III): NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND b.vorschlag NOT IN (''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'')
// neuer Filter:  NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'')

// Check if SQL-Statments have to be executed
sql = `SELECT COUNT(*) FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 d
WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag is null)`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
res = sql_stmt.execute(); 
res.next();
row_count_h = res.getColumnValue(1)

if(row_count_h > 0){


sql=`DELETE FROM dbp_msi_data.erwartete_entwicklung_1 a 
            USING PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 d
      WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag is null) AND
            a.matching_id = d.matching_id AND 
            a.kjmo = d.kjmo AND 
            a.kjwo_update = d.kjwo_update AND 
            a.mandant_id = 1`

sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  




// Insert for matching art_id
sql = `INSERT INTO dbp_msi_data.erwartete_entwicklung_1 (mandant_id 
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
WITH CTE_PRE AS 
      (
            SELECT DISTINCT * 
              FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 d
            WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag IS NULL)
      )
SELECT DISTINCT 1 AS mandant_id 
,x.kjmo AS kjmo 
,x.matching_id 
,x.sm_id 
,'' '' AS ksm_id 
,x.KJWO_UPDATE AS kjwo_update 
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
,Coalesce(Sum(x.umsatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0) AS umsatz 
,Coalesce(Sum(x.absatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0) AS absatz 
,Coalesce(Sum(x.rohertrag_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0) AS rohertrag 
FROM (
   WITH CTE AS 
      ( SELECT a.mandant_id, 
      a.art_id, 
      Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
      Max(a.status_1) AS status_1, 
      B.KJWO_UPDATE AS kjwo_update, 
      B.KJMO AS kjmo, 
      b.ART_ID AS input_art_id, 
      b.LISTUNG_SST_PFLEGE, 
      --B.GTIN AS input_gtin, 
      --B.NL_ART_BEZ , 
      b.matching_id, 
      b.nord_pflege, 
      b.ost_basis_pflege, 
      b.ost_gross_pflege, 
      b.sued_ost_pflege,
      b.sued_west_pflege, 
      b.west_pflege
      , b.region_only
      FROM dbp_etl.art_matching_nielsen_per_1 a 
      INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b 
      ON a.art_matching_id = b.MATCHING_ID  
      WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag is null)
      AND
      CASE
            WHEN trim(a.status_1) <> ''N'' AND
                trim(a.list_kz) = ''A''
            THEN 1
            WHEN trim(a.status_1) = ''N''
            THEN 1
            ELSE 0
      END = 1
      GROUP BY 1,2,5,6,7,8,9, 10,11,12,13,14,15,16
      ) 
            -- Regionen on top; Erweiterung!!! - Reduktion!!! 
            SELECT b.matching_id AS matching_id, 
            a.sm_id, 
            a.nord, 
            a.ost_basis, 
            a.ost_gross, 
            a.sued_ost, 
            a.sued_west, 
            a.west, 
            a.art_id, 
            b.kjmo, 
            b.kjwo_update,
            Max(b.status_1) AS status_1, 
            Sum(a.umsatz_hr) AS umsatz_, 
            Sum(a.absatz_hr) AS absatz_, 
            Sum(a.rohertrag_hr) AS rohertrag_ 
            FROM dbp_msi_data.kl_listung_1 a 
            --JOIN dbp_msi_data.sortiment_art_1 b 
            INNER JOIN CTE b
            ON a.mandant_id = b.mandant_id AND 
            a.art_id = b.art_id AND 
            a.kjwo_update = b.kjwo_update AND 
            a.sm_id_selected = 0 AND
            (a.nord = b.nord_pflege  OR  
            a.ost_basis = b.ost_basis_pflege  OR 
            a.ost_gross = b.ost_gross_pflege  OR 
            a.sued_ost = b.sued_ost_pflege  OR 
            a.sued_west = b.sued_west_pflege  OR 
            a.west = b.west_pflege ) 
            WHERE a.art_id NOT IN (SELECT art_id FROM dbp_etl.not_listed_basis_1) AND 
            a.listung_art IN (''Listung erweitern'',''Listung reduzieren'')  AND 
            b.region_only = 1 AND
            ''1'' = 1 
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11
            HAVING Round(umsatz_,1) <> 0 
) x 
JOIN (SELECT art_matching_id, 
Max(kl_wg_id) AS kl_wg_id, 
Max(kl_owg_id) AS kl_owg_id, 
Max(kl_uwg_id) AS kl_uwg_id 
FROM dbp_etl.art_matching_nielsen_per_1 
GROUP BY 1) y 
ON x.matching_id = y.art_matching_id 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20`

// INsert for matching GTIN and NL_ART_BEZ
sql = `
INSERT INTO dbp_msi_data.erwartete_entwicklung_1 (mandant_id 
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
WITH CTE_pre AS
      (
            SELECT DISTINCT * 
              FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 d
              WHERE NULLIF(d.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (d.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or d.vorschlag is null)
      )
SELECT DISTINCT 1 AS mandant_id 
,x.kjmo AS kjmo 
,x.matching_id 
,x.sm_id 
,'' '' AS ksm_id 
,x.KJWO_UPDATE AS kjwo_update 
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
,Coalesce(Sum(x.umsatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0) AS umsatz 
,Coalesce(Sum(x.absatz_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0) AS absatz 
,Coalesce(Sum(x.rohertrag_)/CASE WHEN Max(x.status_1) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END,0) AS rohertrag 
FROM (
   WITH CTE AS 
      ( SELECT a.mandant_id, 
      a.art_id, 
      Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id, 
      Max(a.status_1) AS status_1, 
      B.KJWO_UPDATE AS kjwo_update, 
      B.KJMO AS kjmo, 
      --b.ART_ID AS input_art_id, 
      b.STK_RE_PFLEGE, 
      B.GTIN AS input_gtin, 
      B.NL_ART_BEZ , 
      b.matching_id, 
      b.nord_pflege, 
      b.ost_basis_pflege, 
      b.ost_gross_pflege, 
      b.sued_ost_pflege,
      b.sued_west_pflege, 
      b.west_pflege
      FROM dbp_etl.art_matching_nielsen_per_1 a 
      INNER JOIN PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1 b 
      ON a.art_matching_id = b.MATCHING_ID  
      WHERE NULLIF(b.LISTUNG_SST_PFLEGE, '' '') IS NULL AND (b.vorschlag NOT IN (''Keine Veränderung zurücksetzen'',''Keine Veränderung setzen'',''Zurücksetzen'',''Produktwissen_1'',''Keine Veränderung'') or b.vorschlag is null)
      AND
      CASE
            WHEN trim(a.status_1) <> ''N'' AND
                trim(a.list_kz) = ''A''
            THEN 1
            WHEN trim(a.status_1) = ''N''
            THEN 1
            ELSE 0
      END = 1
      GROUP BY 1,2,5,6,7,8,9, 10,11,12,13,14,15,16
      ) 
      --Nur Regionen fuer Nielsen (1) 
                  SELECT d.matching_id, 
                        sm_id, 
                        nord, 
                        ost_basis, 
                        ost_gross, 
                        sued_ost, 
                        sued_west, 
                        west, 
                        1 AS art_id, 
                        ''N'' AS status_1, 
                        d.kjmo, 
                        d.kjwo_update,
                        Sum(umsatz_hr) AS umsatz_, 
                        Sum(absatz_hr) AS absatz_, 
                        Sum(absatz_hr)*Cast(REPLACE(d.stk_re_pflege,'','',''.'') AS FLOAT) AS rohertrag_ 
                        FROM dbp_msi_data.nl_listung_1 a
                        INNER JOIN CTE d
                        ON a.gtin = d.input_gtin AND 
                        a.kjwo_update = d.kjwo_update  AND 
                        a.art_nielsen_bez = d.NL_ART_BEZ  AND 
                        a.sm_id_selected = 0 AND
                        (trim(a.nord) = trim(d.nord_pflege) OR  
                        trim(a.ost_basis) = trim(d.ost_basis_pflege)  OR 
                        trim(a.ost_gross) = trim(d.ost_gross_pflege)  OR 
                        trim(a.sued_ost) = trim(d.sued_ost_pflege)  OR 
                        trim(a.sued_west) = trim(d.sued_west_pflege)  OR 
                        trim(a.west) = trim(d.west_pflege) ) 
                        WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1) AND 
                        listung_art = ''Einlistung Potenzialartikel'' AND 
                        ''1'' = 1 
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12, d.stk_re_pflege
                        HAVING Round(umsatz_,1) <> 0 
                        UNION ALL 
                        -- NUR FUER KL-ARTIKEL_1, DIE AUS NIELSEN KALKULIERT WERDEN! 
                        SELECT d.matching_id, 
                        a.sm_id, 
                        a.nord, 
                        a.ost_basis, 
                        a.ost_gross, 
                        a.sued_ost, 
                        a.sued_west, 
                        a.west, 
                        d.art_id, 
                        d.kjmo, 
                        d.kjwo_update,
                        Max(d.status_1) AS status_1, 
                        Sum(a.umsatz_hr) AS umsatz_, 
                        Sum(a.absatz_hr) AS absatz_, 
                        Sum(a.absatz_hr*Coalesce(Cast(REPLACE(d.stk_re_pflege ,'','',''.'') AS FLOAT),c.stueck_re_mep,0)) AS rohertrag_ 
                        FROM dbp_msi_data.nl_listung_1 a 
                        --JOIN dbp_msi_data.sortiment_art_1 b 
                        INNER JOIN CTE d
                        ON a.gtin = d.input_gtin AND 
                        a.kjwo_update = d.kjwo_update  AND 
                        a.art_nielsen_bez = d.NL_ART_BEZ  AND 
                        a.sm_id_selected = 0 AND
                        (a.nord = d.nord_pflege OR  
                        a.ost_basis = d.ost_basis_pflege  OR 
                        a.ost_gross = d.ost_gross_pflege  OR 
                        a.sued_ost = d.sued_ost_pflege  OR 
                        a.sued_west = d.sued_west_pflege  OR 
                        a.west = d.west_pflege ) 
                        LEFT JOIN dbp_etl.bf_sort_sal_export_1 c 
                              ON d.art_id/100 = Cast(c.art_nr AS INT) 
                        WHERE a.gtin IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_1 WHERE Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(100)) = d.input_gtin) AND 
                        a.listung_art = ''Listung erweitern'' AND 
                        ''1'' = 1 
                        GROUP BY 1,2,3,4,5,6,7,8,9 , 10,11
                        HAVING Round(umsatz_,1) <> 0
      ) x 
      JOIN (SELECT art_matching_id, 
      Max(kl_wg_id) AS kl_wg_id, 
            Max(kl_owg_id) AS kl_owg_id, 
            MAX(kl_uwg_id) AS kl_uwg_id 
      FROM dbp_etl.art_matching_nielsen_per_1 
      GROUP BY 1) y 
                        ON x.matching_id = y.art_matching_id 
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20`
                        sql = sql.replace(/''undefined''/g, "NULL") 
                        sql_stmt = snowflake.createStatement({sqlText: sql}); 
                        sql_stmt.execute(); 

      }
    }

}





// Ende der Filter von (III) und (IV)


//-- Tracking der identischen WG-Hierarchie des uebergebenen Matchings 
//-- durch Egalisierung der Felder in der erwarteten_entwicklung. 

// ll 1755

if(row_count_0 > 0 && row_count_1 > 0){
      sql = `CREATE OR REPLACE temporary DBP_MACRO.TABLE PUBLIC.TEMP_INPUT_TABLE_EK_SORT_runtime
            AS
      SELECT DISTINCT * 
        FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0
      UNION ALL
      SELECT DISTINCT * 
        FROM PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1
      `
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();

var var_input_table = "PUBLIC.TEMP_INPUT_TABLE_EK_SORT_runtime"
}

else if(row_count_0 > 0 && row_count_1 == 0){

      var var_input_table = "PUBLIC.TEMP_INPUT_TABLE_EK_SORT_0"

}

else if(row_count_0 == 0 && row_count_1 > 0){

      var var_input_table = "PUBLIC.TEMP_INPUT_TABLE_EK_SORT_1"
      
}

else {

    var var_input_table = "PUBLIC.INPUT_TABLE_EK_SORT_runtime"
    
}


// Check if SQL-Statement to be executed            
sql = `SELECT COUNT(*) FROM public.input_table_ek_sort_runtime src
            WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
            and src.vorschlag = ''Zurücksetzen''`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            sql_stmt.execute(); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_z = res.getColumnValue(1)            

if (row_count_z > 0){  
// GTIN-Filter gilt weiterhin
// neuer Filter: vorschlag = Zurücksetzen
sql = `DELETE FROM dbp_data.art_kl_preislage_zu_per_neu_1 trg
      USING PUBLIC.input_table_ek_sort_runtime src
      WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
      and src.vorschlag = ''Zurücksetzen''
        AND trg.kjmo = src.kjmo AND 
      trg.kjwo_update = src.kjwo_update AND
      trg.art_matching_id = src.matching_id AND
      trg.mandant_id = 1
;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();



sql = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu_1
(mandant_id 
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
      ,menge_sa )
SELECT mandant_id 
      ,art_matching_id 
      ,trg.kjmo 
      ,trg.kjwo_update 
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
      ,menge_sa 
FROM dbp_data.art_kl_preislage_zu_per_1 trg
INNER JOIN PUBLIC.input_table_ek_sort_runtime src
ON trg.kjmo = src.kjmo AND 
      trg.kjwo_update = src.kjwo_update AND
      trg.art_matching_id = src.matching_id
WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
and src.vorschlag = ''Zurücksetzen'' AND
trg.mandant_id = 1`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();

}



// Check if SQL-Statement to be executed            
//sql = `SELECT COUNT(*) FROM ` + var_input_table + ` src
//            WHERE ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
//            and src.vorschlag != ''Zurücksetzen''`

sql = `SELECT COUNT(*)
FROM ` + var_input_table + ` src
INNER JOIN dbp_data.sortiment_leistung_1 a
  ON a.kjmo = src.kjmo
 AND a.kjwo_update = src.kjwo_update
INNER JOIN dbp_data.art_kl_preislage_zu_per_neu_1 c
  ON a.mandant_id = c.mandant_id AND
     a.kjmo = c.kjmo AND
     a.matching_id = c.art_matching_id AND
     a.listung_sst_mvke = c.sm_id AND
     a.kjwo_update = c.kjwo_update
WHERE a.umsatz_hr IS NOT NULL
 AND a.listung_sst_pflege NOT IN (''N/A'')
 AND ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
 AND src.vorschlag != ''Zurücksetzen''
 AND a.listungsaktion IN (''Listung erweitern'',''Einlistung Kauflandartikel'',''Listung reduzieren und erweitern'',''Listung erweitern und reduzieren'')
AND (a.mandant_id,a.matching_id,a.kjmo,a.kjwo_update) NOT IN (SELECT	mandant_id,art_matching_id,kjmo,kjwo_update  
                                                                   FROM dbp_data.art_kl_preislage_zu_per_neu_1 
                                                                   WHERE sm_id NOT IN (''N/A'',''-1''))`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_u = res.getColumnValue(1)

if (row_count_u > 0){ 
// Urspr auskommentiert
// LL 1789

sql = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu_1 (mandant_id 
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
       '' '' AS ksm_id, 
       a.owg_id, 
       a.wg_id, 
       a.wug_id, 
       a.vk_preis AS vk_brutto_pk_1, 
       a.durchschnitt_preis AS durchschnitt_preis_kasse, 
       c.umsatz_brutto, 
       c.umsatz_brutto_af, 
       c.umsatz_brutto_sa, 
       c.menge, 
       c.menge_af, 
       c.menge_sa 
FROM dbp_data.sortiment_leistung_1 a 
JOIN dbp_data.art_kl_preislage_zu_per_neu_1 c 
  ON a.mandant_id = c.mandant_id AND  
     a.kjmo = c.kjmo AND  
     a.matching_id = c.art_matching_id AND  
     a.listung_sst_mvke = c.sm_id AND 
     a.kjwo_update = c.kjwo_update 
JOIN (SELECT wtag_id AS k 
      FROM dbp_data.tag_1 
   WHERE wtag_id BETWEEN 1 AND 5 
   GROUP BY 1) b 
ON a.listung_sst_pflege <= b.k AND  
   b.k < CASE WHEN a.listung_sst_mvke = ''N/A'' THEN 6 ELSE CAST(a.listung_sst_mvke AS INT) END 
INNER JOIN ` + var_input_table + ` d
  ON a.kjmo = d.kjmo AND 
      a.kjwo_update = d.kjwo_update 
WHERE 
      a.umsatz_hr IS NOT NULL AND  
      a.listung_sst_pflege NOT IN (''N/A'') AND
      ((d.gtin IS NOT NULL AND d.GTIN NOT IN (-9999,-9998)) OR d.gtin IS NULL)
      and d.vorschlag != ''Zurücksetzen'' AND
      a.listungsaktion IN (''Listung erweitern'',''Einlistung Kauflandartikel'',''Listung reduzieren und erweitern'',''Listung erweitern und reduzieren'') AND  
     (a.mandant_id,a.matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT	mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT),kjwo_update  
                                                                   FROM dbp_data.art_kl_preislage_zu_per_neu_1 
                                                                   WHERE sm_id NOT IN (''N/A'',''-1'')) 
;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  
}
sql = `DELETE FROM	dbp_data.art_kl_preislage_zu_per_neu_1 
WHERE (mandant_id,art_matching_id,kjmo,sm_id,kjwo_update) IN (SELECT a.mandant_id,a.matching_id,a.kjmo,CAST(b.k AS VARCHAR(10)),a.kjwo_update 
                                                              FROM dbp_data.sortiment_leistung_1 a 
                                                              JOIN (SELECT wtag_id AS k 
                                                                    FROM dbp_data.tag_1 
                                                                    WHERE wtag_id BETWEEN 1 AND 5 
                                                                    GROUP BY 1) b 
                                                                ON NULLIF(NULLIF(NULLIF(a.listung_sst_pflege, ''''),'' ''),''N/A'') > b.k 
                                                                AND b.k <= CASE WHEN a.listung_sst_mvke = ''N/A'' THEN 6 ELSE CAST(a.listung_sst_mvke AS INT) END 
                                                              INNER JOIN ` + var_input_table + ` d
                                                                   ON a.kjmo = d.kjmo AND 
                                                                       a.kjwo_update = d.kjwo_update 
                                                              WHERE 
                                                                    ((d.gtin IS NOT NULL AND d.GTIN NOT IN (-9999,-9998)) OR d.gtin IS NULL)
                                                                    and d.vorschlag != ''Zurücksetzen'' AND
                                                                    a.listung_sst_pflege NOT IN (''N/A'') AND
                                                                    a.umsatz_hr IS NOT NULL AND 
                                                                    a.listungsaktion IN (''Listung reduzieren'',''Listung reduzieren und erweitern'',''Listung erweitern und reduzieren'')) 
;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); 

// Check if SQL-Statement to be executed            
sql = `SELECT COUNT(*)
FROM ` + var_input_table + ` src
INNER JOIN dbp_data.sortiment_leistung_1 a
  ON a.kjmo = src.kjmo
 AND a.kjwo_update = src.kjwo_update
INNER JOIN dbp_data.art_kl_preislage_zu_per_neu_1 c 
  ON a.mandant_id = c.mandant_id AND  
     a.kjmo = c.kjmo AND  
     a.matching_id = c.art_matching_id AND  
     a.listung_sst_mvke = c.sm_id AND 
     a.kjwo_update = c.kjwo_update 
WHERE a.umsatz_hr IS NOT NULL
 AND a.listung_sst_pflege NOT IN (''N/A'')
 AND ((src.gtin IS NOT NULL AND src.GTIN NOT IN (-9999,-9998)) OR src.gtin IS NULL)
 AND src.vorschlag != ''Zurücksetzen''
 AND a.listungsaktion IN (''Einlistung Potenzialartikel'',''Einlistung Kauflandartikel'') 
AND (a.mandant_id,a.matching_id,a.kjmo,a.kjwo_update) NOT IN (SELECT	mandant_id,art_matching_id,kjmo,kjwo_update  
                                                                   FROM dbp_data.art_kl_preislage_zu_per_neu_1 
                                                                   WHERE sm_id NOT IN (''N/A'',''-1''))`
            sql = sql.replace(/''undefined''/g, "NULL") 
            sql_stmt = snowflake.createStatement({sqlText: sql}); 
            res = sql_stmt.execute(); 
            res.next();
            row_count_t = res.getColumnValue(1)

if (row_count_t > 0){
sql = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu_1 (mandant_id 
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
       '' '' AS ksm_id, 
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
FROM dbp_data.sortiment_leistung_1 a 
JOIN dbp_data.art_nielsen_preislage_zu_per_1 c 
  ON a.mandant_id = c.mandant_id AND 
     a.kjmo = c.kjmo AND 
	   a.matching_id = c.art_matching_id 
JOIN (SELECT wtag_id AS k 
      FROM dbp_data.tag_1 
   WHERE wtag_id BETWEEN 1 AND 5 
   GROUP BY 1) b 
  ON a.listung_sst_pflege <= b.k 
  INNER JOIN ` + var_input_table + ` d
  ON a.kjmo = d.kjmo AND 
      a.kjwo_update = d.kjwo_update
WHERE ((d.gtin IS NOT NULL AND d.GTIN NOT IN (-9999,-9998)) OR d.gtin IS NULL)
      and d.vorschlag != ''Zurücksetzen'' AND
      a.listung_sst_pflege NOT IN (''N/A'') AND
      a.umsatz_hr IS NOT NULL AND  
      a.listungsaktion IN (''Einlistung Potenzialartikel'',''Einlistung Kauflandartikel'') AND  
     (a.mandant_id,a.matching_id,a.kjmo,b.k,a.kjwo_update) NOT IN (SELECT	mandant_id,art_matching_id,kjmo,CAST(sm_id AS INT),kjwo_update  
                                                                   FROM dbp_data.art_kl_preislage_zu_per_neu_1 
                                                                   WHERE sm_id NOT IN (''N/A'',''-1'')) 
;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute();  
 }
sql = `DELETE FROM	dbp_data.art_kl_preislage_zu_per_neu_1 
WHERE (mandant_id, art_matching_id, kjmo, kjwo_update) IN (SELECT a.mandant_id, a.matching_id, a.kjmo, a.kjwo_update 
                                                           FROM dbp_data.sortiment_leistung_1 a 
                                                           INNER JOIN ` + var_input_table + ` d
                                                            ON a.kjmo = d.kjmo AND 
                                                                  a.kjwo_update = d.kjwo_update
                                                           WHERE ((d.gtin IS NOT NULL AND d.GTIN NOT IN (-9999,-9998)) OR d.gtin IS NULL)
                                                                  and d.vorschlag != ''Zurücksetzen'' AND
                                                                  a.umsatz_hr IS NOT NULL AND  
                                                                 a.listungsaktion = ''Auslistung'')`
                                                                 sql = sql.replace(/''undefined''/g, "NULL") 
                                                                 sql_stmt = snowflake.createStatement({sqlText: sql}); 
                                                                 sql_stmt.execute();  
 


/*
// Abfangjäger

sql = `UPDATE dbp_data.sortiment_leistung_1 trg
SET trg.listungsaktion = ''SOLL-Listung = IST-Listung''
from ( 
    select a.listungsaktion, b.matching_id, b.kjmo, b.kjwo_update
        from dbp_data.sortiment_leistung_1 a        
        inner join public.input_table_ek_sort_runtime b
            on a.mandant_id = 1 AND
                a.kjmo = b.kjmo AND
                a.kjwo_update = b.kjwo_update AND
                a.matching_id = b.matching_id
         where NULLIF(a.listungsaktion, '' '') is null
         and (b.matching_id, b.kjmo, b.kjwo_update) not in (select distinct matching_id, kjmo, kjwo_update FROM dbp_msi_data.kl_listung_1)
) src
WHERE NULLIF(trg.listungsaktion, '' '') IS NULL and
trg.mandant_id = 1 AND
trg.kjmo = src.kjmo AND
trg.kjwo_update = src.kjwo_update AND
trg.matching_id = src.matching_id
      ;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); 




sql = `UPDATE dbp_data.sortiment_leistung_1 trg
SET trg.umsatz_hr = 0,
      trg.absatz_hr = 0,
      trg.rohertrag_hr = 0
from (
    select a.listungsaktion, b.matching_id, b.kjmo, b.kjwo_update
        from dbp_data.sortiment_leistung_1 a        
        inner join public.input_table_ek_sort_runtime b
            on a.mandant_id = 1 AND
                a.kjmo = b.kjmo AND
                a.kjwo_update = b.kjwo_update AND
                a.matching_id = b.matching_id 
      where (b.matching_id, b.kjmo, b.kjwo_update) not in (select distinct matching_id, kjmo, kjwo_update FROM dbp_msi_data.kl_listung_1)          
) src   
WHERE trg.umsatz_hr IS NULL AND 
trg.absatz_hr IS NULL AND 
trg.rohertrag_hr IS NULL AND 
trg.mandant_id = 1 AND
trg.kjmo = src.kjmo AND
trg.kjwo_update = src.kjwo_update AND
trg.matching_id = src.matching_id;`
sql = sql.replace(/''undefined''/g, "NULL") 
sql_stmt = snowflake.createStatement({sqlText: sql}); 
sql_stmt.execute(); */


          
 
                   
';