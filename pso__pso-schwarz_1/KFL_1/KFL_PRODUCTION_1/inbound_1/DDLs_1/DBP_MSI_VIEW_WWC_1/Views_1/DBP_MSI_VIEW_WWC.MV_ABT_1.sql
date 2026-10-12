CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ABT_1
(
arthiertyp_id
,abt_id
,mandant_id
,sort_id
)
AS
   SELECT v01.arthiertyp_id, v01.abt_id, v01.mandant_id, CASE WHEN v01.abt_id <=0  THEN v01.abt_id + 1000
   ELSE v01.abt_id
   END::SMALLINT AS sort_id

   FROM dbp_view.v_abt_1 v01
   WHERE v01.arthiertyp_id = 2
   GROUP BY arthiertyp_id
   ,abt_id
   ,mandant_id
   ,sort_id
;