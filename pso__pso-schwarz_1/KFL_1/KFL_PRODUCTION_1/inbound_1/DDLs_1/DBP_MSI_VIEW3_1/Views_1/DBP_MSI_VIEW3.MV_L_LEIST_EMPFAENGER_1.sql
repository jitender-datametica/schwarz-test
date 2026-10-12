CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LEIST_EMPFAENGER_1
-- 05.10.2016, AP0003754, srom0404, Erweiterung sap_id, gruppe_id
(
mandant_id
,leist_empfaenger_sap_id
,leist_empfaenger_gruppe_id
,wup_id
,nb_id
,ext_ma_fg
)
AS
   SELECT
   mandant_id, leist_empfaenger_sap_id, leist_empfaenger_gruppe_id, wup_id, nb_id, ext_ma_fg
   FROM dbp_view.v_l_leist_empfaenger_1

   UNION

   -- pro VZ / leist_empfaenger_gruppe_id wird ein 'Eigen' Satz angefügt
   -- In der View mv_transport_leistung_sum_1 wird 'leist_empfaenger_sap_id' zu 'Eigen' wenn das Flag für Einzelauswertung nicht gesetzt ist
   -- Durch den hier erzeugten Satz gehen beim JOIN auf mv_transport_leistung_sum_1 keine Sätze verloren und werden in einem Satz zusammengefasst
   SELECT mandant_id, 'Eigen' AS leist_empfaenger_sap_id, leist_empfaenger_gruppe_id, wup_id, nb_id, MAX(0) AS ext_ma_fg
   FROM dbp_view.v_l_leist_empfaenger_1
   GROUP BY mandant_id
   ,wup_id
   ,nb_id
   ,leist_empfaenger_gruppe_id
;