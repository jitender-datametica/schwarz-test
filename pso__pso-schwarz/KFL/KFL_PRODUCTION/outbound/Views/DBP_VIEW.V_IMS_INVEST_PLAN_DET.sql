CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_invest_plan_det AS SELECT mandant_id,
 hr_plan_gesamt_kz,
 excel_zeile,
 gj,
 berichts_pos_invest_grp_id,
 in_massnahme_typ_id,
 plan_betrag,
 wrg_id,
 sparte_id,
 psp_id
FROM kfl_production_dbp_data.ims_invest_plan_det;