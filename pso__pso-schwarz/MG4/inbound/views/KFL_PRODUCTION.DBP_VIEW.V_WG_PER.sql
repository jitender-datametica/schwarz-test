create or replace view KFL_PRODUCTION.DBP_VIEW.V_WG_PER(
	MANDANT_ID COMMENT 'Mandant im DWH',
	WG_ID COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	DAT_VON COMMENT 'Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format ''YYYY-MM-DD''',
	LEAD_MWST_ID COMMENT 'führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
	ABT_ID COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte ID''s, positive Werte: aus Stammdatensystem übernommen',
	DAT_BIS COMMENT 'Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format ''YYYY-MM-DD''',
	OWG_ID COMMENT 'ID der Oberwarengruppe',
	PLATZIERUNGSWG_ID COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel',
	WERBETEAM_CD COMMENT 'Code des Werbeteams'
) as 
    SELECT 
        mandant_id,
        wg_id,
        arthiertyp_id,
        dat_von,
        lead_mwst_id,
        abt_id,
        dat_bis,
        owg_id,
        platzierungswg_id,
        werbeteam_cd

FROM DBP_DATA.WG_PER ;