CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_wup_denorm_per AS SELECT mandant_id,
 wup_id,
 dat_von_bis,
 gf_gbl_vertrieb_id,
 vkl_id,
 hausleiter_id,
 frische_manager_id,
 glv_land_id,
 gl_vertrieb_id,
 hausleiter_sperr_fg,
 vkl_sperr_fg,
 gf_gbl_vertrieb_sperr_fg
FROM kfl_production_dbp_msi_data.wup_denorm_per;