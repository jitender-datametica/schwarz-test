CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_F_ODS_BON_KOPF_2
-- Fakt-View z.B. für Kassierzeit
-- Gefiltert, d.h. nur nicht stornierte Bons enthalten
(
bon_id
,bon_dat
,wup_id
,nb_id
,mandant_id
--,kasse_nr
--,kunde_fg
--,umsatz_mwst
--,umsatz_brutto
,bon_booking
,dat_booking
--,turnover_fg
,wrg_id
)
AS
  SELECT
   bon_id,
   bon_dat,
   wup_id,
   0,
   v01.mandant_id,
   bon_booking,
   dat_booking,
   CASE 
   WHEN v01.wrg_id <> 'EUR' AND v02.default_wrg = 'EUR' THEN v02.default_wrg 
   ELSE wrg_id END

   FROM dbp_v_ods.v_ods_bon_kopf_2 v01
   
   --Croatia EUR conversion
   JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id

   WHERE (bon_id, wup_id, v01.mandant_id) NOT IN
   (
   SELECT bon_id,
   wup_id,
   mandant_id
  FROM dbp_v_ods.v_ods_bon_storno_2
  )
  AND v01.mandant_id > 1
  AND bon_dat = CURRENT_DATE;
