create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_IN_AUFTRAG_RM_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
	AUFTRAG_RM_ID COMMENT 'ID der Rückmeldung aus rueck',
	AUFTRAG_RM_POS_ID COMMENT 'Positionsid der Rückmeldung aus rmzhl',
	AUFTRAG_ID COMMENT 'Auftragsnummer aus aufnr',
	CO_LEISTUNGSART_ID COMMENT 'ID der CO-Leistungsart der Rückmeldung aus dem Quellfeld learr. Referenztabelle ist in_l_leistungsart_2',
	STORNO_FG COMMENT 'Flag = 1 für stornierten Beleg aus dem Quellfeld stokz',
	STORNO_ZAEHLER COMMENT 'Rückmeldezähler der stornierten Rückmeldung aus dem Quellfeld stzhl',
	DAT_BUCH COMMENT 'Buchungsdatum',
	TEIL_END_RM COMMENT 'Teil-/Endrückmeldung (X = Endrückmeldung, 1 = Automatische Endrückmeldung, leer = Teilrückmeldung)',
	MENGE_ARBEIT_IST COMMENT 'Istarbeit - actual work done for this order',
	MENGE_ARBEIT_IST_EINH_ID COMMENT 'istarbeit Masseinheit - unit_2 in which the actual work for this order is measured',
	DATZEIT_DURCHFUEHRUNG_ENDE COMMENT 'Rückgemeldeter Endzeitpunkt der Durchführung'
) as 
    SELECT 
        mandant_id,
        auftrag_rm_id,
        auftrag_rm_pos_id,
        auftrag_id,
        co_leistungsart_id,
        storno_fg,
        storno_zaehler,
        dat_buch,
        teil_end_rm,
        menge_arbeit_ist,
        menge_arbeit_ist_einh_id,
        datzeit_durchfuehrung_ende

FROM DBP_DATA.IN_AUFTRAG_RM_2 ;
