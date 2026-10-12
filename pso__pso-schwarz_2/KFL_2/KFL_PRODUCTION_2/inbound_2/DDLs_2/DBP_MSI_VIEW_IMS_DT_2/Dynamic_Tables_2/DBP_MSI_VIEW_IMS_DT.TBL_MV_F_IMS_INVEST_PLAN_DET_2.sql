CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.TBL_MV_F_IMS_INVEST_PLAN_DET_2
(
	MANDANT_ID,
	GJ,
	HOCHRECHNUNG_FG,
	BERICHTS_POS_INVEST_GRP_ID,
	PSP_ID,
	PLAN_BETRAG,
	WRG_ID,
	SPARTE_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
 
SELECT

   v01.mandant_id,
   v01.gj,
   v01.hr_plan_gesamt_kz AS hochrechnung_fg,
   v01.berichts_pos_invest_grp_id,
   v01.psp_id,
   v01.plan_betrag,
   v01.wrg_id,
   CASE WHEN v01.sparte_id IN (4,6,8) THEN 5 ELSE v01.sparte_id END AS sparte_id
   FROM dbp_view.v_ims_invest_plan_det_2 v01
;