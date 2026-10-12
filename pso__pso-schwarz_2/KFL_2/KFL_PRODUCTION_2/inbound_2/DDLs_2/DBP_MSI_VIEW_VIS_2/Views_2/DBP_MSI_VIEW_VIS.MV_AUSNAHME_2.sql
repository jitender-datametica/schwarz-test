CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AUSNAHME_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT_PLAN,
	ART_ID,
	PRUEF_ID,
	Z_ARBEITSGEBIET_ID,
	GP_ID,
	AUSNAHME_MUTTER_ID,
	AUSNAHME_MENGE_BME,
	AUSNAHME_MENGE_KOLLI
) AS 

	-- FAKT - filtered
	-- 2020-04-30 snik1809 : AP0047448_SPEC0067726 -  Reiter FWWS
	-- 2020-12-15 ssch0611 : Update, added all columns, included DE
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 														AS wup_id
 , v01.dat_plan
 , v01.art_id
 , v01.pruef_id
 , v01.z_arbeitsgebiet_id
 , v01.gp_id
 , v01.ausnahme_mutter_id
 , v01.ausnahme_menge_bme
 , v01.ausnahme_menge_kolli
FROM dbp_view.v_ausnahme_2 v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
	
WHERE
    (
        v01.mandant_id <> 1
        AND v01.nb_id = 0
        AND v01.z_arbeitsgebiet_id = 1
        AND v01.pruef_id IN (
            202,
            203,
            205,
            206,
            207,
            209,
            210,
            214,
            216,
            218,
            223,
            225,
            231,
            700
        )
    )
    OR (
        v01.mandant_id <> 1
        AND v01.nb_id = 0
        AND v01.z_arbeitsgebiet_id = 0
        AND v01.pruef_id IN (001, 002, 005, 250, 252, 253)
    )
    OR (
        v01.mandant_id = 1
        AND v01.nb_id = 0
        AND v01.z_arbeitsgebiet_id = 0
        AND v01.pruef_id IN (252)
    )
;