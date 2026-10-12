CREATE OR REPLACE VIEW kfl_production_dbp_view.v_stueckliste_det (art_id
OPTIONS(description='Artikelnummer der Stücklistenkomponente'), mandant_id OPTIONS(description='Mandant im DWH'),
stueckliste_id OPTIONS(description='Eindeutige ID der Stückliste'), stueckliste_pos_id
OPTIONS(description='Nummer der Position der Stücklistenkomponente'), dat_von
OPTIONS(description='Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'),
dat_bis
OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'),
stueckliste_typ_id OPTIONS(description='Eindeutiger Schlüssel für die Stücklistentypen.'), komponentenmenge
OPTIONS(description='Menge der Stücklistenkomponente'), komponentenmenge_einh_id
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.Aus meinh'))
OPTIONS(DESCRIPTION = `TP2_AIS - DIE TABELLE STUECKLISTE_DET ENTHÄLT DIE STÜCKLISTENPOSITIONEN AUS DER SAP TABELLE STPO. EINE STÜCKLISTE BESTEHT AUS EINER ODER MEHREREN KOMPONENTEN.`)
AS SELECT art_id,
 mandant_id,
 stueckliste_id,
 stueckliste_pos_id,
 dat_von,
 dat_bis,
 stueckliste_typ_id,
 komponentenmenge,
 komponentenmenge_einh_id
FROM kfl_production_dbp_data.stueckliste_det;