CREATE OR REPLACE VIEW kfl_production_dbp_view.v_linbew_prog_hc_org_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
hr_objekt_id OPTIONS(description='ID der Organisation, 8-stellige Zahl'), dat
OPTIONS(description='Datum Vortag der Lieferung in Beladung gesetzt, im Format JJJJ-MM_2-TT'), anz_prg_beendet
OPTIONS(description='Anzahl abgeschlossene Programme'), anz_prg_faellig OPTIONS(description='Anzahl fälligen Programme'),
anz_prg_gesamt OPTIONS(description='Anzahl zu erledigende Programme Gesamt'), anz_prg_bearbeitung
OPTIONS(description='Anzahl Progamme in Bearbeitung (auch fällige)'), anz_prg_ausstehend
OPTIONS(description='Anzahl nicht begonnene Programme (auch fällige)'))
OPTIONS(DESCRIPTION = `EINARBEITUNGSKENNZAHLEN PROGRAMMBASIERT JE ORGANIZATIONID`) AS SELECT mandant_id,
 hr_objekt_id,
 dat,
 anz_prg_beendet,
 anz_prg_faellig,
 anz_prg_gesamt,
 anz_prg_bearbeitung,
 anz_prg_ausstehend
FROM kfl_production_dbp_data.linbew_prog_hc_org_2;