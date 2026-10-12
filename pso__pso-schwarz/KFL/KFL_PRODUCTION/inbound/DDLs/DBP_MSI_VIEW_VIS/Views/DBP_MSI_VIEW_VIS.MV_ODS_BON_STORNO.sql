CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_STORNO
--20200528, snik1809 - AP0041812, SPEC0056256
AS
SELECT
  bon_id
, bon_dat
, mandant_id  
, wup_id
, bon_nr
, kasse_nr
, datei_name
, 1 as is_in_storno
FROM dbp_v_ods.v_ods_bon_storno;