create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_RECH_POS_WBNK_BRDK_2(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_BELEG_ID,
	GJ,
	WBNK_PLANUNGS_KZ,
	ROW_GRUND_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 01.12.2017 twie: NSR0041699 row_grund_id ist char

          SELECT
          7,
          br.mandant_id,
          br.rech_beleg_id,
          br.gj,
          CASE WHEN row_grund_id IN ('117','124','125','126','129','133','135') THEN 'statistisch geplant'
          WHEN row_grund_id IN ('113','127','128','131','136','143','162') THEN 'ungeplant'
          WHEN row_grund_id IN ('146','150','152','154','163','165','174') THEN 'sonstige Erlöse'
          WHEN row_grund_id IN ('118','130','137','141','144','145','147','151','153','164','172','173','175') THEN 'Sachkosten'
          ELSE 'keine BNK'
          END AS wbnk_planungs_kz,
          COALESCE(brdk.row_grund_id,'0') AS row_grund_id

          FROM dbp_view.v_besch_rech_2  br
          LEFT OUTER JOIN dbp_view.v_besch_rech_det_kont_2 brdk
          ON br.mandant_id = brdk.mandant_id
          AND br.rech_beleg_id = brdk.rech_beleg_id
          AND br.gj = brdk.gj


          WHERE br.mandant_id = 1
          GROUP BY 1,2,3,4,6,5;
