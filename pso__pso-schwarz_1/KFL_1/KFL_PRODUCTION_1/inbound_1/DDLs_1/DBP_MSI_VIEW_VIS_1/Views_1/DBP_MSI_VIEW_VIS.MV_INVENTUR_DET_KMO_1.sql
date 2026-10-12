CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_inventur_det_kmo_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ZEITPUNKT_INV,
	DAT_BUCH,
	ART_ID,
	WRG_ID,
	MENGE_INV,
	BESTAND_WERT,
	WERT_EINGABE
) AS

	--snik1809 21042020 SPEC0071018 AP0047448
	--snik1809 01092020 included dat_buch to group by
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 kmo1.mandant_id
 , kmo1.wup_id
 , kmo1.nb_id
 , kmo1.zeitpunkt_inv
 , CAST(kmo1.zeitpunkt_inv AS DATE) 											AS dat_buch
 , kmo1.art_id
 , kmo1.wrg_id
 , kmo1.menge_inv
 , kmo1.bestand_wert
 , kmo1.wert_eingabe
FROM dbp_data.inventur_det_kmo_1 kmo1

INNER JOIN
(SELECT
 kmo2.mandant_id
 , kmo2.wup_id
 , kmo2.nb_id
 , CAST(kmo2.zeitpunkt_inv AS DATE) 											AS dat_buch
 , kmo2.art_id
 , kmo2.wrg_id
 , Max(kmo2.zeitpunkt_inv) 														    AS maxzeit
FROM dbp_data.inventur_det_kmo_1 kmo2
GROUP BY kmo2.mandant_id, kmo2.wup_id,kmo2.art_id,kmo2.wrg_id,kmo2.nb_id,dat_buch
) kmo2
ON kmo2.maxzeit = kmo1.zeitpunkt_inv
AND kmo2.mandant_id = kmo1.mandant_id
AND kmo2.wup_id = kmo1.wup_id
AND kmo2.nb_id = kmo1.nb_id
AND kmo2.art_id = kmo1.art_id
AND kmo2.wrg_id = kmo1.wrg_id

INNER JOIN dbp_view.v_wup_1 wup_1
ON kmo1.mandant_id = wup.mandant_id AND kmo1.wup_id = wup.wup_id
;