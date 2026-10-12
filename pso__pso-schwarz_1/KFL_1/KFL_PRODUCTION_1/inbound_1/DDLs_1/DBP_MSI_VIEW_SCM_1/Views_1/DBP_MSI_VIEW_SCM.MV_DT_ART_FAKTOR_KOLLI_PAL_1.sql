CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_ART_FAKTOR_KOLLI_PAL_1
TARGET_LAG = '15 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG 
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG 
 (
	MANDANT_ID,
	ART_ID,
	EINH_KOLLI,
	FAKTOR_KOLLI,
	EINH_BEST,
	FAKTOR_BEST,
	EINH_PAL,
	FAKTOR_PAL,
	EINH_LAG,
	FAKTOR_LAG
) AS
--AP0043130_SPEC0056784 | nwag2310
--AP0098488 | nwag2310 added lage 
--AP0098488 | nwag2310 kollifaktor from new dispo table if DE item_1 in KG + adjusted case for einh_kolli  [~ WAUSM!]
--AP0098488 | nwag2310 add Bestellmengeneinheit
--AP0098488 | nwag2310 typecast to avoid kollifaktor lose its precision
--AP0098488 | nwag2310 workaround best menge 
--20250522  | nwag2310 move to DT
SELECT
maw1.mandant_id,
maw1.art_id,
CASE
WHEN TRIM(maw1.ausg_menge_einh_id) = '' THEN mara.basismenge_einh_id
ELSE maw1.ausg_menge_einh_id END AS einh_kolli,
CASE
WHEN mara.basismenge_einh_id = 'KG' AND mara.mandant_id = 1 AND kol_dispo.kollifaktor_dispo IS NOT NULL THEN CAST(kol_dispo.kollifaktor_dispo AS DEC(15,5))
WHEN (marm_kol.umrech_zaehler / marm_kol.umrech_nenner) IS NOT NULL THEN ( CAST( marm_kol.umrech_zaehler AS DEC (15,5)) / CAST( marm_kol.umrech_nenner AS DEC (15,5)) )
ELSE 1 END AS faktor_kolli,
CASE
WHEN TRIM(mara.best_menge_einh_id) <> '' THEN mara.best_menge_einh_id
ELSE mara.basismenge_einh_id END  AS einh_best,
CASE
WHEN TRIM(mara.best_menge_einh_id) <> '' THEN marm_best.umrech_zaehler / marm_best.umrech_nenner
ELSE 1 END AS faktor_best,
maw1.paletten_faktor_einh_id AS einh_pal,
marm_pal.umrech_zaehler / marm_pal.umrech_nenner AS faktor_pal,
maw1.lage_faktor_einh_id AS einh_lag,
marm_lag.umrech_zaehler/marm_lag.umrech_nenner AS faktor_lag
FROM DBP_VIEW.v_art_1 mara_1
JOIN DBP_VIEW.v_art_vorschlagswert_per_1 maw1_1
ON mara.mandant_id = maw1.mandant_id
AND mara.art_id     = maw1.art_id

LEFT JOIN DBP_VIEW.v_art_umrechnung_faktor_per_1 marm_kol
ON marm_kol.dat_bis             = '9999-12-31'
AND marm_kol.altnv_menge_einh_id = maw1.ausg_menge_einh_id
AND marm_kol.mandant_id          = maw1.mandant_id
AND marm_kol.art_id              = maw1.art_id

LEFT JOIN DBP_VIEW.v_art_umrechnung_faktor_per_1 marm_pal
ON marm_pal.dat_bis             = '9999-12-31'
AND marm_pal.altnv_menge_einh_id = maw1.paletten_faktor_einh_id
AND marm_pal.mandant_id          = maw1.mandant_id
AND marm_pal.art_id              = maw1.art_id

LEFT JOIN DBP_VIEW.v_art_umrechnung_faktor_per_1 marm_lag
ON marm_lag.dat_bis             ='9999-12-31'
AND marm_lag.altnv_menge_einh_id = maw1.lage_faktor_einh_id
AND marm_lag.mandant_id          = maw1.mandant_id
AND marm_lag.art_id              = maw1.art_id

LEFT JOIN DBP_VIEW.v_art_umrechnung_faktor_per_1 marm_best
ON marm_best.dat_bis             ='9999-12-31'
AND marm_best.altnv_menge_einh_id = mara.best_menge_einh_id
AND marm_best.mandant_id          = maw1.mandant_id
AND marm_best.art_id              = maw1.art_id


LEFT JOIN (SELECT
mandant_id,
art_id,
MAX(umrech_faktor_best_bme ) AS kollifaktor_dispo
FROM DBP_VIEW.v_art_gp_dispo_tag_1
           WHERE mandant_id = 1
             AND dat_plan = CURRENT_DATE - 1
-- AND dat_plan IN (SELECT MAX(dat_plan) FROM DBP_VIEW.v_art_gp_dispo_tag_1 ) --only for DEV, on PROD = daily update
AND menge_einh_lam_id='KG'
GROUP BY mandant_id
      ,art_id
) kol_dispo
ON mara.mandant_id = kol_dispo.mandant_id
AND mara.art_id     = kol_dispo.art_id
WHERE maw1.dat_bis = '9999-12-31';