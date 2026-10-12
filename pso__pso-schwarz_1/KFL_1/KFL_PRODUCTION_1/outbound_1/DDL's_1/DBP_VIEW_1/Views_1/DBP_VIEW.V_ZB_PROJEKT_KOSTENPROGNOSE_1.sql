CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_kostenprognose_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID eines Gewerks , z.Bsp 3 = Baukosten'), warengruppe_cd
OPTIONS(description='Code der Warengruppe'), dat_version OPTIONS(description='Datum der Version der Kostenprognose'),
version_nr OPTIONS(description='Versionsnummer der Kostenprognose'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_kostenprognose
OPTIONS(description='Betrag der Kostenprognose in Landeswährung'), betrag_zek
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zea
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'))
OPTIONS(DESCRIPTION = `Enthält Kostenprognosen für die Warengruppen pro Gewerk im jeweiligen Projekt.`) AS SELECT
 mandant_id,
 projekt_nr,
 gewerk_id,
 warengruppe_cd,
 dat_version,
 version_nr,
 wrg_id,
 betrag_kostenprognose,
 betrag_zek,
 betrag_zea
FROM kfl_production_dbp_data.zb_projekt_kostenprognose_1;