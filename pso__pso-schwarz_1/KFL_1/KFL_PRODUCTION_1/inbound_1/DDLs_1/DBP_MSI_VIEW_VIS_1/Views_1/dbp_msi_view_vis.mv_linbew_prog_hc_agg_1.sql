CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_linbew_prog_hc_agg_1(
    MANDANT_ID,
	WUP_ID,
	KJMO,
	ANZ_PRG_BEENDET,
	ANZ_PRG_FAELLIG,
	ANZ_PRG_GESAMT,
	ANZ_PRG_BEARBEITUNG,
	ANZ_PRG_AUSSTEHEND
) AS

-- snik1809-17032021-SPEC0099406_AP0065166-Creation 
-- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
    v01.mandant_id
    , wup.aktuell_wup_id AS wup_id
    , v02.kjmo
    , v01.anz_prg_beendet
    , v01.anz_prg_faellig
    , v01.anz_prg_gesamt
    , v01.anz_prg_bearbeitung
    , v01.anz_prg_ausstehend
FROM dbp_view.v_linbew_prog_hc_1 v01
INNER JOIN dbp_view.v_tag_1 v02
ON v01.dat = v02.dat
INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
WHERE v01.wup_id BETWEEN 1 AND 8999
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, aktuell_wup_id, v02.kjmo ORDER BY v01.dat DESC NULLS LAST) = 1;