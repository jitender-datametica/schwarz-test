CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_AUFTRAG_PPS_2(
	AUFTRAG_ID,
	MANDANT_ID,
	DAT_START,
	AUFTRAG_RM_ID,
	AUFTRAG_RM_POS_ID,
	DAT_PLANAUFLOESUNG
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial, copy from LIS
   SELECT
   v01.auftrag_id
  ,v01.mandant_id
  ,v01.dat_start
  ,v01.auftrag_rm_id
  ,v01.auftrag_rm_pos_id
  ,v01.dat_planaufloesung
   FROM dbp_view.v_in_auftrag_pps_2 v01
;