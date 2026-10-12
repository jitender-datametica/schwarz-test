CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_upd_nfmd_markdown_decision(IN P_MANDANT_ID INT64, IN P_MARKDOWN_DECISION_ID INT64, IN P_MARKDOWN_DECISION STRING, IN P_MARKDOWN_DECISION_EN STRING, IN P_MARKDOWN_DECISION_NATIVE STRING, IN P_FLAG_AKTIV INT64, IN P_FLAG_RETOURE INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
IF P_MARKDOWN_DECISION_ID IN (0, 99) THEN
    SET P_FLAG_AKTIV  =  2;
END IF;


 CASE P_MANDANT_ID 
 WHEN 1 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN 2 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN 3 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN 4 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN  5 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN 6 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN 7 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
WHEN 8 THEN
   
    UPDATE dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 SET
    markdown_decision_descr = P_MARKDOWN_DECISION,
    markdown_decision_descr_bg = P_MARKDOWN_DECISION_NATIVE,
    markdown_decision_descr_cz = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_en = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_hr = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_pl = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_ro = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_sk = P_MARKDOWN_DECISION_EN,
    markdown_decision_descr_native = P_MARKDOWN_DECISION_NATIVE,
    active_fg = P_FLAG_AKTIV,
    retoure_fg = P_FLAG_RETOURE
WHERE mandant_id = P_MANDANT_ID AND markdown_decision_id = P_MARKDOWN_DECISION_ID;
END CASE;

COMMIT TRANSACTION;
SET out_param  =  'Verwertungsentschiedung geaendert';
SELECT out_param;
RETURN;
END;


