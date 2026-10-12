
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_INTERFACES 

AS
                          /*    
                          #DescStart#   
                          #$Revision: 6244 $, $LastChangedBy: hwieber $     
                          #SubjectAreas#: Kleinbelege / Storeforms  
                          #DescEnd#     
                          */    
    
                          SELECT    
                          1 AS interface_id  
                          ,CAST('Wareneingänge DL' AS VARCHAR(100)) AS interface
                          ,CAST('t_mov_item_wh_receiving' AS VARCHAR(100)) AS tablename
                          ,CAST('W' AS CHAR(1)) AS factlevel_org
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          2 AS interface_id  
                          ,CAST('Bestandskorrekturen (STD)' AS VARCHAR(100)) AS interface
                          ,CAST('t_stc_item_corr_hist' AS VARCHAR(100)) AS tablename  
                          ,CAST('S' AS CHAR(1)) AS factlevel_org 
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          3 AS interface_id
                          ,CAST('Artikelbestände (STD)' AS VARCHAR(100)) AS interface   
                          ,CAST('t_stc_store_item' AS VARCHAR(100)) AS tablename   
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          4 AS interface_id    
                          ,CAST('Artikelbestände' AS VARCHAR(100)) AS interface 
                          ,CAST('t_stc_item_wh' AS VARCHAR(100)) AS tablename   
                          ,CAST('W' AS CHAR(1)) AS factlevel_org   
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          5 AS interface_id    
                          ,CAST('Inventurbestände (STD)' AS VARCHAR(100)) AS interface  
                          ,CAST('t_inv_stc_store_item' AS VARCHAR(100)) AS tablename   
                          ,CAST('S' AS CHAR(1)) AS factlevel_org   
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          6 AS interface_id    
                          ,CAST('Inventurdaten (Filiale) 1' AS VARCHAR(100)) AS interface   
                          ,CAST('t_inv_store' AS VARCHAR(100)) AS tablename 
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          7 AS interface_id    
                          ,CAST('Inventurdaten (Filiale) 2' AS VARCHAR(100)) AS interface   
                          ,CAST('t_inv_store_item' AS VARCHAR(100)) AS tablename    
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          8 AS interface_id    
                          ,CAST('Inventurdaten (Filiale) 3' AS VARCHAR(100)) AS interface  
                          ,CAST('t_inv_store_item_corr' AS VARCHAR(100)) AS tablename  
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          9 AS interface_id    
                          ,CAST('Inventurdaten (Filiale) 4' AS VARCHAR(100)) AS interface  
                          ,CAST('t_inv_store_opendocs' AS VARCHAR(100)) AS tablename    
                          ,CAST('S' AS CHAR(1)) AS factlevel_org   
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          10 AS interface_id  
                          ,CAST('Inventurdaten (NL)' AS VARCHAR(100)) AS interface
                          ,CAST('t_inv_item_wh' AS VARCHAR(100)) AS tablename   
                          ,CAST('W' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          11 AS interface_id  
                          ,CAST('Direktlieferungen' AS VARCHAR(100)) AS interface 
                          ,CAST('t_mov_item_dir_delivery' AS VARCHAR(100)) AS tablename
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          12 AS interface_id  
                          ,CAST('Kleinbelege' AS VARCHAR(100)) AS interface
                          ,CAST('t_mov_storeform' AS VARCHAR(100)) AS tablename
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          13 AS interface_id  
                          ,CAST('Kommissionierlisten' AS VARCHAR(100)) AS interface
                          ,CAST('t_mov_item_delivery' AS VARCHAR(100)) AS tablename
                          ,CAST('S' AS CHAR(1)) AS factlevel_org   
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          14 AS interface_id 
                          ,CAST('O&G Bestände' AS VARCHAR(100)) AS interface  
                          ,CAST('t_stc_store_item_fv' AS VARCHAR(100)) AS tablename
                          ,CAST('S' AS CHAR(1)) AS factlevel_org  
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          15 AS interface_id
                          ,CAST('O&G Kommissionierlisten' AS VARCHAR(100)) AS interface
                          ,CAST('t_mov_item_fv_delivery' AS VARCHAR(100)) AS tablename 
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          16 AS interface_id  
                          ,CAST('Werbeartikel' AS VARCHAR(100)) AS interface   
                          ,CAST('t_adv_item_advertising' AS VARCHAR(100)) AS tablename
                          ,CAST('W' AS CHAR(1)) AS factlevel_org   
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          17 AS interface_id  
                          ,CAST('Zuteilungen' AS VARCHAR(100)) AS interface 
                          ,CAST('t_mov_item_delivery' AS VARCHAR(100)) AS tablename
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          -- SELECT     
                          --         18 AS interface_id     
                          --     , CAST('Konten (Filiale)' AS VARCHAR(100)) AS interface    
                          --     , CAST('t_mov_account_store' AS VARCHAR(100)) AS tablename     
                          --     , CAST('S' AS CHAR(1)) AS factlevel_org    
                          --     , CAST('D' AS CHAR(1)) AS period_id    
                          --    
                          -- FROM (SELECT 1 dummy_field) dummy_table    
                          --    
                          -- UNION ALL  
    
                          -- SELECT     
                          --         19 AS interface_id     
                          --     , CAST('Konten (NL)' AS VARCHAR(100)) AS interface     
                          --     , CAST('t_mov_account_wh' AS VARCHAR(100)) AS tablename    
                          --     , CAST('W' AS CHAR(1)) AS factlevel_org    
                          --     , CAST('D' AS CHAR(1)) AS period_id    
                          --    
                          -- FROM (SELECT 1 dummy_field) dummy_table    
                          --    
                          -- UNION ALL  
    
                          SELECT    
                          20 AS interface_id   
                          ,CAST('NFB' AS VARCHAR(100)) AS interface
                          ,CAST('t_stc_item_nfb_wh' AS VARCHAR(100)) AS tablename   
                          ,CAST('W' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          21 AS interface_id   
                          ,CAST('Bestandänderung' AS VARCHAR(100)) AS interface
                          ,CAST('t_stc_change_item_wh' AS VARCHAR(100)) AS tablename   
                          ,CAST('W' AS CHAR(1)) AS factlevel_org    
                          ,CAST('' AS CHAR(1)) AS period_id  
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          22 AS interface_id  
                          ,CAST('Fehlartikel' AS VARCHAR(100)) AS interface
                          ,CAST('t_itm_pp_item' AS VARCHAR(100)) AS tablename  
                          ,CAST('W' AS CHAR(1)) AS factlevel_org   
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
    
                          UNION ALL 
    
                          SELECT    
                          23 AS interface_id   
                          ,CAST('BNL-Preisdifferenzen' AS VARCHAR(100)) AS interface   
                          ,CAST('t_mov_bnl_price_diff' AS VARCHAR(100)) AS tablename 
                          ,CAST('S' AS CHAR(1)) AS factlevel_org    
                          ,CAST('D' AS CHAR(1)) AS period_id 
    
                          FROM (SELECT 1 dummy_field) dummy_table   
;
