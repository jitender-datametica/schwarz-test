CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_markdown_decision(IN P_MANDANT_ID INT64, IN P_MARKDOWN_DECISION STRING, IN P_MARKDOWN_DECISION_EN STRING, IN P_MARKDOWN_DECISION_NATIVE STRING, IN P_FLAG_RETOURE INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;

CASE P_MANDANT_ID
WHEN 1 THEN
     
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 2 THEN
     
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 3 THEN
     
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 4 THEN
     
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 5 THEN
     
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 6 THEN
   
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 7 THEN
    
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
WHEN 8 THEN
    
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2 (mandant_id, markdown_decision_id, markdown_decision_descr, markdown_decision_descr_bg, markdown_decision_descr_cz, markdown_decision_descr_en, markdown_decision_descr_hr, markdown_decision_descr_pl, markdown_decision_descr_ro, markdown_decision_descr_sk, markdown_decision_descr_native, active_fg, retoure_fg)
(SELECT P_MANDANT_ID, CASE WHEN MAX(markdown_decision_id) = 97 THEN 100 ELSE MAX(markdown_decision_id) + 1 END AS markdown_decision_id, P_MARKDOWN_DECISION, P_MARKDOWN_DECISION_NATIVE, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_EN, P_MARKDOWN_DECISION_NATIVE, 1, P_FLAG_RETOURE
    FROM dbp_msi_view_nfmd.ts_nfmd_markdown_decision_2
    WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id NOT IN (98, 99));
END CASE;

COMMIT TRANSACTION;
SET out_param  =  'Verwertungsentscheidung hinzugefuegt';
SELECT out_param;
RETURN;
END;
