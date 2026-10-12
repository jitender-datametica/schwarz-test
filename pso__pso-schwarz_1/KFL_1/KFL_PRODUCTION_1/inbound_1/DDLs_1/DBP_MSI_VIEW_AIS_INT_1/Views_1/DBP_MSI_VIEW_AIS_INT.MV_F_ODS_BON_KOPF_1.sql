CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_F_ODS_BON_KOPF_1(
	BON_ID,
	BON_DAT,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	BON_BOOKING,
	DAT_BOOKING,
	WRG_ID
) AS
  -- SPEC0244443, prescherad, 18.04.2024, Neuanlage 
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

 FROM dbp_v_ods.v_ods_bon_kopf_1 v01
   
 --Croatia EUR conversion
 JOIN dbp_view.v_mandant_1 v02
 ON v01.mandant_id = v02.mandant_id

 WHERE (bon_id, wup_id, v01.mandant_id) NOT IN
  (
   SELECT bon_id,
   wup_id,
   mandant_id
  FROM dbp_v_ods.v_ods_bon_storno_1
  )
 AND v01.mandant_id > 1
 AND bon_dat = CURRENT_DATE;