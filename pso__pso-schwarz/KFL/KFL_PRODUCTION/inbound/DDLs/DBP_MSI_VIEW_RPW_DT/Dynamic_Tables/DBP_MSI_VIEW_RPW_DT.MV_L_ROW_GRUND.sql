create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_ROW_GRUND(
	MANDANT_ID,
	ROW_GRUND_ID,
	WBNK_PLANUNGS_KZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          mandant_id,
          row_grund_id,
          CASE WHEN row_grund_id IN ('117','124','125','126','129','133','135') THEN 'statistisch geplant'
          WHEN row_grund_id IN ('113','127','128','131','136','143','162') THEN 'ungeplant'
          WHEN row_grund_id IN ('146','150','152','154','163','165','174') THEN 'sonstige Erlöse'
          WHEN row_grund_id IN ('118','130','137','141','144','145','147','151','153','164','172','173','175') THEN 'Sachkosten'
          ELSE 'keine BNK'
          END AS wbnk_planungs_kz,
          7
          FROM dbp_view.v_l_row_grund
          WHERE mandant_id = 1

          UNION ALL

          SELECT
          1 AS mandant_id,
          '0' AS row_grund_id,
          ' '   AS wbnk_planungs_kz,
          7 AS system_id


          FROM dbp_view.v_l_row_grund
          WHERE mandant_id = 1

          GROUP BY 1, 2, 3, 4
 ;
