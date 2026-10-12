CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_mamo_wup_massnahme_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat_massnahme_von,
 dat_massnahme_bis,
 modernisierung_art,
 gj,
 immo_fg,
 hinweis_massnahme,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ims_mamo_wup_massnahme_per;