CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_vorgang (
  mandant_id INT64 NOT NULL OPTIONS (
    description='Mandant im DWH.'
  ),
  crm_vorgang_id STRING(36) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS (
    description='Vorgang ID (GUID) aus CRM'
  ),
  crm_prozess_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Prozess ID , oberste Stuffe der Hierarchie'
  ),
  wup_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Filialnummer'
  ),
  nb_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ),
  crm_emotion_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Emotion ID (GUID) aus CRM'
  ),
  crm_eingangskanal_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Eingangskanal z.B. Telefon, Email, etc.'
  ),
  crm_prioritaet_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='ID der Prioritaet, niedrig, mittel, hoch'
  ),
  crm_status_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Ticket status zb. Abgeschlossen'
  ),
  crm_schaedlingsart_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Id zur Schaedlingsart'
  ),
  crm_eigenmarke_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Eigenmarke ID (GUID) aus CRM'
  ),
  crm_themenbaum_lv2_id STRING(36) COLLATE 'und:ci' DEFAULT 'N/A' NOT NULL OPTIONS (
    description='Themenbaum ID (GUID) aus CRM'
  ),
  ticketnummer STRING(100) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS (
    description='Ticketnummer'
  ),
  etiketten_text STRING(400) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS (
    description='Etiketten Text des betroffenen Artikels'
  ),
  ticket_text STRING(20000) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS (
    description='Ticket Text'
  ),
  foto_fg INT64 DEFAULT 0 NOT NULL OPTIONS (
    description='Foto beigefuegt'
  ),
  fremdkoerper_fg INT64 DEFAULT 0 NOT NULL OPTIONS (
    description='Fremdkoerper vorhanden'
  ),
  charge STRING(100) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS (
    description='Betroffene Charge'
  ),
  art_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Artikel ID'
  ),
  gtin_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='GTIN/EAN'
  ),
  gp_art_id STRING(40) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS (
    description='Lieferant'
  ),
  wg_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='Warengruppe'
  ),
  dat_start DATETIME DEFAULT CAST('1900-01-01 00:00:00' AS DATETIME) NOT NULL OPTIONS (
    description='Anlagedatum des Tickets'
  ),
  dat_ende DATETIME DEFAULT CAST('9999-12-31 23:59:59' AS DATETIME) NOT NULL OPTIONS (
    description='Abschlußdatum des Tickets'
  ),
  dat_aenderung DATETIME DEFAULT CAST('1900-01-01 00:00:00' AS DATETIME) NOT NULL OPTIONS (
    description='Aenderungsdatum des Tickets'
  ),
  vorgangnummer STRING(100) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS (
    description='Fachliche Vorgangsnummer aus dem Quellsystem'
  ),
  standardloesung_fg INT64 DEFAULT 0 NOT NULL OPTIONS (
    description='Steuert Massenmailversand?'
  ),
  dat_start_processing DATETIME DEFAULT CAST('1900-01-01 00:00:00' AS DATETIME) NOT NULL OPTIONS (
    description='Date on which the process was processed for the first time (i.e. left the status\'Open\')'
  ),
  dat_end_processing DATETIME DEFAULT CAST('9999-12-31 23:59:59' AS DATETIME) NOT NULL OPTIONS (
    description='Date on which the process was finally closed (systemically)'
  ),
  crm_magicword_id STRING(36) DEFAULT '-1' NOT NULL OPTIONS (
    description='Topic related to the content of the ticket which had been defined by the business'
  ),
  dat_best_before DATETIME DEFAULT CAST('1900-01-01 00:00:00' AS DATETIME) NOT NULL OPTIONS (
    description='best before date'
  ),
  zek_id STRING(3) DEFAULT '-1' NOT NULL OPTIONS (
    description='ID of the purchasing group'
  ),
  gp_id INT64 DEFAULT -1 NOT NULL OPTIONS (
    description='ID of the supplier behind the article'
  ),
  subassortment STRING(100) DEFAULT '' NOT NULL OPTIONS (
    description='Partial range'
  ),
  apollo STRING(100) DEFAULT '' NOT NULL OPTIONS (
    description='Apollo'
  ),
  crm_brand_id STRING(36) DEFAULT '-1' NOT NULL OPTIONS (
    description='ID of the brand behind the article'
  ),
  td_update TIMESTAMP OPTIONS (
    description='Technical fields for synchronisation framework. Will be delted after last product migration'
  ),
  td_insert TIMESTAMP OPTIONS (
    description='Technical fields for synchronisation framework. Will be delted after last product migration'
  )
)
OPTIONS (
  description='KMR - Kopfdatentabelle aus der CRM Entitaet incident (Beschwerden) - MS Dynamics CRM'
);