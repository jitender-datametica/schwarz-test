create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_WG_PER(
	WG_ID,
	ARTHIERTYP_ID,
	LEAD_MWST_ID,
	DAT_VON,
	ABT_ID,
	MANDANT_ID,
	DAT_BIS,
	OWG_ID
) as
--22.06.2022 twie: SPEC0145413 Lookup Warengruppe

SELECT

    wg_id
   ,arthiertyp_id
   ,lead_mwst_id
   ,dat_von
   ,abt_id
   ,mandant_id
   ,dat_bis
   ,owg_id

FROM dbp_view.v_wg_per

WHERE arthiertyp_id = 2
AND dat_bis > CURRENT_DATE;