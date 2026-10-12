CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ruecksendung_typ_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
ruecksendung_typ_kz OPTIONS(description='Code für die Art_2 der Rücksendung.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR RÜCKSENDUNGSTYPEN.`) AS SELECT mandant_id,
 ruecksendung_typ_kz
FROM kfl_production_dbp_data.l_ruecksendung_typ_2;