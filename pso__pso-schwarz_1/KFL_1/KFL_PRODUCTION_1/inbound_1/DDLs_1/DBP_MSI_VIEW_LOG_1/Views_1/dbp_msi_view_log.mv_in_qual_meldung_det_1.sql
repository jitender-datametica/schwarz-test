CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_QUAL_MELDUNG_DET_1(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	QUAL_MELDUNG_POS_ID,
	PROBLEMCODE_ID,
	KATALOGART_ID_PC,
	CODEGRUPPE_ID_PC,
	KATALOGART_ID_OT,
	CODEGRUPPE_ID_OT,
	PRUEFCODE_ID_OT
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial
    SELECT 
 mandant_id
,qual_meldung_id
,qual_meldung_pos_id
,problemcode_id
,COALESCE(katalogart_id_pc,'0')
,COALESCE(codegruppe_id_pc,'-1')
,COALESCE(katalogart_id_ot,'0')
,COALESCE(codegruppe_id_ot,'-1')
,COALESCE(pruefcode_id_ot,'-1')

FROM dbp_view.v_in_qual_meldung_det_1
;