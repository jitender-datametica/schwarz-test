create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WEWA_GRP_1(
	WEWA_GRUPPE_ID,
	VORGANGSART_ID,
	OPEN_FG,
	GEMELDET_FG,
	TEILGEBUCHT_FG,
	WEWA_GRP_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       v.wewa_gruppe_id,
       v.vorgangsart_id,
       v.open_fg,
       v.gemeldet_fg,
       v.teilgebucht_fg,
       s.wewa_gruppe_bez AS wewa_grp_bez
       FROM dbp_view.v_vorgangsart_wewa_gruppe_zu_1 v
       INNER JOIN dbp_view.v_wewa_gruppe_spr_zu_1 s
       ON v.mandant_id = s.mandant_id AND
       v.wewa_gruppe_id = s.wewa_gruppe_id AND
       s.spr_id = 22

       WHERE v.mandant_id = 1;
