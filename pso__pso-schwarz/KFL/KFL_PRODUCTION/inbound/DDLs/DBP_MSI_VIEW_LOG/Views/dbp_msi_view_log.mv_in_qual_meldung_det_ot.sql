CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_QUAL_MELDUNG_DET_OT(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	QUAL_MELDUNG_POS_ID,
	KATALOGART_ID_OT,
	CODEGRUPPE_ID_OT,
	PRUEFCODE_ID_OT
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial
 SELECT 
 in_q_m_det.mandant_id
,in_q_m_det.qual_meldung_id
,in_q_m_det.qual_meldung_pos_id
,COALESCE(in_q_m_det.katalogart_id_ot,'0')
,COALESCE(in_q_m_det.codegruppe_id_ot,'-1')
,COALESCE(in_q_m_det.pruefcode_id_ot,'-1')


FROM dbp_view.v_in_qual_meldung_det in_q_m_det
JOIN (SELECT 
       mandant_id
      ,qual_meldung_id
      ,MIN(qual_meldung_pos_id) AS qual_meldung_pos_id 
     FROM dbp_view.v_in_qual_meldung_det
       GROUP BY mandant_id,qual_meldung_id) qm_pos
ON 
in_q_m_det.qual_meldung_pos_id=qm_pos.qual_meldung_pos_id
AND in_q_m_det.qual_meldung_id=qm_pos.qual_meldung_id
AND in_q_m_det.mandant_id=qm_pos.mandant_id
WHERE in_q_m_det.problemcode_id <> 0 --and  in_q_m_det.qual_meldung_id=304792541 ;
;