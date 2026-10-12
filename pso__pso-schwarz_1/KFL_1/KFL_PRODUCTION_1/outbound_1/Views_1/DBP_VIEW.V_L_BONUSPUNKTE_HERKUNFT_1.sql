CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bonuspunkte_herkunft_1 (bonuspunkte_herkunft_id
OPTIONS(description='Code für die Herkunft der Punkte.'), bonuspunkte_herkunft_bez
OPTIONS(description='Bezeichnung für die Herkunft der Punkte.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE HERKUNFT DER BONUSPUNKTE-WIE SIE VERGEBEN WURDEN.ZB:TRANSAKTION, MANUELLE EINGABE, DAILY SUPRISES USW..`)
AS SELECT bonuspunkte_herkunft_id,
 bonuspunkte_herkunft_bez
FROM kfl_production_dbp_data.l_bonuspunkte_herkunft_1;