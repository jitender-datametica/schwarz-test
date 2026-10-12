create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW.MV_ERSTELLER_RPW_GRUPPE_ZU_PER_1(
	MANDANT_ID,
	RPW_ERSTELLER_ID,
	GRUPPE_ID,
	ABTEILUNG_ID,
	DAT_VON,
	DAT_BIS,
	SYSTEM_ID
) as
    SELECT
    mandant_id,
    ersteller_id,
    gruppe_id,
    abteilung_id,
    dat_von,
    dat_bis,
    7
    FROM dbp_view.v_ersteller_rpw_gruppe_zu_per_1
    WHERE mandant_id = 1
    GROUP BY  mandant_id, ersteller_id, gruppe_id, abteilung_id, dat_von, dat_bis
    QUALIFY SUM(mandant_id) OVER (PARTITION BY mandant_id, ersteller_id  ORDER BY ersteller_id,dat_bis DESC NULLS LAST ROWS UNBOUNDED PRECEDING) = 1;
