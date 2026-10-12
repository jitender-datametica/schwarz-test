create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_NACHSCHUBQUOTEN_2(
	WUP_ID,
	ART_ID,
	NB_ID,
	LAGERNUMMER_ID,
	LAGERORT_ID,
	MANDANT_ID,
	NACH_LAGERTYP_ID,
	TRANSPORT_BELEG_ID,
	VON_LAGERTYP_ID,
	DAT_QUITTIERUNG,
	AUSPACK_FG,
	STATUS_QUITTIERUNG
) as
-- 2022.02.03, AP0122465, SPEC0146157, dknop, initial
SELECT
    td.wup_id,
    td.art_id,
    td.nb_id,
    td.lagernummer_id,
    td.lagerort_id,
    td.mandant_id,
    td.nach_lagertyp_id,
    td.transport_beleg_id,
    td.von_lagertyp_id,
    td.dat_quittierung,
    marc.auspack_fg,
    CASE WHEN td.quittierung_fg = 1 AND (td.menge_soll_von = td.menge_ist_nach OR (td.menge_soll_von = 0 AND td.menge_ist_nach > 0))
              AND COALESCE(td.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'voll quittiert'
        WHEN td.quittierung_fg = 1 AND td.menge_soll_von > td.menge_ist_nach AND COALESCE(td.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'teil quittiert'
        WHEN td.quittierung_fg = 1 AND td.transport_vorgang_id IN ('st', 'sl') THEN 'storniert'
        WHEN td.quittierung_fg = 0 THEN 'offen'
        ELSE 'sonstiges'
    END :: VARCHAR(14) AS status_quittierung

FROM dbp_view.v_transportauftrag_det_2 td

JOIN dbp_view.v_art_vorschlagswert_per_2 marc_2
ON  td.mandant_id=marc.mandant_id
AND td.art_id=marc.art_id
AND td.dat_quittierung BETWEEN marc.dat_von AND marc.dat_bis;