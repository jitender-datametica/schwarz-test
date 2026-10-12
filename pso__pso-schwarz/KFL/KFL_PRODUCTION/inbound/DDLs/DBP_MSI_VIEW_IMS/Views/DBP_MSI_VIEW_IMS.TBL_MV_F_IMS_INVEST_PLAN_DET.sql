CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.TBL_MV_F_IMS_INVEST_PLAN_DET
as 
SELECT

   v01.mandant_id,
   v01.gj,
   v01.hr_plan_gesamt_kz AS hochrechnung_fg,
   v01.berichts_pos_invest_grp_id,
   v01.psp_id,
   v01.plan_betrag,
   v01.wrg_id,
   CASE WHEN v01.sparte_id IN (4,6,8) THEN 5 ELSE v01.sparte_id END AS sparte_id
   FROM dbp_view.v_ims_invest_plan_det v01
;