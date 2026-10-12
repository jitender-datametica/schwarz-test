CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_KONZESSIONAER_HIST
(
mandant_id
,konzessionaer_id
,dat_von
,dat_bis
,konzessionaer_branche_id
,konzessionaer_rechtsform
,konzessionaer_name
,konzessionaer_strasse
,konzessionaer_plz
,konzessionaer_ort
,dat_insolvenz_eintritt
,intern_fg
,land_id
,konzessionaer_topmieter_fg
,konzessionaer_holding_id
)
AS
   SELECT
   mandant_id,
   konzessionaer_id,
   dat_von,
   dat_bis,
   konzessionaer_branche_id,
   konzessionaer_rechtsform,
   dbp_process.transcriptc(konzessionaer_name) AS konzessionaer_name,
   dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse,
   konzessionaer_plz,
   dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort,
   dat_insolvenz_eintritt,
   intern_fg,
   land_id,
   konzessionaer_topmieter_fg,
   CAST(konzessionaer_holding_id AS VARCHAR(20)) AS konzessionaer_holding_id
   FROM dbp_view.v_ivs_konzessionaer_per

   WHERE (mandant_id, konzessionaer_id, dat_von) IN
   (
   SELECT
   mandant_id,
   konzessionaer_id,
   MAX(dat_von)
   FROM dbp_view.v_ivs_konzessionaer_per
   GROUP BY
   mandant_id
   ,konzessionaer_id
   )
;