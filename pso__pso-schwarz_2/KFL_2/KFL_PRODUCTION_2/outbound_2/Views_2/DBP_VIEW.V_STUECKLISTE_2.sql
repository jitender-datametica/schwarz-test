CREATE OR REPLACE VIEW kfl_production_dbp_view.v_stueckliste_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
stueckliste_id OPTIONS(description='Eindeutige ID der Stückliste'), dat_von
OPTIONS(description='Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'),
dat_bis
OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'),
art_id OPTIONS(description='Artikelnummer der Stückliste'), stueckliste_verwendung_id
OPTIONS(description='Eindeutiger Schlüssel für die Stücklistenverwendung'))
OPTIONS(DESCRIPTION = `TP2_AIS - DIE TABELLE STUECKLISTE_2 ENTHÄLT DIE STÜCKLISTEN AUS DER SAP TABELLE MAST. AKTUELL WERDEN NUR DIE VOLLGUTSTÜCKLISTEN IN DAS DWH ÜBERTRAGEN`)
AS SELECT mandant_id,
 stueckliste_id,
 dat_von,
 dat_bis,
 art_id,
 stueckliste_verwendung_id
FROM kfl_production_dbp_data.stueckliste_2;