CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_crm_hotline_bereich_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), crm_hotline_bereich_id
OPTIONS(description='ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'))
OPTIONS(DESCRIPTION = `DIE TABELLE IST EINE_2 LOOKUP-TABELLE FÜR DIE BEREICHE BZW. ABTEILUNGEN DER CRM-HOTLINE. SIE ENTHÄLT EINE_2 LISTE DER BEREICHE, AN DIE ANRUFE ZUGESTELLT WERDEN UND DIE ANRUFE ENTGEGENNEHMEN, Z.B. KCARD, KUNDENHOTLINE, SCHADENSHOTLINE ODER ZENTRALE.SIE WIRD MANUELL BEFÜLLT.`)
AS SELECT mandant_id,
 crm_hotline_bereich_id
FROM kfl_production_dbp_data.l_crm_hotline_bereich_2;