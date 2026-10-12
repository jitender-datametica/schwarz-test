 CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_LINBEW_PROG_HC_ORG_AGG_1
 (
	MANDANT_ID,
	HR_OBJEKT_ID,
	KJMO,
	ANZ_PRG_BEENDET,
	ANZ_PRG_FAELLIG,
	ANZ_PRG_GESAMT,
	ANZ_PRG_BEARBEITUNG,
	ANZ_PRG_AUSSTEHEND
) AS

-- 26.09.2024 twie: SPEC0263952 Neuanlage View, Logik von VIS übernommen, statt wup_id mit kostenstelle_id
-- 09.04.2025 twie: SPEC0263952 Tabelle linbew_prog_hc_1 ersetzt durch linbew_prog_hc_org_1 (hr_objekt_id statt wup_id)

SELECT
      v01.mandant_id
    , v01.hr_objekt_id
    , v02.kjmo
    , v01.anz_prg_beendet
    , v01.anz_prg_faellig
    , v01.anz_prg_gesamt
    , v01.anz_prg_bearbeitung
    , v01.anz_prg_ausstehend
    
FROM dbp_view.v_linbew_prog_hc_org_1 v01

INNER JOIN dbp_view.v_tag_1 v02
ON v01.dat = v02.dat

QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.hr_objekt_id, v02.kjmo ORDER BY v01.dat DESC NULLS LAST) = 1;