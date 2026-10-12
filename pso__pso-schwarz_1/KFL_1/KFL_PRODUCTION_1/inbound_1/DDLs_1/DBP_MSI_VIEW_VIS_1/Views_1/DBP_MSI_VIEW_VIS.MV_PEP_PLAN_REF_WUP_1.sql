CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_PLAN_REF_WUP_1
(
mandant_id
,wup_id
,ref_wup_id
,ref_wup_id_man
,ref_wup_standort
)
AS
   SELECT DISTINCT
   v01.mandant_id, v01.wup_id, v02.ref_wup_id, v03.ref_wup_id, COALESCE (v04.wup_standort,NULL)

   FROM dbp_view.v_wup_1 v01
   LEFT OUTER JOIN dbp_dialog.d_pep_plan_ref_wup_1 v02
   ON       v01.mandant_id = v02.mandant_id
   AND     v01.wup_id = v02.wup_id
   LEFT OUTER JOIN dbp_msi_v_view.v_pep_plan_ref_wup_1  v03
   ON       v01.mandant_id = v03.mandant_id
   AND     v02.ref_wup_id = v03.wup_id
   LEFT OUTER JOIN dbp_view.v_wup_1 v04
   ON       v01.mandant_id = v04.mandant_id
   AND     v02.ref_wup_id = v04.wup_id
   ;