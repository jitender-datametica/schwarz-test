CREATE TABLE DBP_DATA.CRM_L_KUNDENKARTE (
	KUNDENKARTE_ID VARCHAR(1020) NOT NULL COMMENT 'Nummer der Kundenkarte/ Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	CRM_KUNDENKARTE_ART_ID INTEGER DEFAULT -1 COMMENT 'Art der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.',
	CRM_KUNDENKARTE_NR VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID für die Kundenkarten/Bonuskarten. Wird in Tabelle aufgenommen, da sie CRM-seitig die eindeutige ID für die Entität arvato_loyaltycard/ für eine Kundenkarte/Bonuskarte darstellt.',
	CRM_KONTO_ID VARCHAR(144) COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos. Ist im PK wegen Relation zu crm_l_kundenkarte',
	GESPERRT_FG INTEGER NOT NULL COMMENT 'Sperrungsflag einer Kundenkarte (1 gesperrt, 0 nicht gesperrt) - wird immer befüllt',
	ZEIT_VON TIMESTAMP_NTZ(9) COMMENT 'Anfang des Kartengültigkeitsintervalls',
	ZEIT_BIS TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Ende des Kartengültigkeitsintervalls - wird immer befüllt',
	GELOESCHT_FG INTEGER NOT NULL COMMENT 'Löschflag einer Kundenkarte (1 gelöscht, 0 nicht gelöscht) - wird immer befüllt',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Enthält Daten der Entität \"Arvato_Loyaltycard\" (Kundenkarte) aus MS Dynamics CRM. Eine Karte (crm_l_kundenkarte) hängt immer an einem Konto (crm_l_konto.crm_konto_id).'
;