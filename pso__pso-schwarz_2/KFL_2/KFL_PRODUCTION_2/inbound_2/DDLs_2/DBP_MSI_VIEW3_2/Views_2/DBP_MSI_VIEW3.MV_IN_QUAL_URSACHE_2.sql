CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_QUAL_URSACHE_2
-- 10.02.2016, srom0404, AP0004702 Dummy_2 Pruefcode/Text
(
mandant_id
,qual_meldung_id
,qual_meldung_pos_id
,qual_meldung_ursache_id
,katalogart_id
,codegruppe_id
,pruefcode_id
,version_id
)
AS
   SELECT
   v01.mandant_id, v01.qual_meldung_id, v01.qual_meldung_pos_id, v01.qual_meldung_ursache_id, v01.katalogart_id, CASE WHEN v01.codegruppe_id = 'KLOAUTM' THEN SUBSTR(v01.codegruppe_id,1,3) ELSE v01.codegruppe_id END AS codegruppe_id, v01.pruefcode_id, v01.version_id
   FROM dbp_view.v_in_qual_ursache_2 v01

   UNION

   SELECT
   v02.mandant_id, v03.qual_meldung_id AS qual_meldung_id, -1 AS qual_meldung_pos_id, -1 AS qual_meldung_ursache_id, '0' AS katalogart_id, '-1' AS codegruppe_id, '-1' AS pruefcode_id, '-1' AS version_id
   FROM dbp_view.v_mandant_2 v02
   INNER JOIN (SELECT mandant_id, qual_meldung_id
   FROM dbp_view.v_in_qual_instand_2 v03
   WHERE (mandant_id,qual_meldung_id) NOT IN (SELECT mandant_id, qual_meldung_id FROM dbp_view.v_in_qual_ursache_2 GROUP BY 1,2)
   ) v03
   ON v02.mandant_id = v03.mandant_id;