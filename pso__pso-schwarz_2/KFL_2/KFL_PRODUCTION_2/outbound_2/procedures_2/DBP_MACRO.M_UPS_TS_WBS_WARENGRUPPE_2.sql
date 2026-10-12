-- P_AUSLIEFERUNGSGRUPPE_ID STRING(10) ,



-- P_WG_CLUSTER_ID NUMBER



CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_wbs_warengruppe(IN P_MANDANT_ID INT64, IN P_WG_ID INT64, IN P_KJWO INT64, IN P_ESTIMATION_FG INT64, IN P_ADJUSTMENT_FG INT64, IN P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG INT64, IN P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG INT64, IN P_BONUSKAUF_PROMOTIONSTYP STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
-- Wenn Eintrag vorhanden loeschen 
--  AND AUSLIEFERUNGSGRUPPE_ID = :P_AUSLIEFERUNGSGRUPPE_ID
DELETE FROM dbp_msi_data.ts_wbs_warengruppe_2
WHERE mandant_id = P_MANDANT_ID AND wg_id = P_WG_ID AND kjwo = P_KJWO;
-- Eintrag einfügen 
/*AUSLIEFERUNGSGRUPPE_ID,*/
/*WG_CLUSTER_ID,*/
/*:P_AUSLIEFERUNGSGRUPPE_ID,*/
/*:P_WG_CLUSTER_ID,*/
INSERT INTO dbp_msi_data.ts_wbs_warengruppe_2 (mandant_id, kjwo, wg_id, estimation_fg, adjustment_id, auto_bestellmenge_mit_bestand_phase_switch_i_fg, auto_bestellmenge_mit_bestand_phase_switch_iii_fg, bonuskauf_promotionstyp, td_update, td_insert)
(SELECT P_MANDANT_ID  AS mandant_id, P_KJWO  AS kjwo, P_WG_ID  AS wg_id, P_ESTIMATION_FG  AS estimation_fg, P_ADJUSTMENT_FG  AS adjustment_id, P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG  AS auto_bestellmenge_mit_bestand_phase_switch_i_fg, P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG  AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg, CASE WHEN P_BONUSKAUF_PROMOTIONSTYP = 'Standard' THEN '-1' ELSE P_BONUSKAUF_PROMOTIONSTYP END AS bonuskauf_promotionstyp, CURRENT_TIMESTAMP() AS td_update, CURRENT_TIMESTAMP() AS td_insert);
COMMIT TRANSACTION;
SET out_param  =  'Warengruppe gespeichert';
SELECT out_param;
RETURN;
END;


