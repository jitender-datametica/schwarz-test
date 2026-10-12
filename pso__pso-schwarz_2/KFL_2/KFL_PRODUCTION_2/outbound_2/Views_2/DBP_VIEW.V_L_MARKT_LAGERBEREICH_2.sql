CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_markt_lagerbereich_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
markt_lagerbereich_id OPTIONS(description='Lagerbereich ID in der Filiale.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE LAGERBEREICHEN IN DER FILIALE. WIRD MANUELL BELADEN. Z.B. 1=NÄHRMITTEL; 2=KONSERVEN/ESSIG/ÖL; USW.`)
AS SELECT mandant_id,
 markt_lagerbereich_id
FROM kfl_production_dbp_data.l_markt_lagerbereich_2;