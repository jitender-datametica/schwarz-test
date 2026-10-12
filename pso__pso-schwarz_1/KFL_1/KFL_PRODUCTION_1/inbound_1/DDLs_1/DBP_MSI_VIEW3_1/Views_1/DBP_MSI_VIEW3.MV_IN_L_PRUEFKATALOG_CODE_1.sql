CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_L_PRUEFKATALOG_CODE_1
(
mandant_id
,katalogart_id
,codegruppe_id
,pruefcode_id
,version_id
)
AS
   SELECT v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.pruefcode_id, v01.version_id

   FROM
   (
   SELECT
   v01_1.mandant_id, v01_1.katalogart_id, CASE WHEN v01_1.codegruppe_id = 'KLOAUTM' THEN SUBSTR(v01_1.codegruppe_id,1,3) ELSE v01_1.codegruppe_id END AS codegruppe_id, v01_1.pruefcode_id, v01_1.version_id
   FROM dbp_view.v_in_l_pruefkatalog_code_1 v01_1
   ) v01

   GROUP BY v01.mandant_id
   ,v01.katalogart_id
   ,v01.codegruppe_id
   ,v01.pruefcode_id
   ,v01.version_id
;