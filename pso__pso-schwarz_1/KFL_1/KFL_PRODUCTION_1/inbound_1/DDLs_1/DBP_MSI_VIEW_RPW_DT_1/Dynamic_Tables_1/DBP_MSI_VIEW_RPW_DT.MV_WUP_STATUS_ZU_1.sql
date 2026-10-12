create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WUP_STATUS_ZU_1(
	OPEN_FG,
	OPEN_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                            SELECT
                               open_fg,
                            CASE
                                 WHEN open_fg=1 THEN 'Offen'
                                 WHEN open_fg=2 THEN 'Geloescht'
                                 WHEN open_fg=3 THEN 'Geplant'
                                 ELSE NULL
                               END AS open_bez
                            FROM dbp_msi_view_rpw.mv_wup_1
                            WHERE nb_id=0
                              AND open_fg <>0

                            GROUP BY 1
 ;
