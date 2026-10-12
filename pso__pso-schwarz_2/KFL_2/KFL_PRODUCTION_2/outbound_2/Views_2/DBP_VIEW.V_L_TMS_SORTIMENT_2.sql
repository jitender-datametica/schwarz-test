CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_sortiment_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_sortiment_id
OPTIONS(description='ID desSortiments. Aus plsortim.srtm_nr'), tms_sortiment_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_sortiment_2 im Quellsystem. Ausplsortim.srtm_id'), tms_sortiment_bez
OPTIONS(description='Bezeichnung zum TMS-Sortiment'), temperaturgruppe_id
OPTIONS(description='Temperaturgruppe des Sortiments'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR KLASSIFIZIERUNG VON WAREN FÜR VERSCHIEDENE SORTIMENTE, Z. B. FOOD, O&G, NONFOOD. AUS DER QUELLE PLSORTIM (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_sortiment_id,
 tms_sortiment_lfd_nr,
 tms_sortiment_bez,
 temperaturgruppe_id
FROM kfl_production_dbp_data.l_tms_sortiment_2;