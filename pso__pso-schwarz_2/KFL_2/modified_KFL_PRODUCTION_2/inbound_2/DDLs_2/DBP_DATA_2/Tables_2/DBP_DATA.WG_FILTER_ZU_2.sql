CREATE TABLE DBP_DATA.WG_FILTER_ZU_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	WG_ID INTEGER NOT NULL COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WG_FILTER_ID INTEGER NOT NULL COMMENT 'ID Filter auf Warengruppen ',
	WUG_ID INTEGER COMMENT 'ID der Warenuntergruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Zuordnung WG-Filter-ID zu WG_ID (Warengruppen) - wird manuell beladen'
;