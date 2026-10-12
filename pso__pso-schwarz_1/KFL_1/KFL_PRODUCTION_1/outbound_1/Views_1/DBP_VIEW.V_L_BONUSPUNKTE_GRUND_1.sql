CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bonuspunkte_grund_1 (bonuspunkte_grund_cd
OPTIONS(description='Code des Grunds der Bonuspunktevergabe.'), bonuspunkte_grund_bez
OPTIONS(description='Bezeichnung des Grunds der Bonuspunktevergabe.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DEN GRUND DER BONUSPUNKTEVERGABE.ZB:CHECKOUT, CANCELLATION, REGISTRIERUNG VON PDP.UNTERSCHIEDLICHE WERTE DIE FREI GEWÄHLT WERDEN KÖNNEN. IN ZUKUNFT KONTINUIERLICH WECHSELNDE WERTE. KEINE FIXEN WERT.`)
AS SELECT bonuspunkte_grund_cd,
 bonuspunkte_grund_bez
FROM kfl_production_dbp_data.l_bonuspunkte_grund_1;