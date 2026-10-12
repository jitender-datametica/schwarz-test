CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_PRUEFMERKMAL_ERG_MIBI_1
--24.08.2012 twie: enthaelt die Informationen mv_l_flw_pruefmerkmal_ergebnis_1, aber anders aufbereitet
--Waehrend mv_l_flw_pruefmerkmal_ergebnis_1 pro Prueflos mehrere Zeilen hat und z.B. GKZ und Entero Merkmal in der gleichen Spalte stehen mit unterschiedlicher lfd_nr
--gibt es hier pro Prueflos nur eine_1 Zeile, und GKZ und Entero Merkmale stehen in unterschiedlichen Spalten, da es jeweils ein eigenes Attribut dafuer gibt.
(
prueflos_id
, mandant_id
, satzstatus_id
, gkz_fehlerklasse_id
, entero_fehlerklasse_id
, gkz_katalogart_id
, entero_katalogart_id
, gkz_codegruppe_id
, entero_codegruppe_id
, gkz_pruefcode_id
, entero_pruefcode_id
,we_dat
, mibi_erfass_dat
, gkz_original_input
, entero_original_input
)
AS

   SELECT

   v01.prueflos_id, v01.mandant_id, v01.satzstatus_id, v01.gkz_fehlerklasse_id, v01.entero_fehlerklasse_id, v01.gkz_katalogart_id, v01.entero_katalogart_id, v01.gkz_codegruppe_id, v01.entero_codegruppe_id, v01.gkz_pruefcode_id, v01.entero_pruefcode_id, v01.we_dat, v01.mibi_erfass_dat, v01.gkz_original_input, v01.entero_original_input

   FROM
   (
   SELECT
   prueflos_id, mandant_id, MAX(satzstatus_id) AS satzstatus_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10 THEN fehlerklasse_id END) AS gkz_fehlerklasse_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40 THEN fehlerklasse_id END) AS entero_fehlerklasse_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10 THEN katalogart_id END) AS gkz_katalogart_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40 THEN katalogart_id END) AS entero_katalogart_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10 THEN codegruppe_id END) AS gkz_codegruppe_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40 THEN codegruppe_id END) AS entero_codegruppe_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10 THEN pruefcode_id END) AS gkz_pruefcode_id, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40 THEN pruefcode_id END) AS entero_pruefcode_id, MAX(CASE WHEN knoten_lfd_nr = 1 THEN dat_pruef_von END) AS we_dat, MAX(CASE WHEN knoten_lfd_nr = 2 THEN dat_pruef_von END) AS mibi_erfass_dat, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 20 and original_input <> '0' THEN original_input END) AS input20, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 30 and original_input <> '0' THEN original_input END) AS input30, COALESCE (input20, input30) AS gkz_original_input, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 50 and original_input <> '0' THEN original_input END) AS input50, MAX(CASE WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 60 and original_input <> '0' THEN original_input END) AS input60, COALESCE (input50, input60) AS entero_original_input
   FROM dbp_view.v_flw_pruefmerkmal_ergebnis_1
   --WHERE prueflos_id = 10001386199 --zum testen
   GROUP BY 1,2
   ) v01;