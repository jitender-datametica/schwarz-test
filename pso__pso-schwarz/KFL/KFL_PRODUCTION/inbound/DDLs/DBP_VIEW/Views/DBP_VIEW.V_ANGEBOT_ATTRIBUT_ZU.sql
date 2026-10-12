create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ANGEBOT_ATTRIBUT_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	ANGEBOT_NR COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
	ANGEBOT_ATTRIBUT_ID COMMENT 'ID des Attributs',
	ANGEBOT_ATTRIBUT_TXT COMMENT 'Freitext für den Wert des Attributs. Dieser Wert kann sich je nach Bedeutung des Attributs unterscheiden.'
) COMMENT='Zuordnungstabelle zwischen einem Angebot und dem jeweils verknüpften Attribut um weitere Informationen dem Angebot hinzuzufügen.'
 as 
    SELECT 
        mandant_id,
        angebot_nr,
        angebot_attribut_id,
        angebot_attribut_txt

FROM DBP_DATA.ANGEBOT_ATTRIBUT_ZU ;
