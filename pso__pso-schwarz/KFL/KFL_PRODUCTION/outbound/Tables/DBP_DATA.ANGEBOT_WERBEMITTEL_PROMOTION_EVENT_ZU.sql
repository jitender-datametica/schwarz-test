--==============================================================
-- Table: angebot_werbemittel_promotion_event_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_werbemittel_promotion_event_zu
   generated from Powerdesigner on Donnerstag, 20. März 2025 17:37:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
werbemittel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbemittels'),
werbemittelkanal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbemittelkanals'),
promotion_event_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Promotion Events.'),
werbeflaechenabschnitt_name STRING(100) NOT NULL OPTIONS(description='Name des Werbeflaechenabschnitts.'),
werbemittel_bez STRING(200) OPTIONS(description='Bezeichnung des Werbemittels'),
werbemittelkanal_bez STRING(200) OPTIONS(description='Bezeichnung des Werbemittelkanals.'),
werbethema_id BIGNUMERIC(38,0) OPTIONS(description='ID des Werbethemas'),
werbethema_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung des Werbethemas'),
werbeflaechenthema_cd STRING(50) OPTIONS(description='Code des Werbeflaechenthemas'),
werbeflaechenthema_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung des Werbeflaechenthemas'),
werbeposition_nr BIGNUMERIC(38,0)
OPTIONS(description='Nummer der Position des Angebots innerhalb des Werbeflachenabschnitts.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_nr, werbemittel_id, werbemittelkanal_id, promotion_event_id,
 werbeflaechenabschnitt_name) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen einem Angebot, dem Werbemittel und Event. Beinhaltet Informationen wo Angebote eines Events beworben werden. Die Tabelle wird zusätzlich zur promotion event Tabelle benötigt, da es auch Angebote ohne Event geben kann, die Informationen zum Werbemittel, Werbethema, etc. beinhalten. ');