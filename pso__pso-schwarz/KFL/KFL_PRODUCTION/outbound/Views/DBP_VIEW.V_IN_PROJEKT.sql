CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_projekt AS SELECT mandant_id,
 in_projekt_id,
 in_projekt_id_char,
 in_projekt_bez,
 pc_id,
 krk_id,
 projekt_ext_id,
 in_budget_typ_id,
 rpm_projekt_typ_id,
 in_massnahme_typ_id,
 standort_id,
 dat_massnahme_ende,
 ims_projekt_typ_id
FROM kfl_production_dbp_data.in_projekt;