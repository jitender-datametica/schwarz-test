create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_AUFTRAG_RM(
	MANDANT_ID,
	AUFTRAG_ID,
	CO_LEISTUNGSART_ID,
	STORNO_FG,
	STORNO_ZAEHLER,
	DAT_BUCH
) as
   SELECT distinct
   mandant_id, auftrag_id, co_leistungsart_id, storno_fg, storno_zaehler, dat_buch

   FROM dbp_view.v_in_auftrag_rm;