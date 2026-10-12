create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_L_IMS_INVEST_PLAN(
	MANDANT_ID,
	HOCHRECHNUNG_FG,
	GJ,
	SPERR_FG,
	DATZEIT_UPLOAD
) as
-- 04.04.2013 twie: Kopftabelle Plandaten
-- 06.04.2016 twie: AP0001938 Umstelllung neue Planstruktur, u.a. von Projekt- auf PSP-Ebene

   SELECT

   v01.mandant_id,
   v01.hr_plan_gesamt_kz AS hochrechnung_fg,
   v01.gj,
   v01.sperr_fg,
   v01.datzeit_upload

   FROM dbp_view.v_ims_invest_plan v01;