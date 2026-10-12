create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_TRANSPORTATION_UNIT_KOSTEN_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	TRANSPORTATION_UNIT_ID,
	KJ_TRANSPORTATION_UNIT,
	WRG_ID,
	BETRAG_DIESEL,
	BETRAG_STROM,
	BETRAG_GAS,
	BETRAG_MAUT,
	BETRAG_KUEHLUNG,
	BETRAG_SONSTIGES,
	TD_UPDATE,
	TD_INSERT
) as
--2026-03-25, dknop, initial
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        transportation_unit_id,
        kj_transportation_unit,
        wrg_id,
        betrag_diesel,
        betrag_strom,
        betrag_gas,
        betrag_maut,
        betrag_kuehlung,
        betrag_sonstiges,
        td_update,
        td_insert 
        
FROM dbp_view.v_transportation_unit_kosten_2;
