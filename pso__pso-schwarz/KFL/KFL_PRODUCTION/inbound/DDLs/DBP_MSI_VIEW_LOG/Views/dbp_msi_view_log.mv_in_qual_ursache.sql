CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_QUAL_URSACHE(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	QUAL_MELDUNG_POS_ID,
	QUAL_MELDUNG_URSACHE_ID,
	KATALOGART_ID,
	CODEGRUPPE_ID,
	PRUEFCODE_ID,
	VERSION_ID)
    AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial based on LIS
--2023-07-11, removing duplicates when there more qual_meldung_pos_id
SELECT
 in_q_u.mandant_id
,in_q_u.qual_meldung_id
,in_q_u.qual_meldung_pos_id
,in_q_u.qual_meldung_ursache_id
,in_q_u.katalogart_id
,CASE WHEN in_q_u.codegruppe_id = 'KLOAUTM' THEN SUBSTR(in_q_u.codegruppe_id,1,3) ELSE in_q_u.codegruppe_id END AS codegruppe_id
,in_q_u.pruefcode_id
,in_q_u.version_id
FROM dbp_view.v_in_qual_ursache in_q_u
JOIN (SELECT 
       mandant_id
      ,qual_meldung_id
      ,MIN(qual_meldung_pos_id) AS qual_meldung_pos_id 
       FROM dbp_view.v_in_qual_ursache 
      GROUP BY mandant_id,qual_meldung_id) qm_pos
ON 
in_q_u.qual_meldung_pos_id=qm_pos.qual_meldung_pos_id
AND in_q_u.qual_meldung_id=qm_pos.qual_meldung_id
AND in_q_u.mandant_id=qm_pos.mandant_id

   
   UNION

SELECT
 v02.mandant_id
,v03.qual_meldung_id AS qual_meldung_id
,-1 AS qual_meldung_pos_id
,-1 AS qual_meldung_ursache_id
,'0' AS katalogart_id, '-1' AS codegruppe_id
,'-1' AS pruefcode_id, '-1' AS version_id

FROM dbp_view.v_mandant v02
INNER JOIN (SELECT
 mandant_id
,qual_meldung_id
FROM dbp_view.v_in_qual_instand v03
   WHERE (mandant_id,qual_meldung_id) NOT IN (SELECT mandant_id, qual_meldung_id FROM dbp_view.v_in_qual_ursache GROUP BY 1,2)
   ) v03
   ON v02.mandant_id = v03.mandant_id
   ;