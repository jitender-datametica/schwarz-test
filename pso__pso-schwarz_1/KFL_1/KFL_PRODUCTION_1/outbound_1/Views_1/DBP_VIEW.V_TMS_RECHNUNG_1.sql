CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_rechnung_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_rech_beleg_id
OPTIONS(description='ID der Rechnung (Rechnungsnummer). Aus plrech.beleg_nr'), tms_rech_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_rechnung_1 im Quellsystem. Aus plrech.rech_id'), dat_tms_rech_beleg
OPTIONS(description='Belegdatum'), empfaenger_tms_gp_id
OPTIONS(description='ID des tms_gp_1, welcher hier als Empfänger auftrifft'), empfaenger_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Empfänger auftrifft'), tms_rech_beleg_status_id
OPTIONS(description='Status_1 des Rechnungsbelegs. 4 = offen, …'), wrg_id OPTIONS(description='ISO-Währungskürzel'),
tms_rech_sammelbeleg_id
OPTIONS(description='Sammelbeleg-Nummer. Eine_1 Sammelbeleg-Nummer dient dazu, mehrere Einzelrechnungsnummern (Spalte: "tms_rech_beleg_id") zusammenzufassen, die gemeinsam abgerechnet werden. Wichtig: Die Sammelbeleg-Nummer bezieht sich nicht direkt auf eine_1 einzelne Einzelrechnungsnummer.'),
abrechnungslauf_id OPTIONS(description='Abrechnungslauf (Nummer)'), tms_rech_storno_beleg_id
OPTIONS(description='ID des Stornobelegs(tms_rech_beleg_id) zu diesem Beleg'), dat_storno
OPTIONS(description='Datum des Stornobelegs zu diesem Beleg'), storno_fg
OPTIONS(description='Kennzeichen, ob der Beleg storniert wurde.'), manueller_beleg_fg
OPTIONS(description='Kennzeichen für einen manuell erstellten Beleg (Bei manuellen Belegen wird bei der Kostensplittung (PLAUST) anders vorgegangen!)'),
freigegeben_fg OPTIONS(description='Kennzeichen, ob der Beleg freigegeben wurde.'), gedruckt_fg
OPTIONS(description='Kennzeichen, ob der Beleg gedruckt wurde.'), tms_dispostelle_id
OPTIONS(description='ID des zuständigen Dispostelles für die Rechnung'), ersteller_tms_gp_id
OPTIONS(description='ID des tms_gp_1, welcher hier als Ersteller des Rechnungsbelegs auftrifft'), ersteller_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Ersteller des Rechnungsbelegs auftrifft'),
tms_rech_beleg_typ_id
OPTIONS(description='Typ des gespeicherten Belegs: 0 = Rechnung; 1 = Gutschrift; 2 = Offerte; 3 = Tourkosten SOLL; 4 = Tourkosten IST; 5 = Fuhrparkkosten; 6 = Tankdaten.'))
OPTIONS(DESCRIPTION = `TMS - DIE TABELLE ENTHÄLT DIE INFORMATIONEN ÜBER TMS-RECHNUNGEN, EINSCHLIESSLICH RECHNUNGSNUMMER, EMPFÄNGER, RECHNUNGSBETRAG, STORNO UND ZAHLUNGSSTATUS. AUS DER QUELLE PLRECH (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_rech_beleg_id,
 tms_rech_lfd_nr,
 dat_tms_rech_beleg,
 empfaenger_tms_gp_id,
 empfaenger_tms_gp_typ_cd,
 tms_rech_beleg_status_id,
 wrg_id,
 tms_rech_sammelbeleg_id,
 abrechnungslauf_id,
 tms_rech_storno_beleg_id,
 dat_storno,
 storno_fg,
 manueller_beleg_fg,
 freigegeben_fg,
 gedruckt_fg,
 tms_dispostelle_id,
 ersteller_tms_gp_id,
 ersteller_tms_gp_typ_cd,
 tms_rech_beleg_typ_id
FROM kfl_production_dbp_data.tms_rechnung_1;