CREATE OR REPLACE PROCEDURE dbp_msi_view2.sp_ins_ek_dashboard_kommentar(IN P_EK_DASHBOARD_ID BIGNUMERIC, IN P_KOMMENTAR_TXT STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
INSERT INTO dbp_msi_view2.ts_ek_dashboard_kommentar_2 (ek_dashboard_id, kommentar_txt, td_insert)
(SELECT CAST(P_EK_DASHBOARD_ID AS INTEGER) AS ek_dashboard_id, P_KOMMENTAR_TXT AS kommentar_txt, CURRENT_TIMESTAMP() AS td_insert);
COMMIT TRANSACTION;
SET out_param  =  'Kommentar gespeichert';
SELECT out_param;
RETURN;
END;