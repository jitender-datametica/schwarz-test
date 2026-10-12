create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TRANSPORTATION_UNIT_KOSTEN_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	WUP_ID COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum ( (hier: nur Speditionen))',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	TRANSPORTATION_UNIT_ID COMMENT 'Transporteinheit (intern)',
	KJ_TRANSPORTATION_UNIT COMMENT 'Anlagejahr der Transporteinheit',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_DIESEL COMMENT 'zusätzliche Kosten für Diesel',
	BETRAG_STROM COMMENT 'zusätzliche Kosten für Strom',
	BETRAG_GAS COMMENT 'zusätzliche Kosten für Gas',
	BETRAG_MAUT COMMENT 'zusätzliche Kosten für Maut',
	BETRAG_KUEHLUNG COMMENT 'zusätzliche Kosten für Kühlung',
	BETRAG_SONSTIGES COMMENT 'zusätzliche Kosten weitere',
	TD_UPDATE,
	TD_INSERT
) as 
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

FROM DBP_DATA.TRANSPORTATION_UNIT_KOSTEN_2 ;
