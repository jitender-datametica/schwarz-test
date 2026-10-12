CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_gp_beschraenkung_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_gp_id
OPTIONS(description='ID des Geschäftspartners (Kundennummer). Aus plkd.nr'), tms_gp_typ_cd
OPTIONS(description='Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)'), tms_beschraenkung_id
OPTIONS(description='Geschäftspartner-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …'),
tms_beschraenkung_pos_nr
OPTIONS(description='Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. bes1 = 1, bes2 = 2, …'))
OPTIONS(DESCRIPTION = `TMS - ZUORDNUNGSTABELLE FÜR GESCHÄFTSPARTNER MIT EINSCHRÄNKUNGEN, UM DIE FÜR DEN GESCHÄFTSPARTNER GELTENDEN EINSCHRÄNKUNGEN ZU DEFINIEREN. AUS DER QUELLE PLKD (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_gp_id,
 tms_gp_typ_cd,
 tms_beschraenkung_id,
 tms_beschraenkung_pos_nr
FROM kfl_production_dbp_data.tms_gp_beschraenkung_zu_2;