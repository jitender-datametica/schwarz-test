CREATE OR REPLACE VIEW DBP_VIEW.V_lagerplatz_aktivitaet_per_1 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        lagerplatz_id,
        aktivitaet_id,
        dat_von,
        dat_bis,
        lfd_nr,
        aktivitaetsbereich_id,
        lagertyp_id,
        lagerbereich_id,
        gang_id,
        sort_nr,
        entfernung_start,
        gang_laenge,
        folge_gang_id,
        entfernung_folgegang,
        konsolidierungsgruppe_id,
        org_aktivitaetsbereich_id,
        td_update,
        td_insert
FROM DBP_DATA.lagerplatz_aktivitaet_per_1 ;