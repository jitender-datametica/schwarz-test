create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_KUNDE_2(
	MANDANT_ID,
	IN_KUNDE_ID,
	KUNDE_NR,
	KUNDE_NAME,
	SYSTEM_ID
) as
   SELECT
   mandant_id, in_kunde_id, kunde_nr, kunde_name, system_id
   FROM dbp_view.v_in_kunde_2;