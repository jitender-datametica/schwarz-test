CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_markt_verraeumung_prio_grund (mandant_id
OPTIONS(description='Mandant im DWH.'), verraeumung_prio_grund_id
OPTIONS(description='ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE VERRÄUMUNGS-PRIORITÄTSGRÜNDE IN DER FILIALE. DIESE TABELLE LISTET DIE VERSCHIEDENEN GRÜNDE AUF, DIE EINEN ARTIKEL IM LAGER ALS "KRITISCH" FÜR DIE VERRÄUMUNG AUF DIE VERKAUFSFLÄCHE EINSTUFEN.Z.B. DAS ERREICHEN EINES NULLBESTANDS IM REGAL. QUELLE: ZRS_LGBPRF_CUST (SAP)`)
AS SELECT mandant_id,
 verraeumung_prio_grund_id
FROM kfl_production_dbp_data.l_markt_verraeumung_prio_grund;