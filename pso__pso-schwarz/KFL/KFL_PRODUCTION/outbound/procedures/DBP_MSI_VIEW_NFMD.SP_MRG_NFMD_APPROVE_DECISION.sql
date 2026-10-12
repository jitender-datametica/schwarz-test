CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_mrg_nfmd_approve_decision(IN P_KJWO_WW FLOAT64, IN P_MANDANT_ID FLOAT64, IN P_USER_ID STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
-- Ermittlung bei welchem Artikel die Entscheidung sich geändert hat /bzw. noch keine Entscheidung freigegeben wurden ist
--mv.AKTION_ID,
--AND ff.AKTION_ID = mv.AKTION_ID
-- AND f.AKTION_ID = wb.AKTION_ID
--f.USER_ID = :3,
MERGE INTO dbp_msi_view_nfmd.ts_nfmd_approved_decision AS F
USING (SELECT DISTINCT MV.kjwo_ww, MV.mandant_id, MV.art_id, MV.markdown_decision
    FROM dbp_msi_view_nfmd.mv_nfmd_art_promotion AS MV
        LEFT JOIN dbp_msi_view_nfmd.ts_nfmd_approved_decision AS FF ON MV.kjwo_ww = FF.kjwo_ww AND MV.mandant_id = FF.mandant_id AND MV.art_id = FF.art_id AND MV.markdown_decision = FF.markdown_decision_id
    WHERE MV.kjwo_ww = P_KJWO_WW AND MV.mandant_id = P_MANDANT_ID AND FF.art_id IS NULL) AS wb
ON F.kjwo_ww = wb.kjwo_ww AND F.mandant_id = wb.mandant_id AND F.art_id = wb.art_id
WHEN MATCHED THEN UPDATE SET
    dwh_created_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME),
    markdown_decision_id = CAST(COALESCE(wb.markdown_decision, 0) AS INTEGER)
WHEN NOT MATCHED THEN INSERT (mandant_id, aktion_id, art_id, kjwo_ww, dwh_created_tmsp, user_id, markdown_decision_id) VALUES(CAST(wb.mandant_id AS INTEGER), '0', CAST(wb.art_id AS INTEGER), CAST(wb.kjwo_ww AS INTEGER), CAST(CURRENT_TIMESTAMP() AS DATETIME), P_USER_ID, CAST(COALESCE(wb.markdown_decision, 0) AS INTEGER));
INSERT INTO dbp_msi_view_nfmd.ts_nfmd_decision_approval_log (mandant_id, dwh_created_tmsp, kjwo_ww, user_id)
(SELECT CAST(P_MANDANT_ID AS INTEGER) AS mandant_id, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp, CAST(P_KJWO_WW AS INTEGER) AS kjwo_ww, P_USER_ID AS user_id);
COMMIT TRANSACTION;
SET out_param  =  'Entscheidung friegegeben';
SELECT out_param;
RETURN;
END;
