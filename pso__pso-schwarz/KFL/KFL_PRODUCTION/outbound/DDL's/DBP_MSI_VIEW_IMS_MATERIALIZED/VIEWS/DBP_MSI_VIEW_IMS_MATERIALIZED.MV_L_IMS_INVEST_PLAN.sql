-- 04.04.2013 twie: Kopftabelle Plandaten

-- 06.04.2016 twie: AP0001938 Umstelllung neue Planstruktur, u.a. von Projekt- auf PSP-Ebene

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_l_ims_invest_plan (mandant_id, hochrechnung_fg,
gj, sperr_fg, datzeit_upload) AS SELECT mandant_id,
 hr_plan_gesamt_kz AS hochrechnung_fg,
 gj,
 sperr_fg,
 datzeit_upload
FROM kfl_production_dbp_view.v_ims_invest_plan AS V01;