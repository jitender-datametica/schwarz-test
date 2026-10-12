CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_gp_sum (mandant_id OPTIONS(description='Mandant'), dat
OPTIONS(description='Datum im Format JJJJ-MM-TT'), gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
vw_id OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup Objekte1 = Ost2 = West3 = Nord'), wrg
OPTIONS(description='Währung, z.Bsp. EUR'), umrechnungskurs_hist
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '), umsatz_netto
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'), diff_umsatz_netto_konz
OPTIONS(description='von der Konzernwährung abweichender Umsatz netto'), ek_mep
OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)'), diff_ek_mep_konz
OPTIONS(description='von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis'))
OPTIONS(DESCRIPTION = `TP2_AIS - Aggregatstabelle enthält Umsatz und MEP pro Lieferant, Vertriebsweg und Tag - MULTISET`)
AS SELECT mandant_id,
 dat,
 gp_id,
 vw_id,
 wrg,
 umrechnungskurs_hist,
 umsatz_netto,
 diff_umsatz_netto_konz,
 ek_mep,
 diff_ek_mep_konz
FROM kfl_production_dbp_data.artbew_gp_sum;