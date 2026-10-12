CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_FREIGABE_LETZTER_KJMO_1
--08.11.2018 twie: AP0034666 Anzeige letzter freigegebener KMR Monat_1 pro Land_1 im Cockpit

(
kjmo
,mandant_id
)
AS

   SELECT
   MAX(v01.kjmo) AS kjmo, v01.mandant_id

   FROM dbp_view.v_ts_kmr_freigabe_kjmo_1 v01

   WHERE freigabe_fg = 1

   GROUP BY mandant_id


   UNION ALL

   -- Im INT Cockpit wird der letzte freigegebene Monat_1 länderunabhängig angezeigt
   -- kann bedeuten es wird bspw. Mai angezeigt weil ein Land_1 den Mai schon freigegeben hat, aber die Daten von manchen Ländern sind erst bis April enthalten
   -- diese Vermischung lässt sich im INT Cockpit nicht erkennen, ist vom FB Revison aber explizit so gewünscht

   SELECT
   MAX(v01.kjmo) AS kjmo, 99 AS  mandant_id

   FROM dbp_view.v_ts_kmr_freigabe_kjmo_1 v01

   WHERE freigabe_fg = 1

   GROUP BY freigabe_fg
;