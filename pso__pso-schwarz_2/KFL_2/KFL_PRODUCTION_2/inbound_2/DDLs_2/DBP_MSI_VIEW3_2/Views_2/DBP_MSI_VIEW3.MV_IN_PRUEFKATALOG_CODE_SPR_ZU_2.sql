CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_PRUEFKATALOG_CODE_SPR_ZU_2

(
mandant_id
,katalogart_id
,codegruppe_id
,pruefcode_id
,version_id
,spr_id
,qtxt_code
)
AS
-- 10.02.2016, srom0404, AP0004702 Dummy_2 Pruefcode/Text
-- 20230717 staeblern Umstellung auf Session Variable
   SELECT v011.mandant_id, v011.katalogart_id, v011.codegruppe_id, v011.pruefcode_id, v011.version_id, v011.spr_id, v011.qtxt_code
   FROM
   (-- v011
   SELECT v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.pruefcode_id, v01.version_id, v01.spr_id, v01.qtxt_code

   FROM (--v01
   SELECT
   v01_1.mandant_id, v01_1.katalogart_id, CASE WHEN v01_1.codegruppe_id = 'KLOAUTM' THEN SUBSTR(v01_1.codegruppe_id,1,3) ELSE v01_1.codegruppe_id END AS codegruppe_id, v01_1.pruefcode_id, v01_1.version_id, v01_1.spr_id, v01_1.qtxt_code
   FROM dbp_view.v_in_pruefkatalog_code_spr_zu_2 v01_1
   ) v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02
   ON v01.spr_id = v02.spr_id

   GROUP BY v01.mandant_id
   ,v01.katalogart_id
   ,v01.codegruppe_id
   ,v01.pruefcode_id
   ,v01.version_id
   ,v01.spr_id
   ,v01.qtxt_code
   ) v011

   UNION

   SELECT
   v03.mandant_id, '0' AS katalogart_id, '-1' AS codegruppe_id, '-1' AS pruefcode_id, '-1' AS version_id, v03.spr_id, 'DWH - no reason' AS qtxt_code
   FROM dbp_view.v_mandant_spr_zu_2 v03;