CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_bestellung_det_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), bestell_beleg_nr OPTIONS(description='Belegnummer der Bestellung.'),
bestell_beleg_pos_nr OPTIONS(description='Nummer der Belegposition der Bestellung.'), projekt_nr
OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '), gewerk_id
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), bestell_beleg_pos_typ_cd
OPTIONS(description='Code der angibt, um welchen Positionstyp der Bestellung es sich handelt, bspw. N = Nachtrag.'),
dat_erstellung OPTIONS(description='Erstelldatum der Belegposition.'), material_nr
OPTIONS(description='Nummer des bestellten Materials.'), warengruppe_cd OPTIONS(description='Code der Warengruppe'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR für betrag_netto'), betrag_netto
OPTIONS(description='Nettobetrag der Bestellposition in Landeswährung'), betrag_netto_konz
OPTIONS(description='Nettobetrag der Bestellposition in Konzernwährung (EUR)'), rate_tageskurs
OPTIONS(description='Rate für die Umrechnung der lokalen Währung zur Konzernwährung mit dem Tageskurs.'),
bestell_pos_txt OPTIONS(description='Freitext für die Belegposition.'), endrechnung_fg
OPTIONS(description='Flag gibt an, ob ...............'), loesch_fg
OPTIONS(description='Flag gibt an, ob Belegposition gelöscht wurde und für das Reporting nicht relevant ist.'))
OPTIONS(DESCRIPTION = `Enthält die Bestellpositionen der getätigten Bestellung für Projekte aus den Zentralbereichen.`)
AS SELECT mandant_id,
 bestell_beleg_nr,
 bestell_beleg_pos_nr,
 projekt_nr,
 gewerk_id,
 bestell_beleg_pos_typ_cd,
 dat_erstellung,
 material_nr,
 warengruppe_cd,
 wrg_id,
 betrag_netto,
 betrag_netto_konz,
 rate_tageskurs,
 bestell_pos_txt,
 endrechnung_fg,
 loesch_fg
FROM kfl_production_dbp_data.zb_projekt_bestellung_det_2;