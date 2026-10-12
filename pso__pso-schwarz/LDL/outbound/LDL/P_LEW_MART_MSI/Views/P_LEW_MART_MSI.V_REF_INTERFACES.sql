CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_interfaces AS SELECT 1 AS interface_id,
 'Wareneingänge DL' AS interface,
 't_mov_item_wh_receiving' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 2 AS interface_id,
 'Bestandskorrekturen (STD)' AS interface,
 't_stc_item_corr_hist' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 3 AS interface_id,
 'Artikelbestände (STD)' AS interface,
 't_stc_store_item' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 4 AS interface_id,
 'Artikelbestände' AS interface,
 't_stc_item_wh' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 5 AS interface_id,
 'Inventurbestände (STD)' AS interface,
 't_inv_stc_store_item' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 6 AS interface_id,
 'Inventurdaten (Filiale) 1' AS interface,
 't_inv_store' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 7 AS interface_id,
 'Inventurdaten (Filiale) 2' AS interface,
 't_inv_store_item' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 8 AS interface_id,
 'Inventurdaten (Filiale) 3' AS interface,
 't_inv_store_item_corr' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 9 AS interface_id,
 'Inventurdaten (Filiale) 4' AS interface,
 't_inv_store_opendocs' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 10 AS interface_id,
 'Inventurdaten (NL)' AS interface,
 't_inv_item_wh' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 11 AS interface_id,
 'Direktlieferungen' AS interface,
 't_mov_item_dir_delivery' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 12 AS interface_id,
 'Kleinbelege' AS interface,
 't_mov_storeform' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 13 AS interface_id,
 'Kommissionierlisten' AS interface,
 't_mov_item_delivery' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 14 AS interface_id,
 'O&G Bestände' AS interface,
 't_stc_store_item_fv' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 15 AS interface_id,
 'O&G Kommissionierlisten' AS interface,
 't_mov_item_fv_delivery' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 16 AS interface_id,
 'Werbeartikel' AS interface,
 't_adv_item_advertising' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 17 AS interface_id,
 'Zuteilungen' AS interface,
 't_mov_item_delivery' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 20 AS interface_id,
 'NFB' AS interface,
 't_stc_item_nfb_wh' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 21 AS interface_id,
 'Bestandänderung' AS interface,
 't_stc_change_item_wh' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR(' ', 1, 1) AS period_id
UNION ALL
SELECT 22 AS interface_id,
 'Fehlartikel' AS interface,
 't_itm_pp_item' AS tablename,
 SUBSTR('W', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id
UNION ALL
SELECT 23 AS interface_id,
 'BNL-Preisdifferenzen' AS interface,
 't_mov_bnl_price_diff' AS tablename,
 SUBSTR('S', 1, 1) AS factlevel_org,
 SUBSTR('D', 1, 1) AS period_id;