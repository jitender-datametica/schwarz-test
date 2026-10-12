--'_dmP_BEZUGSWEG_ID'_dm FLOAT, 



--'_dmP_GP_ID'_dm FLOAT, 



--'_dmP_LIEFERUNG_TAG_OFFSET'_dm FLOAT, 



CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_artikel_vz(IN P_MANDANT_ID FLOAT64, IN P_KJWO FLOAT64, IN P_ANGEBOT_ID FLOAT64, IN P_AKTION_ID STRING, IN P_AUSLIEFERGRUPPE_ID STRING, IN P_ART_ID FLOAT64, IN P_WUP_ID_VZ FLOAT64, IN P_NB_ID_VZ FLOAT64, IN P_MANDANT_ID_VZ FLOAT64, IN P_CLEAR_STOCK_FG STRING, IN P_ESTIMATION_FG FLOAT64, IN P_MAX_KAPA_FG FLOAT64, IN P_ADJUSTMENT_FG FLOAT64, IN P_DAT_LETZTE_NACHVERSORGUNG STRING, IN P_CHECK_CLEAR_STOCK STRING, OUT out_param STRING)
BEGIN
DECLARE dummy_2 FLOAT64;
BEGIN
BEGIN TRANSACTION;
DELETE FROM dbp_data.ts_wbs_artikel_vz_2
WHERE mandant_id = P_MANDANT_ID AND kjwo = P_KJWO AND angebot_id = P_ANGEBOT_ID AND aktion_id = P_AKTION_ID AND ausliefergruppe_id = P_AUSLIEFERGRUPPE_ID AND art_id = P_ART_ID AND wup_id_vz = P_WUP_ID_VZ AND nb_id_vz = P_NB_ID_VZ AND mandant_id_vz = P_MANDANT_ID_VZ;
-- wenn Clearstock nicht geandert wurde dann wird die Bezeichnung uebergeben 
-- In Check clear stock steht die ID vom aktuellen Clear Stock 
INSERT INTO dbp_data.ts_wbs_artikel_vz_2 (mandant_id, kjwo, angebot_id, aktion_id, ausliefergruppe_id, art_id, wup_id_vz, nb_id_vz, mandant_id_vz, bezugsweg_id, gp_id, clear_stock_id, lieferung_tag_offset, estimation_fg, adjustment_id, max_kapa_fg, dat_letzte_nachversorgung)
(SELECT CAST(P_MANDANT_ID AS INTEGER), CAST(P_KJWO AS INTEGER), CAST(P_ANGEBOT_ID AS INTEGER), P_AKTION_ID, P_AUSLIEFERGRUPPE_ID, CAST(P_ART_ID AS INTEGER), CAST(P_WUP_ID_VZ AS INTEGER), CAST(P_NB_ID_VZ AS INTEGER), CAST(P_MANDANT_ID_VZ AS INTEGER), -9, -9, CAST(P_CLEAR_STOCK_FG AS INT64), CAST(NULL AS INTEGER), CAST(P_ESTIMATION_FG AS INTEGER), CAST(P_ADJUSTMENT_FG AS INTEGER), CAST(P_MAX_KAPA_FG AS INTEGER), CAST(P_DAT_LETZTE_NACHVERSORGUNG AS DATE));
COMMIT TRANSACTION;
SET out_param  =  'Artikel_2 gespeichert';
SELECT out_param;
RETURN;
END;
END;

